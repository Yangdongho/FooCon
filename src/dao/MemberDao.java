package dao;

import java.util.List;
import java.util.Map;

public interface MemberDao {
	public List<Map<String,Object>> selectAll(Map<String,Object> param);
	public int countMember(Map<String,Object> param);
	public int countOrderByMember(Map<String,Object> param);
	public int countFavorBrand(String memberNum);
	public String sumAmount(String memberNum);
	public Map<String,Object> selectOne(String memberNum);
	//멤버의 모든 주문내역
		public List<Map<String, Object>> selectAllMemberOrderList(Map<String, Object> params);
		//멤버의 모든 포인트 사용내역
		public List<Map<String, Object>> selectAllMemberPointList(Map<String, Object> params);
		//멤버별 주문 메뉴내역
		public List<Map<String, Object>> selectAllMemberOrderMenu(String ORDERNUM);
		//멤버별 관심트럭
		public List<Map<String,Object>> selectAllFavorBrand(String MEMBERNUM);
		//주문내역 갯수
		public int countOrderList(Map<String,Object>params);
		//포인트 사용내역 갯수
		public int countPointList(Map<String, Object>params);
	public Map<String,Object> memberSelectOne(String seq);
	
	//나래
	//각 회원들이 누른 관심브랜드들만 가져옴
	List<Map<String, Object>> memberFaovrBrand(String memberPK);
}
