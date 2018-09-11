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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_adReferenceList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>   
<script src="<%=path%>/js/admin_adReferenceList.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 광고/제휴문의 리스트 -->
	<section class="advertise-list-area">
		<div class="content_container">
			<div class="submenu-list clearfix">
					<a href="<%=path%>/admin/board/questionList">1:1문의 관리</a>
					<a href="<%=path%>/admin/board/adReferenceList">광고/제휴문의 관리</a>
					
				</div>
			<h2>광고/제휴문의 관리</h2>
			<div class="table_option">
				<form action="adReferenceList">
					<div class="advertise_category">				
						<select name="type" id="selectBox">
						    <option value="">전체</option>
						    <option value="AD">광고</option>
						    <option value="COR">제휴</option>
						</select>
					</div>
					<input type="hidden" value="${viewData.selectBox}" class="selectBox">
					<div class="advertise_search">
						<input type="text" name="keyword" placeholder="업체명, 이름을 입력해주세요.">
						<input type="submit" value="검색">
					</div>
				</form>
			</div>
			<table>
				<caption>문의유형, 문의내용, 업체명, 이름, 연락처, 날짜</caption>
				<colgroup>
					<col style="width:5%">
					<col style="width:7%">
					<col style="width:*%">
					<col style="width:20%">
					<col style="width:5%">
					<col style="width:12%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>문의유형</th>
						<th>문의내용</th>
						<th>업체명</th>
						<th>이름</th>
						<th>연락처</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${!empty viewData.adReferenceList}">
							<c:forEach items="${viewData.adReferenceList}" var="adReference">
							<tr>
								<td>${adReference.RNUM1}</td>
								<c:choose>
									<c:when test="${adReference.INQUIRETYPE eq 'AD'}">
										<td>광고문의</td>
									</c:when>
									<c:otherwise>
										<td>제휴문의</td>
									</c:otherwise>
								</c:choose>
								<td onclick="location.href='adReferenceView?addInquireNUM=${adReference.ADDINQUIRENUM}'">${adReference.INPUIRECONTENT}</td>
								<td>${adReference.INPUIREBRAND}</td>
								<td>${adReference.INQUIRENAME}</td>
								<td>${adReference.INQUIREPHONE}</td>
								<td>${adReference.ADINQUIREDATE}</td>
							</tr>
							</c:forEach>
							<tr>
								<td colspan="7"><c:if test="${viewData.startPage != 1}">
									<a href="adReferenceList?page=1 
										<c:if test="${viewData.type != null}">
											&type=${viewData.type}
										</c:if>
										<c:if test="${viewData.keyword != null}">
											&keyword=${viewData.keyword}
										</c:if>
									">[처음]</a>
									<a href="adReferenceList?page=${viewData.startPage-1} 
										<c:if test="${viewData.type != null}">
											&type=${viewData.type}
										</c:if>
										<c:if test="${viewData.keyword != null}">
											&keyword=${viewData.keyword}
										</c:if>
									">[이전]</a>
								</c:if>
								
								<c:forEach var="pageNum" begin="${viewData.startPage}"
									end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
									<c:choose>
										<c:when test="${pageNum == viewData.currentPage}">
											<b>[${pageNum}]</b>
										</c:when>
										<c:otherwise>
											<a href="adReferenceList?page=${pageNum}
											<c:if test="${viewData.type != null}">
												&type=${viewData.type}
											</c:if>
											<c:if test="${viewData.keyword != null}">
												&keyword=${viewData.keyword}
											</c:if>
											">[${pageNum}]</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<c:if test="${viewData.endPage < viewData.pageTotalCount}">
								<a href="boardList?page=${viewData.endPage+1}
									<c:if test="${viewData.type != null}">
										&type=${viewData.type}
									</c:if>
									<c:if test="${viewData.keyword != null}">
										&keyword=${viewData.keyword}
									</c:if>
								">[다음]</a>
								<a href="boardList?page=${viewData.pageTotalCount}
									<c:if test="${viewData.type != null}">
										&type=${viewData.type}
									</c:if>
									<c:if test="${viewData.keyword != null}">
										&keyword=${viewData.keyword}
									</c:if>
								">[마지막]</a>
							</c:if></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" class="emptyText">문의한 내역이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</section>
</body>	
</html>