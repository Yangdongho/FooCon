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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/orderList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  <script src="<%=path%>/js/sockjs.js"></script> 
  <script src="<%=path%>/js/stomp.js"></script>
 <script type="text/javascript">
 	var session = '${sessionScope.SEQ}';
 	var context = '${pageContext.request.contextPath}';
 	$(function(){
 		if(${viewData.ordertList==""}){
 			$(".orderlist-area").css("height",'607px');
 			
 	 	}
 		$("#loading").hide();
 		if(${sessionScope.SEQ == null}){
 			$(".orderlist-area").css("height",'699px');
 			$("#loading").hide();
 		}
 	})
 	
 </script>  
 <script src="<%=path%>/js/orderList.js"></script>
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 서비스명</title>
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
	
	<section class="orderlist-area">
		<h2 class="hidden">"pointlist-area"</h2>
		<div class="container">
			<h3>주문내역</h3>
			<div class="order-container">
				<span class="filter-container">
					<c:if test="${!empty viewData.ordertList}">
						<a id="filter1" class="filter" href="orderList">전체</a>
				  		<a id="filter2" class="filter" href="orderList?DELIVREGICHECK=0">배달</a>
				  		<a id="filter3" class="filter" href="orderList?DELIVREGICHECK=1">예약</a>
					</c:if>
				 </span>
				<c:forEach var="order" items="${viewData.ordertList}">
				
					<div class="orderList">
					<strong><h4>${order.BRANDNAME}</h4></strong>
					
						<span class="menuList">
						<c:forEach var="menu" items="${order.menuList}">
							${menu.MENUNAME} ${menu.ORDERQUANTITY}개 &ensp;
							
						</c:forEach>
						
						</span>
					
						<ul>
							<li>
								<span>주문번호</span>
								<b>${order.ORDERNUMBER }</b>
							</li>					
						 	<li>
								<span>주소</span>
								<b> ${order.BRANDADDRESS}</b>
							</li>
							<li>
								<span>전화번호</span>
								<b>${order.BRANDPHONE}</b>
							</li>
							<li>
								<span>주문날짜</span>
								<b>${order.ORDERDATE }</b>
							</li>
							<li>
								<span>결제금액</span>
								<b>${order.PAYMENTAMOUNT}원</b>
							</li>
						</ul>
						<div class="btn">
											
						<c:if test="${empty order.NONMEMBERNUM}">
								<c:choose> 
								<c:when test="${empty order.checkReview }">
									<button onclick="review_modal('${order.BRANDNUM}','${order.ORDERNUM}','${order.BRANDOWNERNUM}')">리뷰 작성 하기<br><span>(50p적립)</span></button>	
								</c:when>
								<c:otherwise>
									<span class="tag-default">리뷰 작성 완료</span>	
								</c:otherwise>
							</c:choose>
				
						</c:if>
						
							<button onclick="payment_modal('${order.ORDERNUMBER}','${order.NONMEMBERNUM}')">결제 내역 확인</button>
						</div>
					
						<c:choose>
							<c:when test="${order.DELIVREGICHECK == 'D'}">
									<span class="orderOption">배달</span>
							</c:when>
							<c:otherwise>
								<span class="orderOption">예약</span>	
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
					<center><img id="loading" src="<%=path%>/img/25.gif" alt="loading"></center>
					<c:if test="${viewData.currentPage < viewData.pageTotalCount}">
							<center><button id="getOrderBtn" onclick="getOrder(${viewData.currentPage})">더보기</button></center>
					</c:if>
							
							
					<c:if test="${empty viewData.ordertList}">
						<div>
							<p id="empty">주문 내역이 없습니다.</p>
						</div>
					</c:if>
				

			</div>
		</div>
	</section>
	<div class = "bgLayer"></div>
	<!-- 리뷰 모달 -->
	
	<section>	
			
			<div class="question-modal">
				
				<h6 style = "display : inline-block;">리뷰 작성하기</h6>
				<p class="close-btn"></p>
				<div class="replyForm" style='word-break:break-all'>
					<form action="" autocomplete="off" id="reviewForm" enctype="multipart/form-data" method="post">
						<ul>
							<li><jsp:include page="star.jsp"/><span class="score">0.0</span></li>
							<li>
							<textarea id = "content" name="content" placeholder = "내용을 입력하세요 (200자 이내)"></textarea>
							<!-- <input type="text" name="replyContent" placeholder ="내용을 입력하세요 (200자 이내)"> --><br>
							<input type="hidden" name = "brandNum" id="brandNum">
							<input type="hidden" name = "brandOwnerNum" id="brandOwnerNum" disabled="disabled">
							<input type="hidden" name = "orderNum" id="orderNum">

							</li>
							<li><label class="temp">첨부파일</label>
								<input id = "attach" name="file" type="file" class="file_btn" value="파일 첨부" style='word-break:break-all'>
							</li>
							<li><input id="reply-btn" type="button" value="작성완료" onclick="sendReview()"></li>
						</ul>
					</form>
				<div>
			</div>
	</section>
	
	<!-- 결제내역 모달 -->
	<section>
		<div class="payment-modal">
			<h6 style = "display : inline-block;">결제내역 확인</h6>
			<p class="close-btn"></p>
			
			<div class="paymentForm" >
			
				<center><h6>주문번호:1806171231574</h6></center>
				<div class="ulForm1">
					<ul>
						<li id="check">
							<span>주문자명</span>
							<b id="pay1"></b>
						</li>
						<li>
							<span>휴대번호</span>
							<b id="pay2"></b>
						</li>
						<li>
							<span>결제수단</span>
							<b id="pay3"></b>
						</li>
					</ul>
				</div>
			
				<br>
					
				<div class="ulForm2">
					<ul>
						<li>
							<span>판매금액</span>
							<b id="pay4"></b>
						</li>	
						<li>
							<span>적립금할인</span>
							<b id="pay5"></b>
						</li>	
						<hr>
						<li>
							<span>결제금액</span>
							<b id="pay6"></b>
						</li>												
					</ul>
				</div>
			<div>
		</div>
	</section>
	
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>