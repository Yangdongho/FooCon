<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_menuView.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/admin_menuView.js"></script>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<c:set var="session" value="${sessionScope.AUTHORITY}"></c:set>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 메뉴 뷰페이지 -->
	<section class="menu-list-area">
		<div class="content_container">
			<h2>메뉴 등록 및 수정</h2>	
			<form class="menuViewForm" onsubmit='return frmsubmit();'>
				<input type="hidden" name="MENUCODE" value="${menuData.MENUCODE}">
				<input type="hidden" name="BRANDMENUNUM" value="${menuData.BRANDMENUNUM}">
				<input type="hidden" name="BRANDNUM" value="${menuData.BRANDNUM}">
				<input type="text" class="menuName" name="MENUNAME" placeholder="메뉴명을 입력해주세요." value="${menuData.MENUNAME}" maxlength="50">
				<div class="menu_view_option clearfix">
					<div class="option">
						<label>가격</label>
						<input type="text" class="menuPrice" name="MENUPRICE" placeholder="가격을 입력해주세요.(숫자만 입력)" value="${menuData.MENUPRICE}" onkeydown="onlyNumber(this)" maxlength="10">
					</div>
				</div>
				<c:if test="${session ne 'MASTER'}">
				<input type="submit" value="저장">
				</c:if>
			</form>
		</div>
	</section>
</body>	
</html>