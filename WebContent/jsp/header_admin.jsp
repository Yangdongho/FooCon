<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path=request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<header>

<script type="text/javascript">

	function logout(context){
		 
		//membercontroller에 logout 함수에 기능
		//관리자도 로그아웃 버튼 누르면 화면 메인으로 넘어간다.
		location.href= context+"/member/logout";   
	 }
	
</script>
	<nav class="clearfix">
		<h1 class="logo" style="margin-top: 7px;"><a href="${pageContext.request.contextPath}/admin/main"><img src="<%=path%>/img/admin_logo.png" alt="logo"></a></h1>
		<ul class="nav-list">
			<li><a href="#">${sessionScope.USERID}님</a></li>
			<li><a href="javascript:logout('${pageContext.request.contextPath}');">로그아웃</a></li>
		</ul>
	</nav>
</header>
<div class="side_menubar">
	<ul>
		
		<c:choose>
			<c:when test="${sessionScope.AUTHORITY eq 'BRAND'}">
<%-- 				<li><a href="${pageContext.request.contextPath}/admin/main">메인화면관리</a></li> --%>
				<li><a href="${pageContext.request.contextPath}/admin/brand/brandView">브랜드관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/brand/menuList">메뉴관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/order/orderList">주문관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/review/reviewList">리뷰관리</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${pageContext.request.contextPath}/admin/brand/mainList">메인화면관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/brand/brandView">브랜드관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/member/memberList">회원관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/point/pointList">적립금관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/brand/menuList">메뉴관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/order/orderList">주문관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/review/reviewList">리뷰관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/board/questionList">문의관리</a></li>
				<li><a href="${pageContext.request.contextPath}/admin/board/noticeList">게시판</a></li>
			</c:otherwise>
		</c:choose>
	
	</ul>
</div>