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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_noticeList.css">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/admin_notice.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="notice-list-area">
		<div class="content_container">
			<div class="submenu-list clearfix">
				<a href="${pageContext.request.contextPath}/admin/board/noticeList">공지사항</a>
				<a href="${pageContext.request.contextPath}/admin/board/eventList">이벤트</a>
				<a href="${pageContext.request.contextPath}/admin/board/faqList">FAQ</a>
			</div>
			<h2>공지사항</h2>
			<a href="<%=path%>/admin/board/noticeWriteForm" class="add-btn">새 글 쓰기</a>
			<form action="noticeList">
				<div class="notice_search">
					<input type="text" name="keyword" placeholder="제목을 입력해주세요.">
					<input type="submit" id= "search" value="검색" >
				</div>
			</form>
			<table>
				<caption>순번, 제목, 조회수, 날짜, 비고</caption>
				<colgroup>
					
					<col style="width:7%">
					<col style="width:*%">
					<col style="width:5%">
					<col style="width:7%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>조회수</th>
						<th>날짜</th>
						<th>비고</th>
					</tr>
				</thead>
				<c:forEach items="${totalMap.noticeList}" var="notice">
				<tbody class="tbtn">
							<c:choose>
							<c:when test="${notice.NOTICETYPE eq 'IMPORTANT'}">
							<tr class="important">
								<td>[공지]</td>
								<td title="${notice.NOTICETITLE}"><a href="noticeViewForm?NOTICENUM=${notice.NOTICENUM}">${notice.NOTICETITLE}</a></td>
								<td>${notice.NOTICEVIEWCOUNT}</td>
								<td>${notice.NOTICEREGDATE}</td>
								<td><input type="button" value="삭제" onclick="deleteNotice('${notice.NOTICENUM}')"></td>
							</tr>
							</c:when>
							<c:otherwise>
							<tr>
								<td>${notice.RNUM1}</td>
								<td><a href="noticeViewForm?NOTICENUM=${notice.NOTICENUM}">${notice.NOTICETITLE}</a></td>
								<td>${notice.NOTICEVIEWCOUNT}</td>
								<td>${notice.NOTICEREGDATE}</td>
								<td><input type="button" value="삭제" onclick="deleteNotice('${notice.NOTICENUM}')"></td>
							</tr>
							</c:otherwise>
							</c:choose>
				</tbody>
				</c:forEach>
			</table>
			<c:if test="${empty totalMap.noticeList and !empty totalMap.keyword}">
                  <center><p id="none">검색결과가 없습니다.</p></center>
            </c:if>
			<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="noticeList?pageNum=1">[처음]</a>
					<a href="noticeList?pageNum=${totalMap.strtPage-1}&keyword=${totalMap.keyword}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum == totalMap.currentPage}">
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

</body>	
</html>