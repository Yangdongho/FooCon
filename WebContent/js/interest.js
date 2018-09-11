
$(function() {
	
	//지도에 올릴 내 위치 위도 경도
//	var interLit = $("#interestLit").val();
//	var interLot = $("#interestLot").val();
	
//	var interLit = sessionStorage.getItem('mainlit');
//	var interLot = sessionStorage.getItem('mainlot');
	
	var interLit = nowLit;
	var interLot = nowLot;

	//내 위치 찍는 지도를 생성한다.
	var container = document.getElementById('interestmap'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new daum.maps.LatLng(interLit, interLot), //지도의 중심좌표.
		level: 5 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	
	// 지도에 마커 달기
	var marker = new daum.maps.Marker({
		// 지도 중심좌표에 마커를 생성합니다 
		position : map.getCenter()
	});
	
	// 내 위치를 지도에 마커로 표시합니다
	marker.setMap(map);

//------------------------------------------------------------------------------------------------------------------
	
	//브랜드 위치 지도에 찍기
	//jsp에 hidden으로 숨겨논 리스트들을 선택해서 가져옴
	//controller에서 gson으로 json형태로 만든 리스트맵이다.
	
	var gsonInterest = $("#gsonInterest").val();
	
	//가지고 온 리스트맵을 json형태로 감싼다.
	var beforeInterestJson = '{"InterestMap":'+gsonInterest+'}';
	
	//json형태의 객체를 JSON형태로 parse시킨다.
	var interestJson = JSON.parse(beforeInterestJson);
	
	for (var i = 0; i < interestJson.InterestMap.length; i ++) {

	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new daum.maps.Size(24, 35); 
	    var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

	    // 마커 이미지를 생성합니다    
	    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var interestMarkers = new daum.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: new daum.maps.LatLng(interestJson.InterestMap[i].BRANDLATITUDE, interestJson.InterestMap[i].BRANDLONGITUDE), // 마커를 표시할 위치
	        title : interestJson.InterestMap[i].BRANDNUM, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage, // 마커 이미지 
	        clickable: true
	    });
	    
	    //지도에 마커 표시시킴
	    interestMarkers.setMap(map);


	    //클로저 함수
	    //맨 처음 검색을 통해서 해당 리스트를 뿌리는 리스트들을 클로저함수 사용하려면 따로 클로저함수 만들어줘야함
	    daum.maps.event.addListener(interestMarkers, 'click', InterestAddListener(interestJson.InterestMap.length, map, interestMarkers));
//	    daum.maps.event.addListener(normalMarkers, 'click', firstNormalAddListener(jsonObjRecommand.defaultRecommandMap.length,  jsonObjNormal.defaultNormalMap.length, map, normalMarkers));
	    
	}

});

//최초의 추천 리스트 클로저 함수
function InterestAddListener(inerestLength, map, marker, infowindow) {
	    return function() {
	    	
	    	//내가 맵에서 누른 마크의 키값 잘 가져옴
	    	var key = marker.getTitle();
	    	
									//거리순으로 뿌려진 각각의 값들이 저장된 배열임
			    for (var i = 0; i < inerestLength; i ++) {

			    //각각의 배열에 담아있는 긴 문자열을 잘라서 내가 원하는 값만 비교할 수 있게 한다.
			    var choice = $(".brandNUM"+i).text();
			    
		    	//핀에서 얻어온 키값이랑 리스트에 뿌려진 브랜드넘버랑 비교해서 같으면 그거를 스크롤탑!
		    	if(key == choice){
		    		
		    		var brandNUM = ".brandNUM"+i;
		    		
//		    		$(brandNUM).closest("li").css("background-color", "green");
		    		
		    		$(".maker-rap").each(function() {		    			
		    			$(this).hide();		    			
		    		});
		    		
		    		$(brandNUM).parent().parent().prev().show();

		    //************************************************************************
		    		
		    		var win = $(window),
		    		liScroll = $(brandNUM).closest("li"),
		    		liScrollOffset = liScroll.outerHeight();
		    		
		    		//*? (물음표에는 위에 몇개의 li가 있는지만 넣어주면 된다.)
		    		window.scrollTo(0,(liScrollOffset*(i))+108);
		    		
		    		break;

		    //***********************************************************************
		    	}else{
		    		//조건이 틀리면 그냥 continue
		    		continue;
		    	}
		    }
	    };
	}

//브랜드 이름 누르면 링크이동
function brandview(context, brandNUM){	
	//메인화면에서 브랜드네임을 누르면 링크이동하게 하는거
	location.href= context+"/brand/brandView?brandNUM="+brandNUM;	
}