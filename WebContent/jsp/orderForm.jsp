<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/orderForm.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/orderForm.js"></script>
<!-- 다음 우편찾기 시작 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 다음 우편찾기 끝 -->
<!-- iamport 다날PG 시작 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- iamport 다날PG 끝 -->
<script type="text/javascript">
	$(function(){
		orderList = '${orderListJson}';		
	})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<c:set var="session" value="${sessionScope.USERID}"></c:set>
<input type="hidden" id="session" value="${USERID}">
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 결제 정보 -->
	<section class="payment-area">
		<h2 class="hidden">payment-area</h2>	
		<div class="container clearfix">
			<form name="order_form" method="post" onsubmit='return frmsubmit();'>
				<div class="column_left">
					<div class="payment_form">
						<div class="item-inner clearfix">
							<img src="imagePreview?fileName=${brandImage.THUMNAILIMAGE}">
							<dl class="info-box">
								<dt class="title_rap">${brandInfoView.BRANDNAME}</dt>
								<dd class="txt_rap">
									<p>${brandInfoView.BRANDADDRESS}</p>
									<p class="brandPhone">${brandInfoView.BRANDPHONE}</p>
									<input type="hidden" class="brandNUM" value="${brandInfoView.BRANDNUM}">
								</dd>
							</dl>							
						</div>
					</div>
					<!-- 배달&예약 정보 -->
					<div class="payment_delivery_reservaion">
						<ul class="payment_tab">
							<li>배달</li>
							<li>예약</li>
						</ul>
						<!-- 배달 입력폼 -->
						<div class="payment_form_list">
							<div class="delivery_area">
								<div class="delivery_into">
									<p class="payment_subtitle">배달정보</p>
									<table class="delivery_form">
										<caption>배달정보</caption>
										<tbody>
											<tr>
												<th>주소</th>
												<td>
													<input type="text" id="sample6_postcode" class="address" placeholder="우편번호">
													<input type="button" class="address_btn" onclick="sample6_execDaumPostcode()" value="주소찾기">
												</td>
											</tr>
											<tr>
												<th> </th>
												<td>
													<input type="text" id="sample6_address" placeholder="주소">
													<input type="text" id="sample6_address2" placeholder="상세주소" maxlength="100">
													<span id="guide" style="color:#999"></span>
												</td>
											</tr>
											<c:choose>
												<c:when test="${!empty session}">
													<tr>
														<th>휴대번호</th>
														<td class="user_phone">${member.MEMBERPHONE}</td>
													</tr>
												</c:when>
												<c:otherwise>
													<tr>
														<th>휴대번호</th>
														<td><input type="text" class="phone_certified_delivery phone_certified" placeholder="휴대번호를 입력해주세요('-'제외)" maxlength="11"></td>
													</tr>
													<tr>		
														<th>이메일</th>
														<td><input type="text" class="email_certified_delivery email_certified" placeholder="이메일주소를 입력해주세요('-'제외)" maxlength="50"></td>
													</tr>	
												</c:otherwise>
											</c:choose>
											<tr>
												<th>요청사항</th>
												<td><input type="text" class="requests" placeholder="주문시 요청사항이 있으시면 남겨주세요." maxlength="100"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 예약 입력폼 -->
						<div class="payment_form_list">
							<div class="reservation_area">
								<div class="necessary_into">
									<p class="payment_subtitle">필수정보</p>
									<table class="necessary_form">
										<caption>필수정보</caption>
										<tbody>
											<tr>
												<th class="crrent_time_txt">수령시간</th>
												<td class="crrent_time">
													<p>현재시간 <span></span></p>
													<i>현재시간으로 부터 30분 후에 수령해주세요. (경우애 따라서 지연될 수 있으니 전화로 확인해주세요.)</i>
												</td>
											</tr>
											<tr>
												<th>예약자명</th>
												<td><input type="text" class="booker" placeholder="예약자명을 입력해주세요" maxlength="20"></td>
											</tr>
											<c:choose>
												<c:when test="${!empty session}">
													<tr>
														<th>휴대번호</th>
														<td class="user_phone">${member.MEMBERPHONE}</td>
													</tr>
												</c:when>
												<c:otherwise>
													<tr>
														<th>휴대번호</th>
														<td><input type="text" class="phone_certified_reservation phone_certified" placeholder="휴대번호를 입력해주세요('-'제외)" maxlength="11"></td>
													</tr>
													<tr>		
														<th>이메일</th>
														<td><input type="text" class="email_certified_reservation email_certified" placeholder="이메일주소를 입력해주세요('-'제외)" maxlength="50"></td>
													</tr>	
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 공통사항 할인, 결제수단, 약관동의  -->
						<!-- 할인은 회원일 경우 보이고 비회원일 경우 숨김 -->
						<c:if test="${!empty session}">						
							<div class="point_into">
								<p class="payment_subtitle">할인</p>
								<table class="point_form">
									<caption>적립금 할인 정보</caption>
									<tbody>
										<tr>
											<th>적립금 할인</th>
											<td>
												<input type="text" class="point" placeholder="0" onkeydown="onlyNumber(this)" onblur="onlyNumber(this)" maxlength="100000">
												<span class="point_btn" onclick="pointAllUse()">전액사용</span>
												<span class="point_having">${member.POINTTOTAL}</span>
												<i>P 보유</i>
											</td>
										</tr>
										<tr>
											<th> </th>
											<td><p>1,000P 단위로 사용하실 수 있습니다.</p></td>
										</tr>
									</tbody>
								</table>
							</div>
						</c:if>
						<div class="payment_method_into">
							<p class="payment_subtitle">결제수단</p>
							<div class="payment_method">
								<input type="radio" name="payment_method" value="credit_card" id="credit_card" checked>
								<label for="credit_card">신용카드 결제</label>
								<input type="radio" name="payment_method" value="phone_billing" id="phone_billing">
								<label for="phone_billing">휴대번호 결제</label>
							</div>
						</div>
						<div class="terms_into">
							<p class="payment_subtitle">약관동의</p>
							<div class="tems_chk_all">
								<span>
									<input type="checkbox" id="chk_all" name="chk_all" onclick="acceptClick(this)">
									<label for="chk_all">전체약관</label>
								</span>
							</div> 
							<ul class="tems_chk">
								<li>
									<input type="checkbox" id="chk_1" onclick="acceptClick(this)">
									<label for="chk_1">서비스 이용약관 동의<span>(필수)</span></label>
								</li>
								<li>
									<input type="checkbox" id="chk_2" onclick="acceptClick(this)">
									<label for="chk_2">개인정보 수집 및 이용 동의<span>(필수)</span></label>
								</li>
								<li>
									<input type="checkbox" id="chk_3" onclick="acceptClick(this)">
									<label for="chk_3">위치정보 이용 약관</label>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- 주문내역 -->
				<div class="column_right">
					<div class="payment_bill">
						<div class="payment_bill_head">
							<p>주문내역</p>
						</div>
						<div class="payment_bill_body">
							<ul>
								<c:forEach items="${orderList}" var="orderList">	
									<li>
										<div class="menu_div">
											<span class="menu_name">${orderList.menuName} x ${orderList.orderQuantity}개</span>
											<input type="text" class="menu_price" value="${orderList.menuPrice}" readonly="readonly">
											<i>원</i>
										</div>
									</li>
								</c:forEach>	
								<div class="point_div">
									<span class="point_sale">적립금 할인</span>
									<input type="text" class="point_price" readonly="readonly">
									<i>P</i>
								</div>
							</ul>
							<div class="total_price_payment_btn">
								<div>
									<span class="total_price_txt">총 주문금액</span>
									<input type="text" class="total_price" value="" readonly="readonly">
									<i>원</i>
								</div>
								<input type="submit" class="payment_btn" value="결제하기">
							</div>
						</div>
					</div>
				</div>
			</form>	
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>