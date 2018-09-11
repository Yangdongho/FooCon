package service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.mail.HtmlEmail;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import dao.BrandDao;
import dao.BrandMenuDao;
import dao.BrandOwnerDao;
import dao.MemberDao;
import dao.NonMemberDao;

@Service
public class OrderBrandService{
	///////////////////////원용///////////////////////
	@Autowired
	BrandDao brandDao;
	@Autowired
	BrandMenuDao brandMenuDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	BrandOwnerDao brandOwnerDao;
	@Autowired
	NonMemberDao nonMemberDao;
	
	private static final int NUM_OF_MESSAGE_PER_PAGE = 10;
	private static final int NUM_OF_NAVI_PAGE = 5;
	
	//브랜드 상세페이지 보여줄 때 해당 브랜드가 있는지 확인 및 값 넘겨주는 매서드
	public Map<String,Object> brandViewResult(String brandNUM,String seq,String authority) {
		Map<String,Object> brandImage = brandDao.brandImageSelectOne(brandNUM);
		if(brandImage == null) {return null;}
		
		int brandImageCount = 0;
		for(int i=1;i<=10;i++) {
			if(brandImage.get("IMAGE"+i) != null) {
				brandImageCount++;
			}			
		}
		brandImage.put("BRANDIMAGECOUNT", brandImageCount);
		String brandImageGson = new Gson().toJson(brandImage);
				
		Map<String,Object> brandViewInfoView = brandDao.brandViewInfoView(brandNUM);
		List<Map<String,Object>> brandMenuView = brandDao.brandMenuView(brandNUM);
		int brandInterestTotalCountView = (int)brandDao.brandInterestTotalCountView(brandNUM);
		
		Map<String,Object> brandView = new HashMap<String,Object>();
		if(authority != null) {
			if(authority.equals("MEMBER")) {
				Map<String,Object> param = new HashMap<String,Object>();
				param.put("BRANDNUM", brandNUM);
				param.put("MEMBERNUM", seq);			
				Map<String,Object> brandInterestView = brandDao.brandInterestView(param);
				
				brandView.put("brandInterestView", brandInterestView);
			} 			
		}
		
		brandView.put("brandImageGson", brandImageGson);
		brandView.put("brandViewInfoView", brandViewInfoView);
		brandView.put("brandMenuView", brandMenuView);
		brandView.put("brandInterestTotalCountView", brandInterestTotalCountView);
		return brandView;
	}
	
	public Map<String,Object> reviewList(Map<String,Object> param){
		int currentPage = Integer.parseInt((String)param.get("FISRTROW"));
		
		/*데이터 조회에 필요한 값*/
		int firstRow = getFirstRow(currentPage);
		int endRow = getEndRow(currentPage);
		param.put("FIRSTROW", firstRow);
		param.put("ENDROW", endRow);	
		String memberNUM = (String)param.get("MEMBERNUM");
		
		//권한에 따라 현재 게시글의 총 개수를 넣어주기
		int reviewTotalCount = brandDao.reviewCountView(param);
		int pageTotalCount = getPageTotalCount(reviewTotalCount);
	
		
		List<Map<String,Object>> reviewListView = brandDao.brandReviewView(param);
		List<Map<String,Object>> reviewTotalAverageView = brandDao.reviewTotalAverageView(param);
		
		for(int i=0;i<reviewListView.size();i++ ) {
			String orderNUM = (String)reviewListView.get(i).get("ORDERNUM");
			List<Map<String,Object>> purchaseItemView = brandDao.purchaseItemView(orderNUM);
			
			String purchaseItem = " ";
			for(int j=0;j<purchaseItemView.size();j++) {
				purchaseItem = purchaseItem+((String)purchaseItemView.get(j).get("MENUNAME"))+" "+
											((BigDecimal)purchaseItemView.get(j).get("ORDERQUANTITY"))+"개 / ";
			}
			purchaseItem = purchaseItem.substring(0, purchaseItem.length()-2);
			reviewListView.get(i).put("PURCHASEITEM",purchaseItem);
		}
		
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("reviewListView", reviewListView);
		result.put("reviewTotalAverageView", reviewTotalAverageView);
		result.put("currentPage", currentPage);
		result.put("pageTotalCount", pageTotalCount);
		result.put("reviewTotalCount", reviewTotalCount);
		return result;
	}
	
	
	public boolean interestCheck(Map<String,Object> param,String seq) {
		boolean result = false;
		String interestCheck = (String)param.get("INTERESTCHECK");
		param.put("MEMBERNUM", seq);
		if(interestCheck.equals("true")) { //이미 관심트럭으로 선정했을 경우 (관심트럭 삭제)
			brandDao.brandInterestDelete(param);
		}else { //비관심일 경우 (관심트럭 추가)
			brandDao.brandInterestInsert(param);
			result = true;
		}
		return result;
	}
	
	
	//주문완료 시 주문내역 dao에 넣고 주문번호 메일 발송하는 매서드
	public boolean orderInsert(Map<String,Object> param) {
		String memberNUM = (String)param.get("MEMBERNUM");
		String delivRegiCheck = (String)param.get("DELIVREGICHECK");
		int paymentAmount = Integer.parseInt((String)param.get("PAYMENTAMOUNT"));		
		param.put("ORDERNUMBER", null);
		param.put("PAYMENTAMOUNT", paymentAmount);
		
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyy년 MM월 dd일 ");
		SimpleDateFormat time = new SimpleDateFormat("hh시 mm분");
		param.put("APPROVALDATE", date.format(today)+time.format(today));
		
		String sb = (String) param.get("ORDERLIST"); 
		JSONObject jsonObject = new JSONObject(sb.toString());
		JSONArray items = jsonObject.getJSONArray("orderListJson");
		
		SimpleDateFormat orderNumberDate = new SimpleDateFormat("yyMMdd");
		if(memberNUM == null) { //비회원일 경우
			param.put("USEDPOINT", "0");
			if(nonMemberDao.nonMemberInsert(param)>0) {
				if(brandDao.orderInfoInsert(param)>0) {
					for(int i=0;i<items.length();i++) {
						JSONObject item = items.getJSONObject(i);
						param.put("BRANDMENUNUM", item.get("menuNUM"));
						param.put("ORDERQUANTITY", item.get("orderQuantity"));
						brandDao.orderDetailInsert(param);
						
						Map<String,Object> totalOrders = brandMenuDao.menuSelectOne((String)param.get("BRANDMENUNUM"));
						BigDecimal ogTotal = ((BigDecimal)totalOrders.get("TOTALORDERS"));
						
						int orderQuantity = Integer.parseInt((String)param.get("ORDERQUANTITY"));
						BigDecimal decimalOrderQuantity = new BigDecimal(orderQuantity);
							
						param.put("TOTALORDERS",ogTotal.add(decimalOrderQuantity));
						brandMenuDao.menuTotalOrderUpdate(param);
					}
					String orderNumber = orderNumberDate.format(today)+(String)param.get("ORDERNUM");
					param.put("ORDERNUMBER",orderNumber);
					if(brandDao.orderNumberUpdate(param)>0) {
						if(delivRegiCheck.equals("D")) { //배달일 경우
							if(brandDao.deliveryInsert(param)>0) {
								mail(param,memberNUM);
								return true;
							}
						}else if(delivRegiCheck.equals("R")){ //예약일 경우
							if(brandDao.reservationInsert(param)>0) {
								mail(param,memberNUM);
								return true;							
							}
						}									
					}
				}
			}
		}else { //회원일 경우
			param.put("NONMEMBERNUM", null);
			
			int usedPoint = 0;
			if(!(param.get("USEDPOINT").equals(""))) { //포인트 사용
				usedPoint = Integer.parseInt((String)param.get("USEDPOINT"));
				param.put("PAYMENTAMOUNT", paymentAmount+usedPoint);
				param.put("POINTAMOUNT", usedPoint);
			}else {
				param.put("POINTAMOUNT", usedPoint);
				param.put("USEDPOINT", "0");
			}
			
			if(brandDao.orderInfoInsert(param)>0) {
				if(!(param.get("USEDPOINT").equals("0"))) {
					brandDao.pointHistoryInsert(param);
					
					brandDao.memeberUpdatePointTotal(param);
				}
				
				for(int i=0;i<items.length();i++) {
					JSONObject item = items.getJSONObject(i);
					param.put("BRANDMENUNUM", item.get("menuNUM"));
					param.put("ORDERQUANTITY", item.get("orderQuantity"));
					brandDao.orderDetailInsert(param);
					
					Map<String,Object> totalOrders = brandMenuDao.menuSelectOne((String)param.get("BRANDMENUNUM"));
					BigDecimal ogTotal = ((BigDecimal)totalOrders.get("TOTALORDERS"));
					
					int orderQuantity = Integer.parseInt((String)param.get("ORDERQUANTITY"));
					BigDecimal decimalOrderQuantity = new BigDecimal(orderQuantity);
					
					param.put("TOTALORDERS",ogTotal.add(decimalOrderQuantity));
					brandMenuDao.menuTotalOrderUpdate(param);
				}
				String orderNumber = orderNumberDate.format(today)+(String)param.get("ORDERNUM");
				param.put("ORDERNUMBER",orderNumber);
				if(brandDao.orderNumberUpdate(param)>0) {
					if(delivRegiCheck.equals("D")) {
						if(brandDao.deliveryInsert(param)>0) {
							mail(param,memberNUM);
							return true;
						}
					}else if(delivRegiCheck.equals("R")){
						if(brandDao.reservationInsert(param)>0) {
							mail(param,memberNUM);
							return true;							
						}
					}					
				}
			}
		}
		return false;
	}
	
	//주문완료 시 내용 메일로 발송하는 매서드
	private void mail(Map<String,Object> param, String memberNUM){
		  String charSet = "utf-8";
	      String hostSMTP = "smtp.naver.com";      
	      String hostSMTPid = "fooconhelp@naver.com"; // 본인의 아이디 입력      
	      String hostSMTPpwd = "Foocon123!@"; // 비밀번호 입력
	      	      
	      // 보내는 사람 EMail, 제목, 내용 
	      String fromEmail = "fooconhelp@naver.com"; // 보내는 사람 eamil
	      String fromName = "Foocon";  // 보내는 사람 이름
	      String subject = "주문번호입니다."; // 제목
	      
    	  // 받는 사람 E-Mail 주소
	      String mail = null;
	      if(memberNUM == null) { //비회원일 경우
	    	  mail = (String)param.get("NONMEMBEREMAIL");       	    	  
	      }else {
	    	  Map<String,Object> tmp = memberDao.memberSelectOne(memberNUM);
	    	  mail = (String)tmp.get("MEMBEREMAIL");      
	      }
	      
	      try {
	         HtmlEmail email = new HtmlEmail();
	         email.setDebug(true);
	         email.setCharset(charSet);
	         email.setSSL(true);
	         email.setHostName(hostSMTP);
	         email.setSmtpPort(587);   // SMTP 포트 번호 입력

	         email.setAuthentication(hostSMTPid, hostSMTPpwd);
	         email.setTLS(true);
	         email.addTo(mail, charSet);
	         email.setFrom(fromEmail, fromName, charSet);
	         email.setSubject(subject);
	         email.setHtmlMsg("<p>주문번호는 "+(String)param.get("ORDERNUMBER")+"입니다.</p>"); // 본문 내용
	         email.send();         
	      } catch (Exception e) {
	         System.out.println(e);
	      }
	}
	
	public Map<String,Object> orderFormView(String seq,String brandNUM){
		Map<String,Object> orderFormView = new HashMap<String,Object>();
		if(seq != null) {			
			orderFormView.put("member", memberDao.memberSelectOne(seq));
		}
		orderFormView.put("brandImage", brandDao.brandImage(brandNUM));
		orderFormView.put("brandInfoView", brandDao.brandViewInfoView(brandNUM));
		return orderFormView;
	}
	
	
	/********************************** 관리자 **********************************/	
	public Map<String,Object> admin_menuView(Map<String,Object> param,int page,String authority){
		int currentPage = page;
		
		/*화면 출력에 필요한 값*/
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		
		/*데이터 조회에 필요한 값*/
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		String keyword = (String)param.get("KEYWORD");
		param.put("FIRSTROW", firstRow);
		param.put("ENDROW", endRow);
		param.put("KEYWORD", keyword);
		
		
		String seq = (String)param.get("SEQ");
		//권한에 따라 현재 게시글의 총 개수를 넣어주기
		int pageTotalCount = 0;
		
		int menuCounting = 0;
		
		List<Map<String,Object>> menuListView = null;
		
		Map<String,Object> result = new HashMap<String,Object>();
		if(authority.equals("BRAND")) { //브랜드일 경우
			Map<String,Object> tmp = brandDao.brandSelectOne(seq);
			if(tmp == null) { //브랜드를 안만들었을 경우
				result.put("warning","warning");
				return result;
			}else { //브랜드가 있을 경우
				String brandNUM = (String)tmp.get("BRANDNUM");
				param.put("BRANDNUM", brandNUM);
				
				 menuCounting = brandMenuDao.menuCountView(param);
				
				pageTotalCount = getPageTotalCount(menuCounting);
				menuListView = brandMenuDao.menuSearchView(param);				
			}
		} else if(authority.equals("MASTER")){ // 본사일 경우
			
			menuCounting = brandMenuDao.menuTotalCountView(param);
			pageTotalCount = getPageTotalCount(menuCounting);
			
			menuListView = brandMenuDao.menuSearchTotalView(param);
	
			
		} 
		
		result.put("menuCounting", menuCounting);
		result.put("menuListView", menuListView);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("currentPage", currentPage);
		result.put("pageTotalCount", pageTotalCount);
		
		
		return result;
	}
	
	private int getPageTotalCount(int totalCount) {
		int pageTotalCount = 0;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_MESSAGE_PER_PAGE));
		}
		return pageTotalCount;
	}
	private int getStartPage(int currentPage) {
		return ((currentPage-1)/NUM_OF_NAVI_PAGE)*NUM_OF_NAVI_PAGE + 1;
	}
	private int getEndPage(int currentPage) {
		return  (((currentPage-1)/NUM_OF_NAVI_PAGE)+1)* NUM_OF_NAVI_PAGE;
	}
	private int getFirstRow(int currentPage) {
		return (currentPage-1)*NUM_OF_MESSAGE_PER_PAGE +1;
	}
	private int getEndRow(int currentPage) {
		return currentPage*NUM_OF_MESSAGE_PER_PAGE;
	}
	
	
	public boolean admin_menuDelete(Map<String,Object> param) {
		boolean result = false;
		param.put("QUITMENU",'Y');
		if(brandMenuDao.menuQuitMenuUpdate(param) > 0) {
			result = true;
		}
		return result;
	}
	
	public Map<String,Object> admin_menuView(String brandMenuNUM) {
		if(brandMenuNUM == null) {
			Map<String,Object> param = new HashMap<String,Object>();
			return param;
		}
		return brandMenuDao.menuSelectOne(brandMenuNUM);		
	}
	
	public boolean admin_menuSave(Map<String,Object> param) {
		String brandMenuNUM = (String) param.get("BRANDMENUNUM");
		if(brandMenuNUM.equals("")) { //새로운 메뉴추가일 경우			
			Map<String,Object> tmp = brandDao.brandSelectOne((String)param.get("BRANDOWNERNUM"));
			param.put("BRANDNUM", (String)tmp.get("BRANDNUM"));
			brandMenuDao.menuInsert(param);
			
			String brandMenuNUMSelectKey = (String)param.get("BRANDMENUNUM");
			
			Date today = new Date();			
			SimpleDateFormat date= new SimpleDateFormat("yyMMdd");
			param.put("MENUCODE","M"+date.format(today)+brandMenuNUMSelectKey);
		}
		
		if(brandMenuDao.menuUpdate(param) > 0) {
			return true;
		}
		return false;		
	}
	
	
	public Map<String,Object> admin_brandView(String seq){
		return brandDao.adminBrandView(seq);
	}
	public Map<String,Object> admin_brandViewSeconds(String brandNUM){
		return brandDao.adminBrandViewSeconds(brandNUM);
	}
	public Map<String,Object> admin_brandInfoCounting(String seq,String brandNUM) {
		Map<String,Object> brandInfoCounting = new HashMap<String,Object>();
	
		if(brandNUM == null && !(seq.equals("MASTER"))) { //브랜드일  경우
			Map<String,Object> brandResult = brandDao.adminBrandView(seq);
			if(brandResult.get("BRANDNUM") == null) { //브랜드테이블 생성하지 않았을 경우
				brandInfoCounting.put("totalPaymentAmount","0");
				brandInfoCounting.put("totalOrder","0");
				brandInfoCounting.put("totalDelivery","0");
				brandInfoCounting.put("totalReserve","0");
				brandInfoCounting.put("totalFavor","0");
				brandInfoCounting.put("totalReview","0");
				brandInfoCounting.put("totalMenu","0");
				brandInfoCounting.put("brandImages",null);
				return brandInfoCounting;
			}else { //브랜드 테이블이 생성되어 있을 경우
				brandNUM = (String)brandResult.get("BRANDNUM");
				return brandInfoCounting(brandNUM);
			}
		} else { //마스터일 경우
		
			return brandInfoCounting(brandNUM);
		}
	}
	
	private Map<String,Object> brandInfoCounting(String brandNUM){
		Map<String,Object> brandInfoCounting = new HashMap<String,Object>();
		brandInfoCounting.put("totalOrder",brandDao.orderTotalCount(brandNUM));
		brandInfoCounting.put("totalDelivery",brandDao.orderDeliveryCount(brandNUM));
		brandInfoCounting.put("totalReserve",brandDao.orderReserveCount(brandNUM));
		brandInfoCounting.put("totalFavor",brandDao.brandInterestTotalCountView(brandNUM));
		brandInfoCounting.put("totalReview",brandDao.reviewCount(brandNUM));
		brandInfoCounting.put("totalMenu",brandDao.menuCountView(brandNUM));
		brandInfoCounting.put("totalPaymentAmount",brandDao.orderTotalPaymentAmountCount(brandNUM));
		brandInfoCounting.put("brandImages",brandDao.brandImageSelectOne(brandNUM));
		return brandInfoCounting;
	}
	
	public boolean admin_brandUpdate(Map<String,Object> param) {
		Map<String,Object> resultParam = admin_brandSaveAdditional(param);
//		파일을 빈값으로 넣을 때 어떻게 처리할 것인지 생각(인설트, 업데이트)
		resultParam = admin_brandImage(resultParam);
		
		int detailImageCount = (int)resultParam.get("DETAILIMAGECOUNT");
		int thumnailImageCount = (int)resultParam.get("THUMNAILIMAGECOUNT");
		
		if(thumnailImageCount!=0 && detailImageCount!=0) {
			if((int)brandDao.brandUpdate(resultParam)>0 &&  
				(int)brandDao.brandOwnerUpdate(resultParam)>0 && 
				(int)brandDao.brandPositionUpdate(resultParam)>0 &&
				(int)brandDao.brandImageUpdate(resultParam)>0) {
				return true;
			}	
		}else if(thumnailImageCount==0 && detailImageCount==0) {
			if((int)brandDao.brandUpdate(resultParam)>0 &&  
				(int)brandDao.brandOwnerUpdate(resultParam)>0 && 
				(int)brandDao.brandPositionUpdate(resultParam)>0) {
				return true;
			}
		}else {
			if(thumnailImageCount==0) { //썸네일 안넣을 경우
				resultParam.put("THUMNAILIMAGE", "Y");
			}
			if(detailImageCount==0) { //상세 안넣을 경우
				for(int i=0;i<10;i++) {
					resultParam.put("IMAGE"+(i+1),"Y");
				}
			}
			if((int)brandDao.brandUpdate(resultParam)>0 &&  
				(int)brandDao.brandOwnerUpdate(resultParam)>0 && 
				(int)brandDao.brandPositionUpdate(resultParam)>0 &&
				(int)brandDao.brandImageUpdate(resultParam)>0) {
				return true;
			}
		}	
		return false;
	}
	
	
	public boolean admin_brandInsert(Map<String,Object> param) {
		Map<String,Object> resultParam = admin_brandSaveAdditional(param);
		if((int)brandDao.brandInsert(resultParam)>0) {
			resultParam = admin_brandImage(resultParam);
			if((int)brandDao.brandOwnerUpdate(resultParam)>0 &&
				(int)brandDao.brandPositionInsert(resultParam)>0 &&
				(int)brandDao.brandImageInsert(resultParam)>0) {
				return true;	
			}else {
				brandDao.brandDelete(resultParam);
			}
		}
		return false;
	}
	
	private Map<String,Object> admin_brandSaveAdditional(Map<String,Object> param) {
		if(param.get("EXPOSURELEVEL_RECOMMAND").equals("RECOMMAND")) {
			param.put("EXPOSURELEVEL","RECOMMAND");
			if(param.get("EXPOSURELEVEL_MAIN").equals("MAIN")) {
				param.put("EXPOSURELEVEL","PACKAGE");
			}
		} else {
			param.put("EXPOSURELEVEL","NORMAL");
			if(param.get("EXPOSURELEVEL_MAIN").equals("MAIN")) {
				param.put("EXPOSURELEVEL","MAIN");
			}
		}
		
		String BrandOpenTime = (String)param.get("OPEN_TIME_HOUR")+","+(String)param.get("OPEN_TIME_MINUTE")+","+
							   (String)param.get("CLOSE_TIME_HOUR")+","+(String)param.get("CLOSE_TIME_MINUTE");
		param.put("BRANDOPENTIME", BrandOpenTime);
		return param;
	}
	
	private Map<String,Object> admin_brandImage(Map<String,Object> resultParam) {
		List<MultipartFile> imagesList = (List<MultipartFile>) resultParam.get("IMAGESLIST");
		MultipartFile thumnailImage = (MultipartFile) resultParam.get("THUMNAILIMAGE");
		
		String uploadPath = "C:\\temp";		
		UUID uuid = UUID.randomUUID();
		
		if((int)resultParam.get("THUMNAILIMAGECOUNT") == 0) { //썸네일이미지 안넣었을 경우
			resultParam.put("THUMNAILIMAGE", "fooconDefaultThumnailImage180804.jpg");
		}else {
			String thumnailImageFullName = uuid.toString()+"_"+thumnailImage.getOriginalFilename();
			File target = new File(uploadPath,thumnailImageFullName);
			try {
				FileCopyUtils.copy(thumnailImage.getBytes(), target);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			resultParam.put("THUMNAILIMAGE", thumnailImageFullName);			
		}
		
		
		
		if(imagesList.size()==0) { //상세이미지 안넣었을 경우
			resultParam.put("IMAGE1","fooconDefaultDetailImage180804.jpg");
			for(int i=1;i<10;i++) {
				resultParam.put("IMAGE"+(i+1),null);
			}
		}else {
			for(int i=0;i<imagesList.size();i++) {
				String imageFullName = uuid.toString()+"_"+imagesList.get(i).getOriginalFilename();
				File target = new File(uploadPath,imageFullName);
				resultParam.put("IMAGE"+(i+1),imageFullName);
				try {
					FileCopyUtils.copy(imagesList.get(i).getBytes(), target);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
			if(imagesList.size()!=10) {
				for(int i=imagesList.size();i<10;i++) {
					resultParam.put("IMAGE"+(i+1),null);
				}
			}
		}
		return resultParam;		
	}
	
	public boolean admin_brandOwnerPasswordChange(Map<String,Object> param) {
		Map<String,Object> resultParam = brandOwnerDao.brandOwnerSelectOne((String)param.get("BRANDOWNERNUM"));
		String originPassword = (String)resultParam.get("OWNERPASSWORD");
		if(originPassword.equals((String)param.get("OWNERPASSWORD"))) {
			if((int)brandOwnerDao.brandOwneUpdate(param)>0) {
				return true;				
			}
		}
		return false;
	}
	
	public boolean admin_menuDown(Map<String,Object> param) {
		String brandMenuNUM = (String)param.get("BRANDMENUNUM");
		Map<String,Object> downRow = brandMenuDao.menuSelectOne(brandMenuNUM);
		String menuTurn = String.valueOf(downRow.get("MENUTURN"));
		int intMenuTurn1 = Integer.parseInt(menuTurn);
		downRow.put("MENUTURN", intMenuTurn1-1);
		
		int intMenuTurn2= intMenuTurn1-1;
		Map<String,Object> upRow = brandMenuDao.menuTurnSelectOne(intMenuTurn2);
		upRow.put("MENUTURN", intMenuTurn1);
		if(brandMenuDao.menuUpDownUpdate(downRow)>0) {			
			if(brandMenuDao.menuUpDownUpdate(upRow)>0) {
				return true;
			}
		}
		return false;
	}
	
	public boolean admin_menuUp(Map<String,Object> param) {
		String brandMenuNUM = (String)param.get("BRANDMENUNUM");
		Map<String,Object> upRow = brandMenuDao.menuSelectOne(brandMenuNUM);
		String menuTurn = String.valueOf(upRow.get("MENUTURN"));
		int intMenuTurn1 = Integer.parseInt(menuTurn);
		upRow.put("MENUTURN", intMenuTurn1+1);
		
		int intMenuTurn2= intMenuTurn1+1;
		Map<String,Object> downRow = brandMenuDao.menuTurnSelectOne(intMenuTurn2);
		downRow.put("MENUTURN", intMenuTurn1);
		if(brandMenuDao.menuUpDownUpdate(upRow)>0) {			
			if(brandMenuDao.menuUpDownUpdate(downRow)>0) {
				return true;
			}
		}
		return false;
	}
	///////////////////////원용///////////////////////
}
