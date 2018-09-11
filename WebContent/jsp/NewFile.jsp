<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% int index = 0; %>
<% String path=request.getContextPath(); %>   
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<style type="text/css">

.temp {
	ime-mode:disabled; 
}

}
</style>
<script type="text/javascript">

	

	
/* 	function temp(){
		
		var orderNumber = '180811O46';
	 	 $.ajax({
             type : 'post',
             url  : '${pageContext.request.contextPath}/order/nonMemberOrderCheck',
             data : {orderNumber:orderNumber},
             dataType:"json" ,
             success : function(result) {
            	 if(result){
            		 alert("비회원 로그인 성공");
            		 location.href = '${pageContext.request.contextPath}/order/orderList?orderNumber=180811O46';	 
            	 }else{
            		 alert("주문번호를 확인해주세요.");	 
            	 }
 
             },
             error : function(error) {                
       		 }
     }); 
	 	 
	} */
	$(function(){
		$("#temp").keyup(function(e) { 
			if (!(e.keyCode >=37 && e.keyCode<=40)) {
				var v = $(this).val();
				$(this).val(v.replace(/[^a-z0-9]/gi,''));
			}
		});

	 })
		
	


</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>	



<input id="temp" type='text' style='ime-mode:disabled;' />

</body>
</html>