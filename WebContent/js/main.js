

var mainlit = "";
var mainlot = "";

$(function(){

	getLocation();

//	$("#lit").val(lit);
//	$("#lot").val(lot);
// 	$("#headerlit").val(lit);
// 	$("#headerlot").val(lot);
 	
 	//여기서 ajax로 위도 경도를 서버에 보내서 session에  위도 경도를 박아놓는다.


  
});

function brandview(context, brandNUM){
	
	//메인화면에서 브랜드네임을 누르면 링크이동하게 하는거
	location.href= context+"/brand/brandView?brandNUM="+brandNUM;
	
}	

function getLocation() {
	
    if (navigator.geolocation) {    	
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else { 
    	navigator.geolocation;
    }
}

function showPosition(position) {
	
//	$("#lit").val(position.coords.latitude);
//	$("#lot").val(position.coords.longitude);
// 	$("#headerlit").val(position.coords.latitude);
// 	$("#headerlot").val(position.coords.longitude);
 	
 	//세션에 위도랑 경도를 담음
    sessionStorage.setItem('mainlit', position.coords.latitude);
    sessionStorage.setItem('mainlot', position.coords.longitude);
    
	var lit = sessionStorage.getItem('mainlit');
	var lot = sessionStorage.getItem('mainlot');

	$.ajax({
		
		url : 'litlot',
		type : 'POST',
		data : {
			lit:lit,
			lot:lot
		},
		dataType : 'text',
		success : function(result) {			
//			alert("거리 허용눌러서 위도, 경도 가져오는거 성공");		
		},		
		error:function(request,status,error){				
			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		} 			
	});


}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
        	        
        	$.ajax({
        		
        		url : 'denyLocation',
        		type : 'POST',
        		dataType : 'text',
        		success : function(result) {	
        		
        		},		
        		error:function(request,status,error){				
        			 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        		} 			
        	});
        	
            break;
            
        case error.POSITION_UNAVAILABLE:
//        	alert("정보가 없다능");
//            x.innerHTML = "Location information is unavailable."
            break;
            
        case error.TIMEOUT:
//        	alert("time out이라서 장소 정보 놉");
//            x.innerHTML = "The request to get user location timed out."
            break;
            
        case error.UNKNOWN_ERROR:
//        	alert("알수없는 에러가 일어났다능");
//            x.innerHTML = "An unknown error occurred."
            break;                        
    }
}

////헤더에 있는 내주변 눌렀을때 실행되는 함수 
//function myAreaPosition(){
//	location.href="search/myArea?lit="+$("#lit").val()+"&lot="+$("#lot").val();
//}
//
////헤더에서 관심트럭 눌렀을때 실행되는 함수 
//function myInterest(){
//	alert("메인 js에는 들어오나?");
//	location.href="member/interest?memberPK=M6&lit="+$("#lit").val()+"&lot="+$("#lot").val();
//}

//function mainSearch(){
//	location.href="search/mainSearch?LATITUDE="+$("#lit").val()+"&LONGITUDE="+$("#lit").val();
//}