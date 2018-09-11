package 동호서비스;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import dao.OrderDao;
import dao.PointHistoryDao;
import dao.ReviewDao;

@Service
public class OrderService {
	
	@Autowired
	OrderDao dao;
	
	@Autowired
	ReviewDao reviewdao;
	
	@Autowired
	PointHistoryDao pointdao;
	
	private static final int NUM_OF_ORDER1_PER_PAGE = 3;
	private static final int NUM_OF_NAVI_PAGE = 1;
	private static final String uploadPath = "C:\\review";
	
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
		System.out.println(order);
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
		viewData.put("pageTotalCount",calPageTotalCount(totalCount));
		return viewData;
	}
	
	private int calPageTotalCount(int totalCount) {
		
		int pageTotalCount = 0;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_ORDER1_PER_PAGE));
		}
		return pageTotalCount;
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
