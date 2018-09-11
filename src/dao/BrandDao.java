package dao;

import java.util.List;
import java.util.Map;

public interface BrandDao {
	public Map<String,Object> brandViewInfoView(String brandNUM);
	public Map<String,Object> adminBrandView(String brandOwnerNUM);
	public Map<String,Object> brandSelectOne(String brandOwnerNUM);
	public Map<String,Object> adminBrandViewSeconds(String brandNUM);
	public List<Map<String,Object>> brandMenuView(String brandNUM);
	public Map<String,Object> brandInterestView(Map<String,Object> param);
	public int brandInterestTotalCountView(String brandNUM);
	public int brandInterestDelete(Map<String,Object> param);
	public int brandInterestInsert(Map<String,Object> param);
	public Map<String,Object> brandImage(String brandNUM);
	public int brandOwnerUpdate(Map<String,Object> resultParam);
	public int brandInsert(Map<String,Object> resultParam);
	public int brandUpdate(Map<String,Object> resultParam);
	public int brandDelete(Map<String,Object> resultParam);
	public int brandPositionInsert(Map<String,Object> resultParam);
	public int brandPositionUpdate(Map<String,Object> resultParam);
	public int menuCountView(String brandNUM);
	public int reviewCount(String brandNUM);
	public int orderDeliveryCount(String brandNUM);
	public int orderReserveCount(String brandNUM);
	public int orderTotalCount(String brandNUM);
	public int orderTotalPaymentAmountCount(String brandNUM);
	public int brandImageInsert(Map<String,Object> param);
	public int brandImageUpdate(Map<String,Object> param);
	public Map<String,Object> brandImageSelectOne(String brandNUM);
	public int orderInfoInsert(Map<String,Object> param);
	public int reservationInsert(Map<String,Object> param);
	public int deliveryInsert(Map<String,Object> param);
	public int orderNumberUpdate(Map<String,Object> param);
	public int orderDetailInsert(Map<String,Object> param);
	public int pointHistoryInsert(Map<String,Object> param);
	public List<Map<String,Object>> brandReviewView(Map<String,Object> param);
	public List<Map<String,Object>> reviewTotalAverageView(Map<String,Object> param);
	public int reviewCountView(Map<String,Object> param);
	public List<Map<String,Object>> purchaseItemView(String orderNUM);
	
	//나래
	//메인에 뿌려지는 브랜드들만 정보 가져옴
	public List<Map<String, Object>> selectMainAll();
	
	//검색내용과 관련된 브랜드들만 뽑아옴
	public List<Map<String, Object>> searchSelectAll(String searchValue);
	
	//필터 없이 모든 데이터들을 다 가지고 온다.
	public List<Map<String, Object>> selectBrandAll();
	
	//관리자 메인화면관리에 뿌려질 6개의 브랜드 리스트 뿌리는 것
	public List<Map<String, Object>> selectAdminMainList();
	
	//관리자 메인화면관리에 뿌려진 브랜드들의 mainRank를 가져오는 것
	public List<Map<String, Object>> brandMainRank();
	
	//리스트에 뿌려질 이미지 thumnail을 하나 selectOne해온다.
	public String thumnaulImage(String brandnum);
	
	
	
	//파라미터로 들어온 brandNUM을 통해서 mainRank를 업데이트 시킨다.
	public int updateMainRankUP(String brandNUM);
	
	//파라미터로 들어온 brandNUM을 통해서 mainRank를 업데이트 시킨다.
	public int updateMainRankDOWN(String brandNUM);
	
	//버튼이 눌린 브랜드를 기준으로 up버튼이 눌리면 눌린 브랜드의 brandNUM을 -1한 숫자의 브랜드넘을 찾아오고,
	//버튼 down을 눌르면 눌린 브랜드의 brandNUM을 +1한 brandNUM을 찾아온다.
	public String mainRankSelectBrandNUM(int mainRank);
	
	//브랜드 넘이랑, 파라미터로 받은 메인랭크를 이용해서 업데이트 해주는 것)
	public int updateMainRankZero(Map<String, Object> param);
	
	//업버튼 눌렸으면, 해당 브랜드의 메인랭크보다 -1한 메인랭크가 있으면 그 번호르 없으면 0을 리턴하는 함수
	public int selectAnothermainRank(int mainrank);
	
	
	//관리자 페이지에서 카테고리 중 브랜드 관리를 눌렀을 때, 마스터 권한이면 모든 브랜드의 리스트를 뿌려야한다.
	public List<Map<String, Object>> selectAllBrandList(Map<String, Object> param);
	
	public int totalBrandCount(Map<String, Object> param);
	
	
	
	public int memeberUpdatePointTotal(Map<String,Object> param);
}
