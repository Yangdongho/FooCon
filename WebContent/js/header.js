

	//헤더에 있는 내주변 눌렀을때 실행되는 함수 
	function myAreaPosition(context){		
//		alert(context);
	//	location.href="search/myArea?lit="+$("#lit").val()+"&lot="+$("#lot").val();
		location.href= context+"/search/myArea";
	}
	
	//헤더에서 관심트럭 눌렀을때 실행되는 함수 
	function myInterest(context, memberSEQ ){
	
	//	location.href="member/interest?memberPK=M6&lit="+$("#lit").val()+"&lot="+$("#lot").val();		
		location.href= context+"/member/interest?memberPK="+memberSEQ;
	}
	
    function login(context){
    	
    	location.href= context+"/member/login";  
     }
      
    function logout(context){
    	 
    	//membercontroller에 logout 함수에 기능
    	location.href= context+"/member/logout";   
     }
      
    function myPage(context){
    	
    	//마이페이지 가기전에 비밀번호 체크해서 마이페이지 화면 보여주니까 pwCheck먼저 들림
    	location.href= context+"/member/pwCheck";
    	  
     }
    
    function orderList(context){
    	
    	location.href= context+"/order/orderList";
    	
    }