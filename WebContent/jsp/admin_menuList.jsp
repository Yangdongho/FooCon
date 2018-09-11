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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_menuList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		menuCounting = ${menuCounting};
		currentPage = ${currentPage};
	});
</script>    
<script src="<%=path%>/js/admin_menuList.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<c:set var="session" value="${sessionScope.AUTHORITY}"></c:set>
<input type="hidden" id="session" value="${USERID}">
<input type="hidden" id="authority" value="${AUTHORITY}">
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 메뉴 리스트 -->
	<section class="menu-list-area">
		<div class="content_container">
			<h2>메뉴리스트</h2>
			<c:if test="${session ne 'MASTER'}">
				<a class="add-btn" onclick="location.href='menuView';" >등록</a>
			</c:if>
			<div class="table_option">
				<div class="notice_search">
					<form action="menuList">
						<input type="text" name="keyword" placeholder="메뉴명, 메뉴코드를 입력해주세요.">
						<input type=submit value="검색">
					</form>
				</div>
			</div>
			<table class="menuTable">
				<caption>순번,브랜드명, 메뉴코드, 메뉴, 판매가, 주문, 순서변경, 비고</caption>
				<colgroup>
					<col style="width:5%">
					<col style="width:15%">
					<col style="width:10%">
					<col style="width:*%">
					<col style="width:5%">
					<col style="width:5%">
					<c:if test="${keyword eq null || empty keyword}">
						<col style="width:10%">
					</c:if>
					<col style="width:8%">
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>브랜드명</th>
						<th>메뉴코드</th>
						<th>메뉴</th>
						<th>판매가</th>
						<th>주문</th>
						<c:if test="${keyword eq null || empty keyword}">
						<th>순서변경</th>
						</c:if>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${pageTotalCount eq 0}">
							<tr>
								<td colspan="8" style="height:500px; vertical-align: middle; font-size: 18px; font-weight: 500;">등록된 메뉴가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${menuListView}" var="menu">
								<tr>
									<td>${menu.RNUM1}</td>
									<td>${menu.BRANDNAME}</td>
									<td class="menuCode">${menu.MENUCODE}</td>
									<td onclick="location.href='menuView?brandMenuNUM=${menu.BRANDMENUNUM}'">${menu.MENUNAME}</td>
									<td>${menu.MENUPRICE}</td>
									<td>${menu.TOTALORDERS}</td>
									<c:if test="${keyword eq null || empty keyword}">
										<td>
											<input class="sequence up_btn" type="button" value="▲" onclick="menuUp('${menu.BRANDMENUNUM}','${menu.MENUTURN}');">
											<input class="sequence down_btn" type="button" value="▼" onclick="menuDown('${menu.BRANDMENUNUM}','${menu.MENUTURN}');">
										</td>
									</c:if>
									<td><input class="delete_btn" type="button" value="삭제" onclick="menuDelete(this,'${menu.BRANDMENUNUM}');"></td>
								</tr>
							</c:forEach>	
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<c:if test="${!empty menuListView}">
			<div class = "page">
									<c:if test="${startPage !=1 }">
										<a href="menuList?page=1
											<c:if test="${keyword != null}">
												&keyword=${keyword}
											</c:if>
										">[처음]</a>
										<a href="menuList?page=${startPage-1}
											<c:if test="${keyword != null}">
												&keyword=${keyword}
											</c:if>
										">[이전]</a>
									</c:if> 
									
									<c:forEach var="pageNum" begin="${startPage}"
										end="${endPage < pageTotalCount ? endPage : pageTotalCount}">
										<c:choose>
											<c:when test="${pageNum == currentPage}">
												<b class="currentPage">${pageNum}</b>
											</c:when>
											<c:otherwise>
												<a class="remainPage" href="menuList?page=${pageNum}
												<c:if test="${keyword != null}">
													&keyword=${keyword}
												</c:if>
												">${pageNum}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach> 
									
									<c:if test="${endPage < pageTotalCount}">
										<a href="menuList?page=${endPage+1}
											<c:if test="${keyword != null}">
												&keyword=${keyword}
											</c:if>
										">[다음]</a>
										<a href="menuList?page=${pageTotalCount}
											<c:if test="${keyword != null}">
												&keyword=${keyword}
											</c:if>
										">[마지막]</a>
									</c:if>
									</div>
		</c:if>
		</div>
	</section>
</body>	
</html>