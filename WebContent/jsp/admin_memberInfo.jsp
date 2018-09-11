<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css'
	rel='stylesheet' type='text/css'>
	
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_memberInfo.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/notice_reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>    
	<!-- HEADER -->
	<jsp:include page="header_admin.jsp" />
	<!-- 공지사항 리스트 -->
	<section class="notice-list-area">
	<div class="content_container">
		<div class="headermenu_left">
			<h2>${member.MEMBEREMAIL}(${member.NICK})</h2>
		</div>
		<div class="table_option">
			<div class="sumList">
				<span>총 주문금액 ${member.total}</span>&nbsp;
				<span>총 주문수 <script type="text/javascript">document.write(${member.countD}+${member.countR})</script></span>&nbsp;
				<span>총배달수 ${member.countD}</span>&nbsp;
				<span>총 예약수 ${member.countR}</span>&nbsp;
				<span>적립금 ${member.POINTTOTAL}</span>&nbsp;
				<span>관심트럭 ${member.favor}</span>
			</div>
		</div>
		<div class="submenu-list clearfix">
			<a onclick="location.href = 'memberInfo?memberNum=${member.MEMBERNUM}'">회원정보</a> 
			<a onclick="location.href = 'memberOrderList?MEMBERNUM=${member.MEMBERNUM}'">주문내역</a> 
			<a onclick="location.href = 'memberPointList?MEMBERNUM=${member.MEMBERNUM}'">적립금내역</a>
		</div>
		
		<div class="memberInfo">
			<ul class="clearfix">
				<li class="d01"><span class="email width">이메일</span> <span>${member.MEMBEREMAIL}</span></li>
				<li class="d02"><span class="phoneNumber width">휴대번호</span>
					<span>
							<c:set var="Phone1" value="${fn:substring((member.MEMBERPHONE),0,3)}"></c:set>
	                        <c:set var="Phone2" value="${fn:substring((member.MEMBERPHONE),3,7)}"></c:set>
	                        <c:set var="Phone3" value="${fn:substring((member.MEMBERPHONE),7,11)}"></c:set>
	                           ${Phone1} - ${Phone2} - ${Phone3}
	            	</span>
	            </li>
				<li class="d03"><span class="nick width">닉네임</span> <span>${member.NICK}</span></li>
				<li class="d04"><span class="joinDate width">가입일</span> <span>${member.MEMBERREGDATE}</span></li>
			</ul>
		</div>
	
	</div>
	</section>
</body>
</html>