<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_orderList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/sockjs.js"></script> 
<script src="<%=path%>/js/stomp.js"></script>
<script type="text/javascript">
  
  var context = '${pageContext.request.contextPath}';
  var SEQ = '${sessionScope.SEQ}';
 
</script>  
<script src="<%=path%>/js/admin_orderList.js"></script>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - FooCon</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="notice-list-area">
		<div class="content_container">
		
			<h2>주문리스트</h2><br>
			<div class="table_option">
				<div class="notice_category">
					<form action="orderList">
					<input type="hidden" name="keyword" value="${viewData.keyword}">				
						<select name="category">
					 	   <option value="">전체</option>
					 	   <option value="D" <c:if test="${viewData.category == 'D'}">selected</c:if>>배달</option>
						   <option value="R" <c:if test="${viewData.category == 'R'}">selected</c:if>>예약</option>
						</select>
						<input type="submit" value="적용">
					</form>
				</div>
				<div class="notice_search">
						<form action="orderList">
							<input type="hidden" name="category" value="${viewData.category}">
							<input type="text" name="keyword" placeholder="주문번호,이메일을 입력해주세요.">
							<input type="submit" value="검색">
						</form>
				</div>
			</div>
			<table>
				<caption>회원구분,브랜드명, 주문번호, 메뉴, 판매금액, 실 결제금액, 이메일, 휴대번호, 주문형태, 주문일</caption>
				<colgroup>
					<col style="width:5%">
					<col style="width:12%">
					<col style="width:12%">
					<col style="width:*%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:15%">
					<col style="width:3%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>회원구분</th>
						<th>브랜드명</th>
						<th>주문번호</th>
						<th>메뉴</th>
						<th>판매금액</th>
						<th>실 결제금액</th>
						<th>이메일</th>
						<th>휴대번호</th>
						<th>주문형태</th>
						<th>주문일</th>
					
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${viewData.orderList}" var="order">
					<tr>
						<c:choose>
							<c:when test="${empty order.MEMBERNUM}">
								<td>비회원</td>
								
							</c:when>
							<c:otherwise>
								<td>회원</td>
							</c:otherwise>						
						</c:choose>
						<td>${order.BRANDNAME}</td>
						
						<td onclick="location.href='orderView?orderNum=${order.ORDERNUM}'">${order.ORDERNUMBER}</td>			
						<td title="<c:forEach var="menu" items="${order.menuList}" varStatus="index"><c:choose><c:when test="${index.last ==true}">${menu.MENUNAME}</c:when><c:otherwise>${menu.MENUNAME},</c:otherwise></c:choose></c:forEach>">	
						
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
						<td>${order.PAYMENTAMOUNT}</td>
						<td><script type="text/javascript"> document.write(${order.PAYMENTAMOUNT}-${order.USEDPOINT});</script></td>
						
						<c:choose>
							<c:when test="${empty order.MEMBERNUM}">
					
								<td>${order.NONMEMBEREMAIL  }</td>
								<td><c:set var="Phone1" value="${fn:substring((order.NONMEMBERPHONE ),0,3)}"></c:set>
	                      			  <c:set var="Phone2" value="${fn:substring((order.NONMEMBERPHONE ),3,7)}"></c:set>
	                       			 <c:set var="Phone3" value="${fn:substring((order.NONMEMBERPHONE ),7,11)}"></c:set>
	                        	   ${Phone1} - ${Phone2} - ${Phone3}
	                        	  </td>
							</c:when>
							<c:otherwise>
								<td>${order.MEMBEREMAIL }</td>
								<td><c:set var="Phone1" value="${fn:substring((order.MEMBERPHONE ),0,3)}"></c:set>
	                      			  <c:set var="Phone2" value="${fn:substring((order.MEMBERPHONE ),3,7)}"></c:set>
	                       			 <c:set var="Phone3" value="${fn:substring((order.MEMBERPHONE ),7,11)}"></c:set>
	                        	   ${Phone1} - ${Phone2} - ${Phone3}
	                        	  </td>
								
							</c:otherwise>						
						</c:choose>
												
						<td>
							<c:choose>
								<c:when test="${order.CANCLESTATUS eq 'Y'}">
									<c:if test="${order.DELIVREGICHECK eq 'D'}">배달취소</c:if>
									<c:if test="${order.DELIVREGICHECK eq 'R'}">예약취소</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${order.DELIVREGICHECK eq 'D'}">배달</c:if>
									<c:if test="${order.DELIVREGICHECK eq 'R'}">예약</c:if>
								</c:otherwise>
							</c:choose>
	
						</td>	
						<td>${order.ORDERDATE }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>	
			
			
			<c:choose>
				
				<c:when test="${empty viewData.orderList && !empty viewData.keyword}">
						<p id="empty">검색 결과가 없습니다.</p>
				</c:when>
				
				<c:otherwise>
				<c:if test="${!empty viewData.orderList}">
					<div class = "page">
						<a id="excel" href="excel">전체 주문 내역 Excel 다운로드</a>
						<c:if test="${viewData.startPage !=1 }">
						
						<a href = "orderList?pageNumber=1&keyword=${viewData.keyword}&category=${viewData.category}
								<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
						">[처음]</a>
						<a href = "orderList?pageNumber=${viewData.startPage-1}&keyword=${viewData.keyword}&category=${viewData.category}">[이전]</a>
						</c:if>	
		
						<c:forEach var = "pageNum" begin="${viewData.startPage}" end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
						<c:choose>
							<c:when test="${pageNum == viewData.currentPage}">
								<b class="currentPage">${pageNum}</b>
							</c:when>
							<c:otherwise>
								<a class="remainPage" href="orderList?pageNumber=${pageNum}&keyword=${viewData.keyword}&category=${viewData.category}
									<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
								">${pageNum}</a>	
							</c:otherwise>
						</c:choose>
						</c:forEach>
						
						<c:if test = "${viewData.endPage < viewData.pageTotalCount}">
							<a href = "orderList?pageNumber=${viewData.endPage+1}&keyword=${viewData.keyword}&category=${viewData.category}">[다음]</a>
							<a href = "orderList?pageNumber=${viewData.pageTotalCount}&keyword=${viewData.keyword}&category=${viewData.category}">[마지막]</a>
						</c:if>

					</div>
				</c:if>
				</c:otherwise>
			</c:choose>
			
		</div>
	</section>
</body>	
</html>