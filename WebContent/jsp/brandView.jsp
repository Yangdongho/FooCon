<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/brandView.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/409269/siema.min.js'></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55e37a8550b912ed5a050d715fba2bb7"></script> -->

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ae766bc6085cd009d9f7579828a8888f&libraries=services"></script>
<script type="text/javascript">
	$(function(){
		lat = ${brandViewInfoView.BRANDLATITUDE};
		lng = ${brandViewInfoView.BRANDLONGITUDE};
		
		/******** 이미지 슬라이드 카운트 선언 ********/
		image = '${brandImageGson}';
		var jsonDate = JSON.parse(image);
		count = jsonDate['BRANDIMAGECOUNT'];

		for(var i=1;i<=count;i++){
			var sildeImage = $("<div class=\"slide\" id=\"slide0"+i+"\">");
			var sildeBtn = $("<button class=\"btn-nav\" data-index=\""+(i-1)+"\">");
			
			var imageData = jsonDate['IMAGE'+i];
			
			sildeImage.appendTo($('.slider'));
			sildeBtn.appendTo($('.slider-nav'));
			
			$("#slide0"+i).css('background-image','url("imagePreview?fileName='+imageData+'")');
		}
		/******** 이미지 슬라이드 카운트 선언 ********/
	});
</script>
<script src="<%=path%>/js/brandView.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta property="og:title" content="[FooCon]">
<meta property="og:description" content="${brandViewInfoView.BRANDNAME}">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<input type="hidden" id="session" value="${USERID}">
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 비주얼 -->
	<section class="visual-area">
		<h2 class="hidden">visual</h2>
		<div class="slider-container">
		  <div class="slider"></div>
		  <button class="prev">&lt;</button>
		  <button class="next">&gt;</button>
		</div>
		<div class="slider-nav"></div>
	</section>
	<!-- 브랜드 정보 -->
	<section class="brand-info-area">
		<h2 class="hidden">brand-info-area</h2>	
		<div class="container clearfix">
			<div class="column_left">
				<div class="brand_info">
					<div class="like_sharelink">
						<c:choose>
							<c:when test="${!empty brandInterestView.MEMBERNUM}">
								<span class="like color" style="color:#ff2d60;">♥</span>
							</c:when>
							<c:otherwise>
								<span class="like ">♡</span>	
							</c:otherwise>
						</c:choose>
<!-- 						<span class="sharelink">공유하기</span> -->
						<a id="kakao-link-btn" href="javascript:sendLink()">
							<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
						</a>
						<a id="twitter-link-btn" href="javascript:shareTwitter()">
							<img src="../img/twitter.jpg"/>
						</a>
						<a id="facebook-link-btn" href="javascript:shareFacebook()"> 
							<img src="../img/facebook.png"/> 
						</a> 
					</div>
					<dl class="brand_info_header">
						<dt class="clearfix" id="brandName">${brandViewInfoView.BRANDNAME}</dt>
							<dd>
								<span class="star-total-core"></span>
								<span class="star-total-gray"></span>
							</dd>
						<dd>리뷰:<i class="reviewTotalCount"></i>개 &nbsp;&nbsp;관심:${brandInterestTotalCountView}개</dd>
					</dl>
					<table class="brand_info_con">
						<caption>푸드트럭 정보</caption>
						<tbody>
							<tr>
								<th>주소</th>
								<td>${brandViewInfoView.BRANDADDRESS}</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td class="brandPhone">${brandViewInfoView.BRANDPHONE}</td>
							</tr>
							<tr>
								<th>영업시간</th>
								<td class="bot">${brandViewInfoView.BRANDOPENTIME}</td>
							</tr>
							<tr>
								<th>매장소개</th>
								<td class="brandIntroduce">${brandViewInfoView.BRANDINTRODUCE}</td>
							</tr>
							<c:if test="${brandViewInfoView.BRANDDELIVERYSTATUS eq 'Y'}">
								<c:if test="${!empty brandViewInfoView.DELIVERAREA}">
								<tr>
									<th>배달가능지역</th>
									<td>${brandViewInfoView.DELIVERAREA}</td>
								</tr>
								</c:if>
								<c:if test="${!empty brandViewInfoView.DELIVERMINIMUMAMOUNT}">
								<tr>
									<th>배달최소금액</th>
									<td>${brandViewInfoView.DELIVERMINIMUMAMOUNT}원 이상</td>
								</tr>
								</c:if>
							</c:if>
						</tbody>
					</table>
					<div class="brand_info_bottom">
						<c:if test="${brandViewInfoView.BRANDRESERVATIONSTATUS eq 'Y'}">
							<i class="reservation">예약가능</i>
						</c:if>
						<c:if test="${brandViewInfoView.BRANDDELIVERYSTATUS eq 'Y'}">
							<i class="delivery">배달가능</i>
						</c:if>
						<i class="open">영업중</i>
					</div>
				</div>
				<!-- 메뉴&리뷰 정보 -->
				<div class="brand_menu_review">
					<ul class="brand_tab">
						<li>메뉴</li>
						<li>리뷰</li>
					</ul>
					<!-- 메뉴 정보 -->
					<div class="menu_review_list">
						<c:choose>
							<c:when test="${brandMenuView[0].MENUNAME eq '없음'}">
								<p class="menuNone">등록된 메뉴가 없습니다.</p>
							</c:when>
							<c:otherwise>
							<table class="brand_menu">
								<caption>메뉴정보</caption>
								<tbody>								
									<c:forEach items="${brandMenuView}" var="menu">
										<tr>
											<th class="menu_title">${menu.MENUNAME}</th>
											<td><input type="hidden" class="menu_num" value="${menu.BRANDMENUNUM}"></td>
											<td class="menu_price">${menu.MENUPRICE}</td>
											<td class="won">원</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- 리뷰 정보 -->
					<div class="menu_review_list">
						<div class="review_total_core">
							<span class="star-total-core"></span>
							<span class="star-total-gray"></span>
							<strong class="total-core-count"></strong>
						</div>
						<div class="review_message">
							<i class="badge_live">리뷰</i>
							는 구매한 회원만 작성할 수 있습니다.
						</div>
						<ul class="review_list"></ul>
						<center><img id="loading" src="<%=path%>/img/25.gif" alt="loading"></center>
						<button class="review_more_btn" onclick="theMore()">
							<span>더보기</span>
						</button>
					</div>
				</div>
			</div>
			
			<!-- 지도 및 주문함 -->
			<div class="column_right">
				<div class="column_right_content">
					<div class="brand_map" id="map">
					</div>
					<div class="order_basket">
						<div class="order_basket_head">
							<p>주문함 <span>0</span>개</p>
							<span class="clear_btn" onclick="deleteRowAll(this);">비우기</span>	
						</div>
						<div class="order_basket_body">
							<form action="<%=path%>/order/orderForm?brandNUM=${brandViewInfoView.BRANDNUM}" id="orderForm" name="order" method="post">
								<ul></ul>
								<div class="total_price_order_btn">
									<div>
										<p class="empty_txt">주문표에 담긴 메뉴가 없습니다.</p>
										<div class="not_empty_txt">
											<span class="total_price_txt">총 주문금액</span>
											<span class="total_price"></span>
											<i>원</i>
										</div>
									</div>
									<input type="submit" class="order_btn" value="결제하기">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>