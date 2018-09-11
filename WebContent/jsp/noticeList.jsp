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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/noticeList.css">
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

	<!-- 공지사항 게시판  -->
	<section class="noticelist-area">
		<h2 class="hidden">"noticelist-area"</h2>
		<div class="container">
			<h3>공지사항</h3>
			<table>
				<caption>제목, 날짜, 조회수 , 첨부</caption>
				<colgroup>
					<col style="width:7%">
					<col style="width:*%">
					<col style="width:10%">
					<col style="width:15%">
					<col style="width:8%">
					
				</colgroup>
				<thead>
					<tr>
						<th></th>
						<th>제목</th>
						<th>날짜</th>
						<th>조회수</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${totalMap. noticeList}" var="notice">
					<c:choose>
					<c:when test="${notice.NOTICETYPE eq 'IMPORTANT'}">
					<tr class="important">
					<td>[ 공 지 ]</td>
					<td title="${notice.NOTICETITLE}"><a href="noticeView?NOTICENUM=${notice.NOTICENUM}" >${notice.NOTICETITLE}</a></td>
					<td>${notice.NOTICEREGDATE}</td>
					<td>${notice.NOTICEVIEWCOUNT}</td>
					<c:choose>
						<c:when test="${empty notice.UPLOADFILE1}">
							<td class="img"> </td>
						</c:when>
						<c:otherwise>
							<td class="img"><img id="icon"src="<%=path%>/img/file.png"/><td>
						</c:otherwise>
					</c:choose>
					</tr>
					</c:when>
					<c:otherwise>
					<tr>
					<td>${notice.RNUM1}</td>
					<td><a href="noticeView?NOTICENUM=${notice.NOTICENUM}" title="${notice.NOTICETITLE}">${notice.NOTICETITLE}</a></td>
					<td>${notice.NOTICEREGDATE}</td>
					<td>${notice.NOTICEVIEWCOUNT}</td>
					<c:choose>
						<c:when test="${notice.UPLOADFILE1 ne null}">
							<td class="img"><img id="icon"src="<%=path%>/img/file.png"/><td>
						</c:when>
						<c:otherwise>
							<td class="img"> </td>
						</c:otherwise>
					</c:choose>
					</tr>
					</c:otherwise>
					</c:choose>
				</c:forEach>
				</tbody>
			</table>
			
			<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="noticeList?pageNum=1">[처음]</a>
					<a href="noticeList?pageNum=${totalMap.strtPage-1}&keyword=${totalMap.keyword}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum eq totalMap.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a class="remainPage" href="noticeList?pageNum=${pageNum}&keyword=${totalMap.keyword}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${totalMap.endPage < totalMap.totalCount}">
					<a href="noticeList?pageNum=${totalMap.endPage+1}&keyword=${totalMap.keyword}">[다음]</a>
					<a href="noticeList?pageNum=${totalMap.endPage}&keyword=${totalMap.keyword}">[마지막]</a>
				</c:if>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>