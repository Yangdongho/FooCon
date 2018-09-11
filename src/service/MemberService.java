package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import dao.MemberDao;

@Service
public class MemberService{
		//한페이지에 표시될 목록 개수
		private static final int NUM_OF_BOARD_PER_PAGE=10;
		//한번에 표시될 네비게이션 개수
		private static final int NUM_OF_NAVI_PAGE=5;
		private static final int NUM_OF_REVIEW_PER_PAGE = 10;
	@Autowired
	MemberDao memberDao;
	public Map<String, Object> selectMemberOrderList(Map<String, Object>params){
		int page = (int)params.get("PAGENUM");
		
		//화면 출력에 필요한 값
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		//데이터 조회에 필요한 값
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		params.put("FIRSTROW",firstRow);
		params.put("ENDROW",endRow);
		
		int totalCount = memberDao.countOrderList(params);
		int pageTotalCount = getPageTotalCount(totalCount);
		List<Map<String, Object>> oList = memberDao.selectAllMemberOrderList(params);
		
		for(Map<String, Object> o : oList) {
			o.put("menuList", memberDao.selectAllMemberOrderMenu((String)o.get("ORDERNUM")));
		}
		
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("orderList", oList);
		param.put("startPage",startPage);
		param.put("endPage", endPage);
		param.put("currentPage",page);
		param.put("totalCount", pageTotalCount);
		return param;
	}
	public Map<String,Object> selectAllMemberPoint(Map<String,Object>params){
		
		int page = (int)params.get("PAGENUM");
		
		//화면 출력에 필요한 값
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		//데이터 조회에 필요한 값
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		params.put("FIRSTROW",firstRow);
		params.put("ENDROW",endRow);
		
		
		int totalCount = memberDao.countPointList(params);
		int pageTotalCount = getPageTotalCount(totalCount);
		
		List<Map<String,Object>> pList =  memberDao.selectAllMemberPointList(params);
		for(Map<String,Object> p : pList) {
			p.put("menuList",memberDao.selectAllMemberOrderMenu((String)p.get("ORDERNUM")));
		}
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		param.put("pointList", pList);
		param.put("startPage", startPage);
		param.put("endPage", endPage);
		param.put("currentPage", page);
		param.put("totalCount", pageTotalCount);
		
		return param;
		
	}

	
	
	
	public Map<String,Object> getMember(String memberNum){
		Map<String,Object> member = memberDao.selectOne(memberNum);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("MEMBERNUM", member.get("MEMBERNUM"));
		param.put("CHECK", "D");
		member.put("countD",memberDao.countOrderByMember(param));
		param.put("CHECK", "R");
		member.put("countR",memberDao.countOrderByMember(param));
		member.put("total",memberDao.sumAmount((String)param.get("MEMBERNUM")));
		member.put("favor",memberDao.countFavorBrand((String)param.get("MEMBERNUM")));
		member.put("total",memberDao.sumAmount((String)param.get("MEMBERNUM")));
		return member;
}
	public Map<String, Object> getMemberList(Map<String,Object> temp) {
		
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
		
			totalCount  = memberDao.countMember(temp); //리뷰 개수
			List<Map<String,Object>> memberList = memberDao.selectAll(param);
			for (Map<String, Object> member : memberList) {
			
			Map<String,Object> tmp = new HashMap<String,Object>();
			tmp.put("MEMBERNUM", member.get("MEMBERNUM"));
			tmp.put("CHECK", "D");
			member.put("countD",memberDao.countOrderByMember(tmp));
			tmp.put("CHECK", "R");
			member.put("countR",memberDao.countOrderByMember(tmp));
			member.put("total",memberDao.sumAmount((String)tmp.get("MEMBERNUM")));
		}
		
		
		
		viewData.put("currentPage",pageNumber);
		viewData.put("memberList", memberList);
		viewData.put("pageTotalCount",getPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("keyword", temp.get("keyword"));
		return viewData;
	}

	
	//총페이지 개수 계산
	private int getPageTotalCount(int totalCount) {
		int pageTotalCount = 0;
		if(totalCount!=0) {
			pageTotalCount = (int)Math.ceil(((double)totalCount/NUM_OF_BOARD_PER_PAGE));
		}return pageTotalCount;
	}
	//시작 페이지 계산
	private int getStartPage(int currentPage) {
		return ((currentPage)/NUM_OF_NAVI_PAGE)*NUM_OF_NAVI_PAGE+1;
	}
	//끝 페이지 계산
	private int getEndPage(int currentPage) {
		return (((currentPage-1)/NUM_OF_NAVI_PAGE)+1)*NUM_OF_NAVI_PAGE;
	}
	//fistRow 계산
	private int getFirstRow(int currentPage) {
		return (currentPage-1)*NUM_OF_BOARD_PER_PAGE+1;
	}
	//EndRow 계산
	private int getEndRow(int currentPage) {
		return currentPage*NUM_OF_BOARD_PER_PAGE;
	}
	
	
}
