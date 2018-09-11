package service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSplitPaneUI;

import org.apache.commons.io.IOUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import dao.BrandDao;
import dao.MemberDao;
import dao.NaraeDao;


@Service
public class naraeService {
	
	@Autowired
	BrandDao bDao;
	
	@Autowired
	MemberDao mDao;
	
	@Autowired
	NaraeDao nDao;
	
	private static final int NUM_OF_BOARD_PER_PAGE = 10;
	//한번에 표시될 네비게이션의 개수
	private static final int NUM_OF_NAVI_PAGE = 5;
	
	
	//메인화면에 exposurelevel이 main or package일 때 선택해서 뿌린다.
	public List<Map<String, Object>> selectAll(){
		
		List<Map<String, Object>> mainList = bDao.selectMainAll();
		return mainList;		
	}
	
	//관리자 메인화면 관리 리스트 뿌릴것
	//페이징할때 필요한 함수들
	public List<Map<String, Object>> selectAdminBrandList(){
		
		List<Map<String, Object>> adminMainListManage = bDao.selectAdminMainList();
		
		
		
		Collections.sort(adminMainListManage, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				java.math.BigDecimal tempValue1 = (java.math.BigDecimal) first.get("MAINRANK");

				Integer firstvalue = Integer.valueOf(tempValue1.toString());
				
				java.math.BigDecimal tempValue2 = (java.math.BigDecimal) seconde.get("MAINRANK");

				Integer secondevalue = Integer.valueOf(tempValue2.toString());

	            // 내림차순 정렬
	            if (firstvalue > secondevalue) {
	                return 1;
	            } else if (firstvalue < secondevalue) {
	                return -1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
			}
		});		
		return adminMainListManage;		
	}
	
	
	//관리자 화면에서 'MASTER'권한이 브랜드 관리 클릭했을 때
	//모든 브랜드리스트가 나와야한다.
	public Map<String, Object> adminMasterBrandAll(int page, Map<String,Object> param) {
		
		//화면 출력에 필요한 값들
		int startPage = getStartPage(page);
		int endPage = getEndPage(page);
		
		//데이터 조회에 필요한 값이다.
		int firstRow = getFirstRow(page);
		int endRow = getEndRow(page);
		
		param.put("firstRow", firstRow);
		param.put("endRow", endRow);
		
		//토탈정보구함
		Map<String, Object> viewData = new HashMap<>();
		
		String keyword = (String)param.get("keyword");
		
		String category = (String)param.get("category");
		
		if(keyword != null) {		
			
			
			
			viewData.put("keyword", keyword);		
			
		}
		
		if(category != null) {
			
		
			
			viewData.put("category", category);
			
		}
		
		//모든 정보의 갯수
		int totalCount = bDao.totalBrandCount(param);
		                           //전체 페이지 수
		viewData.put("pageTotalCount", getPageTotalCount(totalCount));
		viewData.put("selectAllBrandList", bDao.selectAllBrandList(param));
		viewData.put("startPage", startPage);
		viewData.put("endPage", endPage);
		viewData.put("currentPage", page);
		return viewData;
	}
	
	
	
	
	//검색어를 통해 관련 브랜드들 뽑아옴
	public Map<String, Object> selectSearchBrand(String searchValue, double mLit, double mLot){		
		//메인화면에서 검색한 내용이 포함된 가게이름, 메뉴이름, 주소를 모두 select한다.
		
		List<Map<String, Object>> mainSearchList = bDao.searchSelectAll(searchValue);
		
		//exposureLevel이 RECOMMAND 또는 PACKAGE이면  brandExposureList에 값이 저장된다.
		List<Map<String, Object>> brandRecommandList = new LinkedList<Map<String,Object>>();
		
		//exposureLevel이 NORMAL이면  brandExposureList에 값이 저장된다.
		List<Map<String, Object>> brandNormalList = new LinkedList<Map<String, Object>>();

		
		//검색어에 맞는 결과값을 추천과 일반으로 나눠서 두개의 리스트로 만든다.
		for(int i = 0; i < mainSearchList.size(); i++) {

			String brandExposure = (String) mainSearchList.get(i).get("EXPOSURELEVEL");
			
			//service에서 꺼내온 List들 추천레벨이  RECOMMAND, PACKAGE이면 추천 리스트에 담고
			if(brandExposure.equals("RECOMMAND") || brandExposure.equals("PACKAGE")) {
				
				Map<String, Object> brandRecommandMap = new HashMap<String, Object>();
				
				brandRecommandMap = mainSearchList.get(i);

				brandRecommandList.add(brandRecommandMap);
				
			} else{
				
				Map<String, Object> brandNormalMap = new HashMap<String, Object>();
				
				//추천 레벨이 NORMAL이면 노말리스트에 담는다.
				brandNormalMap = mainSearchList.get(i);
				
				brandNormalList.add(brandNormalMap);
				
			}
		}

		//추천브랜드 거리순으로 정렬하기
		for(int i = 0; i< brandRecommandList.size(); i++ ) {

			//검색어를 통해 뽑아온 브랜드들의 각각의 위도와 경도를 뽑아서 parseDouble한다.
			double targetBrandLat = Double.parseDouble((String) brandRecommandList.get(i).get("BRANDLATITUDE"));
			double targetBrandLon = Double.parseDouble((String) brandRecommandList.get(i).get("BRANDLONGITUDE"));
			
			//내 위치의 위도,경도와 브랜드의 위도경도를 통해 사이값을 km단위로 뽑아온다.
			double dist = calDistance(mLit, mLot, targetBrandLat, targetBrandLon);
			
			//List에 담긴 Map에 각각의 거리값을  put해준다.
			brandRecommandList.get(i).put("gapM", dist);
					
		}
		
		//List<MAP<>> 거리순으로 재정렬시킴
		Collections.sort(brandRecommandList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				double firstValue = (double) first.get("gapM");
				double secondValue = (double) seconde.get("gapM");
	            
	            // 내림차순 정렬
	            if (firstValue > secondValue) {
	                return 1;
	            } else if (firstValue < secondValue) {
	                return -1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
			}
		});
		
		//NORMAL 브랜드 거리순으로 정렬하기
		for(int i = 0; i< brandNormalList.size(); i++ ) {

			//검색어를 통해 뽑아온 브랜드들의 각각의 위도와 경도를 뽑아서 parseDouble한다.
			double targetBrandLat = Double.parseDouble((String) brandNormalList.get(i).get("BRANDLATITUDE"));
			double targetBrandLon = Double.parseDouble((String) brandNormalList.get(i).get("BRANDLONGITUDE"));
			
			//내 위치의 위도,경도와 브랜드의 위도경도를 통해 사이값을 km단위로 뽑아온다.
			double dist = calDistance(mLit, mLot, targetBrandLat, targetBrandLon);
		
			//List에 담긴 Map에 각각의 거리값을  put해준다.
			brandNormalList.get(i).put("gapM", dist);
					
		}
		
		//List<MAP<>> 거리순으로 재정렬시킴
		Collections.sort(brandNormalList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				double firstValue = (double) first.get("gapM");
				double secondValue = (double) seconde.get("gapM");
	            
	            // 내림차순 정렬
	            if (firstValue > secondValue) {
	                return 1;
	            } else if (firstValue < secondValue) {
	                return -1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
			}
		});
		
		
		//거리순으로 정렬되어 있는 값들을 오픈된 브랜드 우선으로 리스트를 뿌린다.
		
		//현재 시간, 분을 String으로 받는다.
		String todayDate = new Date().toString();
		
		//현재 시간에 대한 모든 값을 " "기준으로 자른다.
		String[] todayDateArr = todayDate.split(" ");
		
		//필요한 값이 들어있는 배열을 " : "을 기준으로 자른다.
		String[] today = todayDateArr[3].split(":");
		
		//현재 시간, 분을 문자열로 붙인다.
		String todayHoureMin = today[0]+today[1];
		
		//문자열로 붙인 현재 시간, 분을 정수형으로 parse시킨다.
		int todayHM = Integer.parseInt(todayHoureMin);
		
		
//************************************************************************************
		
		//추천브랜드 먼저 오픈순으로 재정렬함!
		
		//오픈한 브랜드들이 먼저 리스트의 상위로 올라온 정렬을 담는 리스트
		List<Map<String, Object>> openRecommandBrand = new LinkedList<Map<String, Object>>();
		
		//영업이 종료된 브랜드들을 담는 리스트
		List<Map<String, Object>> notopenRecommandBrand = new LinkedList<Map<String, Object>>();
		
		
		for(int recommandopen = 0; recommandopen<brandRecommandList.size(); recommandopen++) {
			
//			System.out.println(brandRecommandList.get(recommandopen).get("BRANDOPENTIME"));
			
			//문자열로 브랜드의 오픈시간을 가져온다.
			String openTime = (String)brandRecommandList.get(recommandopen).get("BRANDOPENTIME");
			
			//가지고 온 오픈시간을 ','을 기준으로 자른다.
			String[] timesArr = openTime.split(",");
			
			//자른 각각의 문자열 형태의 숫자들을 맞는 문자열 변수에 넣어준다.
			String openbrand = timesArr[0]+timesArr[1];
			String closebrand = timesArr[2]+timesArr[3];
	
			
			//브랜드마다 가지고 있는 오픈 시간, 분을 int형으로 parse시킨 것
			int intOpenBrand = Integer.parseInt(openbrand);
			int intCloseBrand = Integer.parseInt(closebrand);
			
			//
			if(intOpenBrand < todayHM && todayHM < intCloseBrand){
				
				//오픈한 브랜드들의 상세정보를 담을 맵
				Map<String, Object> openRecommandBrandMap = new HashMap<String, Object>();
				
				openRecommandBrandMap.put("BRANDRESERVATIONSTATUS", brandRecommandList.get(recommandopen).get("BRANDRESERVATIONSTATUS"));
				openRecommandBrandMap.put("AVGSTARGRADE", brandRecommandList.get(recommandopen).get("AVGSTARGRADE"));
				openRecommandBrandMap.put("BRANDNAME", brandRecommandList.get(recommandopen).get("BRANDNAME"));
				openRecommandBrandMap.put("gapM", brandRecommandList.get(recommandopen).get("gapM"));
				openRecommandBrandMap.put("BRANDLATITUDE", brandRecommandList.get(recommandopen).get("BRANDLATITUDE"));
				openRecommandBrandMap.put("BRANDADDRESS", brandRecommandList.get(recommandopen).get("BRANDADDRESS"));
				openRecommandBrandMap.put("REVIEWCOUNT", brandRecommandList.get(recommandopen).get("REVIEWCOUNT"));
				openRecommandBrandMap.put("BRANDOPENTIME", "Y");
				openRecommandBrandMap.put("BRANDLONGITUDE", brandRecommandList.get(recommandopen).get("BRANDLONGITUDE"));
				openRecommandBrandMap.put("THUMNAIL", brandRecommandList.get(recommandopen).get("THUMNAIL"));
				openRecommandBrandMap.put("FAVORTOTALCNT", brandRecommandList.get(recommandopen).get("FAVORTOTALCNT"));
				openRecommandBrandMap.put("BRANDDELIVERYSTATUS", brandRecommandList.get(recommandopen).get("BRANDDELIVERYSTATUS"));
				openRecommandBrandMap.put("EXPOSURELEVEL", brandRecommandList.get(recommandopen).get("EXPOSURELEVEL"));
				openRecommandBrandMap.put("BRANDINTRODUCE", brandRecommandList.get(recommandopen).get("BRANDINTRODUCE"));
				openRecommandBrandMap.put("BRANDNUM", brandRecommandList.get(recommandopen).get("BRANDNUM"));
				
				
				openRecommandBrand.add(openRecommandBrandMap);
				
			}else {

				//영업이 종료된 브랜드들의 상세정보를 담을 맵
				Map<String, Object> notopenRecommandBrandMap = new HashMap<String, Object>();
				
				notopenRecommandBrandMap.put("BRANDRESERVATIONSTATUS", brandRecommandList.get(recommandopen).get("BRANDRESERVATIONSTATUS"));
				notopenRecommandBrandMap.put("AVGSTARGRADE", brandRecommandList.get(recommandopen).get("AVGSTARGRADE"));
				notopenRecommandBrandMap.put("BRANDNAME", brandRecommandList.get(recommandopen).get("BRANDNAME"));
				notopenRecommandBrandMap.put("gapM", brandRecommandList.get(recommandopen).get("gapM"));
				notopenRecommandBrandMap.put("BRANDLATITUDE", brandRecommandList.get(recommandopen).get("BRANDLATITUDE"));
				notopenRecommandBrandMap.put("BRANDADDRESS", brandRecommandList.get(recommandopen).get("BRANDADDRESS"));
				notopenRecommandBrandMap.put("REVIEWCOUNT", brandRecommandList.get(recommandopen).get("REVIEWCOUNT"));
				notopenRecommandBrandMap.put("BRANDOPENTIME", "N");
				notopenRecommandBrandMap.put("BRANDLONGITUDE", brandRecommandList.get(recommandopen).get("BRANDLONGITUDE"));
				notopenRecommandBrandMap.put("THUMNAIL", brandRecommandList.get(recommandopen).get("THUMNAIL"));
				notopenRecommandBrandMap.put("FAVORTOTALCNT", brandRecommandList.get(recommandopen).get("FAVORTOTALCNT"));
				notopenRecommandBrandMap.put("BRANDDELIVERYSTATUS", brandRecommandList.get(recommandopen).get("BRANDDELIVERYSTATUS"));
				notopenRecommandBrandMap.put("EXPOSURELEVEL", brandRecommandList.get(recommandopen).get("EXPOSURELEVEL"));
				notopenRecommandBrandMap.put("BRANDINTRODUCE", brandRecommandList.get(recommandopen).get("BRANDINTRODUCE"));
				notopenRecommandBrandMap.put("BRANDNUM", brandRecommandList.get(recommandopen).get("BRANDNUM"));
				
				notopenRecommandBrand.add(notopenRecommandBrandMap);
			}

			
		}

		//각각 2개로 나눈 오픈, 비오픈 가게들을 하나의 리스트로 합친다.
		for(int mergeList = 0; mergeList<notopenRecommandBrand.size(); mergeList++) {
			openRecommandBrand.add(notopenRecommandBrand.get(mergeList));
		}

//************************************************************************************
		
		//일반 브랜드들 오픈순으로 재정렬

		
		//오픈한 브랜드들이 먼저 리스트의 상위로 올라온 정렬을 담는 리스트
		List<Map<String, Object>> openNormalBrand = new LinkedList<Map<String, Object>>();
		
		//영업이 종료된 브랜드들을 담는 리스트
		List<Map<String, Object>> notopenNormalBrand = new LinkedList<Map<String, Object>>();
		
		
		for(int normalopen = 0; normalopen<brandNormalList.size(); normalopen++) {
			
//			System.out.println(brandRecommandList.get(recommandopen).get("BRANDOPENTIME"));
			
			//문자열로 브랜드의 오픈시간을 가져온다.
			String openTime = (String)brandNormalList.get(normalopen).get("BRANDOPENTIME");
			
			//가지고 온 오픈시간을 ','을 기준으로 자른다.
			String[] timesArr = openTime.split(",");
			
			//자른 각각의 문자열 형태의 숫자들을 맞는 문자열 변수에 넣어준다.
			String openbrand = timesArr[0]+timesArr[1];
			String closebrand = timesArr[2]+timesArr[3];
	
			
			//브랜드마다 가지고 있는 오픈 시간, 분을 int형으로 parse시킨 것
			int intOpenBrand = Integer.parseInt(openbrand);
			int intCloseBrand = Integer.parseInt(closebrand);
			
			//
			if(intOpenBrand < todayHM && todayHM < intCloseBrand){
				
				//오픈한 브랜드들의 상세정보를 담을 맵
				Map<String, Object> openNormalBrandMap = new HashMap<String, Object>();
				
				openNormalBrandMap.put("BRANDRESERVATIONSTATUS", brandNormalList.get(normalopen).get("BRANDRESERVATIONSTATUS"));
				openNormalBrandMap.put("AVGSTARGRADE", brandNormalList.get(normalopen).get("AVGSTARGRADE"));
				openNormalBrandMap.put("BRANDNAME", brandNormalList.get(normalopen).get("BRANDNAME"));
				openNormalBrandMap.put("gapM", brandNormalList.get(normalopen).get("gapM"));
				openNormalBrandMap.put("BRANDLATITUDE", brandNormalList.get(normalopen).get("BRANDLATITUDE"));
				openNormalBrandMap.put("BRANDADDRESS", brandNormalList.get(normalopen).get("BRANDADDRESS"));
				openNormalBrandMap.put("REVIEWCOUNT", brandNormalList.get(normalopen).get("REVIEWCOUNT"));
				openNormalBrandMap.put("BRANDOPENTIME", "Y");
				openNormalBrandMap.put("BRANDLONGITUDE", brandNormalList.get(normalopen).get("BRANDLONGITUDE"));
				openNormalBrandMap.put("THUMNAIL", brandNormalList.get(normalopen).get("THUMNAIL"));
				openNormalBrandMap.put("FAVORTOTALCNT", brandNormalList.get(normalopen).get("FAVORTOTALCNT"));
				openNormalBrandMap.put("BRANDDELIVERYSTATUS", brandNormalList.get(normalopen).get("BRANDDELIVERYSTATUS"));
				openNormalBrandMap.put("EXPOSURELEVEL", brandNormalList.get(normalopen).get("EXPOSURELEVEL"));
				openNormalBrandMap.put("BRANDINTRODUCE", brandNormalList.get(normalopen).get("BRANDINTRODUCE"));
				openNormalBrandMap.put("BRANDNUM", brandNormalList.get(normalopen).get("BRANDNUM"));
				
				
				openNormalBrand.add(openNormalBrandMap);
				
			}else {

				//영업이 종료된 브랜드들의 상세정보를 담을 맵
				Map<String, Object> notopenNormalBrandMap = new HashMap<String, Object>();
				
				notopenNormalBrandMap.put("BRANDRESERVATIONSTATUS", brandNormalList.get(normalopen).get("BRANDRESERVATIONSTATUS"));
				notopenNormalBrandMap.put("AVGSTARGRADE", brandNormalList.get(normalopen).get("AVGSTARGRADE"));
				notopenNormalBrandMap.put("BRANDNAME", brandNormalList.get(normalopen).get("BRANDNAME"));
				notopenNormalBrandMap.put("gapM", brandNormalList.get(normalopen).get("gapM"));
				notopenNormalBrandMap.put("BRANDLATITUDE", brandNormalList.get(normalopen).get("BRANDLATITUDE"));
				notopenNormalBrandMap.put("BRANDADDRESS", brandNormalList.get(normalopen).get("BRANDADDRESS"));
				notopenNormalBrandMap.put("REVIEWCOUNT", brandNormalList.get(normalopen).get("REVIEWCOUNT"));
				notopenNormalBrandMap.put("BRANDOPENTIME", "N");
				notopenNormalBrandMap.put("BRANDLONGITUDE", brandNormalList.get(normalopen).get("BRANDLONGITUDE"));
				notopenNormalBrandMap.put("THUMNAIL", brandNormalList.get(normalopen).get("THUMNAIL"));
				notopenNormalBrandMap.put("FAVORTOTALCNT", brandNormalList.get(normalopen).get("FAVORTOTALCNT"));
				notopenNormalBrandMap.put("BRANDDELIVERYSTATUS", brandNormalList.get(normalopen).get("BRANDDELIVERYSTATUS"));
				notopenNormalBrandMap.put("EXPOSURELEVEL", brandNormalList.get(normalopen).get("EXPOSURELEVEL"));
				notopenNormalBrandMap.put("BRANDINTRODUCE", brandNormalList.get(normalopen).get("BRANDINTRODUCE"));
				notopenNormalBrandMap.put("BRANDNUM", brandNormalList.get(normalopen).get("BRANDNUM"));
				
				notopenNormalBrand.add(notopenNormalBrandMap);
			}

			
		}

		//각각 2개로 나눈 오픈, 비오픈 가게들을 하나의 리스트로 합친다.
		for(int mergeList = 0; mergeList<notopenNormalBrand.size(); mergeList++) {
			
//			System.out.println(notopenRecommandBrand.get(mergeList));
			
			openNormalBrand.add(notopenNormalBrand.get(mergeList));
			
		}
		
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("openNormalBrand", openNormalBrand);
		result.put("openRecommandBrand", openRecommandBrand);
		result.put("searchListLength", mainSearchList.size());
		
		
		return result;
	}
	
	
	//관심순을 눌렀을 때 리스트를 다시 관심순 순서대로 정렬시키는 것
	public Map<String, Object> filterFavor(String normalList, String recommanList){
		
		JSONObject nomaljsonObject = new JSONObject(normalList.toString());
		JSONObject recommandjsonObject = new JSONObject(recommanList.toString());

		
		JSONArray nomalitems = nomaljsonObject.getJSONArray("nExLevel");
		JSONArray recommanditems = recommandjsonObject.getJSONArray("rExLevel");

//-------------------------------------------------------------------------------------------------------------		
		
		//json형태의 리스트를 각각의 리스트에 넣어준다.
		
		//추천이 nomal인 브랜드들 리스트
		List<Map<String, Object>> normalstarList = new LinkedList<Map<String,Object>>();
		
		
		
		//추천이 recommand 또는 package인 브랜드들 리스트
		List<Map<String, Object>> recommandstarList = new LinkedList<Map<String,Object>>();
		
		
		// 노말 브랜드들 먼저 리스트에 삽입
		for(int i = 0; i< nomalitems.length(); i++) {
		
			
			Map<String, Object> normalSort = new HashMap<String, Object>();
			
			JSONObject item = nomalitems.getJSONObject(i);
			
			normalSort.put("BRANDRESERVATIONSTATUS", item.get("BRANDRESERVATIONSTATUS"));
			normalSort.put("AVGSTARGRADE", item.get("AVGSTARGRADE"));
			normalSort.put("BRANDNAME", item.get("BRANDNAME"));
			normalSort.put("gapM", item.get("gapM"));
			normalSort.put("BRANDLATITUDE", item.get("BRANDLATITUDE"));
			normalSort.put("BRANDADDRESS", item.get("BRANDADDRESS"));
			normalSort.put("REVIEWCOUNT", item.get("REVIEWCOUNT"));
			normalSort.put("BRANDOPENTIME", item.get("BRANDOPENTIME"));
			normalSort.put("BRANDLONGITUDE", item.get("BRANDLONGITUDE"));
			normalSort.put("THUMNAIL", item.get("THUMNAIL"));
			normalSort.put("FAVORTOTALCNT", item.get("FAVORTOTALCNT"));
			normalSort.put("BRANDDELIVERYSTATUS", item.get("BRANDDELIVERYSTATUS"));
			normalSort.put("EXPOSURELEVEL", item.get("EXPOSURELEVEL"));
			normalSort.put("BRANDINTRODUCE", item.get("BRANDINTRODUCE"));
			normalSort.put("BRANDNUM", item.get("BRANDNUM"));
			
			//노말 브랜드들 리스트 add
			normalstarList.add(normalSort);

		}

		// 추천 브랜드들 리스트에 삽입
		for(int i = 0; i< recommanditems.length(); i++) {
			
			Map<String, Object> recommandSort = new HashMap<String, Object>();
			
			JSONObject item = recommanditems.getJSONObject(i);
			
			recommandSort.put("BRANDRESERVATIONSTATUS", item.get("BRANDRESERVATIONSTATUS"));
			recommandSort.put("AVGSTARGRADE", item.get("AVGSTARGRADE"));
			recommandSort.put("BRANDNAME", item.get("BRANDNAME"));
			recommandSort.put("gapM", item.get("gapM"));
			recommandSort.put("BRANDLATITUDE", item.get("BRANDLATITUDE"));
			recommandSort.put("BRANDADDRESS", item.get("BRANDADDRESS"));
			recommandSort.put("REVIEWCOUNT", item.get("REVIEWCOUNT"));
			recommandSort.put("BRANDOPENTIME", item.get("BRANDOPENTIME"));
			recommandSort.put("BRANDLONGITUDE", item.get("BRANDLONGITUDE"));
			recommandSort.put("THUMNAIL", item.get("THUMNAIL"));
			recommandSort.put("FAVORTOTALCNT", item.get("FAVORTOTALCNT"));
			recommandSort.put("BRANDDELIVERYSTATUS", item.get("BRANDDELIVERYSTATUS"));
			recommandSort.put("EXPOSURELEVEL", item.get("EXPOSURELEVEL"));
			recommandSort.put("BRANDINTRODUCE", item.get("BRANDINTRODUCE"));
			recommandSort.put("BRANDNUM", item.get("BRANDNUM"));
			
			
			//추천 브랜드들 리스트 add
			recommandstarList.add(recommandSort);
		}
		

		
		Collections.sort(normalstarList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				int firstValue = 0;
				int secondValue=0;
				
				
				Object firstAvg = first.get("FAVORTOTALCNT");
				Object secondAvg = seconde.get("FAVORTOTALCNT");
				
				if( firstAvg instanceof Integer) {
					int tmpFirst = (Integer)firstAvg;
					firstValue = tmpFirst;}

				if( secondAvg instanceof Integer) {
					int tmpSeconde = (Integer)secondAvg;
					secondValue = tmpSeconde;
				}
				
				
				  // 오름차순 정렬
	            if (firstValue > secondValue) {
	                return -1;
	            } else if (firstValue < secondValue) {
	                return 1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
				
			}
			
		});
		
		//추천브랜드 재정렬
		
		Collections.sort(recommandstarList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				int firstValue = 0;
				int secondValue=0;
				
				
				Object firstAvg = first.get("FAVORTOTALCNT");
				Object secondAvg = seconde.get("FAVORTOTALCNT");
				
				if( firstAvg instanceof Integer) {
					int tmpFirst = (Integer)firstAvg;
					firstValue = tmpFirst;}

				if( secondAvg instanceof Integer) {
					int tmpSeconde = (Integer)secondAvg;
					secondValue = tmpSeconde;
				}
				
				
				  // 오름차순 정렬
	            if (firstValue > secondValue) {
	                return -1;
	            } else if (firstValue < secondValue) {
	                return 1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
				
			}
			
		});

		//**********************************************************************************************************************************
		
				//요기에 관심순으로 정렬한 리스트를 영업중인 브랜드를 상위로 올려놓는 코드를 삽입한다.
				
				//영업중인 브랜드를 상위로 올리는 일반 브랜드 리스트
				List<Map<String, Object>> openStarNormal = new LinkedList<Map<String, Object>>();
				
				//비영업중인 브랜드를 저장하는 일반 브랜드 리스트
				List<Map<String, Object>> notopenStarNormal = new LinkedList<Map<String, Object>>();
				
				//영업중인 브랜드를 상위로 올리는 추천 브랜드 리스트
				List<Map<String, Object>> openStarRecommand = new LinkedList<Map<String, Object>>();
				
				//비영업중인 브랜드를 저장하는 리스트
				List<Map<String, Object>> notopenStarRecommand = new LinkedList<Map<String, Object>>();
				
				
				for(int openstar = 0; openstar<normalstarList.size(); openstar++) {
					
					String result = (String) normalstarList.get(openstar).get("BRANDOPENTIME");
					
					if(result.equals("Y")) {
						
						//영업중인 일반브랜드의 세부사항을 담을 맵
						Map<String, Object> openStarNormalMap = new HashMap<String, Object>();
						
						openStarNormalMap.put("BRANDRESERVATIONSTATUS", normalstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
						openStarNormalMap.put("AVGSTARGRADE", normalstarList.get(openstar).get("AVGSTARGRADE"));
						openStarNormalMap.put("BRANDNAME", normalstarList.get(openstar).get("BRANDNAME"));
						openStarNormalMap.put("gapM", normalstarList.get(openstar).get("gapM"));
						openStarNormalMap.put("BRANDLATITUDE", normalstarList.get(openstar).get("BRANDLATITUDE"));
						openStarNormalMap.put("BRANDADDRESS", normalstarList.get(openstar).get("BRANDADDRESS"));
						openStarNormalMap.put("REVIEWCOUNT", normalstarList.get(openstar).get("REVIEWCOUNT"));
						openStarNormalMap.put("BRANDOPENTIME", normalstarList.get(openstar).get("BRANDOPENTIME"));
						openStarNormalMap.put("BRANDLONGITUDE", normalstarList.get(openstar).get("BRANDLONGITUDE"));
						openStarNormalMap.put("THUMNAIL", normalstarList.get(openstar).get("THUMNAIL"));
						openStarNormalMap.put("FAVORTOTALCNT", normalstarList.get(openstar).get("FAVORTOTALCNT"));
						openStarNormalMap.put("BRANDDELIVERYSTATUS", normalstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
						openStarNormalMap.put("EXPOSURELEVEL", normalstarList.get(openstar).get("EXPOSURELEVEL"));
						openStarNormalMap.put("BRANDINTRODUCE", normalstarList.get(openstar).get("BRANDINTRODUCE"));
						openStarNormalMap.put("BRANDNUM", normalstarList.get(openstar).get("BRANDNUM"));
						
						
						openStarNormal.add(openStarNormalMap);
					}else {
						
						//비영업중인 일반브랜드의 세부사항을 담을 맵
						Map<String, Object> notopenStarNormalMap = new HashMap<String, Object>();
						
						notopenStarNormalMap.put("BRANDRESERVATIONSTATUS", normalstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
						notopenStarNormalMap.put("AVGSTARGRADE", normalstarList.get(openstar).get("AVGSTARGRADE"));
						notopenStarNormalMap.put("BRANDNAME", normalstarList.get(openstar).get("BRANDNAME"));
						notopenStarNormalMap.put("gapM", normalstarList.get(openstar).get("gapM"));
						notopenStarNormalMap.put("BRANDLATITUDE", normalstarList.get(openstar).get("BRANDLATITUDE"));
						notopenStarNormalMap.put("BRANDADDRESS", normalstarList.get(openstar).get("BRANDADDRESS"));
						notopenStarNormalMap.put("REVIEWCOUNT", normalstarList.get(openstar).get("REVIEWCOUNT"));
						notopenStarNormalMap.put("BRANDOPENTIME", normalstarList.get(openstar).get("BRANDOPENTIME"));
						notopenStarNormalMap.put("BRANDLONGITUDE", normalstarList.get(openstar).get("BRANDLONGITUDE"));
						notopenStarNormalMap.put("THUMNAIL", normalstarList.get(openstar).get("THUMNAIL"));
						notopenStarNormalMap.put("FAVORTOTALCNT", normalstarList.get(openstar).get("FAVORTOTALCNT"));
						notopenStarNormalMap.put("BRANDDELIVERYSTATUS", normalstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
						notopenStarNormalMap.put("EXPOSURELEVEL", normalstarList.get(openstar).get("EXPOSURELEVEL"));
						notopenStarNormalMap.put("BRANDINTRODUCE", normalstarList.get(openstar).get("BRANDINTRODUCE"));
						notopenStarNormalMap.put("BRANDNUM", normalstarList.get(openstar).get("BRANDNUM"));
						
						
						notopenStarNormal.add(notopenStarNormalMap);
						
					}
				}
				
				
				//오픈한 브랜드리스트랑 비오픈 리스트를 하나로 합치는 리스트 만들기, 오픈한 리스트를 상위로 둔다.
				
				for(int merge = 0; merge < notopenStarNormal.size(); merge++) {					
					openStarNormal.add(notopenStarNormal.get(merge));					
				}

		//-------------------------------------------------------------------------------------------------------------------
				
				//추천 브랜드 리스트
				
				for(int openstar = 0; openstar<recommandstarList.size(); openstar++) {
					
					String result = (String) recommandstarList.get(openstar).get("BRANDOPENTIME");
					
					if(result.equals("Y")) {
						
						//추천브랜드의 오픈이면서 별점이 높은 브랜드의 세부사항을 담을 맵
						Map<String, Object> openStarRecommandMap = new HashMap<String, Object>();
						
						openStarRecommandMap.put("BRANDRESERVATIONSTATUS", recommandstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
						openStarRecommandMap.put("AVGSTARGRADE", recommandstarList.get(openstar).get("AVGSTARGRADE"));
						openStarRecommandMap.put("BRANDNAME", recommandstarList.get(openstar).get("BRANDNAME"));
						openStarRecommandMap.put("gapM", recommandstarList.get(openstar).get("gapM"));
						openStarRecommandMap.put("BRANDLATITUDE", recommandstarList.get(openstar).get("BRANDLATITUDE"));
						openStarRecommandMap.put("BRANDADDRESS", recommandstarList.get(openstar).get("BRANDADDRESS"));
						openStarRecommandMap.put("REVIEWCOUNT", recommandstarList.get(openstar).get("REVIEWCOUNT"));
						openStarRecommandMap.put("BRANDOPENTIME", recommandstarList.get(openstar).get("BRANDOPENTIME"));
						openStarRecommandMap.put("BRANDLONGITUDE", recommandstarList.get(openstar).get("BRANDLONGITUDE"));
						openStarRecommandMap.put("THUMNAIL", recommandstarList.get(openstar).get("THUMNAIL"));
						openStarRecommandMap.put("FAVORTOTALCNT", recommandstarList.get(openstar).get("FAVORTOTALCNT"));
						openStarRecommandMap.put("BRANDDELIVERYSTATUS", recommandstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
						openStarRecommandMap.put("EXPOSURELEVEL", recommandstarList.get(openstar).get("EXPOSURELEVEL"));
						openStarRecommandMap.put("BRANDINTRODUCE", recommandstarList.get(openstar).get("BRANDINTRODUCE"));
						openStarRecommandMap.put("BRANDNUM", recommandstarList.get(openstar).get("BRANDNUM"));
						
						
						openStarRecommand.add(openStarRecommandMap);
					}else {
						
						//추천브랜드의 비오픈이면서 별점이 높은 브랜드의 세부사항을 담을 맵
						Map<String, Object> notopenStarRecommandMap = new HashMap<String, Object>();
						
						notopenStarRecommandMap.put("BRANDRESERVATIONSTATUS", recommandstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
						notopenStarRecommandMap.put("AVGSTARGRADE", recommandstarList.get(openstar).get("AVGSTARGRADE"));
						notopenStarRecommandMap.put("BRANDNAME", recommandstarList.get(openstar).get("BRANDNAME"));
						notopenStarRecommandMap.put("gapM", recommandstarList.get(openstar).get("gapM"));
						notopenStarRecommandMap.put("BRANDLATITUDE", recommandstarList.get(openstar).get("BRANDLATITUDE"));
						notopenStarRecommandMap.put("BRANDADDRESS", recommandstarList.get(openstar).get("BRANDADDRESS"));
						notopenStarRecommandMap.put("REVIEWCOUNT", recommandstarList.get(openstar).get("REVIEWCOUNT"));
						notopenStarRecommandMap.put("BRANDOPENTIME", recommandstarList.get(openstar).get("BRANDOPENTIME"));
						notopenStarRecommandMap.put("BRANDLONGITUDE", recommandstarList.get(openstar).get("BRANDLONGITUDE"));
						notopenStarRecommandMap.put("THUMNAIL", recommandstarList.get(openstar).get("THUMNAIL"));
						notopenStarRecommandMap.put("FAVORTOTALCNT", recommandstarList.get(openstar).get("FAVORTOTALCNT"));
						notopenStarRecommandMap.put("BRANDDELIVERYSTATUS", recommandstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
						notopenStarRecommandMap.put("EXPOSURELEVEL", recommandstarList.get(openstar).get("EXPOSURELEVEL"));
						notopenStarRecommandMap.put("BRANDINTRODUCE", recommandstarList.get(openstar).get("BRANDINTRODUCE"));
						notopenStarRecommandMap.put("BRANDNUM", recommandstarList.get(openstar).get("BRANDNUM"));
						
						
						notopenStarRecommand.add(notopenStarRecommandMap);
						
					}
				}
				
				//오픈한 브랜드리스트랑 비오픈 리스트를 하나로 합치는 리스트 만들기, 오픈한 리스트를 상위로 둔다.
				for(int merge = 0; merge < notopenStarRecommand.size(); merge++) {
					
					openStarRecommand.add(notopenStarRecommand.get(merge));
					
					
				}
				
				//추천브랜드 평점순높으면서 영업중인거 최종 리스트
//				System.out.println("추천  브랜드 중에서 관심이 높으면서 영업중인 리스트가 나온다.");
//				System.out.println(openStarRecommand);
//				
				//일반브랜드 평점순높으면서 영업중인거 최종 리스트
//				System.out.println("일반  브랜드 중에서 관심이 높으면서 영업중인 리스트가 나온다.");
//				System.out.println(openStarNormal);
//				
//		//**********************************************************************************************************************************
//		
//		
//		
				//두개의 리스트를 담는 맵을 만들어서 각각의 리스트들을 담아준다
				Map<String, Object> resultMap = new HashMap<String, Object>();
				
				resultMap.put("normalstarList", openStarNormal);
				resultMap.put("recommandstarList", openStarRecommand);
		
		return resultMap;
		
	}
	
	public Map<String, Object> filterEvaluate (String normalList, String recommandList){
		
		
		JSONObject nomaljsonObject = new JSONObject(normalList.toString());
		JSONObject recommandjsonObject = new JSONObject(recommandList.toString());

		
		JSONArray nomalitems = nomaljsonObject.getJSONArray("nExLevel");
		JSONArray recommanditems = recommandjsonObject.getJSONArray("rExLevel");

		
//--------------------------------------------------------------------------------------------------

		
		//json형태의 리스트를 각각의 리스트에 넣어준다.
		//추천이 nomal인 브랜드들 리스트
		List<Map<String, Object>> normalstarList = new LinkedList<Map<String,Object>>();
		
		
		
		//추천이 recommand 또는 package인 브랜드들 리스트
		List<Map<String, Object>> recommandstarList = new LinkedList<Map<String,Object>>();
		
		
		
		// 노말 브랜드들 먼저 리스트에 삽입
		for(int i = 0; i< nomalitems.length(); i++) {

			
			Map<String, Object> normalSort = new HashMap<String, Object>();
			
			JSONObject item = nomalitems.getJSONObject(i);
			
			normalSort.put("BRANDRESERVATIONSTATUS", item.get("BRANDRESERVATIONSTATUS"));
			normalSort.put("AVGSTARGRADE", item.get("AVGSTARGRADE"));
			normalSort.put("BRANDNAME", item.get("BRANDNAME"));
			normalSort.put("gapM", item.get("gapM"));
			normalSort.put("BRANDLATITUDE", item.get("BRANDLATITUDE"));
			normalSort.put("BRANDADDRESS", item.get("BRANDADDRESS"));
			normalSort.put("REVIEWCOUNT", item.get("REVIEWCOUNT"));
			normalSort.put("BRANDOPENTIME", item.get("BRANDOPENTIME"));
			normalSort.put("BRANDLONGITUDE", item.get("BRANDLONGITUDE"));
			normalSort.put("THUMNAIL", item.get("THUMNAIL"));
			normalSort.put("FAVORTOTALCNT", item.get("FAVORTOTALCNT"));
			normalSort.put("BRANDDELIVERYSTATUS", item.get("BRANDDELIVERYSTATUS"));
			normalSort.put("EXPOSURELEVEL", item.get("EXPOSURELEVEL"));
			normalSort.put("BRANDINTRODUCE", item.get("BRANDINTRODUCE"));
			normalSort.put("BRANDNUM", item.get("BRANDNUM"));
			
			//노말 브랜드들 리스트 add
			normalstarList.add(normalSort);

		}

		// 추천 브랜드들 리스트에 삽입
		for(int i = 0; i< recommanditems.length(); i++) {
			
			Map<String, Object> recommandSort = new HashMap<String, Object>();
			
			JSONObject item = recommanditems.getJSONObject(i);
			
			recommandSort.put("BRANDRESERVATIONSTATUS", item.get("BRANDRESERVATIONSTATUS"));
			recommandSort.put("AVGSTARGRADE", item.get("AVGSTARGRADE"));
			recommandSort.put("BRANDNAME", item.get("BRANDNAME"));
			recommandSort.put("gapM", item.get("gapM"));
			recommandSort.put("BRANDLATITUDE", item.get("BRANDLATITUDE"));
			recommandSort.put("BRANDADDRESS", item.get("BRANDADDRESS"));
			recommandSort.put("REVIEWCOUNT", item.get("REVIEWCOUNT"));
			recommandSort.put("BRANDOPENTIME", item.get("BRANDOPENTIME"));
			recommandSort.put("BRANDLONGITUDE", item.get("BRANDLONGITUDE"));
			recommandSort.put("THUMNAIL", item.get("THUMNAIL"));
			recommandSort.put("FAVORTOTALCNT", item.get("FAVORTOTALCNT"));
			recommandSort.put("BRANDDELIVERYSTATUS", item.get("BRANDDELIVERYSTATUS"));
			recommandSort.put("EXPOSURELEVEL", item.get("EXPOSURELEVEL"));
			recommandSort.put("BRANDINTRODUCE", item.get("BRANDINTRODUCE"));
			recommandSort.put("BRANDNUM", item.get("BRANDNUM"));
			
//			System.out.println("evaluate"+i+" = "+evaluateSort);
			
			//추천 브랜드들 리스트 add
			recommandstarList.add(recommandSort);
		}
		
		
		
//		System.out.println("별점순정렬전 = "+evaluateList);
		
		Collections.sort(normalstarList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				double firstValue;
				double secondValue;
				
				
				Object firstAvg = first.get("AVGSTARGRADE");
				Object secondAvg = seconde.get("AVGSTARGRADE");
				
				if( firstAvg instanceof Integer) {
					int tmpFirst = (Integer)firstAvg;
					firstValue = tmpFirst;
				}else {
					firstValue = (Double)firstAvg;
				}
				
				if( secondAvg instanceof Integer) {
					int tmpSeconde = (Integer)secondAvg;
					secondValue = tmpSeconde;
				}else {
					secondValue = (Double)secondAvg;
				}
				
				
				  // 내림차순 정렬
	            if (firstValue > secondValue) {
	                return -1;
	            } else if (firstValue < secondValue) {
	                return 1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
				
			}
			
		});
		
		
		//추천브랜드 재정렬		
		Collections.sort(recommandstarList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				double firstValue;
				double secondValue;
				
				
				Object firstAvg = first.get("AVGSTARGRADE");
				Object secondAvg = seconde.get("AVGSTARGRADE");
				
				if( firstAvg instanceof Integer) {
					int tmpFirst = (Integer)firstAvg;
					firstValue = tmpFirst;
				}else {
					firstValue = (Double)firstAvg;
				}
				
				if( secondAvg instanceof Integer) {
					int tmpSeconde = (Integer)secondAvg;
					secondValue = tmpSeconde;
				}else {
					secondValue = (Double)secondAvg;
				}
				
				
				  // 내림차순 정렬
	            if (firstValue > secondValue) {
	                return -1;
	            } else if (firstValue < secondValue) {
	                return 1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
				
			}
			
		});

//**********************************************************************************************************************************
		
		
		//요기에 별점순으로 정렬한 리스트를 영업중인 브랜드를 상위로 올려놓는 코드를 삽입한다.
		
		//영업중인 브랜드를 상위로 올리는 일반 브랜드 리스트
		List<Map<String, Object>> openStarNormal = new LinkedList<Map<String, Object>>();
		
		//비영업중인 브랜드를 저장하는 일반 브랜드 리스트
		List<Map<String, Object>> notopenStarNormal = new LinkedList<Map<String, Object>>();
		
		//영업중인 브랜드를 상위로 올리는 추천 브랜드 리스트
		List<Map<String, Object>> openStarRecommand = new LinkedList<Map<String, Object>>();
		
		//비영업중인 브랜드를 저장하는 리스트
		List<Map<String, Object>> notopenStarRecommand = new LinkedList<Map<String, Object>>();
		
		
		for(int openstar = 0; openstar<normalstarList.size(); openstar++) {
			
			String result = (String) normalstarList.get(openstar).get("BRANDOPENTIME");
			
			if(result.equals("Y")) {
				
				//영업중인 일반브랜드의 세부사항을 담을 맵
				Map<String, Object> openStarNormalMap = new HashMap<String, Object>();
				
				openStarNormalMap.put("BRANDRESERVATIONSTATUS", normalstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
				openStarNormalMap.put("AVGSTARGRADE", normalstarList.get(openstar).get("AVGSTARGRADE"));
				openStarNormalMap.put("BRANDNAME", normalstarList.get(openstar).get("BRANDNAME"));
				openStarNormalMap.put("gapM", normalstarList.get(openstar).get("gapM"));
				openStarNormalMap.put("BRANDLATITUDE", normalstarList.get(openstar).get("BRANDLATITUDE"));
				openStarNormalMap.put("BRANDADDRESS", normalstarList.get(openstar).get("BRANDADDRESS"));
				openStarNormalMap.put("REVIEWCOUNT", normalstarList.get(openstar).get("REVIEWCOUNT"));
				openStarNormalMap.put("BRANDOPENTIME", normalstarList.get(openstar).get("BRANDOPENTIME"));
				openStarNormalMap.put("BRANDLONGITUDE", normalstarList.get(openstar).get("BRANDLONGITUDE"));
				openStarNormalMap.put("THUMNAIL", normalstarList.get(openstar).get("THUMNAIL"));
				openStarNormalMap.put("FAVORTOTALCNT", normalstarList.get(openstar).get("FAVORTOTALCNT"));
				openStarNormalMap.put("BRANDDELIVERYSTATUS", normalstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
				openStarNormalMap.put("EXPOSURELEVEL", normalstarList.get(openstar).get("EXPOSURELEVEL"));
				openStarNormalMap.put("BRANDINTRODUCE", normalstarList.get(openstar).get("BRANDINTRODUCE"));
				openStarNormalMap.put("BRANDNUM", normalstarList.get(openstar).get("BRANDNUM"));
				
				
				openStarNormal.add(openStarNormalMap);
			}else {
				
				//비영업중인 일반브랜드의 세부사항을 담을 맵
				Map<String, Object> notopenStarNormalMap = new HashMap<String, Object>();
				
				notopenStarNormalMap.put("BRANDRESERVATIONSTATUS", normalstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
				notopenStarNormalMap.put("AVGSTARGRADE", normalstarList.get(openstar).get("AVGSTARGRADE"));
				notopenStarNormalMap.put("BRANDNAME", normalstarList.get(openstar).get("BRANDNAME"));
				notopenStarNormalMap.put("gapM", normalstarList.get(openstar).get("gapM"));
				notopenStarNormalMap.put("BRANDLATITUDE", normalstarList.get(openstar).get("BRANDLATITUDE"));
				notopenStarNormalMap.put("BRANDADDRESS", normalstarList.get(openstar).get("BRANDADDRESS"));
				notopenStarNormalMap.put("REVIEWCOUNT", normalstarList.get(openstar).get("REVIEWCOUNT"));
				notopenStarNormalMap.put("BRANDOPENTIME", normalstarList.get(openstar).get("BRANDOPENTIME"));
				notopenStarNormalMap.put("BRANDLONGITUDE", normalstarList.get(openstar).get("BRANDLONGITUDE"));
				notopenStarNormalMap.put("THUMNAIL", normalstarList.get(openstar).get("THUMNAIL"));
				notopenStarNormalMap.put("FAVORTOTALCNT", normalstarList.get(openstar).get("FAVORTOTALCNT"));
				notopenStarNormalMap.put("BRANDDELIVERYSTATUS", normalstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
				notopenStarNormalMap.put("EXPOSURELEVEL", normalstarList.get(openstar).get("EXPOSURELEVEL"));
				notopenStarNormalMap.put("BRANDINTRODUCE", normalstarList.get(openstar).get("BRANDINTRODUCE"));
				notopenStarNormalMap.put("BRANDNUM", normalstarList.get(openstar).get("BRANDNUM"));
				
				
				notopenStarNormal.add(notopenStarNormalMap);
				
			}
		}
		
		
		//오픈한 브랜드리스트랑 비오픈 리스트를 하나로 합치는 리스트 만들기, 오픈한 리스트를 상위로 둔다.
		
		for(int merge = 0; merge < notopenStarNormal.size(); merge++) {
			
			openStarNormal.add(notopenStarNormal.get(merge));
			
			
		}
		
		//일반브랜드 평점순높으면서 영업중인거 최종 리스트
//		System.out.println("일반  브랜드 중에서 평점이 높으면서 영업중인 리스트가 나온다.");
//		System.out.println(openStarNormal);


//-------------------------------------------------------------------------------------------------------------------
		
		//추천 브랜드 리스트
		
		for(int openstar = 0; openstar<recommandstarList.size(); openstar++) {
			
			String result = (String) recommandstarList.get(openstar).get("BRANDOPENTIME");
			
			if(result.equals("Y")) {
				
				//추천브랜드의 오픈이면서 별점이 높은 브랜드의 세부사항을 담을 맵
				Map<String, Object> openStarRecommandMap = new HashMap<String, Object>();
				
				openStarRecommandMap.put("BRANDRESERVATIONSTATUS", recommandstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
				openStarRecommandMap.put("AVGSTARGRADE", recommandstarList.get(openstar).get("AVGSTARGRADE"));
				openStarRecommandMap.put("BRANDNAME", recommandstarList.get(openstar).get("BRANDNAME"));
				openStarRecommandMap.put("gapM", recommandstarList.get(openstar).get("gapM"));
				openStarRecommandMap.put("BRANDLATITUDE", recommandstarList.get(openstar).get("BRANDLATITUDE"));
				openStarRecommandMap.put("BRANDADDRESS", recommandstarList.get(openstar).get("BRANDADDRESS"));
				openStarRecommandMap.put("REVIEWCOUNT", recommandstarList.get(openstar).get("REVIEWCOUNT"));
				openStarRecommandMap.put("BRANDOPENTIME", recommandstarList.get(openstar).get("BRANDOPENTIME"));
				openStarRecommandMap.put("BRANDLONGITUDE", recommandstarList.get(openstar).get("BRANDLONGITUDE"));
				openStarRecommandMap.put("THUMNAIL", recommandstarList.get(openstar).get("THUMNAIL"));
				openStarRecommandMap.put("FAVORTOTALCNT", recommandstarList.get(openstar).get("FAVORTOTALCNT"));
				openStarRecommandMap.put("BRANDDELIVERYSTATUS", recommandstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
				openStarRecommandMap.put("EXPOSURELEVEL", recommandstarList.get(openstar).get("EXPOSURELEVEL"));
				openStarRecommandMap.put("BRANDINTRODUCE", recommandstarList.get(openstar).get("BRANDINTRODUCE"));
				openStarRecommandMap.put("BRANDNUM", recommandstarList.get(openstar).get("BRANDNUM"));
				
				
				openStarRecommand.add(openStarRecommandMap);
			}else {
				
				//추천브랜드의 비오픈이면서 별점이 높은 브랜드의 세부사항을 담을 맵
				Map<String, Object> notopenStarRecommandMap = new HashMap<String, Object>();
				
				notopenStarRecommandMap.put("BRANDRESERVATIONSTATUS", recommandstarList.get(openstar).get("BRANDRESERVATIONSTATUS"));
				notopenStarRecommandMap.put("AVGSTARGRADE", recommandstarList.get(openstar).get("AVGSTARGRADE"));
				notopenStarRecommandMap.put("BRANDNAME", recommandstarList.get(openstar).get("BRANDNAME"));
				notopenStarRecommandMap.put("gapM", recommandstarList.get(openstar).get("gapM"));
				notopenStarRecommandMap.put("BRANDLATITUDE", recommandstarList.get(openstar).get("BRANDLATITUDE"));
				notopenStarRecommandMap.put("BRANDADDRESS", recommandstarList.get(openstar).get("BRANDADDRESS"));
				notopenStarRecommandMap.put("REVIEWCOUNT", recommandstarList.get(openstar).get("REVIEWCOUNT"));
				notopenStarRecommandMap.put("BRANDOPENTIME", recommandstarList.get(openstar).get("BRANDOPENTIME"));
				notopenStarRecommandMap.put("BRANDLONGITUDE", recommandstarList.get(openstar).get("BRANDLONGITUDE"));
				notopenStarRecommandMap.put("THUMNAIL", recommandstarList.get(openstar).get("THUMNAIL"));
				notopenStarRecommandMap.put("FAVORTOTALCNT", recommandstarList.get(openstar).get("FAVORTOTALCNT"));
				notopenStarRecommandMap.put("BRANDDELIVERYSTATUS", recommandstarList.get(openstar).get("BRANDDELIVERYSTATUS"));
				notopenStarRecommandMap.put("EXPOSURELEVEL", recommandstarList.get(openstar).get("EXPOSURELEVEL"));
				notopenStarRecommandMap.put("BRANDINTRODUCE", recommandstarList.get(openstar).get("BRANDINTRODUCE"));
				notopenStarRecommandMap.put("BRANDNUM", recommandstarList.get(openstar).get("BRANDNUM"));
				
				
				notopenStarRecommand.add(notopenStarRecommandMap);
				
			}
		}
		
		//오픈한 브랜드리스트랑 비오픈 리스트를 하나로 합치는 리스트 만들기, 오픈한 리스트를 상위로 둔다.
		for(int merge = 0; merge < notopenStarRecommand.size(); merge++) {
			
			openStarRecommand.add(notopenStarRecommand.get(merge));
			
			
		}
		
		//추천브랜드 평점순높으면서 영업중인거 최종 리스트
	//	System.out.println("추천  브랜드 중에서 평점이 높으면서 영업중인 리스트가 나온다.");
		//System.out.println(openStarRecommand);
		
		//일반브랜드 평점순높으면서 영업중인거 최종 리스트
		//System.out.println("일반  브랜드 중에서 평점이 높으면서 영업중인 리스트가 나온다.");
	//	System.out.println(openStarNormal);
		
//**********************************************************************************************************************************
		
		//두개의 리스트를 담는 맵을 만들어서 각각의 리스트들을 담아준다
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("normalstarList", openStarNormal);
		resultMap.put("recommandstarList", openStarRecommand);
		
		return resultMap;
		
	}
	
	
	
	//회원이 누른 관심리스트만 뽑아온다.
	public List<Map<String, Object>> memberFavorBrand(String memberPK){
		
		List<Map<String, Object>> favorSelectList =  mDao.memberFaovrBrand(memberPK);		
		return favorSelectList;
		
	}
	
	//memberFavorBrand함수를 통해서 가져온 List<Map>을  거리순으로 가공하는 함수
	//거리순으로 정렬함과 동시에 오픈인지 아닌지 비교한 후 오픈시간을 오픈이면 'Y'로 수정, 브랜드가 마감했으면 'N'으로 수종해준다.
//	public List<Map<String, Object>> favorSorting(List<Map<String, Object>> favorSelectList, String lit, String lot){
	public List<Map<String, Object>> favorSorting(List<Map<String, Object>> favorSelectList, double mLit, double mLot){
		
		//영업시간 현재시간이랑 비교해서 영업중이면 'Y', 비영업중이면 'N'으로 넣는다.
		//거리 계산해서 거리값도 리스트 맵에 각각 추가해서 보낸다.
		
		//내 위치와 리스트안에 있는 브랜드들의 거리값을 구해서  'gapM'의 키값에 값을 넣어준다.
		for(int i = 0; i< favorSelectList.size(); i++ ) {

			//검색어를 통해 뽑아온 브랜드들의 각각의 위도와 경도를 뽑아서 parseDouble한다.
			double targetBrandLat = Double.parseDouble((String) favorSelectList.get(i).get("BRANDLATITUDE"));
			double targetBrandLot = Double.parseDouble((String) favorSelectList.get(i).get("BRANDLONGITUDE"));
			
			//내 위치의 위도,경도와 브랜드의 위도경도를 통해 사이값을 km단위로 뽑아온다.
			double dist = calDistance(mLit, mLot, targetBrandLat, targetBrandLot);
		
			//List에 담긴 Map에 각각의 거리값을  put해준다.
			favorSelectList.get(i).put("gapM", dist);
					
		}
		
		//List<Map> 거리순으로 소팅해주는 것
		//List<MAP<>> 거리순으로 재정렬시킴
		Collections.sort(favorSelectList, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				double firstValue = (double) first.get("gapM");
				double secondValue = (double) seconde.get("gapM");
	            
	            // 내림차순 정렬
	            if (firstValue > secondValue) {
	                return 1;
	            } else if (firstValue < secondValue) {
	                return -1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
			}
		});
		
//------------------------------------------------------------------------------------------------------------------------------------------
		//가게들이 영업중이면 영업시간의 값을 'Y'로 바꾸고 마감쳤으면 'N'으로 수정한다.
		//거리순으로 정렬되어 있는 값들을 오픈된 브랜드 우선으로 리스트를 뿌린다.
		
		//영업시간에 맞춰 'Y' or 'N'을 넣을 리스트
		List<Map<String, Object>> openTimeInterestList = new LinkedList<Map<String, Object>>();
		
		//현재 시간, 분을 String으로 받는다.
		String todayDate = new Date().toString();
		
		//현재 시간에 대한 모든 값을 " "기준으로 자른다.
		String[] todayDateArr = todayDate.split(" ");
		
		//필요한 값이 들어있는 배열을 " : "을 기준으로 자른다.
		String[] today = todayDateArr[3].split(":");
		
		//현재 시간, 분을 문자열로 붙인다.
		String todayHoureMin = today[0]+today[1];
		
		//문자열로 붙인 현재 시간, 분을 정수형으로 parse시킨다.
		int todayHM = Integer.parseInt(todayHoureMin);

		for(int open = 0; open<favorSelectList.size(); open++) {
			
			//openTimeInterestList에 담을 맵, list[0] 하나의 칸 마다 한브랜드의 모든 정보가 들어있다.
			Map<String, Object> openMap = new HashMap<String, Object>();
			
//			System.out.println(brandRecommandList.get(recommandopen).get("BRANDOPENTIME"));
			
			//문자열로 브랜드의 오픈시간을 가져온다.
			String openTime = (String)favorSelectList.get(open).get("BRANDOPENTIME");
			
			//가지고 온 오픈시간을 ','을 기준으로 자른다.
			String[] timesArr = openTime.split(",");
			
			//자른 각각의 문자열 형태의 숫자들을 맞는 문자열 변수에 넣어준다.
			String openbrand = timesArr[0]+timesArr[1];
			String closebrand = timesArr[2]+timesArr[3];
	
			
			//브랜드마다 가지고 있는 오픈 시간, 분을 int형으로 parse시킨 것
			int intOpenBrand = Integer.parseInt(openbrand);
			int intCloseBrand = Integer.parseInt(closebrand);

			if(intOpenBrand < todayHM && todayHM < intCloseBrand){	
				//오픈한 브랜드들의 상세정보를 담을 맵
				openMap.put("BRANDRESERVATIONSTATUS", favorSelectList.get(open).get("BRANDRESERVATIONSTATUS"));
				openMap.put("AVGSTARGRADE", favorSelectList.get(open).get("AVGSTARGRADE"));
				openMap.put("BRANDNAME", favorSelectList.get(open).get("BRANDNAME"));
				openMap.put("gapM", favorSelectList.get(open).get("gapM"));
				openMap.put("BRANDLATITUDE", favorSelectList.get(open).get("BRANDLATITUDE"));
				openMap.put("BRANDADDRESS", favorSelectList.get(open).get("BRANDADDRESS"));
				openMap.put("REVIEWCOUNT", favorSelectList.get(open).get("REVIEWCOUNT"));
				openMap.put("BRANDOPENTIME", "Y");
				openMap.put("BRANDLONGITUDE", favorSelectList.get(open).get("BRANDLONGITUDE"));
				openMap.put("THUMNAIL", favorSelectList.get(open).get("THUMNAIL"));
				openMap.put("FAVORTOTALCNT", favorSelectList.get(open).get("FAVORTOTALCNT"));
				openMap.put("BRANDDELIVERYSTATUS", favorSelectList.get(open).get("BRANDDELIVERYSTATUS"));
				openMap.put("EXPOSURELEVEL", favorSelectList.get(open).get("EXPOSURELEVEL"));
				openMap.put("BRANDINTRODUCE", favorSelectList.get(open).get("BRANDINTRODUCE"));
				openMap.put("BRANDNUM", favorSelectList.get(open).get("BRANDNUM"));
				
				openTimeInterestList.add(openMap);
				
			}else {
				//영업종료한 브랜드들
				openMap.put("BRANDRESERVATIONSTATUS", favorSelectList.get(open).get("BRANDRESERVATIONSTATUS"));
				openMap.put("AVGSTARGRADE", favorSelectList.get(open).get("AVGSTARGRADE"));
				openMap.put("BRANDNAME", favorSelectList.get(open).get("BRANDNAME"));
				openMap.put("gapM", favorSelectList.get(open).get("gapM"));
				openMap.put("BRANDLATITUDE", favorSelectList.get(open).get("BRANDLATITUDE"));
				openMap.put("BRANDADDRESS", favorSelectList.get(open).get("BRANDADDRESS"));
				openMap.put("REVIEWCOUNT", favorSelectList.get(open).get("REVIEWCOUNT"));
				openMap.put("BRANDOPENTIME", "N");
				openMap.put("BRANDLONGITUDE", favorSelectList.get(open).get("BRANDLONGITUDE"));
				openMap.put("THUMNAIL", favorSelectList.get(open).get("THUMNAIL"));
				openMap.put("FAVORTOTALCNT", favorSelectList.get(open).get("FAVORTOTALCNT"));
				openMap.put("BRANDDELIVERYSTATUS", favorSelectList.get(open).get("BRANDDELIVERYSTATUS"));
				openMap.put("EXPOSURELEVEL", favorSelectList.get(open).get("EXPOSURELEVEL"));
				openMap.put("BRANDINTRODUCE", favorSelectList.get(open).get("BRANDINTRODUCE"));
				openMap.put("BRANDNUM", favorSelectList.get(open).get("BRANDNUM"));
				
				openTimeInterestList.add(openMap);
			}
		}		
		return openTimeInterestList;
	}
	
	//데이터베이스에서 뽑아온 모든 브랜드의 데이터들에 거리값을 넣고 나와의 거리가 3키로 이내의 것들만 반환시킨다. 
	public Map<String, Object> BrandAndMeDistanceValue(Double lit, Double lot){
		
		
		List<Map<String, Object>> allBrand = bDao.selectBrandAll();

		//리스트를 일반, 추천 두개로 나눈다.
		//두개로 나눈 리스트들을 오픈인지 아닌지 비교해수 'Y' or 'N'을 넣고
		//각각의 브랜드들과 사용자의 거리값을 넣는다.
		//각각의 브랜드값들 중 5키로 이내의 값들만 리스트에 넣어서 보내준다.
		
		
		//exposureLevel이 RECOMMAND 또는 PACKAGE이면  brandExposureList에 값이 저장된다.
		List<Map<String, Object>> brandRecommandList = new LinkedList<Map<String,Object>>();
		
		//exposureLevel이 NORMAL이면  brandExposureList에 값이 저장된다.
		List<Map<String, Object>> brandNormalList = new LinkedList<Map<String, Object>>();
		
		
		//먼저 모든 브랜드들에 거리값을 넣는다.
		for(int i = 0; i< allBrand.size(); i++ ) {

			//검색어를 통해 뽑아온 브랜드들의 각각의 위도와 경도를 뽑아서 parseDouble한다.
			double targetBrandLat = Double.parseDouble((String) allBrand.get(i).get("BRANDLATITUDE"));
			double targetBrandLon = Double.parseDouble((String) allBrand.get(i).get("BRANDLONGITUDE"));
			
			//내 위치의 위도,경도와 브랜드의 위도경도를 통해 사이값을 km단위로 뽑아온다.
			double dist = calDistance(lit, lot, targetBrandLat, targetBrandLon);
			
			allBrand.get(i).put("gapM", dist);

		}
		
		//List<MAP<>> 거리순으로 재정렬시킴
		Collections.sort(allBrand, new Comparator<Map<String, Object>>(){

			@Override
			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
				
				double firstValue = (double) first.get("gapM");
				double secondValue = (double) seconde.get("gapM");
	            
	            // 내림차순 정렬
	            if (firstValue > secondValue) {
	                return 1;
	            } else if (firstValue < secondValue) {
	                return -1;
	            } else /* if (firstValue == secondValue) */ {
	                return 0;
	            }
			}
		});
		
		
		//검색어에 맞는 결과값을 추천과 일반으로 나눠서 두개의 리스트로 만든다.
		for(int i = 0; i < allBrand.size(); i++) {
		
			String brandExposure = (String) allBrand.get(i).get("EXPOSURELEVEL");
			
			double standard = 2.00;
			
			//service에서 꺼내온 List들 추천레벨이  RECOMMAND, PACKAGE이면 추천 리스트에 담고
			if(brandExposure.equals("RECOMMAND") || brandExposure.equals("PACKAGE")) {
				
				//브랜드 exposureLevel이 'RECOMMAND' or 'PACKAGE'이면 
				if((double)allBrand.get(i).get("gapM") <= standard) {
					
					Map<String, Object> brandRecommandMap = new HashMap<String, Object>();
					
					brandRecommandMap = allBrand.get(i);

					brandRecommandList.add(brandRecommandMap);
					
				}else {					
				
					continue;					
				}
				
			} else{
				
				if((double)allBrand.get(i).get("gapM") <= standard) {
					
					Map<String, Object> brandNormalMap = new HashMap<String, Object>();
					
					//추천 레벨이 NORMAL이면 노말리스트에 담는다.
					brandNormalMap = allBrand.get(i);					
					brandNormalList.add(brandNormalMap);
					
				}else {				
					
					continue;					
				}
			}
		}
		
		//거리순으로 정렬되어 있는 값들을 오픈된 브랜드 우선으로 리스트를 뿌린다.
		
		//현재 시간, 분을 String으로 받는다.
		String todayDate = new Date().toString();
		
		//현재 시간에 대한 모든 값을 " "기준으로 자른다.
		String[] todayDateArr = todayDate.split(" ");
		
		//필요한 값이 들어있는 배열을 " : "을 기준으로 자른다.
		String[] today = todayDateArr[3].split(":");
		
		//현재 시간, 분을 문자열로 붙인다.
		String todayHoureMin = today[0]+today[1];
		
		//문자열로 붙인 현재 시간, 분을 정수형으로 parse시킨다.
		int todayHM = Integer.parseInt(todayHoureMin);
		
		
//************************************************************************************
		
		//추천브랜드 먼저 오픈순으로 재정렬함!
		//오픈한 브랜드들이 먼저 리스트의 상위로 올라온 정렬을 담는 리스트
		List<Map<String, Object>> openRecommandBrand = new LinkedList<Map<String, Object>>();
		
		//영업이 종료된 브랜드들을 담는 리스트
		List<Map<String, Object>> notopenRecommandBrand = new LinkedList<Map<String, Object>>();
		
		
		for(int recommandopen = 0; recommandopen<brandRecommandList.size(); recommandopen++) {
			
			//문자열로 브랜드의 오픈시간을 가져온다.
			String openTime = (String)brandRecommandList.get(recommandopen).get("BRANDOPENTIME");
			
			//가지고 온 오픈시간을 ','을 기준으로 자른다.
			String[] timesArr = openTime.split(",");
			
			//자른 각각의 문자열 형태의 숫자들을 맞는 문자열 변수에 넣어준다.
			String openbrand = timesArr[0]+timesArr[1];
			String closebrand = timesArr[2]+timesArr[3];
	
			
			//브랜드마다 가지고 있는 오픈 시간, 분을 int형으로 parse시킨 것
			int intOpenBrand = Integer.parseInt(openbrand);
			int intCloseBrand = Integer.parseInt(closebrand);

			if(intOpenBrand < todayHM && todayHM < intCloseBrand){
				
				//오픈한 브랜드들의 상세정보를 담을 맵
				Map<String, Object> openRecommandBrandMap = new HashMap<String, Object>();
				
				openRecommandBrandMap.put("BRANDRESERVATIONSTATUS", brandRecommandList.get(recommandopen).get("BRANDRESERVATIONSTATUS"));
				openRecommandBrandMap.put("AVGSTARGRADE", brandRecommandList.get(recommandopen).get("AVGSTARGRADE"));
				openRecommandBrandMap.put("BRANDNAME", brandRecommandList.get(recommandopen).get("BRANDNAME"));
				openRecommandBrandMap.put("gapM", brandRecommandList.get(recommandopen).get("gapM"));
				openRecommandBrandMap.put("BRANDLATITUDE", brandRecommandList.get(recommandopen).get("BRANDLATITUDE"));
				openRecommandBrandMap.put("BRANDADDRESS", brandRecommandList.get(recommandopen).get("BRANDADDRESS"));
				openRecommandBrandMap.put("REVIEWCOUNT", brandRecommandList.get(recommandopen).get("REVIEWCOUNT"));
				openRecommandBrandMap.put("BRANDOPENTIME", "Y");
				openRecommandBrandMap.put("BRANDLONGITUDE", brandRecommandList.get(recommandopen).get("BRANDLONGITUDE"));
				openRecommandBrandMap.put("THUMNAIL", brandRecommandList.get(recommandopen).get("THUMNAIL"));
				openRecommandBrandMap.put("FAVORTOTALCNT", brandRecommandList.get(recommandopen).get("FAVORTOTALCNT"));
				openRecommandBrandMap.put("BRANDDELIVERYSTATUS", brandRecommandList.get(recommandopen).get("BRANDDELIVERYSTATUS"));
				openRecommandBrandMap.put("EXPOSURELEVEL", brandRecommandList.get(recommandopen).get("EXPOSURELEVEL"));
				openRecommandBrandMap.put("BRANDINTRODUCE", brandRecommandList.get(recommandopen).get("BRANDINTRODUCE"));
				openRecommandBrandMap.put("BRANDNUM", brandRecommandList.get(recommandopen).get("BRANDNUM"));
				
				openRecommandBrand.add(openRecommandBrandMap);
				
			}else {

				//영업이 종료된 브랜드들의 상세정보를 담을 맵
				Map<String, Object> notopenRecommandBrandMap = new HashMap<String, Object>();
				
				notopenRecommandBrandMap.put("BRANDRESERVATIONSTATUS", brandRecommandList.get(recommandopen).get("BRANDRESERVATIONSTATUS"));
				notopenRecommandBrandMap.put("AVGSTARGRADE", brandRecommandList.get(recommandopen).get("AVGSTARGRADE"));
				notopenRecommandBrandMap.put("BRANDNAME", brandRecommandList.get(recommandopen).get("BRANDNAME"));
				notopenRecommandBrandMap.put("gapM", brandRecommandList.get(recommandopen).get("gapM"));
				notopenRecommandBrandMap.put("BRANDLATITUDE", brandRecommandList.get(recommandopen).get("BRANDLATITUDE"));
				notopenRecommandBrandMap.put("BRANDADDRESS", brandRecommandList.get(recommandopen).get("BRANDADDRESS"));
				notopenRecommandBrandMap.put("REVIEWCOUNT", brandRecommandList.get(recommandopen).get("REVIEWCOUNT"));
				notopenRecommandBrandMap.put("BRANDOPENTIME", "N");
				notopenRecommandBrandMap.put("BRANDLONGITUDE", brandRecommandList.get(recommandopen).get("BRANDLONGITUDE"));
				notopenRecommandBrandMap.put("THUMNAIL", brandRecommandList.get(recommandopen).get("THUMNAIL"));
				notopenRecommandBrandMap.put("FAVORTOTALCNT", brandRecommandList.get(recommandopen).get("FAVORTOTALCNT"));
				notopenRecommandBrandMap.put("BRANDDELIVERYSTATUS", brandRecommandList.get(recommandopen).get("BRANDDELIVERYSTATUS"));
				notopenRecommandBrandMap.put("EXPOSURELEVEL", brandRecommandList.get(recommandopen).get("EXPOSURELEVEL"));
				notopenRecommandBrandMap.put("BRANDINTRODUCE", brandRecommandList.get(recommandopen).get("BRANDINTRODUCE"));
				notopenRecommandBrandMap.put("BRANDNUM", brandRecommandList.get(recommandopen).get("BRANDNUM"));
				
				notopenRecommandBrand.add(notopenRecommandBrandMap);
			}
		}

		//각각 2개로 나눈 오픈, 비오픈 가게들을 하나의 리스트로 합친다.
		for(int mergeList = 0; mergeList<notopenRecommandBrand.size(); mergeList++) {
			openRecommandBrand.add(notopenRecommandBrand.get(mergeList));
		}

//************************************************************************************
		
		//일반 브랜드들 오픈순으로 재정렬

		
		//오픈한 브랜드들이 먼저 리스트의 상위로 올라온 정렬을 담는 리스트
		List<Map<String, Object>> openNormalBrand = new LinkedList<Map<String, Object>>();
		
		//영업이 종료된 브랜드들을 담는 리스트
		List<Map<String, Object>> notopenNormalBrand = new LinkedList<Map<String, Object>>();
		
		
		for(int normalopen = 0; normalopen<brandNormalList.size(); normalopen++) {
			
			//문자열로 브랜드의 오픈시간을 가져온다.
			String openTime = (String)brandNormalList.get(normalopen).get("BRANDOPENTIME");
			
			//가지고 온 오픈시간을 ','을 기준으로 자른다.
			String[] timesArr = openTime.split(",");
			
			//자른 각각의 문자열 형태의 숫자들을 맞는 문자열 변수에 넣어준다.
			String openbrand = timesArr[0]+timesArr[1];
			String closebrand = timesArr[2]+timesArr[3];
	
			
			//브랜드마다 가지고 있는 오픈 시간, 분을 int형으로 parse시킨 것
			int intOpenBrand = Integer.parseInt(openbrand);
			int intCloseBrand = Integer.parseInt(closebrand);
			
			//
			if(intOpenBrand < todayHM && todayHM < intCloseBrand){
				
				//오픈한 브랜드들의 상세정보를 담을 맵
				Map<String, Object> openNormalBrandMap = new HashMap<String, Object>();
				
				openNormalBrandMap.put("BRANDRESERVATIONSTATUS", brandNormalList.get(normalopen).get("BRANDRESERVATIONSTATUS"));
				openNormalBrandMap.put("AVGSTARGRADE", brandNormalList.get(normalopen).get("AVGSTARGRADE"));
				openNormalBrandMap.put("BRANDNAME", brandNormalList.get(normalopen).get("BRANDNAME"));
				openNormalBrandMap.put("gapM", brandNormalList.get(normalopen).get("gapM"));
				openNormalBrandMap.put("BRANDLATITUDE", brandNormalList.get(normalopen).get("BRANDLATITUDE"));
				openNormalBrandMap.put("BRANDADDRESS", brandNormalList.get(normalopen).get("BRANDADDRESS"));
				openNormalBrandMap.put("REVIEWCOUNT", brandNormalList.get(normalopen).get("REVIEWCOUNT"));
				openNormalBrandMap.put("BRANDOPENTIME", "Y");
				openNormalBrandMap.put("BRANDLONGITUDE", brandNormalList.get(normalopen).get("BRANDLONGITUDE"));
				openNormalBrandMap.put("THUMNAIL", brandNormalList.get(normalopen).get("THUMNAIL"));
				openNormalBrandMap.put("FAVORTOTALCNT", brandNormalList.get(normalopen).get("FAVORTOTALCNT"));
				openNormalBrandMap.put("BRANDDELIVERYSTATUS", brandNormalList.get(normalopen).get("BRANDDELIVERYSTATUS"));
				openNormalBrandMap.put("EXPOSURELEVEL", brandNormalList.get(normalopen).get("EXPOSURELEVEL"));
				openNormalBrandMap.put("BRANDINTRODUCE", brandNormalList.get(normalopen).get("BRANDINTRODUCE"));
				openNormalBrandMap.put("BRANDNUM", brandNormalList.get(normalopen).get("BRANDNUM"));
				
				openNormalBrand.add(openNormalBrandMap);
				
			}else {

				//영업이 종료된 브랜드들의 상세정보를 담을 맵
				Map<String, Object> notopenNormalBrandMap = new HashMap<String, Object>();
				
				notopenNormalBrandMap.put("BRANDRESERVATIONSTATUS", brandNormalList.get(normalopen).get("BRANDRESERVATIONSTATUS"));
				notopenNormalBrandMap.put("AVGSTARGRADE", brandNormalList.get(normalopen).get("AVGSTARGRADE"));
				notopenNormalBrandMap.put("BRANDNAME", brandNormalList.get(normalopen).get("BRANDNAME"));
				notopenNormalBrandMap.put("gapM", brandNormalList.get(normalopen).get("gapM"));
				notopenNormalBrandMap.put("BRANDLATITUDE", brandNormalList.get(normalopen).get("BRANDLATITUDE"));
				notopenNormalBrandMap.put("BRANDADDRESS", brandNormalList.get(normalopen).get("BRANDADDRESS"));
				notopenNormalBrandMap.put("REVIEWCOUNT", brandNormalList.get(normalopen).get("REVIEWCOUNT"));
				notopenNormalBrandMap.put("BRANDOPENTIME", "N");
				notopenNormalBrandMap.put("BRANDLONGITUDE", brandNormalList.get(normalopen).get("BRANDLONGITUDE"));
				notopenNormalBrandMap.put("THUMNAIL", brandNormalList.get(normalopen).get("THUMNAIL"));
				notopenNormalBrandMap.put("FAVORTOTALCNT", brandNormalList.get(normalopen).get("FAVORTOTALCNT"));
				notopenNormalBrandMap.put("BRANDDELIVERYSTATUS", brandNormalList.get(normalopen).get("BRANDDELIVERYSTATUS"));
				notopenNormalBrandMap.put("EXPOSURELEVEL", brandNormalList.get(normalopen).get("EXPOSURELEVEL"));
				notopenNormalBrandMap.put("BRANDINTRODUCE", brandNormalList.get(normalopen).get("BRANDINTRODUCE"));
				notopenNormalBrandMap.put("BRANDNUM", brandNormalList.get(normalopen).get("BRANDNUM"));
				
				notopenNormalBrand.add(notopenNormalBrandMap);
			}
		}

		//각각 2개로 나눈 오픈, 비오픈 가게들을 하나의 리스트로 합친다.
		for(int mergeList = 0; mergeList<notopenNormalBrand.size(); mergeList++) {
			openNormalBrand.add(notopenNormalBrand.get(mergeList));			
		}
		
//		System.out.println("오키로 이내의 추천 가게들"+openRecommandBrand);
//		System.out.println("오키로 이내의 기본 가게들"+openNormalBrand);
		
		Map<String, Object> resultList = new HashMap<String, Object>();
		
		resultList.put("recommand", openRecommandBrand);
		resultList.put("normal", openNormalBrand);
		
		return resultList;
		
	}
	
	//brandOwnerNUM을 통해서 brandNUM을 알아온다.
	public String selectBrand(String brandOwnerNUM) {			
		String brandname = nDao.selectBrand(brandOwnerNUM);
		
		return brandname;		
	}
	
	//admin_main페이지에 필요한 값들
	//마스터 권한일 경우
	public Map<String, Object> adminMasterMainInfo(){
		
		//주문관리
		Map<String, Object> mainorder = nDao.adminMasterMainOrderManage();
		int cancleDeli = nDao.adminMasterMainOrderManageDeliver();
		int cancleReser = nDao.adminMasterMainOrderManageReservation();
		
		//리뷰관리
		int reviewTotal = nDao.adminMasterMainReviewManage();
		int todayReview = nDao.adminMasterMainTodayReviewManage();
		
		//1:1문의관리
		int inquireTotal = nDao.adminMasterMainInquireManage();
		int inquireToday = nDao.adminMasterMainTodayInquireManage();
		
		//광고, 제휴 문의관리
		int adTotal = nDao.adminMasterMainAdManage();
		int adToday = nDao.adminMasterMainTodayAdManage();
		
		//매출현황
		int salesTotal = nDao.adminMasterMainSales();
		int salesMonth = nDao.adminMasterMonthMainSales();	
		
		Map<String, Object> masterMap = new HashMap<String, Object>();
		
		masterMap.put("NDELIVERTOTALCOUNT", mainorder.get("NDELIVERTOTALCOUNT"));
		masterMap.put("NREGITOTALCOUNT", mainorder.get("NREGITOTALCOUNT"));
		masterMap.put("ORDERTOTALCOUNT", mainorder.get("ORDERTOTALCOUNT"));
		masterMap.put("cancleDeli", cancleDeli);
		masterMap.put("cancleReser", cancleReser);
		masterMap.put("reviewTotal", reviewTotal);
		masterMap.put("todayReview", todayReview);
		masterMap.put("inquireTotal", inquireTotal);
		masterMap.put("inquireToday", inquireToday);
		masterMap.put("adTotal", adTotal);
		masterMap.put("adToday", adToday);
		masterMap.put("salesTotal", salesTotal);
		masterMap.put("salesMonth", salesMonth);
		
		return masterMap;
		
	}
	
	//admin_main페이지에 필요한 값들
	//브랜드 권한일 경우
	public Map<String, Object> adminBrandMainInfo(String brandNUM){
		
		//주문관리
		Map<String, Object> mainorder = nDao.adminBrandMainOrderManage(brandNUM);
	
		int cancleDeli = nDao.adminBrandMainOrderManageDeliver(brandNUM);
		int cancleReser = nDao.adminBrandMainOrderManageReservation(brandNUM);
		
		//리뷰관리
		int reviewTotal = nDao.adminBrandMainReviewManage(brandNUM);
		int todayReview = nDao.adminBrandMainTodayReviewManage(brandNUM);

		//매출현황
		int salesTotal = nDao.adminBrandMainSales(brandNUM);
		int salesMonth = nDao.adminBrandMonthMainSales(brandNUM);	
		
		Map<String, Object> BrandMap = new HashMap<String, Object>();
		
		BrandMap.put("NDELIVERTOTALCOUNT", mainorder.get("DELIVERTOTALCOUNT"));
		BrandMap.put("NREGITOTALCOUNT", mainorder.get("REGITOTALCOUNT"));
		BrandMap.put("ORDERTOTALCOUNT", mainorder.get("ORDERTOTALCOUNT"));
		
		
		BrandMap.put("cancleDeli", cancleDeli);
		BrandMap.put("cancleReser", cancleReser);
		BrandMap.put("reviewTotal", reviewTotal);
		BrandMap.put("todayReview", todayReview);
		BrandMap.put("salesTotal", salesTotal);
		BrandMap.put("salesMonth", salesMonth);
		
		return BrandMap;		
	}
	
	//이미지 이름 
	public byte[] getImegeAsByteArray(String brandnum) {
	      //특정이미지를 바이터 배열로 만들어서 반환한다!!!
	      //C:\boardimg 이미지 경로

	      String thumNail = bDao.thumnaulImage(brandnum);
	   
	      File originFile = new File("C:/temp/"+thumNail);
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
	
	
	
//---------------------------------------mainRank건들이는 부분------------------------------------------------------------
	
	//brand테이블에서 mainRank번호들을 뽑아오고 없는 번호에 배치번호가 0번인 요소들에 값을 부여한다.
	public int selectmainRank() {
		
		List<Map<String, Object>> brandMainRank = bDao.brandMainRank();

	    List<Integer> arra = new ArrayList<Integer>();
			
			arra.add(1);
			arra.add(2);
			arra.add(3);
			arra.add(4);
			arra.add(5);
			arra.add(6);
			
//			int[] arra = {1,2,3,4,5,6};
			
			for(int i = 0; i<brandMainRank.size(); i++) {
				
				String alreadyRank = String.valueOf(brandMainRank.get(i).get("MAINRANK")); 
				
				int alreadyRank2 = Integer.parseInt(alreadyRank);
				
				for(int j = 1; j <= arra.size(); j++) {
					
					if(alreadyRank2 == arra.get(j-1)) {					
//						System.out.println("이 번호는 이미 있는 번호 : "+j);
//						System.out.println("배열에서 꺼낸 값"+arra.get(j-1));
						arra.remove(j-1);
						break;					
					}else {
						
//						System.out.println("else 번호 : "+j);
						continue;
						
					}			
				}			
			}	

//			System.out.println("런매;"+arra.size());
			
//			for(int i = 0; i<=arra.size();i++) {
//				
//				System.out.println(arra.get(i));
//				
//			}
		 
			return arra.get(0);


	}
	
	//rankNUM 수정해주는 함수
	public boolean updateRankNUM(String brandNUM, int MAINRANK) {
		
		
//		System.out.println("service에서 updaateRanNUM함수에서 받은 파리미터 값" + brandNUM + MAINRANK);
	
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("brandNUM", brandNUM);
		param.put("mainRANK", MAINRANK);
		
//		int result =  bDao.updateMainRankZero(brandNUM, MAINRANK);
		int result =  bDao.updateMainRankZero(param);
		
		if(result == 1) {
			
			return true;
		}else {
			
			return false;
			
		}
		
	}
	
	
	public boolean mainRankUp(String brandNUM, int MAINRANK) {
		
		// 똑딱이를 눌렀을 때, 먼저 똑딱이 up이 눌렸으면 눌린 브랜드의 메인랭크 번호보다 -1한 메인랭크가 있는지 먼저 찾고
		// 없으면 해당 브랜드만 up시키고

		// -1한 브랜드의 메인랭크를 +1시킨다.
		// 있으면 해당브랜드를 up시키고

		
		//눌린 브랜드의 메인랭크보다 -1한 브랜드가 있는지 검색해본다.
		int result = bDao.selectAnothermainRank(MAINRANK - 1);
		
		//있으면 해당 번호가 없으면 0과 ''값이 있을 것	
		


		//업데이트 후 결과를 이용하기 위해 조건문 전에 선언해준다.
		int upUpdate;
		int upUpdate2;

		//검색해온 결과값이 0이면, 해당 브랜드만 메인랭크 -1해준다.
		if (result == 0) {
			// -1한 브랜드가 없을 때, 즉 해당 브랜드면 위로 한칸만 올려주면 된다.
			upUpdate = bDao.updateMainRankUP(brandNUM);
			
			if (upUpdate == 1) {
				//업데이트 성공 후에는 리턴트루
				return true;
			} else {

				return false;
			}

		} else {

			// 해당 브랜드를 -1해주고
			// result값 즉 -1한 메인랭크 번호를 가지고 있는 브랜드를 메인랭크 +1해준다.
			//0이 아닌 다른수가 있으면 해당 눌린 번호먼저 업 시켜주고

			//먼저 -1한 메인랭크를 update 해주고
			String brandNUM2 = bDao.mainRankSelectBrandNUM(MAINRANK - 1);			
			upUpdate = bDao.updateMainRankDOWN(brandNUM2);
			
			if (upUpdate == 1) {
				//위에 update가 잘 실행이 되면, 눌린 브랜드보다 -1한 메인랭크를 +1해준다.
				
				//그 다음 눌린 브랜드의 메인랭크를 수정한다.
				upUpdate2 = bDao.updateMainRankUP(brandNUM);
				
				if (upUpdate2 == 1) {
					return true;
				} else {

					return false;

				}
			} else {

				return false;

			}

		}

	}
	
	public boolean mainRankDown(String brandNUM, int mainRank) {
		
		int result = bDao.selectAnothermainRank(mainRank + 1);
		
		//업데이트 후 결과를 이용하기 위해 조건문 전에 선언해준다.
		int upUpdate;
		int upUpdate2;

		//검색해온 결과값이 0이면, 해당 브랜드만 메인랭크 -1해준다.
		if (result == 0) {
			// -1한 브랜드가 없을 때, 즉 해당 브랜드면 위로 한칸만 올려주면 된다.
			upUpdate = bDao.updateMainRankDOWN(brandNUM);
			
			if (upUpdate == 1) {
				//업데이트 성공 후에는 리턴트루
				return true;
			} else {

				return false;
			}

		} else {

			String brandNUM2 = bDao.mainRankSelectBrandNUM(mainRank + 1);			
			upUpdate = bDao.updateMainRankUP(brandNUM2);
			
			if (upUpdate == 1) {
				//위에 update가 잘 실행이 되면, 눌린 브랜드보다 -1한 메인랭크를 +1해준다.
				
				//그 다음 눌린 브랜드의 메인랭크를 수정한다.
				upUpdate2 = bDao.updateMainRankDOWN(brandNUM);
				
				if (upUpdate2 == 1) {
					
					return true;
				} else {

					return false;

				}
			} else {

				return false;

			}

		}

	}
	
	
	//거리값 계산해 주는 함수들                          내 위도경도                                                 목적지 위도경도
	public double calDistance(double lat1, double lon1, double lat2, double lon2){  
	    
	    double theta, dist;  
	    theta = lon1 - lon2;  
	    dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1))   
	          * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));  
	    dist = Math.acos(dist);  
	    dist = rad2deg(dist);  
	      
	    dist = dist * 60 * 1.1515;   
	    dist = dist * 1.609344;    // 단위 mile 에서 km 변환.  
//	    dist = dist * 1000.0;      // 단위  km 에서 m 로 변환  
	    
	    return (Math.round(dist*100)/100.0);  //반환값은 km단위로 나온다.
	}  
	
	// 주어진 도(degree) 값을 라디언으로 변환  
	private double deg2rad(double deg){  
	    return (double)(deg * Math.PI / (double)180d);  
	}  
	  
	// 주어진 라디언(radian) 값을 도(degree) 값으로 변환  
	private double rad2deg(double rad){  
	    return (double)(rad * (double)180d / Math.PI);  
	} 
	
	private int getPageTotalCount(int totalCount) {
		
		int pageTotalCount = 0;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_BOARD_PER_PAGE));
		}
		
		return pageTotalCount;
	}
	
	private int getStartPage(int currentPage) {
		//6  >>> 1
		//16 >>> 11
		//30 >> 21 
		//현재페이지 >> 시작페이지
		
		//현재 페이지 6이라고 가정, 네비게이션은 5개씩
		//6부터 시작

		return ((currentPage-1)/NUM_OF_NAVI_PAGE)*NUM_OF_NAVI_PAGE + 1;
		
	}
	
	private int getEndPage(int currentPage) {
		/*6  >>  10
		  10 >> 10*/
		/*11 >> 15*/
		// (16 - 1) / 5 >>> (3 + 1 ) * 5 =  20;
		return (((currentPage-1)/NUM_OF_NAVI_PAGE)+1)* NUM_OF_NAVI_PAGE;
		
	}
	
	private int getFirstRow(int currentPage) {
		return (currentPage-1)*NUM_OF_BOARD_PER_PAGE +1;
	}
	
	private int getEndRow(int currentPage) {
		return currentPage*NUM_OF_BOARD_PER_PAGE;
	}
}


