<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css'
	rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/notice_reset.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_memberPointList.css">
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
		<div class="headermenu_left">
			<h2>${member.MEMBEREMAIL}(${member.NICK})</h2>
		</div>
		<div class="table_option">
			<div class="sumList">
				<span>총 주문금액 ${member.total}</span>&nbsp;
				<span>총 주문수 <script type="text/javascript">document.write(${member.countD}+${member.countR})</script></span>&nbsp;
				<span>총배달수 ${member.countD}</span>&nbsp;
				<span>총 예약수 ${member.countR}</span>&nbsp;
				<span>적립금 ${member.POINTTOTAL}</span>&nbsp;
				<span>관심트럭 ${member.favor}</span>
			</div>
		</div>
			<div class="submenu-list clearfix">
			<a onclick="location.href = 'memberInfo?memberNum=${member.MEMBERNUM}'">회원정보</a> 
			<a onclick="location.href = 'memberOrderList?MEMBERNUM=${member.MEMBERNUM}'">주문내역</a> 
			<a onclick="location.href = 'memberPointList?MEMBERNUM=${member.MEMBERNUM}'">적립금내역</a>
		</div>
		<table>
			<caption>이메일, 닉네임, 적립금 내역, 지급, 차감, 차감내용, 상세내역, 날짜</caption>
			<colgroup>
				<col style="width: 13%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: *%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th>이메일</th>
					<th>닉네임</th>
					<th>적립금 내역</th>
					<th>지급</th>
					<th>차감</th>
					<th>상세내역</th>
					<th>날짜</th>
				</tr>
			</thead>
		<c:forEach items="${totalMap.pointList}" var="point">

					<c:choose>
						<c:when test="${point.POINTSEPARATION eq 'minus'}">
							<tbody>
							<tr>
								<td>${point.MEMBEREMAIL}</td>
								<td>${point.NICK}</td>
								<td>차감-
									<c:choose>
										<c:when test="${point.DELIVREGICHECK eq 'D'}">
										배달
										</c:when>
										<c:otherwise>
										예약
										</c:otherwise>
									</c:choose>
								</td>
								<td></td>
								<td>${point.POINTAMOUNT}</td>
								<td>주문번호 :
									${point.ORDERNUMBER}
								</td>
								<td>${point.POINTDATE}</td>
							</tr>
							</tbody>
						</c:when>
						<c:otherwise>
							<tbody>
							<tr>
								<td>${point.MEMBEREMAIL}</td>
								<td>${point.NICK}</td>
								<td>지급</td>
								<td>${point.POINTAMOUNT}</td>
								<td></td>
								<td title="<c:forEach items="${point.menuList}" var="menu">${menu.MENUNAME}</c:forEach>" id="menu">
								상품명 : 
								<c:forEach var="menu" items="${point.menuList}" varStatus="index">
                        		<c:choose>
                           		<c:when test="${index.last ==true}">
                              		 ${menu.MENUNAME}
                          		 </c:when>
                          		 <c:otherwise>
                             	   ${menu.MENUNAME},
                          	 	</c:otherwise>
                       	 		</c:choose>
                  				</c:forEach> 
								</td>
								<td>${point.POINTDATE}</td>
							</tr>
							</tbody>
						</c:otherwise>
					</c:choose>
					</c:forEach>
			</table>
			<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="memberPointList?pageNum=1">[처음]</a>
					<a href="memberPointList?pageNum=${totalMap.strtPage-1}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum == totalMap.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a class="remainPage" href="memberPointList?pageNum=${pageNum}}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${totalMap.endPage < totalMap.totalCount}">
					<a href="memberPointList?pageNum=${totalMap.endPage+1}">[다음]</a>
					<a href="memberPointList?pageNum=${totalMap.endPage}">[마지막]</a>
				</c:if>
			</div>
		</div>
	</section>
</body>
</html>