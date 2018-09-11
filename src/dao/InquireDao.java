package dao;

import java.util.List;
import java.util.Map;

public interface InquireDao {
	//문의 등록
	public int insertInquire(Map<String, Object>params);
	//문의답변 여부 변경
	public int updateInquire(String inquireNum);
	//회원 문의 내역보기
	public List<Map<String, Object>> selectAllUser(Map<String,Object>params);
	//관리자 문의내역 보기
	public List<Map<String, Object>> selectAllAdmin(Map<String,Object>params);
	//회원개인 문의 갯수
	public int inquireCount(String MemberNum);
	//관리자 모든 문의 갯수
	public int inquireCountAdmin(Map<String,Object>params);
	//관리자 문의 상세보기
	public Map<String, Object> selectOneAdmin(String INQUIRENUM);
}

