<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/noticeView.css">
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
	<!-- 공지시항 상세페이지  -->
	<section class="notice-view-area">
		<h2 class="hidden">notice-view-area</h2>
		<div class="container">
			<h3>공지사항</h3>
			<div class="view_head">
				<p class="title" title="${notice.NOTICETITLE}">${notice.NOTICETITLE}</p>
				<ul class="clearfix">
					<li>
					<c:choose>
						<c:when test="${notice.NOTICETYPE eq 'IMPORTANT'}">공지</c:when>
						<c:otherwise>일반</c:otherwise>
					</c:choose>
					</li>
					<li>${notice.NOTICEREGDATE}</li>
					<li>${notice.NOTICEVIEWCOUNT}</li>
				</ul>
				<div class="attachfile_area">
					<p><span>첨부파일</span></p><br>
					<c:if test="${!empty notice.UPLOADFILE1}">
						<a name = uploadfile1 href="download?fileName=${notice.UPLOADFILE1}">첨부 파일 1 : ${fn:substringAfter(notice.UPLOADFILE1,'_')}</a><br>
					</c:if>
					<c:if test="${!empty notice.UPLOADFILE2}">
						<a name = uploadfile2 href="download?fileName=${notice.UPLOADFILE2}">첨부 파일 2 : ${fn:substringAfter(notice.UPLOADFILE2,'_')}</a><br>
					</c:if>
					<c:if test="${!empty notice.UPLOADFILE3}">
						<a name = uploadfile3 href="download?fileName=${notice.UPLOADFILE3}">첨부 파일 3 : ${fn:substringAfter(notice.UPLOADFILE3,'_')}</a>
					</c:if>
				</div>
			</div>
			<div class="view_cont">
				${notice.NOTICECONTENT}
			</div>
			<div class="view_bottom clearfix">
				<c:if test="${page.PRE_NOTICENUM ne '이전글'}">
				<div class="notice_prev">
					<a href="noticeView?NOTICENUM=${page.PRE_NOTICENUM}"><span>[이전 글]</span> ${page.PRE_NOTICETITLE}</a>
				</div>
				</c:if>
				<c:if test="${page.NEXT_NOTICENUM ne '다음글'}">
				<div class="notice_next">
					<a href="noticeView?NOTICENUM=${page.NEXT_NOTICENUM}"><span>[다음 글]</span>${page.NEXT_NOTICETITLE}</a>
				</div>
				</c:if>
				<a class="notice_list_btn" href="noticeList">목록</a>
			</div>			
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>