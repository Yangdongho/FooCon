var brandAllMarkerArr = new Array();

var nadd = -1;
var radd = -1;

var context = "'/FoodTruck'";

$(function(){
	
//	var lit = sessionStorage.getItem('mainlit');
//	var lot = sessionStorage.getItem('mainlot');
	var lit = nowLit;
	var lot = nowLot;

	//지도 설정
	//내위치만 찍어줌
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new daum.maps.LatLng(lit, lot),//내 위치 위도, 경도를 파라메터로 넣어준다.
		level : 5 // 지도의 확대 레벨
	};
	

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	map = new daum.maps.Map(mapContainer, mapOption);

	// 지도에 마커 달기
	var marker = new daum.maps.Marker({
		// 지도 중심좌표에 마커를 생성합니다 
		position : map.getCenter()
	});
	
	// 내 위치를 지도에 마커로 표시합니다
	marker.setMap(map);
	
	//브랜드들 json 객체로 바꿔준다.
	var gsonNormalList = $("#gsonNormal").val();
	var gsonRecommandList = $("#gsonRecommand").val();
	
	//가지고 온 리스트맵을 json형태로 감싼다.
	var beforeNormalJson = '{"defaultNormalMap":' + gsonNormalList +'}';
	var beforeRecommandJson = '{"defaultRecommandMap":' + gsonRecommandList +'}';
	
	
	//json형태의 객체를 JSON형태로 parse시킨다.
	var jsonObjNormal = JSON.parse(beforeNormalJson);
	var jsonObjRecommand = JSON.parse(beforeRecommandJson);
	
	
	if(jsonObjRecommand.defaultRecommandMap.length > 0){		
		
		$(".titleRecommand").show();
		
		$(".imageGood").show();		
		
		$(".imageGood").attr('src', '/FoodTruck/img/pickpick.gif').css('width',"30px").css('margin-top', '10px');
		
		$(".titleRecommand").text("추천 푸드트럭");
		
		
	}else {
		
		$(".titleRecommand").hide();
		
		$(".imageGood").removeAttr('src');
		
	}
	
	if(jsonObjNormal.defaultNormalMap.length > 0){		
		
		$(".titleNormal").show();
		$(".titleNormal").text("일반 푸드트럭");
		
	}else{
		
		$(".titleNormal").hide();
	}
	
	//추천브랜드
	for(var recommand = 0; recommand < jsonObjRecommand.defaultRecommandMap.length; recommand++){
				
		//지도에 마크 찍고 마커 정보 반환한다.
		var markers = mapRecommandMarkerSpread(jsonObjRecommand.defaultRecommandMap[recommand]);
		
		//반환한 바커 정보를 통해 클로저 함수를 만든다.
		daum.maps.event.addListener(markers, 'click', firstRecommandAddListener(jsonObjRecommand.defaultRecommandMap.length, map, markers));
		
	}
	
	
	//일반브랜드
	for(var normal = 0; normal< jsonObjNormal.defaultNormalMap.length; normal++){

		
		//지도에 마크 찍고 마커 정보 반환한다.
		var markers = mapRecommandMarkerSpread(jsonObjNormal.defaultNormalMap[normal]);
		
		//반환한 바커 정보를 통해 클로저 함수를 만든다.
		daum.maps.event.addListener(markers, 'click', firstNormalAddListener(jsonObjRecommand.defaultRecommandMap.length, jsonObjNormal.defaultNormalMap.length, map, markers));
		
	}
	
	
	//지도에 클릭 이벤트를 준다.
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {  

	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    var lat = latlng.getLat(); //위도
	    var lng = latlng.getLng(); //경도
	    
		$.ajax({
			
			url : '../search/clickArea',
			type : 'POST',
			data : {controllLat:lat,
					controllerLng:lng},
			dataType : 'JSON',
			success : function(result) {
				
				//근처에 가까운 브랜드가 없을떄
				if(result.recommand.length == 0 && result.normal.length == 0){
					
					$(".top").remove();
					$(".down").remove();
					
//					alert("브랜드가 없습니다.");
		
				}
				
				//검색 결과 수를 업데이트 해준다.
				$(".gun").text(result.recommand.length+result.normal.length);
				
				if(result.recommand.length > 0){
					$(".titleRecommand").show();
					$(".titleRecommand").text("추천 푸드트럭");
					
					$(".imageGood").show();							
					$(".imageGood").attr('src', '/FoodTruck/img/pickpick.gif').css('width',"30px").css('margin-top', '10px');
					
				}else{
					
					$(".titleRecommand").hide();
					$(".titleRecommand").hide();					
					$(".imageGood").removeAttr('src');
				}
				
				if(result.normal.length > 0){
					$(".titleNormal").show(); 
					$(".titleNormal").text("일반 푸드트럭");
				}else{
					$(".titleNormal").hide();
				}
				
				
				hideMarkers();

//				기존의  추천 리스트를 지운다.
				$(".top").remove();

				$(result.recommand).each(function(index, recommand) {
					
					var BRANDRESERVATIONSTATUS = recommand.BRANDRESERVATIONSTATUS;
					var AVGSTARGRADE = recommand.AVGSTARGRADE;
					var BRANDNAME = recommand.BRANDNAME;
					var gapM = recommand.gapM;
					var BRANDLATITUDE = recommand.BRANDLATITUDE;
					var BRANDADDRESS = recommand.BRANDADDRESS;
					var REVIEWCOUNT = recommand.REVIEWCOUNT;
					var BRANDOPENTIME = recommand.BRANDOPENTIME;
					var BRANDLONGITUDE = recommand.BRANDLONGITUDE;
					var THUMNAIL = recommand.THUMNAIL;
					var FAVORTOTALCNT = recommand.FAVORTOTALCNT;
					var BRANDDELIVERYSTATUS = recommand.BRANDDELIVERYSTATUS;
					var EXPOSURELEVEL = recommand.EXPOSURELEVEL;
					var BRANDINTRODUCE = recommand.BRANDINTRODUCE;
					var BRANDNUM = recommand.BRANDNUM;
					
					//영업중인지 아닌지 비교하기
					
					var open = "";
	                if(BRANDOPENTIME == 'Y'){
	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
	                }
	                else{
	                	open = "<i class='open' style='display: none;'>영업중</i>";
	                }
					
					
					//예약가능여부
					var reservation = "";
	                if(BRANDRESERVATIONSTATUS == 'Y'){
	                	reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능&nbsp;</i>";
	                }
	                else{
	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
	                }
	                
	                //배달가능여부
	                var delivery = "";	                
	                if(BRANDDELIVERYSTATUS == 'Y'){	                	
	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
	                }else{
	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
	                }
	                
	                //별 갯수 찍기  
	                var star = "";
	                for(var i = 1; i <=AVGSTARGRADE; i++){
	                	star = star + '<span class= "5-star stars">★</span>';
	                }
	                
	                for(var j = AVGSTARGRADE+1; j<=5; j++){	                	
	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
	                }
	                
	                
	                //지도에 마크 찍고, 배열에도 push
	                var recommandMarker = mapRecommandMarkerSpread(recommand);
	                
	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(result.recommand.length, map, recommandMarker));
	                
	                var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class ="recommandNUM'+index+'" id = "recommandNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
					
	                $(".listTop").append(recommandbrand);
	                
				});
				
				
				//기존  normal 리스트 지우기
				$(".down").remove();
				
				//기본리스트 화면에 뿌린다.
				$(result.normal).each(function(index, normal) {
					
					var BRANDRESERVATIONSTATUS = normal.BRANDRESERVATIONSTATUS;
					var AVGSTARGRADE = normal.AVGSTARGRADE;
					var BRANDNAME = normal.BRANDNAME;
					var gapM = normal.gapM;
					var BRANDLATITUDE = normal.BRANDLATITUDE;
					var BRANDADDRESS = normal.BRANDADDRESS;
					var REVIEWCOUNT = normal.REVIEWCOUNT;
					var BRANDOPENTIME = normal.BRANDOPENTIME;
					var BRANDLONGITUDE = normal.BRANDLONGITUDE;
					var THUMNAIL = normal.THUMNAIL;
					var FAVORTOTALCNT = normal.FAVORTOTALCNT;
					var BRANDDELIVERYSTATUS = normal.BRANDDELIVERYSTATUS;
					var EXPOSURELEVEL = normal.EXPOSURELEVEL;
					var BRANDINTRODUCE = normal.BRANDINTRODUCE;
					var BRANDNUM = normal.BRANDNUM;
									
					//영업중인지 아닌지 비교하기
					
					var open = "";
	                if(BRANDOPENTIME == 'Y'){
	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
	                }
	                else{
	                	open = "<i class='open' style='display: none;'>영업중</i>";
	                }
					
					//예약가능여부
					
	                if(BRANDRESERVATIONSTATUS == 'Y'){
	                	reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능&nbsp;</i>";
	                }
	                else{
	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
	                }
	                
	                //배달가능여부
	                var delivery = "";
	                
	                if(BRANDDELIVERYSTATUS == 'Y'){
	                	
	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
	                }else{
	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
	                }
	                
	                //별 갯수 찍기  
	                var star = "";	
	                for(var i = 1; i <=AVGSTARGRADE; i++){
	                	star = star + '<span class="5-star stars">★</span>';	                	
	                }
	                
	                for(var j = AVGSTARGRADE+1; j<=5; j++){	                	
	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
	                }
	                
	                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
	                var normalMarker = mapRecommandMarkerSpread(normal);
	                
	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(result.recommand.length, result.normal.length, map, normalMarker));
	                
	                var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+index+'" id ="normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
					
	                $(".listdown").append(normalbrand);
	                
				});
				
			},
			error:function(request,status,error){
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} 			
		});
	});	
	
});




//최초리스트 일반브랜드 클로저 함수                  //노말브랜드선택자를 스크롤에 더해줄 추천브랜드 갯수
function firstNormalAddListener(recommandListLength, normalListLength, map, marker, infowindow) {
	    return function() {
	    	
	    	//내가 맵에서 누른 마크의 키값 잘 가져옴
	    	var key = marker.getTitle();
									//거리순으로 뿌려진 일반브랜드 길이 (함수 파라미터로 받아온다.)
			    for (var i = 0; i < normalListLength; i ++) {
			    
			    //반복문을 돌면서 각각의 클래스이름을 통해서 값을 비교한다.
			    var choice = $(".normalNUM"+i).text();
			    
		    	//핀에서 얻어온 키값이랑 리스트에 뿌려진 브랜드넘버랑 비교해서 같으면 그거를 스크롤탑!
		    	if(key == choice){
		    		
		    		var normalNUM = ".normalNUM"+i;

//		    		$(normalNUM).closest("li").css("background-color", "red");
		    		
		    		$(".maker-rap").each(function() {
		    			
		    			$(this).hide();
		    			
		    		});
		    		
		    		$(normalNUM).parent().parent().prev().show();

		    //************************************************************************
		    		
		    		var win = $(window),
		    		liScroll = $(normalNUM).closest("li"),
		    		liScrollOffset = liScroll.outerHeight();
		    		
//		    		window.scrollTo(0,(liScrollOffset*(i))+108);
		    		
		    		//*? (물음표에는 위에 몇개의 li가 있는지만 넣어주면 된다.)
		    		window.scrollTo(0,(liScrollOffset*(recommandListLength+i))+108);
		    		
		    		break;
		    //***********************************************************************
		    	}else{
		    		//조건이 틀리면 그냥 continue
		    		continue;
		    	}
		    }
	    };
	}

//최초의 추천 리스트 클로저 함수
function firstRecommandAddListener(recommandListLength, map, marker, infowindow) {
	    return function() {
	    	
	    	//내가 맵에서 누른 마크의 키값 잘 가져옴
	    	var key = marker.getTitle();
	    	
									//거리순으로 뿌려진 각각의 값들이 저장된 배열임
			    for (var i = 0; i < recommandListLength; i ++) {

			    //각각의 배열에 담아있는 긴 문자열을 잘라서 내가 원하는 값만 비교할 수 있게 한다.
			    var choice = $(".recommandNUM"+i).text();
			    
		    	//핀에서 얻어온 키값이랑 리스트에 뿌려진 브랜드넘버랑 비교해서 같으면 그거를 스크롤탑!
		    	if(key == choice){
		    		
		    		var recommandNUM = ".recommandNUM"+i;

//		    		$(recommandNUM).closest("li").css("background-color", "green");
		    		
		    		$(".maker-rap").each(function() {
		    			
		    			$(this).hide();
		    			
		    		});
		    		
		    		$(recommandNUM).parent().parent().prev().show();

		    //************************************************************************
		    		
		    		var win = $(window),
		    		liScroll = $(recommandNUM).closest("li"),
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

//일반 브랜드 핀 찍는거 함수로 뻄
function mapNormalMarkerSpread(loofParameter){

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new daum.maps.Size(24, 35); 
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		    	    	    		    
		// 마커 이미지를 생성합니다    
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 

		// 마커를 생성합니다
		var Markers = new daum.maps.Marker ({
		map: map, // 마커를 표시할 지도
		position: new daum.maps.LatLng(loofParameter.BRANDLATITUDE, loofParameter.BRANDLONGITUDE), // 마커를 표시할 위치
		title : loofParameter.BRANDNUM, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		image : markerImage, // 마커 이미지 
		clickable: true });

		//지도에 마커 표시시킴
		Markers.setMap(map);

		//전역변수로 선언된 배열에 값을 넣어준다.
		brandAllMarkerArr.push(Markers);

		//마커정보를 리턴
		return Markers;

}

//추천브랜드 핀 찍는거 함수로 뻄
function mapRecommandMarkerSpread(loofParameter){
	
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new daum.maps.Size(24, 35); 
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		    	    	    		    
		// 마커 이미지를 생성합니다    
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 

		// 마커를 생성합니다
		var Markers = new daum.maps.Marker ({
		map: map, // 마커를 표시할 지도
		position: new daum.maps.LatLng(loofParameter.BRANDLATITUDE, loofParameter.BRANDLONGITUDE), // 마커를 표시할 위치
		title : loofParameter.BRANDNUM, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		image : markerImage, // 마커 이미지 
		clickable: true 
		});

		//지도에 마커 표시시킴
		Markers.setMap(map);

		//전역변수로 선언된 배열에 값을 넣어준다.
		brandAllMarkerArr.push(Markers);
		
		//마커정보를 리턴
		return Markers;

}


//지도에 있는 핀을 지우거나 보이게 하는 함수
function setMarkers(map) {

    for (var i = 0; i < brandAllMarkerArr.length; i++) {
    	//핀 지우고
    	brandAllMarkerArr[i].setMap(map);
    }        
	//배열 초기화
    brandAllMarkerArr = new Array();	
	nadd = -1;
	radd = -1;
}

//지도에 있는 핀을 지우게 하는 함수
function hideMarkers() {
	//여기서  setMarkers 함수를 파라메터  null로 호출하면 배열에 담은 지도의 핀이 모두 삭제된다.	
    setMarkers(null);    
}

//브랜드 이름 누르면 링크이동
function brandview(context, brandNUM){	
	//메인화면에서 브랜드네임을 누르면 링크이동하게 하는거
	location.href= context+"/brand/brandView?brandNUM="+brandNUM;
}