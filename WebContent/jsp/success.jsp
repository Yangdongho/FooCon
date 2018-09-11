<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/success.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 로그인 입력 -->
	<section class="payment-complete-area">
		<h2 class="hidden">payment-complete</h2>
		<div class="container">
			<div class="payment_complete_header">
				<h3>주문완료</h3>
				<p>요청하신 상품이 주문 완료되었습니다.</p>
				<p>주문내역을 확인하길 원하시면 주문내역에서 확인해주세요.</p>			
			</div>
			<div class="payment_complete_body">
				<c:choose>
               		<c:when test="${empty seq}">
                		  <input type="button" class="order_btn" value="주문내역 확인" onclick="location.href='<%=path%>/member/login'">   
               		</c:when>
               		<c:otherwise>
                  		  <input type="button" class="order_btn" value="주문내역 확인" onclick="location.href='orderList'">
               		</c:otherwise>
            	</c:choose>
            <input type="button" class="main_btn" value="메인으로 이동" onclick="location.href='<%=path%>/'">
			</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>