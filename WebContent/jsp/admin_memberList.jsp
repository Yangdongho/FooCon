<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/notice_reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_memberList.css">
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
		<h2>회원리스트</h2>
		<div class="table_option">

			<div class="notice_search">
				<form action="memberList">
						<input type="text" name="keyword" placeholder="이메일 또는 닉네임을 입력해주세요">
						<input type="submit" value="검색">
				</form>
			</div>
		</div>
		<table>
			<caption>순번, 이메일, 닉네임, 연락처, 주문금액, 배달건수, 예약건수, 가입일</caption>
			<colgroup>
				<col style="width: 5%">
				<col style="width: *%">
				<col style="width: 12%">
				<col style="width: 22%">
				<col style="width: 9%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 12%">
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>이메일</th>
					<th>닉네임</th>
					<th>연락처</th>
					<th>주문금액</th>
					<th>배달건수</th>
					<th>예약건수</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
				
				<c:forEach var="member" items="${viewData.memberList}">
					<tr>
						<td>${member.RNUM}</td>
						<td onclick="location.href = 'memberInfo?memberNum=${member.MEMBERNUM}'">${member.MEMBEREMAIL}</td>
						<td>${member.NICK}</td>
						<td>
	                        <c:set var="Phone1" value="${fn:substring((member.MEMBERPHONE),0,3)}"></c:set>
	                        <c:set var="Phone2" value="${fn:substring((member.MEMBERPHONE),3,7)}"></c:set>
	                        <c:set var="Phone3" value="${fn:substring((member.MEMBERPHONE),7,11)}"></c:set>
	                           ${Phone1} - ${Phone2} - ${Phone3}
	                    </td>
	                    <td>${member.total}</td>
						<td>${member.countD}</td>
						<td>${member.countR}</td>
						<td>${member.MEMBERREGDATE}</td>
					</tr>
				</c:forEach>					
				
			</tbody>
			
		</table>
		
		
			<div class = "page">
				<c:if test="${viewData.startPage !=1 }">
				<a href = "memberList?pageNumber=1&keyword=${viewData.keyword}
						<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
				">[처음]</a>
				<a href = "memberList?pageNumber=${viewData.startPage-1}&keyword=${viewData.keyword}">[이전]</a>
				</c:if>	

				<c:forEach var = "pageNum" begin="${viewData.startPage}" end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
				<c:choose>
					<c:when test="${pageNum == viewData.currentPage}">
						<b class="currentPage">${pageNum}</b>
					</c:when>
					<c:otherwise>
						<a class="remainPage" href="memberList?pageNumber=${pageNum}&keyword=${viewData.keyword}
							<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
						">${pageNum}</a>	
					</c:otherwise>
				</c:choose>
				</c:forEach>
				
				<c:if test = "${viewData.endPage < viewData.pageTotalCount}">
				<a href = "memberList?pageNumber=${viewData.endPage+1}&keyword=${viewData.keyword}">[다음]</a>
				<a href = "memberList?pageNumber=${viewData.pageTotalCount}&keyword=${viewData.keyword}">[마지막]</a>
				</c:if>

			</div>
	</div>
	

	</section>
</body>
</html>