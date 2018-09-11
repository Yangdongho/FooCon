<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/notice_reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_memberOrderList.css">
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
				<caption>브랜드명, 주문번호, 메뉴, 실 결제금액, 휴대번호, 주문형태, 주문일</caption>
				<colgroup>
					<col style="width:15%">
					<col style="width:10%">
					<col style="width:*%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:8%">
					<col style="width:12%">
				</colgroup>
				<thead>
					<tr>
						<th>브랜드명</th>
						<th>주문번호</th>
						<th>메뉴</th>
						<th>실 결제금액</th>
						<th>휴대번호</th>
						<th>주문형태</th>
						<th>주문일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${totalMap.orderList}" var="order">
					<tr>
						<td>${order.BRANDNAME}</td>
						<td>${order.ORDERNUMBER}</td>
						<td title="<c:forEach items="${order.menuList}" var="menu">${menu.MENUNAME}</c:forEach>" id="menu">
							상품명 : 
							<c:forEach var="menu" items="${order.menuList}" varStatus="index">
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
						<td>
							<script type="text/javascript">
								document.write(${order.PAYMENTAMOUNT}-${order.USEDPOINT});
							</script>
						</td>
						<td>
						<c:set var="Phone1" value="${fn:substring((order.MEMBERPHONE),0,3)}"></c:set>
						<c:set var="Phone2" value="${fn:substring((order.MEMBERPHONE),3,7)}"></c:set>
						<c:set var="Phone3" value="${fn:substring((order.MEMBERPHONE),7,11)}"></c:set>
						${Phone1} - ${Phone2} - ${Phone3}
						</td>
						<td>
							<c:choose>
								<c:when test="${order.DELIVREGICHECK eq 'D'}">
									<c:if test="${order.canclestatus eq'N'}">
									배달 취소
									</c:if>
									배달
								</c:when>
								<c:otherwise>
									<c:if test="${order.canclestatus eq'N'}">
									예약 취소
									</c:if>
									예약
								</c:otherwise>
							</c:choose>
						</td>
						<td>${order.ORDERDATE}</td>
					</tr>
				</c:forEach>
					
				</tbody>
			</table>
			<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="memberOrderList?pageNum=1">[처음]</a>
					<a href="memberOrderList?pageNum=${totalMap.strtPage-1}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum == totalMap.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a class="remainPage" href="memberOrderList?pageNum=${pageNum}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${totalMap.endPage < totalMap.totalCount}">
					<a href="memberOrderList?pageNum=${totalMap.endPage+1}">[다음]</a>
					<a href="memberOrderList?pageNum=${totalMap.endPage}">[마지막]</a>
				</c:if>
			</div>
		</div>
	</section>

</body>	
</html>