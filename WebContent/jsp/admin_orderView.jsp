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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_orderView.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - FooCon</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="notice-list-area">
		<div class="content_container">
		
			<h2>${order.BRANDNAME}[${order.ORDERNUMBER}]</h2><br>
			<div class="view1">
				<h3>금액</h3>
				<ul>
					<li><span>판매가</span><b>${order.PAYMENTAMOUNT}</b></li>
					<li><span>적립금 사용</span><b>-${order.USEDPOINT}</b></li>
					<li><span>실 결제금액</span><b><script type="text/javascript"> document.write(${order.PAYMENTAMOUNT}-${order.USEDPOINT});</script></b></li>
				</ul>
			</div>
			
			<div class="view2">
				<h3>결제정보</h3>
				<ul>
					<li><span>결제방법</span><b>${order.PAYMENT }</b></li>
					<li><span>승인일시</span><b>${order.APPROVALDATE }</b></li>
				</ul>
			</div>
				
			<div class="clearfix">	
			<div class="view3">
				<h3>상세 주문 메뉴</h3>
				
				<table>
				<colgroup>
					<col style="width:15%">
					<col style="width:20%">
					<col style="width:10%">
					<col style="width:15%">
					<col style="width:10%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>메뉴</th>
						<th>수량</th>
						<th>판매금액</th>
						<th>주문형태</th>
						<th>주문일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${order.menuList}" var="menu">
					<tr>
					
						<td>${order.ORDERNUMBER }</td>
						<td>${menu.MENUNAME}</td>
						<td>${menu.ORDERQUANTITY}</td>
						<td>${menu.MENUPRICE}</td>
						<td>
							<c:if test="${order.DELIVREGICHECK eq 'D' }">배달</c:if>
							<c:if test="${order.DELIVREGICHECK eq 'R' }">예약</c:if>
						</td>
						<td>${order.ORDERDATE}</td>
					</tr>
					</c:forEach>
				</tbody>
				
				</table>
			</div>	
				
				
				
			<div class="view4">
				<h3>주문자 정보</h3>
				<ul>
					<c:if test="${!empty order.RESERNAME }">
						<li><span>예약자명</span><b>${order.RESERNAME}</b></li>
					</c:if>
					
					
					<c:choose>
						<c:when test="${empty order.NONMEMBERNUM }">
							<li><span>휴대번호</span><b>${order.MEMBERPHONE }</b></li>
							<li><span>아이디</span><b>${order.MEMBEREMAIL }</b></li>
							<li><span>닉네임</span><b>${order.NICK }</b></li>
					
						</c:when>
						<c:otherwise>
							<li><span>휴대번호</span><b>${order.NONMEMBERPHONE }</b></li>
							<li><span>아이디</span><b>${order.NONMEMBEREMAIL }</b></li>
						
						</c:otherwise>
					</c:choose>	
						
					
					
					
					
					<c:if test="${order.DELIVREGICHECK eq 'D'}">
						<li><span>주소</span><b>${order.DELIADDRESS }</b></li>
						<li><span>요청사항</span><b>${order.DELIMEMO }</b></li>
					</c:if>
				</ul>
			</div>
			
			<div class="view5">
				<h3>메모</h3>
				<form action="writeMemo">
					<input type="hidden" name="orderNumber" value="${order.ORDERNUMBER}">
					<textarea id="memo" name="memo">${order.MEMO}</textarea><br>
					<input type="submit" value="저장">
				</form>
				
			</div>
			</div>
			
		</div>
		
	</section>
</body>	
</html>