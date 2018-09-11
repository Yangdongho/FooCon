<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_mainList.css">

<script 
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
  
<script type="text/javascript" src="<%=path%>/js/admin_mainList.js"></script>
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 메인화면 관리</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 메뉴 리스트 -->
	<section class="menu-list-area">
		<div class="content_container">
			
			<h2>메인화면 관리</h2>
			<table>
				<caption>배치, 매장명, 평점, 관심트럭 수, 리뷰 수, 이메일, 이름, 연락처, 순서변경</caption>
				<colgroup>
					<col style="width:5%">
					<col style="width:*%">
					<col style="width:5%">
					<col style="width:7%">
					<col style="width:5%">
					<col style="width:13%">
					<col style="width:10%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>배치</th>
						<th>매장명</th>
						<th>평점</th>
						<th>관심트럭 수</th>
						<th>리뷰 수</th>
						<th>이메일</th>
						<th>이름</th>
						<th>연락처</th>
						<th>순서변경</th>
					</tr>
				</thead>
				<tbody>
				
				<c:forEach items = "${MasterBrandList}" var = "masterMainList">
					<tr class = "mainList">
						<td class = "mainRank">${masterMainList.MAINRANK}</td>
						<td>${masterMainList.BRANDNAME}</td>
						<td id = "average">
						<fmt:formatNumber value="${masterMainList.AVGSTARGRADE}" pattern=".0"></fmt:formatNumber>
						</td>
						<td>${masterMainList.FAVORTOTALCNT}</td>
						<td>${masterMainList.REVIEWCOUNT}</td>
						<td>${masterMainList.OWNEREMAIL}</td>
						<td>${masterMainList.OWNERNAME}</td>
						<td>${masterMainList.OWNERPHONE}</td>
						<td>
							<input class="sequence up_btn" type="button" value="▲" onclick="btnUp(${masterMainList.MAINRANK}, '${masterMainList.BRANDNUM}')">
							<input class="sequence down_btn" type="button" value="▼" onclick="btnDown(${masterMainList.MAINRANK}, '${masterMainList.BRANDNUM}')">
						</td> 
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
</body>	
</html>