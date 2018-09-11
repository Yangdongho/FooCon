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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_faqList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  

<script src="<%=path%>/js/admin_faq.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="faq-list-area">
		<div class="content_container">
			<div class="submenu-list clearfix">
				<a href="${pageContext.request.contextPath}/admin/board/noticeList">공지사항</a>
				<a href="${pageContext.request.contextPath}/admin/board/eventList">이벤트</a>
				<a href="${pageContext.request.contextPath}/admin/board/faqList">FAQ</a>
			</div>
			<h2>FAQ</h2>
			<a href="<%=path%>/admin/board/faqWriteForm" class="add-btn">새 글 쓰기</a>
			
			<table class="faq">
				<caption>순번, 제목, 날짜, 비고</caption>
				<colgroup>
					<col style="width:7%">
					<col style="width:*%">
					<col style="width:25%">
					<col style="width:15%">
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>날짜</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody class="tbtn">
					<c:forEach items="${faqList}" var="faq">
						<tr>
							<td>${faq.RNUM}</td>
							<td><a href="faqViewForm?faqNum=${faq.FAQNUM}">${faq.FAQTITLE}</a></td>
							<td>${faq.FAQREGDATE}</td>
<%-- 							<td><input type="button" value="삭제" class="delete-btn" onclick="location.href='faqDelete?faqNum=${faq.FAQNUM}'"></td> --%>
							<td><input type="button" value="삭제" class="delete-btn" onclick="deleteFaq('${faq.FAQNUM}')"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>

</body>	
</html>