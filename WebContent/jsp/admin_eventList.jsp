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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_eventList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/admin_eventList.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - FooCon</title>
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
			
			<div class="table_option">
				<div class="notice_category">				
					<h2>이벤트</h2>
					<a href="eventView" class="add-btn">새 글 쓰기</a>
				</div>
				<div class="notice_search">
					<form action="eventList">
						<input type="text" name="keyword" placeholder="제목을 입력해주세요.">
						<input type="submit" value="검색">
					</form>
					
				</div>
			</div>
			<table>
				<caption>순번, 제목, 기간, 조회수, 등록일, 비고</caption>
				<colgroup>
					<col style="width:5%">
					<col style="width:*%">
					<col style="width:15%">
					<col style="width:5%">
					<col style="width:15%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>기간</th>
						<th>조회수</th>
						<th>등록일</th>
						<th>비고</th>
					</tr>
				</thead>
				
				<tbody>
				
					
					<c:forEach items="${viewData.eventList}" var="event">
						<tr>
							<td>${event.RNUM}</td>
							<td><a href="eventView?eventNum=${event.EVENTNUM}">${event.EVENTTITLE}</a></td>
							<td>${event.EVENTSTARTDATE} ~ ${event.EVENTENDDATE}</td>
							<td>${event.EVENTVIEWCOUNT}</td>
							<td>${event.EVENTREGDATE}</td>
							<td><input class="deleteBtn" type="button" value="삭제" onclick="location.href='deleteEvent?eventNum=${event.EVENTNUM}'"></td>
							
						</tr>
					</c:forEach>
				</tbody>
					
			</table>
			<c:if test="${empty viewData.eventList && !empty viewData.keyword}">
						<p id="empty">검색 결과가 없습니다.</p>
			</c:if>
			<div class = "page">
				<c:if test="${viewData.startPage !=1 }">
				<a href = "eventList?pageNumber=1&keyword=${viewData.keyword}
						<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
				">[처음]</a>
				<a href = "eventList?pageNumber=${viewData.startPage-1}&keyword=${viewData.keyword}">[이전]</a>
				</c:if>	

				<c:forEach var = "pageNum" begin="${viewData.startPage}" end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
				<c:choose>
					<c:when test="${pageNum == viewData.currentPage}">
						<b class="currentPage">${pageNum}</b>
					</c:when>
					<c:otherwise>
						<a class="remainPage" href="eventList?pageNumber=${pageNum}&keyword=${viewData.keyword}
							<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
						">${pageNum}</a>	
					</c:otherwise>
				</c:choose>
				</c:forEach>
				
				<c:if test = "${viewData.endPage < viewData.pageTotalCount}">
				<a href = "eventList?pageNumber=${viewData.endPage+1}&keyword=${viewData.keyword}">[다음]</a>
				<a href = "eventList?pageNumber=${viewData.pageTotalCount}&keyword=${viewData.keyword}">[마지막]</a>
			</c:if>

			</div>
		</div>
	</section>
</body>	
</html>