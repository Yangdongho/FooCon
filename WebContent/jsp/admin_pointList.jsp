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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_pointList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="point-list-area">
		<div class="content_container">
			
			<h2>적립금 현황</h2>
			<div class="table_option">
				<form action="pointList">
					<div class="point_search">
						<input type="text" name="keyword" placeholder="이메일을 입력해주세요.">
						<input type="submit" value="검색" id="search">
					</div>
				</form>
			</div>
			<table>
				<caption>이메일, 닉네임,적립금 내역, 지급, 차감, 상세내역, 날짜</caption>
				<colgroup>
					<col style="width:15%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:7%">
					<col style="width:7%">
					<col style="width:*%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th>이메일</th>
						<th>닉네임</th>
						<th>적립금 내역</th>
						<th>지급</th>
						<th>차감</th>
						<th>상세내역</th>
						<th>날짜</th>
					</tr>
				</thead>
					<c:forEach items="${totalMap.pointList}" var="point">
					<c:choose>
						<c:when test="${point.POINTSEPARATION eq 'MINUS'}">
							<tbody>
							<tr>
								<td>${point.MEMBEREMAIL}</td>
								<td>${point.NICK}</td>
								<td>차감-
									<c:choose>
										<c:when test="${point.DELIVREGICHECK eq 'D'}">
										배달
										</c:when>
										<c:otherwise>
										예약
										</c:otherwise>
									</c:choose>
								</td>
								<td></td>
								<td>${point.POINTAMOUNT}</td>
								<td>주문번호 :
									${point.ORDERNUMBER}
								</td>
								<td>${point.POINTDATE}</td>
							</tr>
							</tbody>
						</c:when>
						<c:otherwise>
							<tbody>
							<tr>
								<td>${point.MEMBEREMAIL}</td>
								<td>${point.NICK}</td>
								<td>지급</td>
								<td>${point.POINTAMOUNT}</td>
								<td></td>
								<td title="<c:forEach items="${point.menuList}" var="menu">${menu.MENUNAME}</c:forEach>" id="menu">
								상품명 : 
								<c:forEach var="menu" items="${point.menuList}" varStatus="index">
                        		<c:choose>
                           		<c:when test="${index.last ==true}">
                              		 ${menu.MENUNAME}
                          		 </c:when>
                          		 <c:otherwise>
                             	   ${menu.MENUNAME},
                          	 	</c:otherwise>
                       	 		</c:choose>
                  				</c:forEach> 
								</td>
								<td>${point.POINTDATE}</td>
							</tr>
							</tbody>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					</table>
			<c:if test="${empty totalMap.pointList}">
                  <center><p id="none">검색결과가 없습니다.</p></center>
            </c:if>
			<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="pointList?pageNum=1">[처음]</a>
					<a href="pointList?pageNum=${totalMap.strtPage-1}&keyword=${totalMap.keyword}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum == totalMap.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a class="remainPage" href="pointList?pageNum=${pageNum}&keyword=${totalMap.keyword}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${totalMap.endPage < totalMap.totalCount}">
					<a href="pointList?pageNum=${totalMap.endPage+1}&keyword=${totalMap.keyword}">[다음]</a>
					<a href="pointList?pageNum=${totalMap.endPage}&keyword=${totalMap.keyword}">[마지막]</a>
				</c:if>
			</div>
		</div>
	</section>
</body>	
</html>