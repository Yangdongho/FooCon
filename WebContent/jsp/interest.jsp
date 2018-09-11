<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<% int brandNum = -1; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/interest.css">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
  
<!-- 다음 지도 api 사용하기 위한 key 값 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ae766bc6085cd009d9f7579828a8888f"></script>

<script type="text/javascript">	
		
		var nowLit = "${sessionScope.lit}";
		var nowLot = "${sessionScope.lot}";

</script>

<script type="text/javascript" src="<%=path%>/js/interest.js"></script>
<script type="text/javascript" src="<%=path%>/js/header.js"></script>
 

 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 서비스명</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 내위치 및 검색 결과 -->
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

	<!-- 푸드트럭 리스트  -->
	<section class="placelist-area">
		<div>
			<div class="filter_container">
		</div>
			<div class="placelist_container">			
				<div class="recommend brand_list">
					<div class="title_box">
						<h4>관심&nbsp;푸드트럭&nbsp;<span>${searchSize}</span>건</h4>
						<input type="hidden" id = "interestLit" value="${param.lit}">
						<input type="hidden" id = "interestLot" value="${param.lot}">
						<input type = "hidden" id = "gsonInterest" value='${gsonInterestList}'>
					</div>
					<ul>
					
				<c:if test="${searchSize eq 0}">			
					<p style="text-align: center">선호 브랜드가 없습니다.</p>			
				</c:if>
					
					<c:forEach items = "${memberFavor}" var = "fList">
					
						<li class="recommend-item">
							<div class="item-inner clearfix">
							
								<div class = "image-box" >									
									<img alt="thumnail" src="imageDown?brandNUM=${fList.BRANDNUM}">
								</div>											
										
								<div  class = "maker-rap">
									<div class = "marker-image">											
										<img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pin-image">
									</div>
								</div>	
														
<%-- 								<img alt="foodtruck" src="<%=path%>/img/dummy.jpg"> --%>								
								<dl class="info-box">
									<dt class="title_rap"><a href = "javascript:brandview('${pageContext.request.contextPath}','${fList.BRANDNUM}');">${fList.BRANDNAME}</a><span class = "brandNUM<%=brandNum = brandNum+1%>" style="display: none;" >${fList.BRANDNUM}</span></dt>
									<dd class="score-rap clearfix">
										<!--가게 별 갯수만큼 별로 보이게 하기 -->
										<c:forEach begin="1" end="${fList.AVGSTARGRADE}" step="1" >
										<span class="5-star stars">★</span>
										</c:forEach>
										
										<c:forEach begin="${fList.AVGSTARGRADE+1}" end="5" step="1" >
										<span class="5-star stars" style="color: #F2F2F2">★</span>
										</c:forEach>
										
										<span class="txt_review">리뷰:${fList.REVIEWCOUNT} &nbsp;&nbsp;관심:${fList.FAVORTOTALCNT}</span>
										<span class="txt_distance">${fList.gapM}Km</span>
									</dd>
									<dd class="type-rap">
										<c:set var="reservation" value="Y" />
											<c:choose>
											    <c:when test="${fList.BRANDRESERVATIONSTATUS eq 'Y'}">
											       <i class="reservation">예약가능</i>
											    </c:when>
											
											    <c:when test="${fList.BRANDRESERVATIONSTATUS eq 'N'}">
											        <i class="reservation" style="display: none;">예약가능</i>
											    </c:when>
											</c:choose>
											
											
										<c:set var="delivery" value="Y" />
											<c:choose>
											    <c:when test="${fList.BRANDDELIVERYSTATUS eq 'Y'}">
											       <i class="delivery">배달가능</i>
											    </c:when>
											
											    <c:when test="${fList.BRANDDELIVERYSTATUS eq 'N'}">
											        <i class="delivery" style="display: none;">배달가능</i>
											    </c:when>
											</c:choose>
										
										<c:set var="open" value="Y" />
											<c:choose>
											    <c:when test="${fList.BRANDOPENTIME eq 'Y'}">
											       <i class="open">영업중</i>
											    </c:when>
											
											    <c:when test="${fList.BRANDOPENTIME eq 'N'}">
											        <i class="open" style="display: none;">영업중</i>
											    </c:when>
										</c:choose>		
										
									</dd>
									<dd class="indroduce-rap">
										<span>매장소개</span>
										<p>${fList.BRANDINTRODUCE}</p>
									</dd>
								</dl>							
							</div>
						</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</section>
	
	<!-- 푸드트럭 맵  -->
	<section class="placemap-area">
		<div id="interestmap" style="z-index:1; position:fixed; top:116px; right:0; width:40%; height:100%; overflow:hidden;"></div>
	</section>
</body>	
</html>