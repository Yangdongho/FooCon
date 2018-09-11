<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_faqView.css">

<script src="<%=path%>/js/admin_faqView.js"></script>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
	
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 뷰페이지 -->
	<section class="faq-list-area">
		<div class="content_container">
			<div class="submenu-list clearfix">
				<a href="${pageContext.request.contextPath}/admin/board/noticeList">공지사항</a>
				<a href="${pageContext.request.contextPath}/admin/board/eventList">이벤트</a>
				<a href="${pageContext.request.contextPath}/admin/board/faqList">FAQ</a>
			</div>
			<h2>FAQ 상세보기 및 수정</h2>	
			<form action="faqView" onsubmit="return nullcheck();">
				<input type="hidden" name="faqNum" value="${faqOne.FAQNUM}">
				<input type="text" name="title" id="title"placeholder="제목을 입력해주세요." value="${faqOne.FAQTITLE}">
				<ul class="clearfix">
					<li>${faqOne.FAQREGDATE}</li>
				</ul>
				
				<textarea class="faqContent" name="content">${faqOne.FAQCONTENT}</textarea>
				
				<div class="faq_view_option clearfix">
					
				</div>
				<div class="btn">
					<input type="submit" value="저장">
					<input type="button"  id="list-btn" value="목록" onclick="history.back()">
				</div>
			</form>
		</div>
	</section>
</body>	
</html>