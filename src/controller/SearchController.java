package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import service.naraeService;

@Controller
@RequestMapping("/search")
public class SearchController {
	

	@Autowired
	naraeService service;
	
	//메인 화면창에서 검색을 했을 때 해당 값을 뿌린다. 브랜드이름, 메뉴, 주소와 검색어 내용과 일치하는 부분이 있으면 리스트에 포함된다.
	//필터의 디폴트값이 거리순이기 때문에 일단 거리순으로 리스트가 출력된다.
	//최초 정렬시킬 때 오픈인지 아닌지  'Y' or 'N'을 list<Map<>>에 넣었기 때문에 추후에 다른 곳에서는 'Y' or 'N'만 비교하면 된다.
	@RequestMapping("/mainSearch")
//	public String mainSearch(String searchBlank, String comeWay, @RequestParam Map<String, Object> param, Model model, HttpSession session) {
	public String mainSearch(String searchBlank, String comeWay, Model model, HttpSession session) {
	
		if(searchBlank == "") {
		
			model.addAttribute("searchListLength", 0);
			model.addAttribute("myAreaComeIn", "search");
			
			return "myArea";
			
		}
		
//		double mLit = (double)session.getAttribute("lit");
//		double mLot = (double)session.getAttribute("lot");
		
		double mLit= 0.0;
		double mLot= 0.0;
		
		//만약 사용자가 허용을 누르지 않으면, 세션에 위도,경도에 대한 값이 없으니니까 디폴트 위도, 경도를 넣어준다.
		if((Double)session.getAttribute("lit") == null) {
	
			//비트캠프 위도 경도
			//사용자가 본인 위치 허용 안눌렀으면 디폴트 위도 경도를 session에 넣고 그 값을 꺼내서 사용한다
			session.setAttribute("lit", 37.494796);
			session.setAttribute("lot", 127.027583);
			
			mLit = (double)session.getAttribute("lit");
			mLot = (double)session.getAttribute("lot");
			
		}else {
		
			//사용자가 본인 위치 허용했을 때 위도, 경도 찍는 곳
			mLit = (double)session.getAttribute("lit");
			mLot = (double)session.getAttribute("lot");
		}
		
		

		//검색창에 작성한 내용을 가지고 정보를 뽑아온다.
		Map<String, Object> mainSearchList = service.selectSearchBrand(searchBlank, mLit, mLot);
		
		List<Map<String, Object>> openNormalBrand = (List<Map<String, Object>>) mainSearchList.get("openNormalBrand");
		
		List<Map<String, Object>> openRecommandBrand = (List<Map<String, Object>>) mainSearchList.get("openRecommandBrand");

		int searchListLength = (int) mainSearchList.get("searchListLength");

		model.addAttribute("brandNormalList", openNormalBrand); //검색 결과 중 노말 브랜드 리스트 이면서 오픈한 가게가 상단에 올라간 최종 리스트를 보낸다.
		model.addAttribute("normalSize", openNormalBrand.size());
		model.addAttribute("brandRecommandList", openRecommandBrand); //검색 결과 중 추천 브랜드 리스트이면서 오픈한 가게가 상단에 올라간 최종 리스트를 보낸다.
		model.addAttribute("recommandSize", openRecommandBrand.size());
		
		
		model.addAttribute("searchListLength", searchListLength); //검색결과 사이즈 보내줌
		model.addAttribute("searchBlank", searchBlank);
		
		//노출 레벨이 추천,일반인 리스트들을 미리 json형으로 바꿔서 화면에 hidden으로 숨겨놓고 재정렬할 때 사용할 것
		String normalList = new Gson().toJson(openNormalBrand);
		String recommandList = new Gson().toJson(openRecommandBrand);
		
		//hidden으로 숨겨놓을 json형태의 리스트들
		model.addAttribute("normalList", normalList);
		model.addAttribute("recommandList", recommandList);
		
		model.addAttribute("myAreaComeIn", "search");
		
		return "myArea";
		
	}
	
	
//	내주변 눌렀을 때 화면이동
	
	@RequestMapping("/myArea")
//	public String myArea(String lit, String lot, Model model) {
	public String myArea(Model model, HttpSession session) {
		
		double dLit= 0.0;
		double dLot= 0.0;
		
		//만약 사용자가 허용을 누르지 않으면, 세션에 위도,경도에 대한 값이 없으니니까 디폴트 위도, 경도를 넣어준다.
		if((Double)session.getAttribute("lit") == null) {
	
			//비트캠프 위도 경도
			//사용자가 본인 위치 허용 안눌렀으면 디폴트 위도 경도를 session에 넣고 그 값을 꺼내서 사용한다
			session.setAttribute("lit", 37.494796);
			session.setAttribute("lot", 127.027583);
			
			dLit = (double)session.getAttribute("lit");
			dLot = (double)session.getAttribute("lot");
			
		}else {
		
			//사용자가 본인 위치 허용했을 때 위도, 경도 찍는 곳
			dLit = (double)session.getAttribute("lit");
			dLot = (double)session.getAttribute("lot");
		}
		
//		double dLit = (double)session.getAttribute("lit");
//		double dLot = (double)session.getAttribute("lot");
		
		//파라미터로 받아온 위도, 경도를 통해서 데이터베이스에 저장된 모든 위도, 경도와 거리값을 비교한다.
		
		Map<String, Object> result = service.BrandAndMeDistanceValue(dLit, dLot);
		
		List<Map<String, Object>> recommandList = (List<Map<String, Object>>) result.get("recommand");
		List<Map<String, Object>> normalList = (List<Map<String, Object>>) result.get("normal");
		
		//jsp화면에서 조건문으로 사용할 것 
		model.addAttribute("myAreaComeIn", "myArea");
		
		//거리 사이값을 기준으로 2키로 이내의 가게들만 뽑았고  추천, 일반 브랜드를 나누고 그 2개의 리스트 들중 지금 오픈상태인 브랜드들을 리스트의 상단에 올려놨다.
		model.addAttribute("recommand", recommandList);
		model.addAttribute("normal", normalList);
		
		//검색결과 갯수 보내주는 거
		model.addAttribute("searchListLength", recommandList.size()+normalList.size());
		
		//노출 레벨이 추천,일반인 리스트들을 미리 json형으로 바꿔서 화면에 hidden으로 숨겨놓고 재정렬할 때 사용할 것
		String gsonNormalList = new Gson().toJson(normalList);
		String gsonRecommandList = new Gson().toJson(recommandList);
		
		model.addAttribute("gsonNormal", gsonNormalList);
		model.addAttribute("gsonRecommand", gsonRecommandList);
		
		return "myArea";
		
	}
	
	
	//지도를 클릭했을 때 지도 2km이내에 있는 브랜드들 다시 정렬시켜서 리턴시키는 함수 
	@ResponseBody
	@RequestMapping("/clickArea")
	public Map<String, Object> clickArea(Double controllLat, Double controllerLng) {
		
//		System.out.println(controllLat);
//		System.out.println(controllerLng);
		
		Map<String, Object> result = service.BrandAndMeDistanceValue(controllLat, controllerLng);
		
		List<Map<String, Object>> recommandList = (List<Map<String, Object>>) result.get("recommand");
		List<Map<String, Object>> normalList = (List<Map<String, Object>>) result.get("normal");
		
		Map<String, Object> allLists = new HashMap<String, Object>();
		
		allLists.put("recommand", recommandList);
		allLists.put("normal", normalList);
		
		return allLists;
		
	}
	
	
	//필터에서 관심순 눌렀을 때 리스트를 관심순으로 재정렬 해주는 것
	@ResponseBody
	@RequestMapping(value = "/filterFavor", method = RequestMethod.POST)
	public Map<String, Object> filterDistance (String normalList, String recommandList){
		
		Map<String, Object> resultMap = service.filterFavor(normalList, recommandList);
		return resultMap;
		
	}
	
	
	
	//필터에서  평가순 눌렀을 때 리스트를 평가순으로 정렬해서 다시 보내준다.
	@ResponseBody
	@RequestMapping(value = "/filterEvaluate", method = RequestMethod.POST)
	public Map<String, Object> filterEvaluate(String normalList, String recommandList) {
		
		Map<String, Object> resultMap = service.filterEvaluate(normalList, recommandList);
		return resultMap;

		
	}
	
	//썸네일 사진 바이트로 가져오기
	@RequestMapping("/imageDown")
	@ResponseBody
	public byte[] imageDown(@RequestParam String brandNUM){
		
		byte[] image = service.getImegeAsByteArray(brandNUM);
		
		return image;
		
	}
	
	
	
	
	
	//관심순을 눌렀을 때, 다시 리스트를 dao에 접근해서 꺼내오고, 관심순이 높은 순서로 정렬해서 보낸다.
	//다시 관심순으로 리스트를 정렬시키려고 해도 거리값을 가지고 있어야 하기 때문에 반복적인 작업이 계속 필요해서 좀 불필요하다.
//	@ResponseBody
//	@RequestMapping(value = "/favorBrand", method = RequestMethod.GET)
//	public String favorBrand(String searchBlank, String lit, String lot) {
//	public String favorBrand(String searchBlank, HttpSession session) {
//		
////		double mLit =  Double.parseDouble(lit);
////		double mLot = Double.parseDouble(lot);
//		
//		double mLit =  (double)session.getAttribute("lit");
//		double mLot = (double)session.getAttribute("lot");
//		
//		//검색어로 다시 결과값을 가져와서 관심순으로 재정렬 시킨다.
//		List<Map<String, Object>> mainSearchList = (List<Map<String, Object>>) service.selectSearchBrand(searchBlank, mLit, mLot);
//		
//		//exposureLevel이 RECOMMAND 또는 PACKAGE이면  brandExposureList에 값이 저장된다.
//		List<Map<String, Object>> brandRecommandList = new LinkedList<Map<String,Object>>();
//		
//		//brandExposureList에 담을 맵
//		Map<String, Object> brandRecommandMap = new HashMap<String, Object>();
//		
//		//exposureLevel이 NORMAL이면  brandExposureList에 값이 저장된다.
//		List<Map<String, Object>> brandNormalList = new LinkedList<Map<String, Object>>();
//		
//		//brandExposureList에 담을 맵
//		Map<String, Object> brandNormalMap = new HashMap<String, Object>();
//		
//		
//		
//		//검색어에 맞는 결과값을 추천과 일반으로 나눠서 두개의 리스트로 만든다.
//		for(int i = 0; i < mainSearchList.size(); i++) {
//			
//			//
//			String brandExposure = (String) mainSearchList.get(i).get("EXPOSURELEVEL");
//			
//			//service에서 꺼내온 List들 추천레벨이  RECOMMAND, PACKAGE이면 추천 리스트에 담고
//			if(brandExposure.equals("RECOMMAND") || brandExposure.equals("PACKAGE")) {
//				
//				brandRecommandMap = mainSearchList.get(i);
//				
////				System.out.println("추천인 맵 잘 찍히나"+mainSearchList.get(i));
//				
//				brandRecommandList.add(brandRecommandMap);
//				
//			} else{
//				
//				//추천 레벨이 NORMAL이면 노말리스트에 담는다.
//				brandNormalMap = mainSearchList.get(i);
//				
//				brandNormalList.add(brandNormalMap);
//				
//			}
//		}
//		
//		//추천브랜드 거리순으로 정렬하기
////		System.out.println("추천브랜드리스트 정렬전 : "+brandRecommandList);
//		
//		
//		for(int i = 0; i< brandRecommandList.size(); i++ ) {
//
//			//검색어를 통해 뽑아온 브랜드들의 각각의 위도와 경도를 뽑아서 parseDouble한다.
//			double targetBrandLat = Double.parseDouble((String) brandRecommandList.get(i).get("BRANDLATITUDE"));
//			double targetBrandLon = Double.parseDouble((String) brandRecommandList.get(i).get("BRANDLONGITUDE"));
//			
//			//내 위치의 위도,경도와 브랜드의 위도경도를 통해 사이값을 km단위로 뽑아온다.
//			double dist = calDistance(mLit, mLot, targetBrandLat, targetBrandLon);
//		
//			//List에 담긴 Map에 각각의 거리값을  put해준다.
//			brandRecommandList.get(i).put("gapM", dist);
//					
//		}
//		
//		//List<MAP<>> 거리순으로 재정렬시킴
//		Collections.sort(brandRecommandList, new Comparator<Map<String, Object>>(){
//
//			@Override
//			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
//				
//				double firstValue = (double) first.get("gapM");
//				double secondValue = (double) seconde.get("gapM");
//	            
//	            // 내림차순 정렬
//	            if (firstValue > secondValue) {
//	                return 1;
//	            } else if (firstValue < secondValue) {
//	                return -1;
//	            } else /* if (firstValue == secondValue) */ {
//	                return 0;
//	            }
//			}
//		});
//		
////		System.out.println("추천브랜드리스트  정렬 후: "+brandRecommandList);
//		
//		
//		
//		//NORMAL 브랜드 거리순으로 정렬하기
//		
////		System.out.println("NORMAL브랜드리스트 정렬전 : "+brandNormalList);
//		
//		for(int i = 0; i< brandNormalList.size(); i++ ) {
//
//			//검색어를 통해 뽑아온 브랜드들의 각각의 위도와 경도를 뽑아서 parseDouble한다.
//			double targetBrandLat = Double.parseDouble((String) brandNormalList.get(i).get("BRANDLATITUDE"));
//			double targetBrandLon = Double.parseDouble((String) brandNormalList.get(i).get("BRANDLONGITUDE"));
//			
//			//내 위치의 위도,경도와 브랜드의 위도경도를 통해 사이값을 km단위로 뽑아온다.
//			double dist = calDistance(mLit, mLot, targetBrandLat, targetBrandLon);
//		
//			//List에 담긴 Map에 각각의 거리값을  put해준다.
//			brandNormalList.get(i).put("gapM", dist);
//					
//		}
//		
//		//List<MAP<>> 거리순으로 재정렬시킴
//		Collections.sort(brandNormalList, new Comparator<Map<String, Object>>(){
//
//			@Override
//			public int compare(Map<String, Object> first, Map<String, Object> seconde) {
//				
//				double firstValue = (double) first.get("gapM");
//				double secondValue = (double) seconde.get("gapM");
//	            
//	            // 내림차순 정렬
//	            if (firstValue > secondValue) {
//	                return 1;
//	            } else if (firstValue < secondValue) {
//	                return -1;
//	            } else /* if (firstValue == secondValue) */ {
//	                return 0;
//	            }
//			}
//		});
//		
//		//애초에 추천, 일반을 나누고 나서 거리까지 모두 삽입시킨 맵을 가지고 다시 재정렬 시키는 것
//		return null;
//		
//		
//	}
	
	
	
	
	
	

//	//거리값 계산해 주는 함수들                          내 위도경도                                                 목적지 위도경도
//	public double calDistance(double lat1, double lon1, double lat2, double lon2){  
//	    
//	    double theta, dist;  
//	    theta = lon1 - lon2;  
//	    dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1))   
//	          * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));  
//	    dist = Math.acos(dist);  
//	    dist = rad2deg(dist);  
//	      
//	    dist = dist * 60 * 1.1515;   
//	    dist = dist * 1.609344;    // 단위 mile 에서 km 변환.  
////	    dist = dist * 1000.0;      // 단위  km 에서 m 로 변환  
//	    
//	    return (Math.round(dist*100)/100.0);  //반환값은 km단위로 나온다.
//	}  
//	
//	// 주어진 도(degree) 값을 라디언으로 변환  
//	private double deg2rad(double deg){  
//	    return (double)(deg * Math.PI / (double)180d);  
//	}  
//	  
//	// 주어진 라디언(radian) 값을 도(degree) 값으로 변환  
//	private double rad2deg(double rad){  
//	    return (double)(rad * (double)180d / Math.PI);  
//	} 
	
	
}
