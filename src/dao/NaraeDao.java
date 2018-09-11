package dao;

import java.util.Map;

public interface NaraeDao {
	
	
	//세션에 있는 brandOwnerNUM을 통해 brandNUM을 가져온다.
	public String selectBrand(String brandOwnerNum);
	
	
	

	
	//마스터 권한으로 들어왔을 때 보여지는 adminMainScreen 정보
	
	//누적주문, 배달, 예약 건수를 반환
	public Map<String, Object> adminMasterMainOrderManage();
	//배달취소
	public int adminMasterMainOrderManageDeliver();
	//예약취소
	public int adminMasterMainOrderManageReservation();
	
	//리뷰관리 - 리뷰 총 갯수
	public int adminMasterMainReviewManage();
	//리뷰관리 - 신규리뷰(오늘)
	public int adminMasterMainTodayReviewManage();

	
	//1:1문의관리 - 누적문의갯수, 신규문의
	public int adminMasterMainInquireManage();
	//1:1문의관리 - 신규문의 갯수(오늘)
	public int adminMasterMainTodayInquireManage();
	
	//광고/제휴 문의관리 - 누적문의
	public int adminMasterMainAdManage();
	//광고/제휴 문의관리 - 신규문의
	public int adminMasterMainTodayAdManage();
	
	
	//매출현황 - 누적매출
	public int adminMasterMainSales();	
	//매출현황 - 이번달 매출
	public int adminMasterMonthMainSales();
	
	//----------------------------------------------------------------------------------------------
	//브랜드 권한으로 드러왔을 때, 통계보이게 하기
	
	public Map<String, Object> adminBrandMainOrderManage(String brandNum);
	//배달취소
	public int adminBrandMainOrderManageDeliver(String brandNum);
	//예약취소
	public int adminBrandMainOrderManageReservation(String brandNum);
	
	//리뷰관리 - 리뷰 총 갯수
	public int adminBrandMainReviewManage(String brandNum);
	//리뷰관리 - 신규리뷰(오늘)
	public int adminBrandMainTodayReviewManage(String brandNum);

	
//	//1:1문의관리 - 누적문의갯수, 신규문의
//	public int adminBrandMainInquireManage(String brandNum);
//	//1:1문의관리 - 신규문의 갯수(오늘)
//	public int adminBrandMainTodayInquireManage(String brandNum);
//	
//	//광고/제휴 문의관리 - 누적문의
//	public int adminBrandMainAdManage(String brandNum);
//	//광고/제휴 문의관리 - 신규문의
//	public int adminBrandMainTodayAdManage(String brandNum);
	
	
	//매출현황 - 누적매출
	public int adminBrandMainSales(String brandNum);	
	//매출현황 - 이번달 매출
	public int adminBrandMonthMainSales(String brandNum);
	
	
	
	
	
}
