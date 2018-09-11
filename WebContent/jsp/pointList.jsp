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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/pointList.css">
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
	<!-- 2차 메뉴 -->
	<section class="two-depth-menu">
		<h2 class="hidden">two-depth-menu</h2>
		<div class="container">
			<ul class="clearfix">
				<li><a href="<%=path%>/point/pointList" class="menu_pointlist">적립금 관리</a></li>
				<li><a href="<%=path%>/order/orderList" class="menu_orderlist">주문내역</a></li>
				<li><a href="<%=path%>/member/interest?memberPK=${sessionScope.SEQ}" class="menu_likelist">관심트럭</a></li>
				<li><a href="<%=path%>/board/question" class="menu_question">1:1 문의내역</a></li>
				<li><a href="<%=path%>/member/pwCheck" class="menu_mypage">개인정보 수정/탈퇴</a></li>
			</ul>
		</div>
	</section>
	<!-- 포인트 게시판  -->
	<section class="pointlist-area">
		<h2 class="hidden">"pointlist-area"</h2>
		<div class="container">
			<h3>적립금 관리</h3>
			<p id="point">보유적립금 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>${totalMap.totalPoint.POINTTOTAL}</span> P</p>
			<table>
				<caption>사용내역, 사용처, 사용구분, 날짜</caption>
				<colgroup>
					<col style="width:15%">
					<col style="width:*%">
					<col style="width:10%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>사용내역</th>
						<th>사용처</th>
						<th>사용구분</th>
						<th>날짜</th>
					</tr>
				</thead>
				<c:forEach items="${totalMap.pointList}" var="point">
					
					<c:choose>
					
						<c:when test="${point.POINTSEPARATION eq 'MINUS'}">
							<tbody>
							<tr>
								<td>- ${point.POINTAMOUNT}</td>
								<td>${point.BRANDNAME}</td>
								<td>
									<c:choose>
										<c:when test="${point.DELIVREGICHECK eq 'D'}">
										배달
										</c:when>
										<c:otherwise>
										예약
										</c:otherwise>
									</c:choose>
									주문
								</td>
								<td>${point.POINTDATE}</td>
							</tr>
							</tbody>
						</c:when>
						<c:otherwise>
							<tbody>
							<tr>
								<td>+ ${point.POINTAMOUNT}</td>
								<td>${point.BRANDNAME}</td>
								<td>
									후기작성
								</td>
								<td>${point.POINTDATE}</td>
							</tr>
							</tbody>
						</c:otherwise>
					</c:choose>
					</c:forEach>
			</table>
		</div>
		<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="pointList?pageNum=1">[처음]</a>
					<a href="pointList?pageNum=${totalMap.strtPage-1}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum == totalMap.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a class="remainPage" href="pointList?pageNum=${pageNum}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${totalMap.endPage < totalMap.totalCount}">
					<a href="pointList?pageNum=${totalMap.endPage+1}">[다음]</a>
					<a href="pointList?pageNum=${totalMap.endPage}">[마지막]</a>
				</c:if>
			</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>