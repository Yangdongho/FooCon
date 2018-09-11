package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.AdInquireDao;

@Service
public class BoardService {
	///////////////////////원용///////////////////////
	@Autowired
	private AdInquireDao adInquireDao;
	
	private static final int NUM_OF_MESSAGE_PER_PAGE = 10;
	private static final int NUM_OF_NAVI_PAGE = 5;
	
	public boolean adReferenceResult(Map<String,Object> param) {
		if(adInquireDao.adReferenceInsert(param) > 0) {
			return true;
		}
		return false; 
	}
	
	public Map<String,Object> admin_adReferenceList(Map<String,Object> param, int page) {
		int currentPage = page;
				
		/*화면 출력에 필요한 값*/
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		
		/*데이터 조회에 필요한 값*/
		int firstRow =  getFirstRow(page);
		int endRow =  getEndRow(page);
		
		param.put("FRISTROW", firstRow);
		param.put("ENDROW", endRow);
		
		String keyword = (String)param.get("keyword");
		if(param.get("type") == null || param.get("type") == "") {
			param.put("INQUIRETYPE", null);
		}else {
			param.put("INQUIRETYPE", param.get("type"));			
		}
		if(param.get("keyword") == null || param.get("keyword") == "") {
			param.put("INPUIREBRAND", null);
			param.put("INQUIRENAME", null);
		}else {
			param.put("INPUIREBRAND", keyword);
			param.put("INQUIRENAME", keyword);
		}
		
		int pageTotalCount = getPageTotalCount(adInquireDao.totalAdInquire(param));
		List<Map<String,Object>> adReferenceList = adInquireDao.searchAdInquire(param);
		
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("adReferenceList", adReferenceList);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("currentPage", currentPage);
		result.put("pageTotalCount", pageTotalCount);
		result.put("selectBox", (String)param.get("INQUIRETYPE"));
		
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
	
	public Map<String,Object> admin_adReferenceView(String addInquireNUM){
		return adInquireDao.adReferenceSelectOne(addInquireNUM);
	}
	///////////////////////원용///////////////////////
}
