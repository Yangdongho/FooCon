<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value = "<%=request.getContextPath()%>"/>

<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<script type="text/javascript" src="${path}/js/index.js"></script>
<script type="text/javascript" src="${path}/js/main.js"></script>
<script type="text/javascript" src="${path}/js/header.js"></script>


<link rel="stylesheet" type="text/css" href="${path}/css/reset.css">
<link rel="stylesheet" type="text/css" href="${path}/css/common.css">
<link rel="stylesheet" type="text/css" href="${path}/css/main.css">



<style type="text/css">

	.header_search .searchBlock{
		display: none;
	} 
		
</style> 

<script type="text/javascript">

// if (document.location.protocol == 'http:') {
//     document.location.href = document.location.href.replace('http:', 'https:');
// }

</script> 


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 서비스명</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 메인비주얼 -->
	<section class="search-area" >
		<h2 class="hidden">search</h2>
		<div class="visual_content_container">
			<p style="font-weight: 950;">FOOCON<br>존맛탱 음식을 찾아서</p>
			<div class="search_box">
			
				<form action="${path}/search/mainSearch">
					 
					<label>
						<img alt="search" src="${path}/img/ic-search2x.png">
						<input type="text" name = "searchBlank" placeholder="원하는 지역, 푸드트럭, 음식을 입력해주세요">
						<input type = "hidden"  name= "lit" id = "lit">
						<input type = "hidden" name= "lot" id = "lot">
						<input type = "hidden" name = "comeWay" id = "comeWay" value = "main">
					</label>
					
					<input type="submit" value = "트럭검색">
					
				</form>

			</div>
		</div>
		<div class="main_visual_opacity"></div>
	</section>
	<!-- 추천 푸드트럭 -->
	<section class="mainrecommend-area">
		<div class= "container">
			<div class="mainrecommend_header">
				<h2>추천 푸드트럭</h2><br>
				<p>FOOCON에서 추천하는 푸드트럭입니다.</p>
				

			</div>
			<div class="mainrecommend_list">
				<ul class="clearfix">
					
				<c:forEach items = "${mainList}" var = "mList">
					<li>	
<%-- 						<img alt="foodtruck" src="${path}/img/dummy.jpg"> --%>
						<a href = "javascript:brandview('${pageContext.request.contextPath}','${mList.BRANDNUM}');"><img alt="foodtruck" src="imageDown?brandNUM=${mList.BRANDNUM}"></a>
						<dl class="clearfix">
							<dt><a href = "javascript:brandview('${pageContext.request.contextPath}','${mList.BRANDNUM}');">${mList.BRANDNAME}</a><span style="display:none;">${mList.BRANDNUM}</span></dt>
							<dd>
								<c:forEach begin="1" end="${mList.AVGSTARGRADE}" step="1" >
								<span class="5-star stars">★</span>
								</c:forEach>
								
								<c:forEach begin="${mList.AVGSTARGRADE+1}" end="5" step="1" >
								<span class="5-star stars" style="color:#F2F2F2 ">★</span>
								</c:forEach>
							</dd>
							<dd>리뷰:${mList.REVIEWCOUNT} &nbsp;&nbsp;관심:${mList.FAVORTOTALCNT}</dd>
						</dl>
					</li>
				</c:forEach>
				
				</ul>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
	
</body>	
</html>