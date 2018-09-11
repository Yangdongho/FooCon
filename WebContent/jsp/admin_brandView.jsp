<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_brandView.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<!-- 다음 지도api 시작 -->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55e37a8550b912ed5a050d715fba2bb7"></script> -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ae766bc6085cd009d9f7579828a8888f&libraries=services"></script>
<!-- 다음 지도api 끝 -->
<!-- 다음 우편찾기 시작 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 다음 우편찾기 끝 -->
<script src="<%=path%>/js/admin_brandView.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 브랜드 뷰페이지 -->
	<section class="brand-list-area">
		<div class="content_container">
			<h2>브랜드 상세페이지</h2>	
			<form class="brandViewForm" enctype="multipart/form-data" method="post" onsubmit='return frmsubmit();'>
				<input type="hidden" name="BRANDNUM" value="${brandView.BRANDNUM}">
				<input type="text" name="BRANDNAME" class="brandname" placeholder="푸드트럭 명을 입력해주세요." value="${brandView.BRANDNAME}" maxlength="50">
				<ul class="clearfix">
					<li><p>총 매출금액 <span>${brandInfoCounting.totalPaymentAmount}</span><p></li>
					<li><p>총 주문수 <span>${brandInfoCounting.totalOrder}</span><p></li>
					<li><p>총 배달수 <span>${brandInfoCounting.totalDelivery}</span><p></li>
					<li><p>총 예약수 <span>${brandInfoCounting.totalReserve}</span><p></li>
					<li><p>관심트럭 <span>${brandInfoCounting.totalFavor}</span><p></li>
					<li><p>리뷰 <span>${brandInfoCounting.totalReview}</span><p></li>
					<li><p>메뉴 <span>${brandInfoCounting.totalMenu}</span><p></li>
				</ul>
				<div class="brand-list-inner">
					<div class="exposure_option clearfix">
						<input type="hidden" class="exposureLevel" value="${brandView.EXPOSURELEVEL}">
						<div class="recommend_option">
							<span class="title_txt">추천여부</span>
							<input type="radio" class="recommand_normal" name="EXPOSURELEVEL_RECOMMAND" value="NORMAL" id="recommend_off" checked>
							<label for="recommend_off">일반</label>
							<input type="radio" class="recommand" name="EXPOSURELEVEL_RECOMMAND" value="RECOMMAND" id="recommend_on">
							<label for="recommend_on">추천</label>
						</div>
						<div class="main_option">
							<span class="title_txt">메인노출</span>
							<input type="radio" class="main_normal" name="EXPOSURELEVEL_MAIN" value="NORMAL" id="main_off" checked>
							<label for="main_off">비노출</label>
							<input type="radio" class="main" name="EXPOSURELEVEL_MAIN" value="MAIN" id="main_on">
							<label for="main_on">노출</label>
						</div>
					</div>
					<div class="account_info">
						<p class="title_txt">계정정보</p>
						<ul class="clearfix">
							<li><span>이메일</span><input type="text" name="OWNEREMAIL" value="${brandView.OWNEREMAIL}" readonly="readonly"></li>
							<li><span>휴대번호</span><input type="text" class="ownerPhone" name="OWNERPHONE" value="${brandView.OWNERPHONE}" onkeydown="onlyNumber(this)" maxlength="11"></li>
							<li><span>이름</span><input type="text" name="OWNERNAME" value="${brandView.OWNERNAME}" readonly="readonly"></li>
							<li><span>가입일</span><input type="text" name="OWNERREGDATE" value="${brandView.OWNERREGDATE}" readonly="readonly"></li>
							<c:if test="${authority ne 'MASTER'}">
							<li><span class="pwText">비밀번호</span>
								<span class="pwSpan">
									<input type="password" class="OwnerPassword" value="" placeholder="현재 비밀번호">
									<span class="OwnerPasswordText text"></span>
									<input type="password" class="OwnerPasswordChange" value="" placeholder="변경할 비밀번호" >
									<span class="OwnerPasswordChangeText text"></span>
									<br>
								</span>
								<input type="button" class="pwChangeBtn" value="비밀번호 변경" onclick="passwordChange()">
							</li>
							</c:if>
						</ul>
					</div>
					<div class="img_info">
						<p class="title_txt">이미지 정보</p>
						<ul class="clearfix">
							<li>
								<span>썸네일</span>
								<label for="thumnailImage" class="custom-file-upload">
									<i>파일 업로드</i>
								</label>
								<input type="file" id="thumnailImage" class="thumnailImage" name="THUMNAILIMAGE">
							</li>
							<li class="thumnailImg_wrap">
								<p>변경할 이미지</p>
								<div></div>
							</li>
							<c:if test="${!empty brandInfoCounting.brandImages.THUMNAILIMAGE}">
							<li><img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.THUMNAILIMAGE}"></li>
							</c:if>
							<li class="detailLi">
								<span>상세</span>
								<label for="detailImages" class="custom-file-upload">
									<i>파일 업로드</i>
								</label>
								<input type="file" id="detailImages" class="detailImages" name="IMAGES" multiple>
							</li>
							<li class="detailImg_wrap">
								<p>변경할 이미지</p>
								<div></div>
							</li>
							<li>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE1}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE1}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE2}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE2}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE3}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE3}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE4}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE4}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE5}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE5}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE6}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE6}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE7}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE7}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE8}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE8}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE9}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE9}">
							</c:if>
							<c:if test="${!empty brandInfoCounting.brandImages.IMAGE10}">
								<img class="img" src="imagePreview?fileName=${brandInfoCounting.brandImages.IMAGE10}">
							</c:if>
							</li>
						</ul>
					</div>
					<div class="basic_info clearfix">
						<p class="title_txt">기본정보</p>
						<div class="left_column">
							<ul class="clearfix">
								<li>
									<span>주소</span><input type="text" class="brandAddress" name="BRANDADDRESS" value="${brandView.BRANDADDRESS}" onblur="mapAddress()" maxlength="100">
									<input type="hidden" class="brandLongitude" name="BRANDLONGITUDE" value="${brandView.BRANDLONGITUDE}">
									<input type="hidden" class="brandLatitude" name="BRANDLATITUDE" value="${brandView.BRANDLATITUDE}">	
								</li>
								<li><span>전화번호</span><input type="text" class="brandPhone" name="BRANDPHONE" value="${brandView.BRANDPHONE}" placeholder="'-'없이 전화번호를 입력해주세요" onkeydown="onlyNumber(this)" onblur="onlyNumber(this)" maxlength="11"></li>
								<li>
									<input type="hidden" class="brandOpenTime" value="${brandView.BRANDOPENTIME}">
									<span>영업시간</span>
									<select name="OPEN_TIME_HOUR" class="OPEN_TIME_HOUR">
									    <option value="00">00</option>
									    <option value="01">01</option>
									    <option value="02">02</option>
									    <option value="03">03</option>
									    <option value="04">04</option>
									    <option value="05">05</option>
									    <option value="06">06</option>
									    <option value="07">07</option>
									    <option value="08">08</option>
									    <option value="09">09</option>
									    <option value="10">10</option>
									    <option value="11">11</option>
									    <option value="12">12</option>
									    <option value="13">13</option>
									    <option value="14">14</option>
									    <option value="15">15</option>
									    <option value="16">16</option>
									    <option value="17">17</option>
									    <option value="18">18</option>
									    <option value="19">19</option>
									    <option value="20">20</option>
									    <option value="21">21</option>
									    <option value="22">22</option>
									    <option value="23">23</option>
									</select>
									<select name="OPEN_TIME_MINUTE" class="OPEN_TIME_MINUTE">
									    <option value="00">00</option>
									    <option value="30">30</option>
									</select>
									<i>~</i>
									<select name="CLOSE_TIME_HOUR" class="CLOSE_TIME_HOUR">
									    <option value="00">00</option>
									    <option value="01">01</option>
									    <option value="02">02</option>
									    <option value="03">03</option>
									    <option value="04">04</option>
									    <option value="05">05</option>
									    <option value="06">06</option>
									    <option value="07">07</option>
									    <option value="08">08</option>
									    <option value="09">09</option>
									    <option value="10">10</option>
									    <option value="11">11</option>
									    <option value="12">12</option>
									    <option value="13">13</option>
									    <option value="14">14</option>
									    <option value="15">15</option>
									    <option value="16">16</option>
									    <option value="17">17</option>
									    <option value="18">18</option>
									    <option value="19">19</option>
									    <option value="20">20</option>
									    <option value="21">21</option>
									    <option value="22">22</option>
									    <option value="23">23</option>
									</select>
									<select name="CLOSE_TIME_MINUTE" class="CLOSE_TIME_MINUTE">
									    <option value="00">00</option>
									    <option value="30">30</option>
									</select>
								</li>
								<li>	
									<span>주문옵션</span>
									<input type="hidden" class="brandDeliveryStatus" value="${brandView.BRANDDELIVERYSTATUS}">
									<input type="checkbox" name="BRANDDELIVERYSTATUS" value="Y" id="delivery_on">
									<label for="delivery_on">배달가능</label>
									<input type="hidden" class="brandReservationStatus" value="${brandView.BRANDRESERVATIONSTATUS}">
									<input type="checkbox" name="BRANDRESERVATIONSTATUS" value="Y" id="reservation_on">
									<label for="reservation_on">예약가능</label>
								</li>
								<li><span>배달가능지역</span><input type="text" name="DELIVERAREA" value="${brandView.DELIVERAREA}" placeholder="배달 가능지역을 입력해주세요" maxlength="100"></li>
								<li><span>배달최소금액</span><input type="text" name="DELIVERMINIMUMAMOUNT" value="${brandView.DELIVERMINIMUMAMOUNT}" placeholder="배달 가능한 최소 금액을 입력해주세요" onkeydown="onlyNumber(this)" onblur="onlyNumber(this)" maxlength="100000000"></li>
								<li><span class="brand_intruduce">매장소개</span><textarea rows="10" cols="96" name="BRANDINTRODUCE" placeholder="매장을 소개해주세요(100자 이내)" maxlength="100">${brandView.BRANDINTRODUCE}</textarea></li>
							</ul>
						</div>
						<div id="map" class="right_column"></div> 
						<div id="clickLatlng"></div>
					</div>
				</div>
				<c:if test="${authority ne 'MASTER'}">
					<input type="submit" value="저장">
				</c:if>
			</form>
		</div>
	</section>
</body>	
</html>