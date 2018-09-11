<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>   
<% String id = (String)session.getAttribute("MEMBEREMAIL"); %>

<script type="text/javascript" src="<%=path%>/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/header.css">

<header>

<script type="text/javascript">
	var context ='${pageContext.request.contextPath}';	
</script>

	<nav class="clearfix">
	
		<h1 class="logo"><a href = "<%=path%>/"><img src="<%=path%>/img/logo_m.png" alt="logo"></a></h1>
		
		<form action="<%=path%>/search/mainSearch">
		<div class="header_search">
			<label>
				<img alt="search" src="<%=path%>/img/ic-search2x.png">
				<input type="text" name = "searchBlank" placeholder="원하는 지역, 푸드트럭, 음식을 입력해주세요">
				<input type = "hidden"  name= "headerlit" id = "headerlit"> 
				<input type = "hidden" name= "headerlot" id = "headerlot">
				<input type = "hidden" name = "comeWay" id = "comeWay" value = "header">
			</label>
			
			<input type = "submit" class = "headerSearch" value = "검색" >

		</div>
		</form>
		
		
		<ul class="nav-list">
<!-- 		<li><a href="#">트럭 검색</a></li> -->
			<li><a id="myArea" href="javascript:myAreaPosition('${pageContext.request.contextPath}');">내 주변</a></li>
			<li><a href="javascript:orderList('${pageContext.request.contextPath}');">주문 내역</a></li>
<%-- 		<li><a href="<%=path%>/member/interest?memberPK=M6&lit=${#headerlit}&lot=${#headerlot}">관심 트럭</a></li> --%>
			<li><a href="javascript:myInterest('${pageContext.request.contextPath}' , '${sessionScope.SEQ}');">관심 트럭</a></li>
		
		<c:choose>		
		    <c:when test="${not empty sessionScope.NICK}">
			    <ul class = "headerDrop">
			    	<li class = "headerLI">
			    	
			        	<a href="#">${sessionScope.NICK} &nbsp;님</a>
			        	<br><br>
			        	<ul class = "headerDown">	
						  <li class = "login"><a href="javascript:logout('${pageContext.request.contextPath}');">로그아웃</a></li>
						  <li class = "login"><a href="javascript:myPage('${pageContext.request.contextPath}');">마이페이지</a></li>					      	
						</ul>
						
					</li>
				</ul>
		    </c:when>

		    <c:otherwise>		    
			       	<li>
					  <a href="javascript:login('${pageContext.request.contextPath}');">회원가입 및 로그인</a>
					</li>				
		    </c:otherwise>	
		    	
		</c:choose>		
		</ul>			
	</nav>		
</header>