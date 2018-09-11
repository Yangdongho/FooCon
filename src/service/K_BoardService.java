package service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.bind.attachment.AttachmentMarshaller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.FaqDao;
import dao.InquireDao;
import dao.InqurieReplyDao;
import dao.NoticeDao;
import dao.PointDao;


@Service
public class K_BoardService {
	//한페이지에 표시될 목록 개수
	private static final int NUM_OF_BOARD_PER_PAGE=10;
	//한번에 표시될 네비게이션 개수
	private static final int NUM_OF_NAVI_PAGE=5;
	@Autowired
	FaqDao faqdao;
	@Autowired
	InquireDao inquiredao;
	@Autowired
	InqurieReplyDao replydao;
	@Autowired
	PointDao pointdao;
	@Autowired
	NoticeDao noticedao;
	
	//FAQ등록
	public boolean insertFaq(Map<String, Object>params) {
		
		int result = faqdao.insertFaq(params);
		if(result>0) {
			return true;
		}
		return false;
	}
	//FAQ전체 리스트 뿌리기
	public List<Map<String,Object>> selectAll() {
//		System.out.println(dao.selectAll());
		return faqdao.selectAll();
	}
	//FAQ하나 상세보기
	public Map<String, Object> selectOne(String faqNum){
		return faqdao.selectOne(faqNum);
	}
	//FAQ수정하기
	public boolean updateFaq(Map<String,Object>params) {
		int result = faqdao.updateFaq(params);
		if(result>0) {
			return true;
		}return false;
	}
	//FAQ삭제하기
	public boolean deleteFaq(String faqNum) {
		int result=faqdao.deleteFaq(faqNum);
		if(result>0) {
			return true;
		}return false;
	}
	//모든 공지사항 불러오기
	public Map<String, Object> selectAllNotice(Map<String, Object>params){
		
		int page = (int)params.get("PAGENUM");
		int totalContent = noticedao.countNotice(params);
		
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		params.put("FIRSTROW", firstRow);
		params.put("ENDROW", endRow);
		
		int pageTotalCount = getPageTotalCount(totalContent);
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		param.put("noticeList", noticedao.selectAllNotice(params));
		param.put("startPage", startPage);
		param.put("endPage",endPage);
		param.put("totalCount", pageTotalCount);
		param.put("currentPage",page);
		return param;
	}
	//공지사항 등록하기
	public boolean insertNotice(Map<String, Object>params) {
		int result = noticedao.insertNotice(params);
		
		if(result>0) {
			return true;
		}return false;
	}
	//공지사항 삭제하기
	public boolean deleteNotice(String noticeNum) {
		int result =noticedao.deleteNotice(noticeNum);
		if(result>0) {
			return true;
		}return false;
	}
	//공지사항 상세보기
	public Map<String, Object> selectOneNotice(String NOTICENUM) {
		return noticedao.selectOneNotice(NOTICENUM);
	}
	//공지사항 수정하기
	public boolean updateNotice(Map<String,Object>params) {
		int result = noticedao.updateNotice(params);
		if(result>0) {
			return true;
		}return false;
	}

	//이전글,다음글 제목 가져오기
	public Map<String,Object> userPage(String rnum){
		return noticedao.userPage(rnum);
	}
	//조회수 올려주기
	public boolean updateCount(Map<String, Object>params) {
		int result =noticedao.updateViewCount(params);
		if(result>0) {
			return true;
		}return false;
	}
	//1:1문의 등록하기
	public boolean insertInquire(Map<String,Object>params) {
		int result = inquiredao.insertInquire(params);
		if(result>0) {
			return true;
		}return false;
	}
	
	//회원별 문의 내역 가져오기
	public Map<String,Object> selectAllUser(Map<String,Object>params){
		
		
		String MemberNum = (String)params.get("MEMBERNUM");
		int totalContent = inquiredao.inquireCount(MemberNum);
		int page = (int)params.get("PAGENUM");
		
		//화면 출력에 필요한 값
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		//데이터 조회에 필요한 값
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		params.put("FIRSTROW",firstRow);
		params.put("ENDROW",endRow);
		
		
		int pageTotalCount = getPageTotalCount(totalContent);
		inquiredao.selectAllUser(params);
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("userInquireList", inquiredao.selectAllUser(params));
		param.put("startPage",startPage);
		param.put("endPage",endPage);
		param.put("currentPage",page);
		param.put("totalCount", pageTotalCount);
		param.put("totalContent", totalContent);
		return param;
		
	}
	
	//관리자 페이지 1:1문의 내역 리스트
	public Map<String,Object> selectAllAdmin(Map<String,Object>params){
		
			int pageTotalCount;
			int page = (int)params.get("PAGENUM");
			
			//화면 출력에 필요한 값
			int startPage = getStartPage(page);
			int endPage = getEndPage(page);
			//데이터 조회에 필요한 값
			int firstRow = getFirstRow(page);
			int endRow = getEndRow(page);
			
			params.put("FIRSTROW",firstRow);
			params.put("ENDROW",endRow);
			
			
			pageTotalCount = getPageTotalCount(inquiredao.inquireCountAdmin(params));
			inquiredao.selectAllAdmin(params);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("adminInquireList", inquiredao.selectAllAdmin(params));
			param.put("startPage",startPage);
			param.put("endPage",endPage);
			param.put("currentPage",page);
			param.put("totalCount", pageTotalCount);
			param.put("totalContent", inquiredao.inquireCountAdmin(params));
			
			return param;
			
		}

	//관리자 1:1문의 상세보기
	public Map<String,Object> selectOneAdmin(String INQUIRENUM){
		return inquiredao.selectOneAdmin(INQUIRENUM);
	}
	//관리자 1:1문의 댓글등록
	public boolean insertInquireReply(Map<String,Object>params) {
		int result=replydao.insertInquireReply(params);
		if(result>0) {
			return true;
		}return false;
	}
	//1:1문의 댓글 등록여부 업데이트
	public boolean updateInquire(String INQUIRENUM) {
		int result=inquiredao.updateInquire(INQUIRENUM);
		if(result>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//관리자 포인트 내역 조회
	public Map<String,Object> selectAllPointAdmin(Map<String,Object>params){
		
		int page = (int)params.get("PAGENUM");
		
		//화면 출력에 필요한 값
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		//데이터 조회에 필요한 값
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		params.put("FIRSTROW",firstRow);
		params.put("ENDROW",endRow);
		
		
		int totalCount = pointdao.pointCountAdmin(params);
		int pageTotalCount = getPageTotalCount(totalCount);
		
		List<Map<String,Object>> pList =  pointdao.selectAllAdmin(params);
		for(Map<String,Object> p : pList) {
			p.put("menuList",pointdao.selectAllMenu((String)p.get("ORDERNUM")));
		}
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		param.put("pointList", pList);
		param.put("startPage", startPage);
		param.put("endPage", endPage);
		param.put("currentPage", page);
		param.put("totalCount", pageTotalCount);
		
		return param;
		
	}
	//회원 포인트 내역
	public Map<String,Object> selectAllUserPoint(Map<String,Object>params){
		
		int page = (int)params.get("PAGENUM");
		
		//화면 출력에 필요한 값
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		//데이터 조회에 필요한 값
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		params.put("FIRSTROW",firstRow);
		params.put("ENDROW",endRow);
		
		
		int totalCount = pointdao.pointCount(params);
		int pageTotalCount = getPageTotalCount(totalCount);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("totalPoint", pointdao.UserTotalPoint(params));
		param.put("pointList",pointdao.selectAllUser(params));
		param.put("startPage", startPage);
		param.put("endPage", endPage);
		param.put("currentPage", page);
		param.put("totalCount", pageTotalCount);
		
		return param;
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
