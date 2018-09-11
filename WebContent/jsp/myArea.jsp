<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<% String path = request.getContextPath(); %> 

<% int rindex = -1; %>    
<% int nindex = -1; %>    



<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/myArea.css">

<style type="text/css">

.dropDown-Span {
    border: none;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #ddd;
    min-width: 160px;
    box-shadow: 0px 8px 8px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

#reset{
	float: right;
	padding-top: 5px;}	
</style>


<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
  
<script type="text/javascript">		
		var nowLit = ${sessionScope.lit};
		var nowLot = ${sessionScope.lot};
</script>

<!-- 다음 지도 api 사용하기 위한 key 값 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ae766bc6085cd009d9f7579828a8888f"></script>

<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55e37a8550b912ed5a050d715fba2bb7"></script> -->

<script type="text/javascript" src="<%=path%>/js/header.js"></script>

<script type="text/javascript">
	var current = -1;							
</script>
 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 서비스명</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	
	<!-- 내위치 및 검색 결과 -->
	<section class="search-result-area">
		<h2 class="hidden">search-result</h2>
		<div class="search_container">
<!-- 			<div class="search_position"> -->
<!-- 				<p>내 위치<span>중구 태평로 1가</span></p> -->
<!-- 			</div> -->
			<div class="search_keyword">
				
				<c:if test="${myAreaComeIn eq 'search'}">			
					<p><span>'${searchBlank}'</span> 검색 결과 총<span class = "gun">&nbsp; ${searchListLength}</span> 건 입니다.</p> 				
				</c:if>
				
				<c:if test="${myAreaComeIn eq 'myArea'}">				
					<p>검색 결과 총<span class = "gun">&nbsp; ${searchListLength}</span> 건 입니다.</p>
				</c:if>
					<input type = "hidden"  id= "lit" >
					<input type = "hidden" id = "lot"  >
					
<!-- 				필터에서 거리순, 평점순, 관심순으로 다시 리스트를 뿌리기 위해 hidden으로 박어둠 -->
					<input type = "hidden" id="normalList" value = '${normalList}'>
					<input type = "hidden" id="recommandList" value = '${recommandList}'>
			</div>			
		</div>
	</section>
	
	<!-- 푸드트럭 리스트  -->
	
	<section class="placelist-area">
		
<!-- 	검색이랑 내주변 둘 다 통틀어서 담고있는 div -->
		<div> 
		
			<div class="filter_container">
				<div class="filter">
					<!-- 		<p>검색으로 들어왔을 때</p> -->
					<c:if test="${myAreaComeIn eq 'search'}">
						<!-- 			검색으로 들어왔을 때 이 js파일을 실행시킨다. -->
						
						<script type="text/javascript" src="<%=path%>/js/myArea.js"></script>
						
						<div class="dropdown">
							<span class="dropDown-Span">거리순</span>

							<div class="dropdown-content">
								<a id='location'>거리순</a> <a id='evaluate'>평점순</a> <a id='heart'>관심순</a>
								<%-- <a id = 'heart' href='<%=path%>/search/favorBrand?searchBlank=${searchBlank}&lit=${param.lit}&lot=${param.lot}'>관심순</a> --%>
							</div>
						</div>
					<input type="checkbox" name="chk_reser" id="chk_reser" class="option" value="예약가능">예약가능
					<input type="checkbox" name="chk_deliver" id="chk_deliver" class="option" value="배달가능">배달가능
					<a id='reset' href='javascript:void(0);' onclick='resetLink();' style='text-decoration: none; display: block;'><span>필터초기화</span></a>
				</div>
				
			</div>

			<!-- 검색결과가 없을 때 나오는 문구 -->
			<c:if test="${searchListLength eq 0}">
				<p style="text-align: center">검색결과가 없습니다.</p>
			</c:if>
			
<c:if test="${searchListLength gt 0}">
		
<!-- 		추천결과가 비어있지 않으면 추천푸드트럭 title을 보여준다 -->
			<c:if test="${ !empty brandRecommandList}">
				<div class="title_box">
					<img alt="" src="<%=path%>/img/pickpick.gif"  width="30px" style="margin-top: 10px;">
					<h4 id="lit" >추천 푸드트럭</h4>
				</div>			
			</c:if>
				
			<div class="placelist_container">
				<div class="recommend brand_list">
					<ul class="listTop" style="background-color:">
					
						<c:forEach items="${brandRecommandList}" var="searchList">
							<li class="recommend-item top">
								<div class="item-inner clearfix">
								
									<div class = "image-box" >									
									<img alt="thumnail" src="imageDown?brandNUM=${searchList.BRANDNUM}">
								</div>											
										
								<div  class = "maker-rap">
									<div class = "marker-image">											
										<img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pin-image">
									</div>
								</div>
								
									<dl class="info-box">
										<dt class="title_rap">
											<a
												href="javascript:brandview('${pageContext.request.contextPath}','${searchList.BRANDNUM}');">${searchList.BRANDNAME}</a><span
												class="recommandNUM<%=rindex = rindex + 1%>" id="recommandNUM"
												style="display: none;">${searchList.BRANDNUM}</span>
										</dt>
										<dd class="score-rap clearfix">

											<!--가게 별 갯수만큼 별로 보이게 하기 -->
											<c:forEach begin="1" end="${searchList.AVGSTARGRADE}" step="1">
												<span class="5-star stars">★</span>
											</c:forEach>

											<c:forEach begin="${searchList.AVGSTARGRADE+1}" end="5"
												step="1">
												<span class="5-star stars" style="color: #F2F2F2">★</span>
											</c:forEach>

											<span class="txt_review">리뷰:${searchList.REVIEWCOUNT}
												&nbsp;&nbsp;관심:${searchList.FAVORTOTALCNT}</span> <span
												class="txt_distance">${searchList.gapM}Km</span>
										</dd>
										<dd class="type-rap">

											<c:set var="reservation" value="Y" />
											<c:choose>
												<c:when test="${searchList.BRANDRESERVATIONSTATUS eq 'Y'}">
													<i class="reservation">예약가능</i>
												</c:when>

												<c:when test="${searchList.BRANDRESERVATIONSTATUS eq 'N'}">
													<i class="reservation" style="display: none;">예약가능</i>
												</c:when>
											</c:choose>


											<c:set var="delivery" value="Y" />
											<c:choose>
												<c:when test="${searchList.BRANDDELIVERYSTATUS eq 'Y'}">
													<i class="delivery">배달가능</i>
												</c:when>

												<c:when test="${searchList.BRANDDELIVERYSTATUS eq 'N'}">
													<i class="delivery" style="display: none;">배달가능</i>
												</c:when>
											</c:choose>

											<c:set var="open" value="Y" />
											<c:choose>
												<c:when test="${searchList.BRANDOPENTIME eq 'Y'}">
													<i class="open">영업중</i>
												</c:when>

												<c:when test="${searchList.BRANDOPENTIME eq 'N'}">
													<i class="open" style="display: none;">영업중</i>
												</c:when>
											</c:choose>
										</dd>
										<dd class="indroduce-rap">
											<span>매장소개</span>
											<p>${searchList.BRANDINTRODUCE}</p>

										</dd>
									</dl>
								</div>
							</li>
						</c:forEach>
					</ul>

				</div>

				<!--	만약, 추천리스트가 페이징갯수보다 부족하면 부족한 만큼 일반 리스트를 뿌려준다. -->
				<div class="recommend brand_list">
					<ul class='listdown'>
						
<!-- 					일반 브랜드 리스트가 비어있지 않으면 title노출 -->
						<c:if test="${ !empty brandNormalList}">
						
							<div class="title_box">
								<h4 id="lit">일반 푸드트럭</h4>
							</div>			
						
					
						<c:if test="${recommandSize < 5 }" >
							
							<c:forEach begin="0" end="${5 - recommandSize -1}" varStatus="narae" step="1">
							
							<c:if test="${narae.current lt normalSize}">
							
							<script type="text/javascript">
								current = current+1 ;			
							</script>							
								<li class="recommend-item down">
									<div class="item-inner clearfix">
												
								<div class = "image-box" >									
									<img alt="thumnail" src="imageDown?brandNUM=${brandNormalList[narae.current].BRANDNUM}">
								</div>											
										
								<div  class = "maker-rap">
									<div class = "marker-image">											
										<img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pin-image">
									</div>
								</div>												
												<dl class="info-box">
													<dt class="title_rap">
														<a
															href="javascript:brandview('${pageContext.request.contextPath}','${brandNormalList[narae.current].BRANDNUM}');">${brandNormalList[narae.current].BRANDNAME}</a><span
															class="normalNUM<%=nindex = nindex + 1%>" id="normalNUM"
															style="display: none;">${brandNormalList[narae.current].BRANDNUM}</span>
													</dt>
													<dd class="score-rap clearfix">

														<!-- 										가게 별 갯수만큼 별로 보이게 하기 -->
														<c:forEach begin="1" end="${brandNormalList[narae.current].AVGSTARGRADE}"
															step="1">
															<span class="5-star stars">★</span>
														</c:forEach>

														<c:forEach begin="${brandNormalList[narae.current].AVGSTARGRADE+1}" end="5"
															step="1">
															<span class="5-star stars" style="color: #F2F2F2">★</span>
														</c:forEach>

														<span class="txt_review">리뷰:${brandNormalList[narae.current].REVIEWCOUNT}
															&nbsp;&nbsp;관심:${brandNormalList[narae.current].FAVORTOTALCNT}</span> <span
															class="txt_distance">${brandNormalList[narae.current].gapM}Km</span>

													</dd>
													<dd class="type-rap">

														<c:set var="reservation" value="Y" />
														<c:choose>
															<c:when
																test="${brandNormalList[narae.current].BRANDRESERVATIONSTATUS eq 'Y'}">
																<i class="reservation">예약가능</i>
															</c:when>

															<c:when
																test="${brandNormalList[narae.current].BRANDRESERVATIONSTATUS eq 'N'}">
																<i class="reservation" style="display: none;">예약가능</i>
															</c:when>
														</c:choose>


														<c:set var="delivery" value="Y" />
														<c:choose>
															<c:when test="${brandNormalList[narae.current].BRANDDELIVERYSTATUS eq 'Y'}">
																<i class="delivery">배달가능</i>
															</c:when>

															<c:when test="${brandNormalList[narae.current].BRANDDELIVERYSTATUS eq 'N'}">
																<i class="delivery" style="display: none;">배달가능</i>
															</c:when>
														</c:choose>

														<c:set var="open" value="Y" />
														<c:choose>
															<c:when test="${brandNormalList[narae.current].BRANDOPENTIME eq 'Y'}">
																<i class="open">영업중</i>
															</c:when>

															<c:when test="${brandNormalList[narae.current].BRANDOPENTIME eq 'N'}">
																<i class="open" style="display: none;">영업중</i>
															</c:when>
														</c:choose>

													</dd>
													<dd class="indroduce-rap">
														<span>매장소개</span>
														<p>${brandNormalList[narae.current].BRANDINTRODUCE}</p>
													</dd>
												</dl>
											</div>
										</li>											
								</c:if>				
							</c:forEach>
						</c:if>						
						</c:if>						
					</ul>
				</div>
			</div>
</c:if>
			</c:if>



			<c:if test="${myAreaComeIn eq 'myArea'}">
<!-- 			내주변 버튼을 클릭해서 이 화면에 들어왔을 때 아래 js파일을 사용한다. -->
			<script type="text/javascript" src="<%=path%>/js/myAreaDistance.js"></script>
			
			<div class="title_box">
			
<%-- 		<img alt="" class = 'imageGood' src="<%=path%>/img/pickpick.gif"  width="30px" style="margin-top: 10px;"> --%>
			<img alt="" class = 'imageGood' >
			<h4 id = "lit" class = "titleRecommand"></h4>	
						
				<input type="hidden" id = "myAreaLit" value="${param.lit}">
				<input type="hidden" id = "myAreaLot" value="${param.lot}">	
									
			</div>	
			
			<input type="hidden" id = "gsonRecommand" value='${gsonRecommand}'>
			<input type="hidden" id = "gsonNormal" value='${gsonNormal}'>	
			
			<c:if test="${searchListLength eq 0}">						
				<p style="text-align: center">가까운 거리의 브랜드가 없습니다.</p>							
			</c:if>

			<div class="placelist_container">	
			
				<span class = "alertSpan"></span>	

				<div class="recommend brand_list">

					<ul class = "listTop">
					
					<c:forEach items = "${recommand}" var = "searchList">
						<li class="recommend-item top">
							<div class="item-inner clearfix">
								<div class = "image-box" >									
									<img alt="thumnail" src="imageDown?brandNUM=${searchList.BRANDNUM}">
								</div>											
										
								<div  class = "maker-rap">
									<div class = "marker-image">											
										<img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pin-image">
									</div>
								</div>	
								
								<dl class="info-box">
									<dt class="title_rap"><a href = "javascript:brandview('${pageContext.request.contextPath}','${searchList.BRANDNUM}');">${searchList.BRANDNAME}</a><span class = "recommandNUM<%=rindex=rindex+1%>" id = "recommandNUM" style="display : none;">${searchList.BRANDNUM}</span></dt>
									<dd class="score-rap clearfix">
										
										<!--가게 별 갯수만큼 별로 보이게 하기 -->
										<c:forEach begin="1" end="${searchList.AVGSTARGRADE}" step="1" >
										<span class="5-star stars">★</span>
										</c:forEach>
										
										<c:forEach begin="${searchList.AVGSTARGRADE+1}" end="5" step="1" >
										<span class="5-star stars" style="color: #F2F2F2">★</span>
										</c:forEach>
										
										<span class="txt_review">리뷰:${searchList.REVIEWCOUNT} &nbsp;&nbsp;관심:${searchList.FAVORTOTALCNT}</span>
										
										<span class="txt_distance">${searchList.gapM}Km</span>
										
									</dd>
									<dd class="type-rap">
										
										<c:set var="reservation" value="Y" />
											<c:choose>
											    <c:when test="${searchList.BRANDRESERVATIONSTATUS eq 'Y'}">
											       <i class="reservation">예약가능</i>
											    </c:when>
											
											    <c:when test="${searchList.BRANDRESERVATIONSTATUS eq 'N'}">
											        <i class="reservation" style="display: none;">예약가능</i>
											    </c:when>
											</c:choose>
											
											
										<c:set var="delivery" value="Y" />
											<c:choose>
											    <c:when test="${searchList.BRANDDELIVERYSTATUS eq 'Y'}">
											       <i class="delivery">배달가능</i>
											    </c:when>
											
											    <c:when test="${searchList.BRANDDELIVERYSTATUS eq 'N'}">
											        <i class="delivery" style="display: none;">배달가능</i>
											    </c:when>
											</c:choose>
										
										<c:set var="open" value="Y" />
											<c:choose>
											    <c:when test="${searchList.BRANDOPENTIME eq 'Y'}">
											       <i class="open">영업중</i>
											    </c:when>
											
											    <c:when test="${searchList.BRANDOPENTIME eq 'N'}">
											        <i class="open" style="display: none;">영업중</i>
											    </c:when>
										</c:choose>		
									</dd>
									<dd class="indroduce-rap">
										<span>매장소개</span>
										<p>${searchList.BRANDINTRODUCE}</p>
									</dd>
								</dl>							
							</div>
						</li>
						
						</c:forEach>
					</ul>
				</div>
				
<!-- 			노출레벨  NORMAL인 브랜드들 -->
				<div class="recommend brand_list">
					<ul class = 'listdown'>		
					
					<c:if test="${ !empty normal}">
						<div class="title_box">
							<h4 id="lit" class = "titleNormal"></h4>
						</div>				
					</c:if>
					
					<c:forEach items = "${normal}" var = "searchList">
						<li class="recommend-item down">
							<div class="item-inner clearfix">
								
								<div class = "image-box" >									
									<img alt="thumnail" src="imageDown?brandNUM=${searchList.BRANDNUM}">
								</div>											
										
								<div  class = "maker-rap">
									<div class = "marker-image">											
										<img alt="foodtruck" src="https://yaimg.yanolja.com/joy/pw/place/maker-focused.png" class = "pin-image">
									</div>
								</div>	
																
<%-- 							<img alt="foodtruck" src="<%=path%>/img/dummy.jpg"> --%>								
								<dl class="info-box">
									<dt class="title_rap"><a href = "javascript:brandview('${pageContext.request.contextPath}','${searchList.BRANDNUM}');">${searchList.BRANDNAME}</a><span class = "normalNUM<%=nindex=nindex+1%>" id = "normalNUM" style="display: none;">${searchList.BRANDNUM}</span></dt>
									<dd class="score-rap clearfix">
										
										<!--가게 별 갯수만큼 별로 보이게 하기 -->
										<c:forEach begin="1" end="${searchList.AVGSTARGRADE}" step="1" >
										<span class="5-star stars">★</span>
										</c:forEach>
										
										<c:forEach begin="${searchList.AVGSTARGRADE+1}" end="5" step="1" >
										<span class="5-star stars" style="color: #F2F2F2">★</span>
										</c:forEach>
										
										<span class="txt_review">리뷰:${searchList.REVIEWCOUNT} &nbsp;&nbsp;관심:${searchList.FAVORTOTALCNT}</span>
										
										<span class="txt_distance">${searchList.gapM}Km</span>
										
									</dd>
									<dd class="type-rap">
										
										<c:set var="reservation" value="Y" />
											<c:choose>
											    <c:when test="${searchList.BRANDRESERVATIONSTATUS eq 'Y'}">
											       <i class="reservation">예약가능</i>
											    </c:when>
											
											    <c:when test="${searchList.BRANDRESERVATIONSTATUS eq 'N'}">
											        <i class="reservation" style="display: none;">예약가능</i>
											    </c:when>
											</c:choose>
											
											
										<c:set var="delivery" value="Y" />
											<c:choose>
											    <c:when test="${searchList.BRANDDELIVERYSTATUS eq 'Y'}">
											       <i class="delivery">배달가능</i>
											    </c:when>
											
											    <c:when test="${searchList.BRANDDELIVERYSTATUS eq 'N'}">
											        <i class="delivery" style="display: none;">배달가능</i>
											    </c:when>
										</c:choose>

										<c:set var="open" value="Y" />
											<c:choose>
											    <c:when test="${searchList.BRANDOPENTIME eq 'Y'}">
											       <i class="open">영업중</i>
											    </c:when>
											
											    <c:when test="${searchList.BRANDOPENTIME eq 'N'}">
											        <i class="open" style="display: none;">영업중</i>
											    </c:when>
										</c:choose>										
										
									</dd>
									<dd class="indroduce-rap">
										<span>매장소개</span>
										<p>${searchList.BRANDINTRODUCE}</p>
									</dd>
								</dl>							
							</div>
						</li>						
						</c:forEach>
					</ul>
				</div>				
			</div>
		</c:if>
		</div>
	</section>
	
	<!-- 푸드트럭 맵  -->
	<section class="placemap-area">
		<div id="map" style="z-index:1; position:fixed; top:103px; right:0; width:40%; height:100%; overflow:hidden;"></div>
	</section>
</body>	
</html>