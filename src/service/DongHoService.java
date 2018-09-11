package service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import dao.Admin_OrderDao;
import dao.EventDao;
import dao.MemberDao;
import dao.OrderDao;
import dao.PointHistoryDao;
import dao.ReviewDao;

@Service
public class DongHoService {
	@Autowired
	ReviewDao reviewdao;
	
	@Autowired
	Admin_OrderDao admin_OrderDao;
	
	@Autowired
	OrderDao orderDao;
	
	@Autowired
	MemberDao memberdao;
	
	@Autowired
	
	EventDao eventDao;
	@Autowired
	OrderDao dao;
	
	@Autowired
	PointHistoryDao pointdao;
	
	private static final int NUM_OF_ORDER1_PER_PAGE = 3;
	private static final int NUM_OF_EVENT_PER_PAGE = 10;
	private static final String uploadPath = "C:\\temp";
	
	
	private static final int NUM_OF_REVIEW_PER_PAGE = 10;
	private static final int NUM_OF_NAVI_PAGE = 5;
	private static final int NUM_OF_ORDER_PER_PAGE = 10;
	
	public boolean addReply(Map<String,Object> reply) {

		if(reviewdao.insertReply(reply)==1) {
			
			if(reviewdao.updateReview((String)reply.get("reviewNum"))==1) {
				return true;
			}
			else {
				return false;
			}

		}else {
			return false;
		}
	}
	public Map<String, Object> getReview(String reviewNum) {
		return reviewdao.selectOne(reviewNum);
	}
	
	public Map<String,Object> getOrder(String orderNum){
		Map<String,Object> order = admin_OrderDao.selectOrder(orderNum);
		order.put("menuList",orderDao.selectMenuList(orderNum));
		return order;
	}

	public boolean removeReview(String reviewNum) {
		reviewdao.deleteReview(reviewNum);
		return true;
	}
	
	public String getBrandNum(String brandOwnerNum) {
		
		return admin_OrderDao.selectBrandNum(brandOwnerNum);
	};
	

	public Map<String, Object> getReviewList(Map<String,Object> temp) {
		
		Map<String, Object> viewData = new HashMap<String,Object>();
		
		int firstRow = 0;
		int endRow =0;
		int totalCount = 0;  //총 메시지의 개수, 총 페이지수를 구하기 위해 필요
		
		int pageNumber = (int) temp.get("pageNumber");
		firstRow = (pageNumber-1)*NUM_OF_REVIEW_PER_PAGE +1;
		endRow = pageNumber*NUM_OF_REVIEW_PER_PAGE;
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("firstRow", firstRow);
		param.put("endRow", endRow);
		
		
		if(temp.get("keyword")!=null && temp.get("keyword")!="") {
			param.put("keyword",temp.get("keyword"));
		}
		
		if(temp.get("brandNum")!=null) {
			param.put("brandNum", getBrandNum((String)temp.get("brandNum")));
		}
		
		if(temp.get("brandNum")!=null && getBrandNum((String)temp.get("brandNum"))==null) {
			return null;
		}
		
		if(temp.get("category")!=null && temp.get("category")!="") {
			param.put("category",temp.get("category"));
		}
			
			totalCount  = reviewdao.countReview(param); //리뷰 개수
		
		List<Map<String,Object>> reviewList 
		  = reviewdao.selectAll(param);
		
		viewData.put("currentPage",pageNumber);
		viewData.put("reviewList", reviewList);
		viewData.put("pageTotalCount",calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("keyword", temp.get("keyword"));
		viewData.put("category", temp.get("category"));
		return viewData;
	}
	
	public Map<String, Object> getAdminOrderList(Map<String,Object> temp) {
		
		Map<String, Object> viewData = new HashMap<String,Object>();
		
		int firstRow = 0;
		int endRow =0;
		int totalCount = 0;  //총 메시지의 개수, 총 페이지수를 구하기 위해 필요
		
		int pageNumber = (int) temp.get("pageNumber");
		firstRow = (pageNumber-1)*NUM_OF_ORDER_PER_PAGE +1;
		endRow = pageNumber*NUM_OF_ORDER_PER_PAGE;
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("firstRow", firstRow);
		param.put("endRow", endRow);
		
		
		if(temp.get("keyword")!=null && temp.get("keyword")!="") {
			param.put("keyword",temp.get("keyword"));
		}
		
		if(temp.get("brandNum")!=null) {
			param.put("brandNum", getBrandNum((String)temp.get("brandNum")));
		}
		if(temp.get("brandNum")!=null && getBrandNum((String)temp.get("brandNum"))==null) {
			return null;
		}
		if(temp.get("category")!=null && temp.get("category")!="") {
			param.put("category",temp.get("category"));
		}
		
			totalCount  = admin_OrderDao.countOrder(param);
	
		List<Map<String,Object>> orderList 
		  = admin_OrderDao.selectOrderList(param);
		
		for (Map<String, Object> oneOrder : orderList) {
			oneOrder.put("menuList", orderDao.selectMenuList((String)oneOrder.get("ORDERNUM")));
			
		}
		
		
		viewData.put("currentPage",pageNumber);
		viewData.put("orderList", orderList);
		viewData.put("pageTotalCount",calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("keyword", temp.get("keyword"));
		viewData.put("category", temp.get("category"));
	
		return viewData;
	}
	
	public boolean addMemo(Map<String,Object> param) {
		admin_OrderDao.updateMemo(param);
		return true;
	}
	
	public List<Map<String,Object>> getExcelList(String brandNum){
		return admin_OrderDao.selectAllOrder(brandNum);
	}
	

	
	private int calPageTotalCount(int totalCount) {
	
		int pageTotalCount = 0;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_REVIEW_PER_PAGE));
		}
		return pageTotalCount;
	}
	
	private int calPageTotalCountPer3(int totalCount) {
		
		int pageTotalCount = 0;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_ORDER1_PER_PAGE));
		}
		return pageTotalCount;
	}
	
	public int getStartPage(int pageNum) {
	
		int startPage = ((pageNum-1)/NUM_OF_NAVI_PAGE)*NUM_OF_NAVI_PAGE + 1;
		
		return startPage;
	}
	
	
	public int getEndPage(int pageNum) {
		
		int endPage 
		= (((pageNum-1)/NUM_OF_NAVI_PAGE)+1)
		* NUM_OF_NAVI_PAGE;
		return endPage;
	}
	
	public byte[] getImegeAsByteArray(String reviewNum) {
		//특정이미지를 바이터 배열로 만들어서 반환한다!!!
		//C:\boardimg 이미지 경로
		String fileName = null;
		Map<String, Object> review = reviewdao.selectOne(reviewNum);
		fileName = (String)review.get("REVIEWPHOTO");
	
		File originFile = new File("C:/temp/"+fileName);
		InputStream targetStream = null;
		try {
			targetStream  = new FileInputStream(originFile);
			//스트림을 바이트로 변환 -> IOUtils , commons.io
			return IOUtils.toByteArray(targetStream);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	public void addViewCount(String eventNum) {
		eventDao.updateViewCount(eventNum);
	}
	public Map<String, Object> getEvent(String eventNum) {
		return eventDao.selectOne(eventNum);
	}

	public boolean removeEvent(String eventNum) {
		eventDao.delete(eventNum);
		return true;
	}
	
	public List<Map<String,Object>> getUserEventList(){
		Map<String,Object> param = new HashMap<String,Object>();
		int totalCount = eventDao.countEvent(param);
		param.put("firstRow",totalCount-5);
		param.put("endRow",totalCount);
		return eventDao.userSelectAll(param);
	}

	public boolean addEvent(Map<String,Object> event ,MultipartFile eventImg,MultipartFile thumnail ) {
		if(eventImg.getSize()!=0) {
			event.put("eventImg", writeFile(eventImg));
		}
		if(thumnail.getSize()!=0) {
			event.put("thumnail", writeFile(thumnail));
		}
		if(eventDao.insert(event)==1) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean modifyEvent(Map<String,Object> event ,MultipartFile eventImg,MultipartFile thumnail) {
	
		if(eventImg.getSize()!=0 && thumnail.getSize()!=0) {
			event.put("thumnail", writeFile(thumnail));
			event.put("eventImg", writeFile(eventImg));
		}else if(eventImg.getSize()!=0) {
			event.put("eventImg", writeFile(eventImg));
		}else if(thumnail.getSize()!=0) {
			event.put("thumnail", writeFile(thumnail));
		
		}
	
		if(eventDao.update(event)==1) {
			return true;
		}else {
			return false;
		}
		
		
	}
	//다운로드할때
	public File getAttachName(String eventNum) {
		//게시글에 포함된 첨부파일 가져오기 
				//게시글 번호를 이용해서 file fullName 얻어오고,
				//fullName을 이용해서 파일 얻어오기 
				//attach table에서 파일이름 얻어오기 
			Map<String, Object> event = eventDao.selectOne(eventNum);
			String fullName = (String)event.get("EVENTUPLOADFILE");
			return new File(uploadPath,fullName);
	}
	
	//서버에서 이미지 보내주기
	public byte[] getImegeAsByteArray(String type,String eventNum) {
		//특정이미지를 바이터 배열로 만들어서 반환한다!!!
		//C:\boardimg 이미지 경로
		String fileName = null;
		Map<String, Object> event = eventDao.selectOne(eventNum);
		if(type.equals("1")) {
			fileName = (String)event.get("EVENTUPLOADFILE");
		}else if(type.equals("2")){
			
			fileName = (String)event.get("EVENTTHUMNAIL");
		}
		
	
		
		File originFile = new File("C:/temp/"+fileName);
		//이셉션을 어디다가 보내야 하는지 물어보기
		InputStream targetStream = null;
		try {
			targetStream  = new FileInputStream(originFile);
			//스트림을 바이트로 변환 -> IOUtils , commons.io
			return IOUtils.toByteArray(targetStream);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}


	

	public Map<String, Object> getEventList(Map<String,Object> temp) {
			
		Map<String, Object> viewData = new HashMap<String,Object>();
		
		int firstRow = 0;
		int endRow =0;
		int totalCount = 0;  //총 메시지의 개수, 총 페이지수를 구하기 위해 필요
		
		int pageNumber = (int) temp.get("pageNumber");
		firstRow = (pageNumber-1)*NUM_OF_EVENT_PER_PAGE +1;
		endRow = pageNumber*NUM_OF_EVENT_PER_PAGE;
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("firstRow", firstRow);
		param.put("endRow", endRow);

		if(temp.get("keyword")!=null) {
			param.put("keyword",temp.get("keyword"));
		}
			totalCount  = eventDao.countEvent(temp); //이벤트 개수
		
		List<Map<String,Object>> eventList 
		  = eventDao.selectAll(param);
		
		viewData.put("currentPage",pageNumber);
		viewData.put("eventList", eventList);
		viewData.put("pageTotalCount",calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("keyword", temp.get("keyword"));
		
		return viewData;
	}
	public Map<String,Object> getOrderInfo(String orderNum){
		return dao.selectOrder(orderNum);
		
	}
	
	public Map<String,Object> getNonmemberOrderCheck(String orderNumber) {
		Map<String,Object> order = dao.selectNonMemberOrderList(orderNumber);
		order.put("menuList", dao.selectMenuList((String)order.get("ORDERNUM")));
		return order;
	}
	
	public Map<String,Object> getNonmemberOrderInfo(String orderNumber) {
		return dao.selectNonMemberOrderInfo(orderNumber);
	}
	
	public Map<String,Object> getOrderList(Map<String,Object> order){
		int firstRow = 0;
		int endRow =0;
		int pageNumber = (int) order.get("pageNumber");
		int totalCount = 0;	
		firstRow = (pageNumber-1)*NUM_OF_ORDER1_PER_PAGE +1;
		endRow = pageNumber*NUM_OF_ORDER1_PER_PAGE;
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("firstRow", firstRow);
		param.put("endRow", endRow);
		param.put("memberNum",order.get("memberNum"));
		if(order.get("DELIVREGICHECK")!=null && order.get("DELIVREGICHECK")!="" ) {
			param.put("CHECK",Integer.parseInt((String)order.get("DELIVREGICHECK")));
		}
	
		// viewDatga에 현재페이지랑 마지막페이지를 보내주어서 jsp에서 확인한다
		List<Map<String,Object>> orderList = dao.selectOrderList(param);
		
		for (Map<String, Object> oneOrder : orderList) {
			oneOrder.put("menuList", dao.selectMenuList((String)oneOrder.get("ORDERNUM")));
			Map<String,Object> reviewParam = new HashMap<String,Object>();
			reviewParam.put("memberNUM", order.get("memberNum"));
			reviewParam.put("orderNUM", oneOrder.get("ORDERNUM"));
			oneOrder.put("checkReview", dao.selectReview(reviewParam));
			
		}
		
		//토탈카운터수정
		totalCount = dao.countOrder(param);
		
		
		Map<String, Object> viewData = new HashMap<String,Object>();
		viewData.put("currentPage",pageNumber);
		viewData.put("ordertList", orderList);
		viewData.put("pageTotalCount",calPageTotalCountPer3(totalCount));
		return viewData;
	}

	
	public String writeFile(MultipartFile file) {
		//파일 저장하고 uuid가 붙은 파일이름 반환
		String fullName = null;
		UUID uuid = UUID.randomUUID();
		fullName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath,fullName);
		try {
			FileCopyUtils.copy(file.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fullName;
	}
	
	public boolean wirteReview(MultipartFile file, Map<String,Object> reviewParam) {
		//파일저장 
		//히스토리 테이블 ,리뷰테이블 작성
		if(file!=null && file.getSize()!=0) {
			reviewParam.put("reviewPhoto",writeFile(file));
		}
		
		
		if(reviewdao.insertReview(reviewParam)==1) {
			if(pointdao.insertHistory(reviewParam)==1) {
				reviewdao.updateMemberPoint((String)reviewParam.get("memberNum"));
				return true;
			}
			else {
				return false;
			}
		}else {
			return false;
		}
		
	}
}
