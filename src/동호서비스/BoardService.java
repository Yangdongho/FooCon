package 동호서비스;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.Admin_OrderDao;
import dao.MemberDao;
import dao.OrderDao;
import dao.ReviewDao;

@Service
public class BoardService {
	
	@Autowired
	ReviewDao reviewdao;
	
	@Autowired
	Admin_OrderDao admin_OrderDao;
	
	@Autowired
	OrderDao orderDao;
	
	@Autowired
	MemberDao memberdao;
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
			param.put("brandNum", temp.get("brandNum"));
		}
		
		if(temp.get("category")!=null && temp.get("category")!="") {
			param.put("category",temp.get("category"));
		}
		
			totalCount  = reviewdao.countReview(temp); //리뷰 개수
	
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
	
	public Map<String, Object> getOrderList(Map<String,Object> temp) {
		
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
			param.put("brandNum", temp.get("brandNum"));
		}
		
		if(temp.get("category")!=null && temp.get("category")!="") {
			param.put("category",temp.get("category"));
		}
		
			totalCount  = admin_OrderDao.countOrder(temp); //리뷰 개수
			System.out.println(temp);
			System.out.println(param);
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
	
		File originFile = new File("C:/review/"+fileName);
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

	
	
}
