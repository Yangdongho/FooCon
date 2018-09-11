package dao;

import java.util.List;
import java.util.Map;

public interface PointDao {
	//관리자 포인트 내역 조회(회원,포인트,주문)
	public List<Map<String, Object>> selectAllAdmin(Map<String,Object>params);
	//관리자 포인트  내역 조회(주문상세)
	public List<Map<String, Object>> selectAllMenu(String ORDERNUM);
	//회원별 포인트 내역
	public List<Map<String, Object>> selectAllUser(Map<String,Object>params);
	//회원 총 보유 포인트 
	public  Map<String,Object> UserTotalPoint(Map<String,Object>params);
	//회원 총 리스트 수
	public int pointCount(Map<String,Object>params);
	//모든포인트 내역 갯수
	public int pointCountAdmin(Map<String,Object>params);
}
