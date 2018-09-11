//**********************************************************************
//거리순 정렬이랑 관련된 모든 변수들
//**********************************************************************
//거리순으로 정렬된 리스트
var jsonObjNormal;
var jsonObjRecommand;

//거리순으로 정렬된 배열인데 안에 append내용까지 다 들어있는 배열
var locationNormalbrandArr = new Array();
var locationRecommandbrandArr = new Array();
//**********************************************************************


//**********************************************************************
//                평점순 정렬이랑 관련된 모든 변수들
//**********************************************************************
//평점순으로 정렬된 리스트
//ajax에서 받아온 값의 결과
var starNomalList;
var starRecommandList;

//평점순으로 정렬된 배열인데 안에 append내용까지 다 들어있는 배열
var starNormalbrandArr = new Array();
var starRecommandbrandArr = new Array();
//**********************************************************************


//**********************************************************************
//                관심순 정렬이랑 관련된 모든 변수들
//**********************************************************************
//관심순으로 정렬된 리스트
var favorNomalList;
var favorRecommandList; 

//관심순으로 정렬된 배열인데 안에 append 내용까지 다 들어가 있는 배열
var favorNormalbrandArr = new Array();
var favorRecommandbrandArr = new Array();
//**********************************************************************


//어펜드로 리스트 붙이는데 <span>의 클래스 넘버를 새로 붙여주기위해
var radd = -1;
var nadd = -1;

//배달, 예약 스크롤 함수 파라매터 넘겨줄때 해당 리스트의 몇번째까지 리스트르 돌았는지 알아야해서 선언한 변수
var fillList = 0;

//배달, 예약들은 추천길이가 일정한게 아니니까 이 변수에 넣어준다.
var recommandCheckLength=0;
var normalCheckLength=0;


//핀에 찍고 배열에 넣을껀데 그거 담을 배열
//추천, 일반브랜드 모두 한개의 배열에 지도 핀 정보가 가지고 있다.
//상위 조건에서 예약 배달을 각각 눌렀을 때마다 모든 핀을 제거하고 다시 뿌려야 하기 때문에 
//모든 조건에서 하나의 배열에 담고 다른 조건을 클릭했을 때 이 배열을  hidden시킨다.
var brandAllMarkerArr = new Array();


//맵 전역에 선언선언
var map;

//브랜드들 핀 찍을 이미지 전역변수로 선언
//마커 이미지의 이미지 주소입니다 (별모양)
var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";


//지도에 있는 핀을 지우거나 보이게 하는 함수
function setMarkers(map) {

    for (var i = 0; i < brandAllMarkerArr.length; i++) {
    	//핀 지우고
    	brandAllMarkerArr[i].setMap(map);
    }        
    
	//배열 초기화
    brandAllMarkerArr = new Array();	
    
    //<span>고유 클래스 이름 줄거고 버튼 누를 때 마다 초기화해서 새로운 번호를 계속 줘야 한다.
	nadd = -1;
	radd = -1;
	
	//
	current = -1;
	
	//맨 처음 5개 default값을 사용할 때, 추천길이가 5개 이하면 일반브랜드로 5개를 채워야하는데 그 때 사용된 마지막 index값을 저장해놓는 함수
	fillList = 0;
	
	//예약, 배달은 추천길이가 일정한게 아니니까 이 변수에 추천길이 저장해놓고 사용한것
	recommandCheckLength = 0;
	normalCheckLength = 0;
	
	//아래는 무슨변수였지?
//	checkingNUM = 0;
}

//지도에 있는 핀을 지우게 하는 함수
function hideMarkers() {
	//여기서  setMarkers 함수를 파라메터  null로 호출하면 배열에 담은 지도의 핀이 모두 삭제된다.	
    setMarkers(null);    
}

var context = "'/FoodTruck'";

//체크속성 전부다 reset 시켜준다.
//checkBox 전부 unchecked, 필터도  default인 거리순으로 한다.
function resetLink() {
	
	$("input[type=checkbox]").each(function() {
		this.checked = false;
	});
	
	$(".dropDown-Span").text("거리순");
	
	//다시 거리순으로 리스트를 뿌려줘야한다.
	$('#location').trigger('click');
	
}


//===거리, 관심, 평가 리스트 클로저 함수=============================================================================================

//최초리스트 일반브랜드 클로저 함수                  //노말브랜드선택자를 스크롤에 더해줄 추천브랜드 갯수
function firstNormalAddListener(recommandListLength, normalListLength, map, marker, infowindow) {
	    return function() {
	    	//파라미터중 추천길이, 일반길이는 들고오오
	    	
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

		    		//$(recommandNUM).find(".maker-rap").show();
		    		
		    		
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

		    //***********************************************************************
		    	}else{
		    		//조건이 틀리면 그냥 continue
		    		continue;
		    	}
		    }
	    };
	}


//===최초리스트 클로저 함수 ==================== -끝- =====================================================================



//-------------------------------------------------------------------------------------------------

//html 다 로딩 끝나고 아래 시작!
$(function() {
	
//  내 위치를 알려줄 함수 호출
//	getLocation();
	
//	$("#lit").on('change', function() {
		
		//내 아이피를 기반으로 위도, 경도 가져옴
//		var lat = $("#lit").val();
//		var lng = $("#lot").val();
		
//		var lat = sessionStorage.getItem('mainlit');
//		var lng = sessionStorage.getItem('mainlot');
	
		var lat = nowLit;
		var lng = nowLot;
		
		
//-----------------------------------------------------------------		

		//jsp에 hedden으로 숨겨논 리스트들을 선택해서 가져옴
		//controller에서 gson으로 json형태로 만든 리스트맵이다.
		var gsonNormalList = $("#normalList").val();
		var gsonRecommandList = $("#recommandList").val();
		
		//가지고 온 리스트맵을 json형태로 감싼다.
		var beforeNormalJson = '{"defaultNormalMap":'+gsonNormalList+'}';
		var beforeRecommandJson = '{"defaultRecommandMap":'+gsonRecommandList+'}';

		
		//json형태의 객체를 JSON형태로 parse시킨다.
		jsonObjNormal = JSON.parse(beforeNormalJson);
		jsonObjRecommand = JSON.parse(beforeRecommandJson);
		
		
		
//-----------------------------------------------------------------		
		
		//지도 설정
		//내위치만 찍어줌
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(lat, lng),//내 위치 위도, 경도를 파라메터로 넣어준다.
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


//-----------------------------------------------------------------	
		
		//브랜드들 마크 지도에 달기
		//최초로 지도에 뿌리는 것
		
		

			// *****추천브랜드 핀찍는것*****

		// 핀에 찍고 배열에 넣을껀데 그거 담을 배열, pin hidden 사용할 때 쓸려고
	if(!(jsonObjRecommand.defaultRecommandMap.length  == 0)){
		for (var i = 0; i < jsonObjRecommand.defaultRecommandMap.length; i++) {
	
			// 마커 이미지의 이미지 크기 입니다
			var imageSize = new daum.maps.Size(24, 35);
	
			// 마커 이미지를 생성합니다
			var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
	
			// 마커를 생성합니다
			var recommandMarkers = new daum.maps.Marker({
				map : map, // 마커를 표시할 지도
				position : new daum.maps.LatLng(
						jsonObjRecommand.defaultRecommandMap[i].BRANDLATITUDE,
						jsonObjRecommand.defaultRecommandMap[i].BRANDLONGITUDE), // 마커를
																					// 표시할
																					// 위치
				title : jsonObjRecommand.defaultRecommandMap[i].BRANDNUM, // 마커의
																			// 타이틀,
																			// 마커에
																			// 마우스를
																			// 올리면
																			// 타이틀이
																			// 표시됩니다
				image : markerImage, // 마커 이미지
				clickable : true
			});
	
			// 지도에 마커 표시
			recommandMarkers.setMap(map);
	
			// 지도에 표시한 추천브랜드 마커들 배열에 넣음
			// 핀에 찍고 배열에 넣을껀데 그거 담을 배열, pin hidden 사용할 때 쓸려고
			brandAllMarkerArr.push(recommandMarkers);
			// 거리순으로 뿌려진 브랜드 갯수를 파라미터로 보내
			daum.maps.event.addListener(recommandMarkers, 'click',
					firstRecommandAddListener(
							jsonObjRecommand.defaultRecommandMap.length, map,
							recommandMarkers));
		}
	}

	// *****노말브랜드 핀찍는것*****

	// mapMarkerSpread(jsonObjNormal.defaultNormalMap);

	// for (var i = 0; i < jsonObjNormal.defaultNormalMap.length; i ++) {
	for (var i = 0; i <= current; i++) {

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new daum.maps.Size(24, 35);

		// 마커 이미지를 생성합니다
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

		// 마커를 생성합니다
		var normalMarkers = new daum.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : new daum.maps.LatLng(
					jsonObjNormal.defaultNormalMap[i].BRANDLATITUDE,
					jsonObjNormal.defaultNormalMap[i].BRANDLONGITUDE), // 마커를
																		// 표시할
																		// 위치
			title : jsonObjNormal.defaultNormalMap[i].BRANDNUM, // 마커의 타이틀, 마커에
																// 마우스를 올리면 타이틀이
																// 표시됩니다
			image : markerImage, // 마커 이미지
			clickable : true
		});

		// 지도에 마커 표시시킴
		normalMarkers.setMap(map);

		// 지도에 표시한 일반브랜드 마커들 배열에 넣음
		// 핀에 찍고 배열에 넣을껀데 그거 담을 배열, pin hidden 사용할 때 쓸려고
		brandAllMarkerArr.push(normalMarkers);

		// 클로저 함수
		// 맨 처음 검색을 통해서 해당 리스트를 뿌리는 리스트들을 클로저함수 사용하려면 따로 클로저함수 만들어줘야함
		daum.maps.event.addListener(normalMarkers, 'click',
				firstNormalAddListener(
						jsonObjRecommand.defaultRecommandMap.length,
						jsonObjNormal.defaultNormalMap.length, map,
						normalMarkers));

	}
		

		

		
// -----------------------------------------------------------------
	
	// 거리, 평점, 관심순 hover 선택하면 <span>설정값 바뀌게 하는거
	// 필터 클릭 이벤트 일어날 때 실행되는 함수들
	$("#evaluate").on('click', function() {
		
		// 일단 지도에 있는 핀 지워, 지우고 나서 배열 초기화도 같이 해준다.
		hideMarkers();

		$("input[type=checkbox]").each(function() {
			this.checked = false;
		});
		
		$('.dropDown-Span').text("평점순");
		
		//jsp에  hidden으로 숨겨논 각각의 json 형태로 바뀐 값들을 요소를 선택함으로써 값을 담는다.
		var normalList = $('#normalList').val();
		var recommandList = $('#recommandList').val();
		
		//요청으로 넘어간 곳에서 사용하기 위해 리스트의 키값을 임의로 지정해서 보낸다.
		var sendNormal = '{"nExLevel":'+normalList+'}';
		var sendRecommand = '{"rExLevel":'+recommandList+'}';
		
//		console.log(reSort);
//		console.log(typeof(reSort));
		
		$.ajax({
			
			url : '../search/filterEvaluate',
			type : 'POST',
			data : {
				normalList:sendNormal,
				recommandList:sendRecommand
			},
			dataType : 'JSON',
			success : function(result) {
				
				 //기존의  추천 리스트를 지운다.
				$(".top").remove();
				
				//전역변수에 평점순으로 정렬한 일반, 추천 리스트들을 저장한다.
				starNomalList = result.normalstarList;
				starRecommandList = result.recommandstarList;

				$(result.recommandstarList).each(function(index, recommand) {
					
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
	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
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
	                
	                for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
	                }
	                
//----------------------------------------------------------------------------------------------------------------------------------
	            
	                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
	                //이 함수에서 배열에 push까지 한다.
	                var recommandMarker = mapRecommandMarkerSpread(recommand);
	                                                                                            //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(starRecommandList.length, map, recommandMarker));
//----------------------------------------------------------------------------------------------------------------------------------
	                
//	                                                                                                                          src="imageDown?brandNUM=${searchList.BRANDNUM}"
//	                var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><img alt="foodtruck" src="<%=path%>/img/dummy.jpg"><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "recommandNUM'+index+'" id = "recommandNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';
	                var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "recommandNUM'+index+'" id = "recommandNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';
	                
	                //추후에 다른 곳에서 배열 지우기 위해서 위에서 초기화 했던 배열에 다시 값을 넣는다.
//	                brandAllMarkerArr.push(recommandMarker);
	                
//	                starRecommandbrandArr.push(recommandbrand);
					
	                $(".listTop").append(recommandbrand);
					
				});
				
				
				//여기서 만약 추천브랜드가 5개 이하면, 일반브랜드를 추가해 5개를 맞춰준다.
				//그리고 나서 나머지 브랜드들은 스크롤다운 이벤트가 주어졌을 때 실행시킨다.
				
				//기존  normal 리스트 지우기
				$(".down").remove();
				
				
				if(starRecommandList.length < 5){
					
					for(var index = 0; index < 5 - starRecommandList.length; index++){
						
						current = current+1;
						
						var BRANDRESERVATIONSTATUS = starNomalList[current].BRANDRESERVATIONSTATUS;
						var AVGSTARGRADE = starNomalList[current].AVGSTARGRADE;
						var BRANDNAME = starNomalList[current].BRANDNAME;
						var gapM = starNomalList[current].gapM;
						var BRANDLATITUDE = starNomalList[current].BRANDLATITUDE;
						var BRANDADDRESS = starNomalList[current].BRANDADDRESS;
						var REVIEWCOUNT = starNomalList[current].REVIEWCOUNT;
						var BRANDOPENTIME = starNomalList[current].BRANDOPENTIME;
						var BRANDLONGITUDE = starNomalList[current].BRANDLONGITUDE;
						var THUMNAIL = starNomalList[current].THUMNAIL;
						var FAVORTOTALCNT = starNomalList[current].FAVORTOTALCNT;
						var BRANDDELIVERYSTATUS = starNomalList[current].BRANDDELIVERYSTATUS;
						var EXPOSURELEVEL = starNomalList[current].EXPOSURELEVEL;
						var BRANDINTRODUCE = starNomalList[current].BRANDINTRODUCE;
						var BRANDNUM = starNomalList[current].BRANDNUM;
										
						//영업중인지 아닌지 비교하기
						
						var open = "";
		                if(BRANDOPENTIME == 'Y'){
		                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
		                }
		                else{
		                	open = "<i class='open' style='display: none;'>영업중</i>";
		                }
						
						//예약가능여부
						
		                if(BRANDRESERVATIONSTATUS == 'Y'){
		                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&</i>";
		                }
		                else{
		                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
		                }
		                
		               
		                
		                //배달가능여부
		                var delivery = "";
		                
		                if(BRANDDELIVERYSTATUS == 'Y'){
		                	
		                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
		                }else{
		                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
		                }
		                
		                //별 갯수 찍기  
		                var star = "";
		                for(var i = 1; i <=AVGSTARGRADE; i++){
		                	star = star + '<span class="5-star stars">★</span>';	                	
		                }
		                for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
		                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
		                }
		                
	//----------------------------------------------------------------------------------------------------------------------------------
		                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
		                var normalMarker = mapRecommandMarkerSpread(starNomalList[current]);
		                                                                                            //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
		                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(starRecommandList.length, starNomalList.length, map, normalMarker));
	//----------------------------------------------------------------------------------------------------------------------------------
		                
		                var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+current+'" id ="normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
		                
//		                starNormalbrandArr.push(normalbrand);
						
		                $(".listdown").append(normalbrand);
						
					}
				}
				


				
			},
			error:function(request,status,error){				
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} 			
		});

		return false;
		
	});
	
	
	//관심순으로 정렬
	$("#heart").on('click', function() {
		
		$("input[type=checkbox]").each(function() {
			this.checked = false;
		});
		
		$('.dropDown-Span').text("관심순");
		
		//일단 지도에 있는 핀 지워, 지우고 나서 배열 초기화도 같이 해준다.
		hideMarkers();
		
//		//jsp에  hidden으로 숨겨논 각각의 json 형태로 바뀐 값들을 요소를 선택함으로써 값을 담는다.
		var normalList = $('#normalList').val();
		var recommandList = $('#recommandList').val();
		
//---------------------------------------------------------------------------------------------------------------
		
		//요청으로 넘어간 곳에서 사용하기 위해 리스트의 키값을 임의로 지정해서 보낸다.
		var sendNormal = '{"nExLevel":'+normalList+'}';
		var sendRecommand = '{"rExLevel":'+recommandList+'}';
		
		$.ajax({
			
			url : '../search/filterFavor',
			type : 'POST',
			data : {
				normalList:sendNormal,
				recommandList:sendRecommand
			},
			dataType : 'JSON',
			success : function(result) {
				
				 //기존의  추천 리스트를 지운다.
				$(".top").remove();

				//전역변수에 관심순으로 정렬한 일반, 추천 리스트들을 저장한다.
				//후에 예약, 배달때 쓸려고 저장한 거임
				favorNomalList = result.normalstarList;
				favorRecommandList = result.recommandstarList;

				$(result.recommandstarList).each(function(index, recommand) {
					
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
	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
	                }
	                else{
	                	open = "<i class='open' style='display: none;'>영업중</i>";
	                }
					
					//예약가능여부
					var reservation = "";
	                if(BRANDRESERVATIONSTATUS == 'Y'){
	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
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
	                
	                for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
	                }
	                
	                
	                //지도에 마크 찍고, 배열에도 push
	                var recommandMarker = mapRecommandMarkerSpread(recommand);
	                
	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(favorRecommandList.length, map, recommandMarker));
	                
	                var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class ="recommandNUM'+index+'" id = "recommandNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
					
	                favorRecommandbrandArr.push(recommandbrand);
					
	                $(".listTop").append(recommandbrand);
	                
				});
				
				
				//기존  normal 리스트 지우기
				$(".down").remove();
				
				
				if(favorRecommandList.length < 5){
					
					for(var index = 0; index < 5 - favorRecommandList.length; index++){
						
						current = current+1;
						
						var BRANDRESERVATIONSTATUS = favorNomalList[current].BRANDRESERVATIONSTATUS;
						var AVGSTARGRADE = favorNomalList[current].AVGSTARGRADE;
						var BRANDNAME = favorNomalList[current].BRANDNAME;
						var gapM = favorNomalList[current].gapM;
						var BRANDLATITUDE = favorNomalList[current].BRANDLATITUDE;
						var BRANDADDRESS = favorNomalList[current].BRANDADDRESS;
						var REVIEWCOUNT = favorNomalList[current].REVIEWCOUNT;
						var BRANDOPENTIME = favorNomalList[current].BRANDOPENTIME;
						var BRANDLONGITUDE = favorNomalList[current].BRANDLONGITUDE;
						var THUMNAIL = favorNomalList[current].THUMNAIL;
						var FAVORTOTALCNT = favorNomalList[current].FAVORTOTALCNT;
						var BRANDDELIVERYSTATUS = favorNomalList[current].BRANDDELIVERYSTATUS;
						var EXPOSURELEVEL = favorNomalList[current].EXPOSURELEVEL;
						var BRANDINTRODUCE = favorNomalList[current].BRANDINTRODUCE;
						var BRANDNUM = favorNomalList[current].BRANDNUM;
										
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
		                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
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
		                for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
		                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
		                }
		                
	//----------------------------------------------------------------------------------------------------------------------------------
		                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수, 배열에 add까지 한다.
		                var normalMarker = mapRecommandMarkerSpread(starNomalList[current]);
		                                                                                            //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
		                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(favorRecommandList.length, favorNomalList.length, map, normalMarker));
	//----------------------------------------------------------------------------------------------------------------------------------
		                
		                var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+current+'" id ="normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
		                
//		                starNormalbrandArr.push(normalbrand);
						
		                $(".listdown").append(normalbrand);
						
					}
				}
				
			},
			error:function(request,status,error){
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			} 
			
		});
		
		return false;
	});
		
//---------------------------------------------------------------------------------------------------------------
	
	
	//recommand, normal 리스트 모두 brandNUM을 가지고 있는 <span>에 고유의 클래스이름을 줬다.
	//이 <span>의 아이디는 핀이 선택될 때 요소를 찾는데 사용된다.
	$("#location").on('click', function() {
		
		hideMarkers();
		
		$("input[type=checkbox]").each(function() {
			this.checked = false;
		});
		
		$('.dropDown-Span').text("거리순");
		
		
		//jsp에  hidden으로 숨겨논 각각의 json 형태로 바뀐 값들을 요소를 선택함으로써 값을 담는다.
		var gsonNormalList = $('#normalList').val();
		var gsonRecommand = $('#recommandList').val();
		
		var beforeNormalJson = '{"defaultNormalMap":'+gsonNormalList+'}';
		var beforeRecommandJson = '{"defaultRecommandMap":'+gsonRecommand+'}';
		
		//거리순 중에서도 예약, 배달 정렬할 때 사용할려고 전역에 변수 선언해두고 여기서  값을 넣어준다.
		jsonObjNormal = JSON.parse(beforeNormalJson);
		jsonObjRecommand = JSON.parse(beforeRecommandJson);
		
		 //기존의  추천 리스트를 지운다.
		$(".top").remove();
		
		$(jsonObjRecommand.defaultRecommandMap).each(function(index, recommand) {
			
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
			
			//오픈여부
			var open = "";
            if(BRANDOPENTIME == 'Y'){
            	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
            }
            else{
            	open = "<i class='open' style='display: none;'>영업중</i>";
            }
			
			
			//예약가능여부	
            var reservation = "";
            if(BRANDRESERVATIONSTATUS == 'Y'){
            	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
            }
            else{
            	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
            }
            
            //배달가능여부
            var delivery = "";            
            if(BRANDDELIVERYSTATUS == 'Y'){
            	
            	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
            }else{
            	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
            }
			
			 //별 갯수 찍기  
            var star = "";
            for(var i = 1; i <=AVGSTARGRADE; i++){
            	star = star + '<span class="5-star stars">★</span>';            	
            }
            for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
            	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
            }
            
            
            var recommandMarker = mapRecommandMarkerSpread(recommand);    	    	                  	    	                    	    	                  	        				
            daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(jsonObjRecommand.defaultRecommandMap.length, map, recommandMarker));
			
			var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "recommandNUM'+index+'" id = "recommandNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';
			
			//전역변수에 선언된 배열에 값을 넣는다. 
			//추후에 지도에 있는 핀을 선택시 해당 핀의 brandNUM이랑 내가 가지고 있는 리스트들의 brandNUM을 비교해야해서
//			locationRecommandbrandArr.push(recommandbrand);
			
			$(".listTop").append(recommandbrand);
			
		});
		
		//기존  normal 리스트 지우기
		$(".down").remove();

		if(jsonObjRecommand.defaultRecommandMap.length < 5){
			
			for(var index = 0; index < 5 - jsonObjRecommand.defaultRecommandMap.length; index++){
				
				current = current+1;
				                             
				var BRANDRESERVATIONSTATUS = jsonObjNormal.defaultNormalMap[current].BRANDRESERVATIONSTATUS;
				var AVGSTARGRADE = jsonObjNormal.defaultNormalMap[current].AVGSTARGRADE;
				var BRANDNAME = jsonObjNormal.defaultNormalMap[current].BRANDNAME;
				var gapM = jsonObjNormal.defaultNormalMap[current].gapM;
				var BRANDLATITUDE = jsonObjNormal.defaultNormalMap[current].BRANDLATITUDE;
				var BRANDADDRESS = jsonObjNormal.defaultNormalMap[current].BRANDADDRESS;
				var REVIEWCOUNT = jsonObjNormal.defaultNormalMap[current].REVIEWCOUNT;
				var BRANDOPENTIME = jsonObjNormal.defaultNormalMap[current].BRANDOPENTIME;
				var BRANDLONGITUDE = jsonObjNormal.defaultNormalMap[current].BRANDLONGITUDE;
				var THUMNAIL = jsonObjNormal.defaultNormalMap[current].THUMNAIL;
				var FAVORTOTALCNT = jsonObjNormal.defaultNormalMap[current].FAVORTOTALCNT;
				var BRANDDELIVERYSTATUS = jsonObjNormal.defaultNormalMap[current].BRANDDELIVERYSTATUS;
				var EXPOSURELEVEL = jsonObjNormal.defaultNormalMap[current].EXPOSURELEVEL;
				var BRANDINTRODUCE = jsonObjNormal.defaultNormalMap[current].BRANDINTRODUCE;
				var BRANDNUM = jsonObjNormal.defaultNormalMap[current].BRANDNUM;
								
				//영업중인지 아닌지 비교하기
				
				var open = "";
                if(BRANDOPENTIME == 'Y'){
                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
                }
                else{
                	open = "<i class='open' style='display: none;'>영업중</i>";
                }
				
				//예약가능여부	
                var reservation="";
                if(BRANDRESERVATIONSTATUS == 'Y'){
                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
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
                for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
                }
                
//----------------------------------------------------------------------------------------------------------------------------------
                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수, 배열에 add까지 한다.
                var normalMarker = mapRecommandMarkerSpread(jsonObjNormal.defaultNormalMap[current]);
                                                                                            //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(jsonObjRecommand.defaultRecommandMap.length, jsonObjNormal.defaultNormalMap.length, map, normalMarker));
//----------------------------------------------------------------------------------------------------------------------------------
                
                var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+current+'" id ="normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
                
//                starNormalbrandArr.push(normalbrand);
				
                $(".listdown").append(normalbrand);
				
			}
		}

    //클릭이벤트를 감싸는 괄호
	});
	
	
	//예약체크박스  checked, unchecked 구분 이벤트 줌
	//사리사리
    $("#chk_reser").change(function(){
    	
	    	var goal = $(".dropDown-Span").text();

    		if ($("#chk_reser").is(':checked') && !($("#chk_deliver").is(':checked'))) {
   
    	        	$(".top").remove();
    	        	$(".down").remove();
    	      
    	    		if(goal == "거리순"){
    	    			//먼저 지도에 있는 모든 핀을 지워야 한다.
    	    			//아래 함수를 수행시키면 지도에 뿌릴 핀이 가지고 있는 정보를 담은배열도 함께 초기화 시킨다.
    	    			hideMarkers(); 
    	    			
//    	        		//추천리스트 
    	        		$(jsonObjRecommand.defaultRecommandMap).each(function(index, element) {
   
    	        			if(element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//예약가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//여기 들어온 자체가 Y니까
    	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                
    	    	                //배달가능여부
    	    	                var delivery = "";
    	    	                if(element.BRANDDELIVERYSTATUS == 'Y'){
    	    	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                }else{
    	    	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';}
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }

//----------------------------------------------------------------------------------------------------------------------------------
    	    	                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);

    	    	    		    radd = radd+1; //추천길이, 전역변수로 선언, -1으로 초기화했음 
    	    	    		                   //아래 append 시킬 때, 브랜드 각각의 고유  brandNUM을 가지고 있는 <span>에 고유 클래스이름을 줄때 사용하는 변수이다.
    	    	    		                                                                                     //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
    	    	    		    daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
//----------------------------------------------------------------------------------------------------------------------------------                                                               <a href = "javascript:brandview('+context+','+element.BRANDNUM+');">'+element.BRANDNAME+'</a>
                            
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
	    	     	            
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;

    	        			}else{    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < jsonObjNormal.defaultNormalMap.length; fillList++){
    	        				
        	        			if(jsonObjNormal.defaultNormalMap[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        				
        	        				//여기 들어온 자체가 Y니까
        	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>&nbsp;예약가능&nbsp;</i>";
        	    	                
        	    	                //배달가능여부
        	    	                var delivery = "";
        	    	                if(jsonObjNormal.defaultNormalMap[fillList] == 'Y'){
        	    	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
        	    	                }else{
        	    	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
        	    	                }
        	        				
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(jsonObjNormal.defaultNormalMap[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(jsonObjNormal.defaultNormalMap[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+"'"+');">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+jsonObjNormal.defaultNormalMap[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+jsonObjNormal.defaultNormalMap[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+jsonObjNormal.defaultNormalMap[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+jsonObjNormal.defaultNormalMap[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}

    	    			
    	    		}else if(goal == "평점순"){

    	    			//먼저 지도에 있는 모든 핀을 지워야 한다.
    	    			hideMarkers();
    	    			
    	        		//추천리스트
    	        		$(starRecommandList).each(function(index, element) {
    	        			
    	        			if(element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//예약가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//여기 들어온 자체가 Y니까
    	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                
    	    	                //배달가능여부
    	    	                var delivery = "";
    	    	                if(element.BRANDDELIVERYSTATUS == 'Y'){    	    	                	
    	    	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                }else{
    	    	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //지도에 핀 뿌려주는 함수 호출
//----------------------------------------------------------------------------------------------------------------------------------
    	    	                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);
    	    	                
    	    	    		    radd = radd+1; //추천길이, 전역변수로 선언, -1으로 초기화했음 
    	    	    		                   //아래 append 시킬 때, 브랜드 각각의 고유  brandNUM을 가지고 있는 <span>에 고유 클래스이름을 줄때 사용하는 변수이다.
    	    	    		                                                                                     //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
    	    	    		    daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
//----------------------------------------------------------------------------------------------------------------------------------    	    	                
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);    	 
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	     	                
    	        			}else{    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}   	     		
    	        		});
    	        		
    	        		
    	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < starNomalList.length; fillList++){
    	        				
        	        			if(starNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        				
        	        				//여기 들어온 자체가 Y니까
        	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
        	    	                
        	    	                //배달가능여부
        	    	                var delivery = "";
        	    	                if(starNomalList[fillList] == 'Y'){
        	    	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
        	    	                }else{
        	    	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
        	    	                }
        	        				
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= starNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = starNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(starNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(starNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+starNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+starNomalList[fillList].BRANDNUM+"'"+');">'+starNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+starNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+starNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+starNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+starNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+starNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		
 

    	        	}else if(goal == "관심순"){
    	        		
    	    			//먼저 지도에 있는 모든 핀을 지워야 한다.
    	    			hideMarkers();
    	    			
    	        		//추천리스트
    	        		$(favorRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//예약가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//여기 들어온 자체가 Y니까
    	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                
    	    	                //배달가능여부
    	    	                var delivery = "";
    	    	                if(element.BRANDDELIVERYSTATUS == 'Y'){
    	    	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                }else{
    	    	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	    	                
       	    	                //지도에 핀 뿌려주는 함수 호출
//----------------------------------------------------------------------------------------------------------------------------------
    	    	                //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);
    	    	                  	    	                
    	    	                  	        				
    	    	                radd = radd+1; //추천길이, 전역변수로 선언, -1으로 초기화했음 
    	    	                  	    	   //아래 append 시킬 때, 브랜드 각각의 고유  brandNUM을 가지고 있는 <span>에 고유 클래스이름을 줄때 사용하는 변수이다.
    	    	                  	    	    		                                                 //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
//----------------------------------------------------------------------------------------------------------------------------------    	    	                
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	        				
    	        			}else{    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < favorNomalList.length; fillList++){
    	        				
        	        			if(favorNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        				
        	        				//여기 들어온 자체가 Y니까
        	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
        	    	                
        	    	                //배달가능여부
        	    	                var delivery = "";
        	    	                if(favorNomalList[fillList] == 'Y'){
        	    	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
        	    	                }else{
        	    	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
        	    	                }
        	        				
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= favorNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = favorNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(favorNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(favorNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+favorNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+favorNomalList[fillList].BRANDNUM+"'"+');">'+favorNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+favorNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+favorNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+favorNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+favorNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+favorNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		
    	    		}
    	        	
    	        	
    	        }else if($("#chk_reser").is(':checked')&& $("#chk_deliver").is(':checked')) {
    	        	
    	    		var choice = $(".dropDown-Span").text();
    	    		
    	    		//기존에 있는 지도핀 다 지웡
    	    		hideMarkers();
    	    		
    	        	$(".top").remove();
    	        	$(".down").remove();
    	        	
    	        	if(choice == "거리순"){
    	        		
    	        		//추천리스트
    	        		$(jsonObjRecommand.defaultRecommandMap).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y' && element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//예약, 배달 둘 다 가능한 브랜드들만 append 시켜준다.    
    	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                
    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';}
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	        				
    	    	                //지도에 핀찍고, 
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);
    	    	                radd = radd+1;
    	    	                
    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	    	                
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
    	     	                current = current + 1;
    	     	                recommandCheckLength = recommandCheckLength+1;
    	     	                
    	        			}else{
    	        				
    	        				//BRANDDELIVERYSTATUS, BRANDRESERVATIONSTATUS 둘 다 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		
    	        			if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < jsonObjNormal.defaultNormalMap.length; fillList++){
    	        				
        	        			if(jsonObjNormal.defaultNormalMap[fillList].BRANDDELIVERYSTATUS == 'Y' && jsonObjNormal.defaultNormalMap[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        				
        	        				//여기 들어온 자체가 Y니까
        	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
        	    	                
        	    	                //배달가능여부
        	    	                var delivery = "<i class='delivery' style='margin-right: 4px;'>배달가능</i>";
        	    	
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(jsonObjNormal.defaultNormalMap[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(jsonObjNormal.defaultNormalMap[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+"'"+');">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+jsonObjNormal.defaultNormalMap[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+jsonObjNormal.defaultNormalMap[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+jsonObjNormal.defaultNormalMap[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+jsonObjNormal.defaultNormalMap[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	                
        	     	                current = current + 1;

	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}

    	    			
    	        	}else if(choice == "평점순"){
    	        		
    	        		//추천리스트
    	        		$(starRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y' && element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//배달가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//예약가능인지 아닌지 oif
    	    	                
    	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
    	    	               
    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                //지도에 핀찍고 배열에 push
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);      	    	                
    	    	                radd = radd+1;
    	        				
    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	    	                
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	        				
    	        			}else{
    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
       	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < starNomalList.length; fillList++){
    	        				
        	        			if(starNomalList[fillList].BRANDDELIVERYSTATUS == 'Y'&& starNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        				
        	        				//여기 들어온 자체가 Y니까
        	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
        	    	                
        	    	                //배달가능여부
        	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
        	        				
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(jsonObjNormal.defaultNormalMap[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(starNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+starNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+starNomalList[fillList].BRANDNUM+"'"+');">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+starNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+starNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+starNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+starNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+starNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		

    	        	}else if(choice == "관심순"){
    	        		
    	        		//추천리스트
    	        		$(favorRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y' && element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//배달가능한 브랜드들만 append 시켜준다.
    	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                //지도에 찍고 배열에 push
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);      	    	                
    	    	                radd = radd+1;
    	    	                
    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	        				
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	        				
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	     	                
    	     	                
    	        			}else{    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < favorNomalList.length; fillList++){
    	        				
        	        			if(favorNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y' && favorNomalList[fillList].BRANDDELIVERYSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        				

        	    	                var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
        	    	                var delivery = '<i class="delivery">&nbsp;배달가능&nbsp;</i>';
        	   
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= favorNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = favorNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(favorNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(favorNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+favorNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+favorNomalList[fillList].BRANDNUM+"'"+');">'+favorNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+favorNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+favorNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+favorNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+favorNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+favorNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}    	        		
    	        	}
    	        	
    	        }else{
    	        	
    	        	//예약 라디오 버튼 해제했을 때 예약라디오 누르기 전 리스트로 돌아간다.
    	        	
    	        	var choice = $(".dropDown-Span").text();
    	        	
    	        	if(choice == "거리순"){
    	        		
    	        		$('#location').trigger('click');
    	        		
    	        	}else if(choice == "평점순") {
    	        		
    	        		 $('#evaluate').trigger('click');
    	        	}else if (choice == "관심순"){
    	        		
    	        		$('#heart').trigger('click');
    	        	}
    	        	
    	        }
    });


    $("#chk_deliver").change(function(){
    			
    			//일단 배열 지우고, 초기화먼저 시작하고 아래 조건 들어강
    			//스리스리
    			hideMarkers(); 
    			
    			//배달 만!!체크될때 실행됨
    			if ($("#chk_deliver").is(':checked') && !($("#chk_reser").is(':checked'))) {
    	          
    	    		var choice = $(".dropDown-Span").text();
    	    		
    	        	$(".top").remove();
    	        	$(".down").remove();

    	    		if(choice == "거리순"){
    	    			
    	        		//추천리스트
    	        		$(jsonObjRecommand.defaultRecommandMap).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y'){

    	        				var reservation = "";
    	    	                if(element.BRANDRESERVATIONSTATUS == 'Y'){
    	    	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
    	    	                }
    	    	                
    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                //마커찍고 배열에 push
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);    	    	                  	        				
    	    	                radd = radd+1;

    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	    	                
    	    	                //추천으로 뿌려진 갯수를 알기 위해 전역변수를 사용함
    	    	                
    	    	                if(current == -1){
    	    	                	current = 0;
    	    	                }
    	    	                
    	    	                //추천 브랜드가 총 몇개인지 알아야해서 사용
    	    	                //이 변수는 normal브랜드의 갯수가까지 더해질 변수라서 아래 변수를 따로 더 선언해준 것
    	    	                current = current + 1;
    	    	                
    	    	                //지도 핀 클릭함수에서 추천 길이를 파라미터로 넘겨줘야 해서 아래 해당 변수가 필요, 추천배달길이를 알아야해서
    	    	                recommandCheckLength = recommandCheckLength+1;
    	    	                
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	        				
    	        			}else{
    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		
    	        		//추천리스트가 5개보다 작으면 들어간다.
    	        		if(current < 5){
    	        			
    	        			//fillList를 전역변수로 선언해서 사용하는 이유는 후에 스크롤다운 이벤트에서 사용할 인덱스 번호이기 때문이다.
    	        			for(fillList = 0; fillList < jsonObjNormal.defaultNormalMap.length; fillList++){
    	        				
    	        				//노말리스트 jsonObjNormal.defaultNormalMap    	        					
    	    	        			if(jsonObjNormal.defaultNormalMap[fillList].BRANDDELIVERYSTATUS == 'Y'){
    	    	        				
    	    	    					//예약가능한 브랜드들만 append 시켜준다.
    	    	        				
    	    	        				//예약가능인지 아닌지 oif
    	    	        				var reservation = "";
    	    	    	                if(jsonObjNormal.defaultNormalMap[fillList].BRANDRESERVATIONSTATUS == 'Y'){
    	    	    	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
    	    	    	                }
    	    	    	                else{
    	    	    	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
    	    	    	                }
    	    	    	                
    	    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
    	    	    	                
    	    	    	                //가게 오픈 여부
    	    	    					var open = "";
    	    	    	                if(jsonObjNormal.defaultNormalMap[fillList].BRANDOPENTIME == 'Y'){
    	    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	    	                }
    	    	    	                else{
    	    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	    	                }

    	    	    	                //별 갯수 찍기  
    	    	    	                var star = "";
    	    	    	                for(var i = 1; i <= jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE; i++){
    	    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	    	                }
    	    	    	                
    	    	    	                for(var j = jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
    	    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	    	                }
    	    	    	                
    	    	    	                var normalMarker = mapNormalMarkerSpread(jsonObjNormal.defaultNormalMap[fillList]);        	    	              
    	    	    	                nadd = nadd+1;

    	    	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));
    	    	        				
    	    	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+"'"+');">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+jsonObjNormal.defaultNormalMap[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+jsonObjNormal.defaultNormalMap[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+jsonObjNormal.defaultNormalMap[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+jsonObjNormal.defaultNormalMap[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	    	     	                $(".listdown").append(normalbrand);
    	    	     	                
    	    	     	                //뿌려진 갯수를 알기위해서
    	    	     	                current = current + 1;

    	    	     	                if(current >= 5){
    	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
    	    	     	                	return false;
    	    	     	                }    	    	        				
    	    	        			}else{    	    	        				
    	    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue    	    	        				
    	    	        				continue;    	        				
    	    	        			}    
    	    	        			
    	        			}    	        			
    	        		}
    	        		
    	    		}else if(choice == "평점순"){
    	        		
    	        		//추천리스트
    	        		$(starRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y'){

    	    					//배달가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//예약가능인지 아닌지 oif
    	        				var reservation = "";
    	    	                if(element.BRANDRESERVATIONSTATUS == 'Y'){
    	    	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
    	    	                }
    	    	                
    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
    	    	          
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);      	    	                
    	    	                radd = radd+1;

    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));

    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	        				
    	        			}else{
    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		
    	        		
       	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < starNomalList.length; fillList++){
    	        				
        	        			if(starNomalList[fillList].BRANDDELIVERYSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        			
        	        				//예약가능인지 아닌지 oif
        	        				var reservation = "";
        	    	                if(starNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";
        	    	                }
        	    	                else{
        	    	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
        	    	                }
        	    	                
        	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
        	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
        	    	                
        	    	                
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= starNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = starNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(starNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(starNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+starNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+starNomalList[fillList].BRANDNUM+"'"+');">'+starNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+starNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+starNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+starNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+starNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+starNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		
    	        	}else if(choice == "관심순"){
    	    			
    	        		//추천리스트
    	        		$(favorRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y'){

    	    					//배달가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//예약가능인지 아닌지 oif
    	        				var reservation = "";
    	    	                if(element.BRANDRESERVATIONSTATUS == 'Y'){
    	    	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
    	    	                }
    	    	                else{
    	    	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
    	    	                }
    	    	                
    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
    	    	          
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);      	    	                
    	    	                radd = radd+1;

    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	        				
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	        				
    	        			}else{
    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		//노말리스트
    	        		
        	    		
       	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < favorNomalList.length; fillList++){
    	        				
        	        			if(favorNomalList[fillList].BRANDDELIVERYSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        			
        	        				//예약가능인지 아닌지 oif
        	        				var reservation = "";
        	    	                if(favorNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    	                	reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능</i>";
        	    	                }
        	    	                else{
        	    	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
        	    	                }
        	    	                
        	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
        	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
        	    	                
        	    	                
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= favorNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = favorNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(favorNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(favorNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+favorNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+favorNomalList[fillList].BRANDNUM+"'"+');">'+favorNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+favorNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+favorNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+favorNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+favorNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+favorNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		
    	    		}
    	        	
    	        }else if($("#chk_deliver").is(':checked')  && $("#chk_reser").is(':checked')) {
    	        	
    	    		var choice = $(".dropDown-Span").text();
    	    		
    	        	$(".top").remove();
    	        	$(".down").remove();
    	        	
    	        	if(choice == "거리순"){
    	        		
    	        		//추천리스트
    	        		$(jsonObjRecommand.defaultRecommandMap).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y' && element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//예약, 배달 둘 다 가능한 브랜드들만 append 시켜준다.
    	
    	    	                var reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                
    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	                
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';}
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	        				
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);    	    	                  	    	                    	    	                  	        				
    	    	                radd = radd+1;

    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	    	                
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	    	                if(current == -1){
    	    	                	current = 0;
    	    	                }
    	    	                
    	    	                //추천 브랜드가 총 몇개인지 알아야해서 사용
    	    	                //이 변수는 normal브랜드의 갯수가까지 더해질 변수라서 아래 변수를 따로 더 선언해준 것
    	    	                current = current + 1;
    	    	                
    	    	                //지도 핀 클릭함수에서 추천 길이를 파라미터로 넘겨줘야 해서 아래 해당 변수가 필요, 추천배달길이를 알아야해서
    	    	                recommandCheckLength = recommandCheckLength+1;
    	     	                
    	        			}else{
    	        				
    	        				//BRANDDELIVERYSTATUS, BRANDRESERVATIONSTATUS 둘 다 'Y'가 아니면 continue
    	        				return true;
    	        				
    	        			}
    	        			
    	        			
    	        		});
    	        		
    	        		
    	        		//노말브랜드 배달, 예약 둘 다    	        		
    	        		//추천리스트가 5개보다 작으면 들어간다.
    	        		if(current < 5){
    	        			
    	        			//fillList를 전역변수로 선언해서 사용하는 이유는 후에 스크롤다운 이벤트에서 사용할 인덱스 번호이기 때문이다.
    	        			for(fillList = 0; fillList < jsonObjNormal.defaultNormalMap.length; fillList++){
    	        				
    	        				//노말리스트 jsonObjNormal.defaultNormalMap    	        					
    	    	        			if(jsonObjNormal.defaultNormalMap[fillList].BRANDDELIVERYSTATUS == 'Y' && jsonObjNormal.defaultNormalMap[fillList].BRANDRESERVATIONSTATUS == 'Y'){
    	    	        				
    	    	    					//예약가능한 브랜드들만 append 시켜준다.
    	    	        				
    	    	        				//여기 들어오면 무조건 예약  Y
    	    	        				var reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	    	                
    	    	    	                //여기들어오면 무조건 배달 Y니까 조건문 없음
    	    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	    	                
    	    	    	                //가게 오픈 여부
    	    	    					var open = "";
    	    	    	                if(jsonObjNormal.defaultNormalMap[fillList].BRANDOPENTIME == 'Y'){
    	    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	    	                }
    	    	    	                else{
    	    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	    	                }

    	    	    	                //별 갯수 찍기  
    	    	    	                var star = "";
    	    	    	                for(var i = 1; i <= jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE; i++){
    	    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	    	                }
    	    	    	                
    	    	    	                for(var j = jsonObjNormal.defaultNormalMap[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
    	    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	    	                }
    	    	    	                
    	    	    	                var normalMarker = mapNormalMarkerSpread(jsonObjNormal.defaultNormalMap[fillList]);        	    	              
    	    	    	                nadd = nadd+1;

    	    	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));
    	    	        				
    	    	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+"'"+');">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+jsonObjNormal.defaultNormalMap[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+jsonObjNormal.defaultNormalMap[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+jsonObjNormal.defaultNormalMap[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+jsonObjNormal.defaultNormalMap[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+jsonObjNormal.defaultNormalMap[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	    	     	                $(".listdown").append(normalbrand);
    	    	     	                
    	    	     	                //뿌려진 갯수를 알기위해서
    	    	     	                current = current + 1;

    	    	     	                if(current >= 5){
    	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
    	    	     	                	return false;
    	    	     	                }    	    	        				
    	    	        			}else{    	    	        				
    	    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue    	    	        				
    	    	        				continue;    	        				
    	    	        			}        	    	        			
    	        			}    	        			
    	        		}
    	        		
    	        	}else if(choice == "평점순"){
    	        		
    	        		//추천리스트
    	        		$(starRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y' && element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//배달가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//여기 들어오면 무조건 배달, 예약 둘다 오케이인거임 조건을 또 줄 필요가 없단말임
    	    	                var reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능&nbsp;</i>";
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
    	    	          
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	    	                
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);    	    	                  	    	                    	    	                  	        				
    	    	                radd = radd+1;


    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	        				
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	        				
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	     	                
    	        			}else{
    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        			
    	        		});
    	        		
    	        		//노말리스트
    	        		
    	        		
      	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < starNomalList.length; fillList++){
    	        				
        	        			if(starNomalList[fillList].BRANDDELIVERYSTATUS == 'Y' && starNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	    					//예약가능한 브랜드들만 append 시켜준다.
        	        			
        	        				
        	        				var reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능</i>";        	    	              
        	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
        	    	                
        	    	                
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= starNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = starNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(starNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>&nbsp;영업중&nbsp;</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(starNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //--------------------------------------------------------------------------------------------------------------------------------- 																											
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+starNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+starNomalList[fillList].BRANDNUM+"'"+');">'+starNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+starNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+starNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+starNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+starNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+starNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		
    	        	}else if(choice == "관심순"){
    	        		
    	        		//추천리스트
    	        		$(favorRecommandList).each(function(i, element) {
    	        			
    	        			if(element.BRANDDELIVERYSTATUS == 'Y' && element.BRANDRESERVATIONSTATUS == 'Y'){

    	    					//배달가능한 브랜드들만 append 시켜준다.
    	        				
    	        				//여기 들어오면 무조건 배달, 예약 둘다 오케이인거임 조건을 또 줄 필요가 없단말임
    	    	                var reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능</i>";
    	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
    	    	          
    	    	                
    	    	                //가게 오픈 여부
    	    					var open = "";
    	    	                if(element.BRANDOPENTIME == 'Y'){
    	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
    	    	                }
    	    	                else{
    	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
    	    	                }
    	        				
    	    	                //별 갯수 찍기  
    	    	                var star = "";
    	    	                for(var i = 1; i <= element.AVGSTARGRADE; i++){
    	    	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
    	    	                }
    	    	                
    	    	                for(var j = element.AVGSTARGRADE+1; j<=6; j++){	                	
    	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
    	    	                }
    	        				
    	    	                var recommandMarker = mapRecommandMarkerSpread(element);    	    	                  	    	                    	    	                  	        				
    	    	                radd = radd+1;


    	    	                daum.maps.event.addListener(recommandMarker, 'click', firstRecommandAddListener(radd+1, map, recommandMarker));
    	    	                                   																																																	
    	        				var recommandbrand = '<li class="recommend-item top"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+element.BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+element.BRANDNUM+"'"+');">'+element.BRANDNAME+'</a><span class = "recommandNUM'+radd+'" id = "recommandNUM" style="display: none;">'+element.BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+element.REVIEWCOUNT+' &nbsp;&nbsp;관심:'+element.FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+element.gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+element.BRANDINTRODUCE+'</p></dd></dl></div></li>';      
    	     	                $(".listTop").append(recommandbrand);
    	     	                
    	     	                if(current == -1){
	   	    	                	current = 0; 
	   	    	                }
	   	    	                
	   	    	                current = current + 1;
	   	    	             
		   	    	            //예약추천길이 저장하는 함수
		   	    	            recommandCheckLength = recommandCheckLength+1;
    	     	                
    	        				
    	        			}else{
    	        				
    	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
    	        				return true;    	        				
    	        			}    	        		
    	        		});
    	        		
    	        		//노말리스트
    	        		
       	        		//만약  예약추천 수가 5개 미만이면 노멀에서 추가해주기
    	        		if(current < 5){
    	        			
    	        			for(fillList = 0; fillList < favorNomalList.length; fillList++){
    	        				
    	        				if(favorNomalList[fillList].BRANDDELIVERYSTATUS == 'Y' && favorNomalList[fillList].BRANDRESERVATIONSTATUS == 'Y'){
        	        			
        	    					//예약, 배달 가능한 브랜드들만 append 시켜준다.
        	        			
        	        				
        	        				var reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능</i>";        	    	                
        	    	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
        	    	                
        	    	                
        	    	                //별 갯수 찍기  
        	    	                var star = "";
        	    	                for(var i = 1; i <= favorNomalList[fillList].AVGSTARGRADE; i++){
        	    	                	star = star + '<span class="5-star stars">★</span>';
        	    	                }
        	    	                
        	    	                for(var j = favorNomalList[fillList].AVGSTARGRADE+1; j<=6; j++){	                	
        	    	                	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
        	    	                }
        	    	                
        	    	                //가게 오픈 여부
        	    					var open = "";
        	    	                if(favorNomalList[fillList].BRANDOPENTIME == 'Y'){
        	    	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
        	    	                }
        	    	                else{
        	    	                	open = "<i class='open' style='display: none;'>영업중</i>";
        	    	                }
        	    	                
        	    	                
        	    	                //여기서 다시 지도에 핀을 뿌려줘야한다. 예약지도예약지도
    //---------------------------------------------------------------------------------------------------------------------------------
        	    	                
        	    	                //함수의 리턴값으로 마커의 정보를 normalMarker변수에 넣는다.
        	    	                var normalMarker = mapNormalMarkerSpread(favorNomalList[fillList]);
        	    	                
        	    	                nadd = nadd+1;
        	    	               
        	    	                //함수 리턴값을 이용해서 클로저함수를 만들어 클릭했을 때 실행될 수 있도록 한다.
        	    	                daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(radd+1, nadd+1, map, normalMarker));

    //---------------------------------------------------------------------------------------------------------------------------------                                                                                                              
        	        				var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+favorNomalList[fillList].BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+favorNomalList[fillList].BRANDNUM+"'"+');">'+favorNomalList[fillList].BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id ="normalNUM" style="display: none;">'+favorNomalList[fillList].BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+favorNomalList[fillList].REVIEWCOUNT+' &nbsp;&nbsp;관심:'+favorNomalList[fillList].FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+favorNomalList[fillList].gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+favorNomalList[fillList].BRANDINTRODUCE+'</p></dd></dl></div></li>';      
        	     	                $(".listdown").append(normalbrand);
        	     	               
        	     	                //예약이 가능한 브랜드들 갯수가 5개여야하니까 추천갯수변수인 current +1을 해서 일반 브랜드를 몇개 뿌려야하는지 비교시킨다.
        	     	                current = current + 1;
        	     	                
	    	     	                if(current >= 5){
	    	     	                	//일반 브랜드를 추가해서 디폴트로 뿌려지는 갯수가 5개가 되면 리턴시켜버린다.
	    	     	                	return false;
	    	     	                }  
       
        	        			}else{        	        				
        	        				//BRANDRESERVATIONSTATUS가 'Y'가 아니면 continue
        	        				continue;        	        				
        	        			}       	        				
    	        			}    	        			
    	        		}
    	        		
 
    	        	}    	        	
    	        }else{
    	        	
    	        	//예약 라디오 버튼 해제했을 때 예약라디오 누르기 전 리스트로 돌아간다.
    	 
    	        	var choice = $(".dropDown-Span").text();
    	        	if(choice == "거리순"){
    	        		$('#location').trigger('click');
    	        		
    	        	}else if(choice == "평점순") {
    	        		 $('#evaluate').trigger('click');

    	        	}else if (choice == "관심순"){
    	        		$('#heart').trigger('click');		
    	        	}    	        	
    	        }
    	      });
    
    
    
//스크롤 이벤트 건드는 곳입니다, 

		  $(document).scroll(function() {
			    
		    var maxHeight = $(document).height();
		    var currentScroll = $(window).scrollTop() + $(window).height();
		 
		    if (maxHeight <= currentScroll+30) {

		    	var order = $('.dropDown-Span').text();

		    	if(order == '거리순'){
		    		
		    		if (!($("#chk_deliver").is(':checked')) && !($("#chk_reser").is(':checked'))){
		    			
			    		//거리순인데, 배달, 예약 둘 다 체크없음	
			    		scrollDownAddList(jsonObjRecommand.defaultRecommandMap.length, jsonObjNormal.defaultNormalMap);	
			    		
		    		}else if( $("#chk_reser").is(':checked') && !($("#chk_deliver").is(':checked'))){
		    			//거리순인데 예약만 체크했을 경우	
		    			
			    		if(fillList >= jsonObjNormal.defaultNormalMap.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
		    					    	
			    		scrollDownCheckAddList(recommandCheckLength, jsonObjNormal.defaultNormalMap, fillList, 'R');
		    		
		    		}else if( !($("#chk_reser").is(':checked')) && $("#chk_deliver").is(':checked')){
		    			//거리순인데 배달만 체크되어있을 경우
		    		
			    		if(fillList >= jsonObjNormal.defaultNormalMap.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
			    			
			    		//                      배달가능한 추천리스트 길이,
			    		scrollDownCheckAddList(recommandCheckLength, jsonObjNormal.defaultNormalMap, fillList, 'D');
		    			
		    		
		    		}else if($("#chk_deliver").is(':checked') && $("#chk_reser").is(':checked')){
		    			//거리순인데 배달, 예약 둘 다 체크되어 있을 때 
		    			
		    			if(fillList >= jsonObjNormal.defaultNormalMap.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
		    			
		    			scrollDownCheckAddList(recommandCheckLength, jsonObjNormal.defaultNormalMap, fillList, 'T');
		    		
		    		}
		    		
		    		return null;
		    		
		    	}else if(order == '평점순'){
		    		
//		    		alert("평점순 scroll함수에 들어옴");

		    		if (!($("#chk_deliver").is(':checked')) && !($("#chk_reser").is(':checked'))){
//		    			alert("평점순 노체크");
			    		//거리순인데, 배달, 예약 둘 다 체크없음	
		    			scrollDownAddList(starRecommandList.length, starNomalList);
			    		
		    		}else if( $("#chk_reser").is(':checked') && !($("#chk_deliver").is(':checked'))){
		    			//거리순인데 예약만 체크했을 경우	
//		    			alert("평점순 예약만체크");
			    		if(fillList >= starNomalList.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
		    					    	
			    		scrollDownCheckAddList(recommandCheckLength, starNomalList, fillList, 'R');
		    		
		    		}else if( !($("#chk_reser").is(':checked')) && $("#chk_deliver").is(':checked')){
		    			//거리순인데 배달만 체크되어있을 경우
//		    			alert("평점순 배달만체크");
			    		if(fillList >= starNomalList.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
			    			
			    		//                      배달가능한 추천리스트 길이,
			    		scrollDownCheckAddList(recommandCheckLength, starNomalList, fillList, 'D');
		    			
		    		
		    		}else if($("#chk_deliver").is(':checked') && $("#chk_reser").is(':checked')){
		    			//거리순인데 배달, 예약 둘 다 체크되어 있을 때 
//		    			alert("평점순 둘 다 체크");
		    			if(fillList >= starNomalList.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
		    			
		    			scrollDownCheckAddList(recommandCheckLength, starNomalList, fillList, 'T');
		    		
		    		}
		    		
		    		return null;
		    		
		    	}else if (order == '관심순'){
//		    		
//		    		var favorNomalList;
//		    		var favorRecommandList; 

		    		
//		    		alert("관심순 scroll함수에 들어옴");

		    		if (!($("#chk_deliver").is(':checked')) && !($("#chk_reser").is(':checked'))){
//		    			alert("평점순 노체크");
			    		//거리순인데, 배달, 예약 둘 다 체크없음	
		    			scrollDownAddList(favorRecommandList.length, favorNomalList);
			    		
		    		}else if( $("#chk_reser").is(':checked') && !($("#chk_deliver").is(':checked'))){
		    			//거리순인데 예약만 체크했을 경우	
//		    			alert("평점순 예약만체크");
			    		if(fillList >= favorNomalList.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
		    					    	
			    		scrollDownCheckAddList(recommandCheckLength, favorNomalList, fillList, 'R');
		    		
		    		}else if( !($("#chk_reser").is(':checked')) && $("#chk_deliver").is(':checked')){
		    			//거리순인데 배달만 체크되어있을 경우
//		    			alert("평점순 배달만체크");
			    		if(fillList >= favorNomalList.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
			    			
			    		//                      배달가능한 추천리스트 길이,
			    		scrollDownCheckAddList(recommandCheckLength, favorNomalList, fillList, 'D');
		    			
		    		
		    		}else if($("#chk_deliver").is(':checked') && $("#chk_reser").is(':checked')){
		    			//거리순인데 배달, 예약 둘 다 체크되어 있을 때 
//		    			alert("평점순 둘 다 체크");
		    			if(fillList >= favorNomalList.length){
//			    			alert("마지막 브랜드 입니다.");
			    			return null;
			    		}
		    			
		    			scrollDownCheckAddList(recommandCheckLength, favorNomalList, fillList, 'T');
		    		
		    		}
		    		
		    		return null;
		
		    	}
		    	
//				alert("부기웅앵웅");			
		    }
		    
		  });

//가장 크게 감싸는 괄호
});





function scrollDownAddList(recommandLength, normalList){
	
	//현재까지 뿌려진 일반브랜드 갯수가 길이보다 크거나 같으면 더이상 append 시킬 브랜드가 없는 것
		
		if(current >= normalList.length - 1){
//			$(".listdown").append("더이상 브랜드가 없습니다.aaaa");			
//			alert("브랜드가 없습니다.");
			return false;					
		}
		
		for(var index = 0; index <5; index++){

			//현재 뿌려진 인덱스 다음번호 부터 뿌려야해서
			current  = current+1;
			
			var BRANDRESERVATIONSTATUS = normalList[current].BRANDRESERVATIONSTATUS;
			var AVGSTARGRADE = normalList[current].AVGSTARGRADE;
			var BRANDNAME = normalList[current].BRANDNAME;
			var gapM = normalList[current].gapM;
			var BRANDLATITUDE = normalList[current].BRANDLATITUDE;
			var BRANDADDRESS = normalList[current].BRANDADDRESS;
			var REVIEWCOUNT = normalList[current].REVIEWCOUNT;
			var BRANDOPENTIME = normalList[current].BRANDOPENTIME;
			var BRANDLONGITUDE = normalList[current].BRANDLONGITUDE;
			var THUMNAIL = normalList[current].THUMNAIL;
			var FAVORTOTALCNT = normalList[current].FAVORTOTALCNT;
			var BRANDDELIVERYSTATUS = normalList[current].BRANDDELIVERYSTATUS;
			var EXPOSURELEVEL = normalList[current].EXPOSURELEVEL;
			var BRANDINTRODUCE = normalList[current].BRANDINTRODUCE;
			var BRANDNUM = normalList[current].BRANDNUM;
			
		
			//영업중인지 아닌지 비교하기
			var open = "";
	        if(BRANDOPENTIME == 'Y'){
	        	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
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
	        	star = star + '<span class="5-star stars">★</span>';
	        }	                
	        for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
	        	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
	        }
	//----------------------------------------------------------------------------------------------------------------------------------	            
	        //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
	        //이 함수에서 배열에 push까지 한다.
	        var normalMarker = mapNormalMarkerSpread(normalList[current]);
	                                                                                    //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
	        daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(recommandLength, normalList.length, map, normalMarker));	                
	//----------------------------------------------------------------------------------------------------------------------------------

	        var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+current+'" id = "normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';
	        
	        $(".listdown").append(normalbrand);
	        
			if(current >= normalList.length-1){
//				$(".listdown").append("더이상 브랜드가 없습니다.bbb");			
//				alert("더이상 브랜드가 없습니다.");
				break;						
			}
		}	
		
	}

//배달, 예약인 것들 스크롤 함수 일어나면 어펜드 시키는 것                                                                    fillList            D or R
function scrollDownCheckAddList(recommandLength, normalList, normalUseListNumber, status){
	
		if(normalUseListNumber >= normalList.length - 1){
//			$(".listdown").append("더이상 브랜드가 없습니다.aaaa");		
//			alert("마지막 브랜드 입니다.");
			return false;					
		}
		
		if(status == 'R'){
			
			//사용한 fillList 번호보다 1 더 큰숫라부터 사용해야해서
			normalUseListNumber = normalUseListNumber+1;
			
			for(var index = 0; index <5; index++){
				
				var BRANDRESERVATIONSTATUS = normalList[normalUseListNumber].BRANDRESERVATIONSTATUS;
				var AVGSTARGRADE = normalList[normalUseListNumber].AVGSTARGRADE;
				var BRANDNAME = normalList[normalUseListNumber].BRANDNAME;
				var gapM = normalList[normalUseListNumber].gapM;
				var BRANDLATITUDE = normalList[normalUseListNumber].BRANDLATITUDE;
				var BRANDADDRESS = normalList[normalUseListNumber].BRANDADDRESS;
				var REVIEWCOUNT = normalList[normalUseListNumber].REVIEWCOUNT;
				var BRANDOPENTIME = normalList[normalUseListNumber].BRANDOPENTIME;
				var BRANDLONGITUDE = normalList[normalUseListNumber].BRANDLONGITUDE;
				var THUMNAIL = normalList[normalUseListNumber].THUMNAIL;
				var FAVORTOTALCNT = normalList[normalUseListNumber].FAVORTOTALCNT;
				var BRANDDELIVERYSTATUS = normalList[normalUseListNumber].BRANDDELIVERYSTATUS;
				var EXPOSURELEVEL = normalList[normalUseListNumber].EXPOSURELEVEL;
				var BRANDINTRODUCE = normalList[normalUseListNumber].BRANDINTRODUCE;
				var BRANDNUM = normalList[normalUseListNumber].BRANDNUM;
				
    			if(BRANDRESERVATIONSTATUS == 'Y'){
        			
					//예약가능한 브랜드들만 append 시켜준다.
    				
    				//배달가능인지 아닌지 oif
	                if(BRANDDELIVERYSTATUS == 'Y'){
	                	delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
	                }
	                else{
	                	delivery = '<i class="delivery" style="display: none;">배달가능</i>';
	                }
	                
	                //여기들어오면 무조건 배달 Y니까 조건문 없음
	                var reservation = "<i class='delivery' style='margin-right: 4px;'>&nbsp;예약가능&nbsp;</i>";
	                
	                //가게 오픈 여부
					var open = "";
	                if(BRANDOPENTIME == 'Y'){
	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
	                }
	                else{
	                	open = "<i class='open' style='display: none;'>영업중</i>";
	                }

	                //별 갯수 찍기  
	                var star = "";
	                for(var i = 1; i <= AVGSTARGRADE; i++){
	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
	                }
			        for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
			        	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
			        }
			        
	        //----------------------------------------------------------------------------------------------------------------------------------	            
			        //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
			        //이 함수에서 배열에 push까지 한다.
			        var normalMarker = mapNormalMarkerSpread(normalList[normalUseListNumber]);
			        nadd = nadd+1;
			                                                                                 //전체 길이는 0까지 포함시켜야하니까 최종적으로 보낼 때 +1로 전체 길이를 파라미터로 보낸다.
//			        daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(recommandLength, normalList.length, map, normalMarker));
			        //                                                                        배달가능한 추천리스트길이     배달가능한 일반브랜드 길이
			        daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(recommandLength, normalUseListNumber, map, normalMarker));
			        
			//----------------------------------------------------------------------------------------------------------------------------------
    				
			        var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id = "normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
 	                $(".listdown").append(normalbrand);

 			        //다음 포문에서 다음 index 정보를 써야하기 때문에
 			        normalUseListNumber = normalUseListNumber+1;
 			        
 			        //다음 스크롤 이벤트에 index값을 적용하기 위해서
 			       fillList = fillList + 1;

 			        if(fillList >= normalList.length){ 			        	
// 			        	alert("마지막페이지입니다."); 			        	
 			        }
 	                				
    			}else {    	
    				normalUseListNumber = normalUseListNumber+1;
    				fillList = fillList + 1;
    				index = index - 1;
    				continue;    

    			}
			}	
			
			
			
			
		}else if(status == 'D'){
			//이미 사용된 index 다음부터 사용되야 하기 때문에 먼저 1을 더해준다.
			normalUseListNumber = normalUseListNumber+1;

			for(var index = 0; index <5; index++){
				
				var BRANDRESERVATIONSTATUS = normalList[normalUseListNumber].BRANDRESERVATIONSTATUS;
				var AVGSTARGRADE = normalList[normalUseListNumber].AVGSTARGRADE;
				var BRANDNAME = normalList[normalUseListNumber].BRANDNAME;
				var gapM = normalList[normalUseListNumber].gapM;
				var BRANDLATITUDE = normalList[normalUseListNumber].BRANDLATITUDE;
				var BRANDADDRESS = normalList[normalUseListNumber].BRANDADDRESS;
				var REVIEWCOUNT = normalList[normalUseListNumber].REVIEWCOUNT;
				var BRANDOPENTIME = normalList[normalUseListNumber].BRANDOPENTIME;
				var BRANDLONGITUDE = normalList[normalUseListNumber].BRANDLONGITUDE;
				var THUMNAIL = normalList[normalUseListNumber].THUMNAIL;
				var FAVORTOTALCNT = normalList[normalUseListNumber].FAVORTOTALCNT;
				var BRANDDELIVERYSTATUS = normalList[normalUseListNumber].BRANDDELIVERYSTATUS;
				var EXPOSURELEVEL = normalList[normalUseListNumber].EXPOSURELEVEL;
				var BRANDINTRODUCE = normalList[normalUseListNumber].BRANDINTRODUCE;
				var BRANDNUM = normalList[normalUseListNumber].BRANDNUM;
				
    			if(BRANDDELIVERYSTATUS == 'Y'){
        			
					//예약가능한 브랜드들만 append 시켜준다.
    				
    				//예약가능인지 아닌지 
    				var reservation = "";
	                if(BRANDRESERVATIONSTATUS == 'Y'){
	                	reservation = "<i class='delivery' style='margin-right: 4px;'>예약가능</i>";
	                }
	                else{
	                	reservation = "<i class='reservation' style='display: none;'>예약가능</i>";
	                }
	                
	                //여기들어오면 무조건 배달 Y니까 조건문 없음
	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능</i>';
	                
	                //가게 오픈 여부
					var open = "";
	                if(BRANDOPENTIME == 'Y'){
	                	open = "<i class='open' style='margin-right: 4px;'>영업중</i>";
	                }
	                else{
	                	open = "<i class='open' style='display: none;'>영업중</i>";
	                }

	                //별 갯수 찍기  
	                var star = "";
	                for(var i = 1; i <= AVGSTARGRADE; i++){
	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
	                }
			        for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
			        	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
			        }
			        
	        //----------------------------------------------------------------------------------------------------------------------------------	            
			        //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
			        //이 함수에서 배열에 push까지 한다.
			        var normalMarker = mapNormalMarkerSpread(normalList[normalUseListNumber]);
			        nadd = nadd+1;			        
			        //                                                                        배달가능한 추천리스트길이     배달가능한 일반브랜드 길이
			        daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(recommandLength, normalUseListNumber, map, normalMarker));
			        
			//----------------------------------------------------------------------------------------------------------------------------------
    				
			        var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id = "normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
 	                $(".listdown").append(normalbrand);

 			        //다음 포문에서 다음 index 정보를 써야하기 때문에
 			        normalUseListNumber = normalUseListNumber+1;
 			        
 			        //다음 스크롤 이벤트에 index값을 적용하기 위해서
 			        fillList = fillList + 1;

 			        if(fillList >= normalList.length){ 			        	
// 			        	alert("마지막브랜드 입니다."); 			        	
 			        }
 	                				
    			}else {    	
    				normalUseListNumber = normalUseListNumber+1;
    				fillList = fillList + 1;
    				//만약 해당 조건에 맞지 않는 경우 바로 else 문으로 들어오는데 게시글은 5개 써줘야하니까 반복문에 증간  1을 다시 빼기 1해줘서 조건에 맞는 브랜드가 5개 나올 수 있도록 한다.
    				index = index-1;
    				continue;    

    			}
			}							
		} else if(status == 'T'){
//			alert("배달예약 둘 다 ");
			
			//이미 사용된 index 다음부터 사용되야 하기 때문에 먼저 1을 더해준다.
			normalUseListNumber = normalUseListNumber+1;

			for(var index = 0; index <5; index++){
				
				var BRANDRESERVATIONSTATUS = normalList[normalUseListNumber].BRANDRESERVATIONSTATUS;
				var AVGSTARGRADE = normalList[normalUseListNumber].AVGSTARGRADE;
				var BRANDNAME = normalList[normalUseListNumber].BRANDNAME;
				var gapM = normalList[normalUseListNumber].gapM;
				var BRANDLATITUDE = normalList[normalUseListNumber].BRANDLATITUDE;
				var BRANDADDRESS = normalList[normalUseListNumber].BRANDADDRESS;
				var REVIEWCOUNT = normalList[normalUseListNumber].REVIEWCOUNT;
				var BRANDOPENTIME = normalList[normalUseListNumber].BRANDOPENTIME;
				var BRANDLONGITUDE = normalList[normalUseListNumber].BRANDLONGITUDE;
				var THUMNAIL = normalList[normalUseListNumber].THUMNAIL;
				var FAVORTOTALCNT = normalList[normalUseListNumber].FAVORTOTALCNT;
				var BRANDDELIVERYSTATUS = normalList[normalUseListNumber].BRANDDELIVERYSTATUS;
				var EXPOSURELEVEL = normalList[normalUseListNumber].EXPOSURELEVEL;
				var BRANDINTRODUCE = normalList[normalUseListNumber].BRANDINTRODUCE;
				var BRANDNUM = normalList[normalUseListNumber].BRANDNUM;
				
    			if(BRANDDELIVERYSTATUS == 'Y' && BRANDRESERVATIONSTATUS == 'Y'){
        			
					//예약가능한 브랜드들만 append 시켜준다.
    				
    				//예약가능인지 아닌지 
    				var reservation = "<i class='reservation' style='margin-right: 4px;'>예약가능&nbsp;</i>";	                
	                
	                //여기들어오면 무조건 배달 Y니까 조건문 없음
	                var delivery = '<i class="delivery" style="margin-right: 4px;">배달가능&nbsp;</i>';
	                
	                //가게 오픈 여부
					var open = "";
	                if(BRANDOPENTIME == 'Y'){
	                	open = "<i class='open' style='margin-right: 4px;'>영업중&nbsp;</i>";
	                }
	                else{
	                	open = "<i class='open' style='display: none;'>영업중</i>";
	                }

	                //별 갯수 찍기  
	                var star = "";
	                for(var i = 1; i <= AVGSTARGRADE; i++){
	                	star = star + '<span class="5-star stars">★</span>';    	    	                	
	                }
			        for(var j = AVGSTARGRADE+1; j<=6; j++){	                	
			        	star = star + '<span class="5-star stars" style="color: #F2F2F2">★</span>';	                	
			        }
			        
	        //----------------------------------------------------------------------------------------------------------------------------------	            
			        //예약이 가능한 추천 브랜드들 지도에 핀띄워주는 함수
			        //이 함수에서 배열에 push까지 한다.
			        var normalMarker = mapNormalMarkerSpread(normalList[normalUseListNumber]);
			        nadd = nadd+1;

			        //                                                                        배달가능한 추천리스트길이     배달가능한 일반브랜드 길이
			        daum.maps.event.addListener(normalMarker, 'click', firstNormalAddListener(recommandLength, normalUseListNumber, map, normalMarker));
			        
			//----------------------------------------------------------------------------------------------------------------------------------
    				
			        var normalbrand = '<li class="recommend-item down"><div class="item-inner clearfix"><div class = "image-box" ><img alt="thumnail" src="imageDown?brandNUM='+BRANDNUM+'"></div><div  class = "maker-rap"><div class = "marker-image"><img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pinimage"></div></div><dl class="info-box"><dt class="title_rap"><a href = "javascript:brandview('+context+','+"'"+BRANDNUM+"'"+');">'+BRANDNAME+'</a><span class = "normalNUM'+nadd+'" id = "normalNUM" style="display: none;">'+BRANDNUM+'</span></dt><dd class="score-rap clearfix">'+star+'<span class="txt_review">리뷰:'+REVIEWCOUNT+' &nbsp;&nbsp;관심:'+FAVORTOTALCNT+'</span>'+'<span class="txt_distance">'+gapM+'Km</span>'+'</dd><dd class="type-rap">'+reservation+delivery+open+'</dd><dd class="indroduce-rap"><span>매장소개</span><p>'+BRANDINTRODUCE+'</p></dd></dl></div></li>';      
 	                $(".listdown").append(normalbrand);

 			        //다음 포문에서 다음 index 정보를 써야하기 때문에
 			        normalUseListNumber = normalUseListNumber+1;
 			        
 			        //다음 스크롤 이벤트에 index값을 적용하기 위해서
 			       fillList = fillList + 1;

 			        if(fillList >= normalList.length){ 			        	
// 			        	alert("마지막브랜드 입니다."); 			        	
 			        }
 	                				
    			}else {    	
    				normalUseListNumber = normalUseListNumber+1;
    				fillList = fillList + 1;
    				//반복문이 배달과 예약 둘 다 Y인게 5개 돌아야하니까
    				index = index - 1;
    				continue;    

    			}
			}	
			
		}
	}

	

//일반 브랜드 핀 찍는거 함수로 뻄
function mapNormalMarkerSpread(loofParameter){
	
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new daum.maps.Size(24, 35); 
		    	    	    		    
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

//추천브랜드 핀 찍는거 함수로 뻄
function mapRecommandMarkerSpread(loofParameter){
	
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new daum.maps.Size(24, 35); 
		    	    	    		    
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

//내 아이피주소로 위도, 경도 알려주는 함수 2개
//function getLocation() {
//
//	if (navigator.geolocation) {
//		navigator.geolocation.getCurrentPosition(showPosition);
//	} else {
//		navigator.geolocation;
//	}
//}
//
//function showPosition(position) {
//	$("#lit").val(position.coords.latitude);
//	$("#lot").val(position.coords.longitude);	
//	$("#lit").trigger("change");
//}

//브랜드 이름 누르면 링크이동
function brandview(context, brandNUM){	
	//메인화면에서 브랜드네임을 누르면 링크이동하게 하는거
	location.href= context+"/brand/brandView?brandNUM="+brandNUM;
	
}
