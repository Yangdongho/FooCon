<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% String path=request.getContextPath(); %>   
 
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_brandList.css">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
  
<%-- <script type="text/javascript" src="${path}/js/admin_mainList.js"></script> --%>

<script type="text/javascript">
	

function brandList(context){	
	//메인화면에서 브랜드네임을 누르면 링크이동하게 하는거
	location.href= context+"/admin/brand/brandList";}	
	
	
function newBrand(context){
	location.href= context+"/admin/brand/newBrand";
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 서비스명</title>
</head> 
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 메뉴 리스트 -->
	<section class="menu-list-area">
		<div class="content_container">
			
			<!-- 탭 추가하기  페이징으로 넘기기 -->
			<div class = "brandTab">
			<button  class="tabLink" onclick="javascript:brandList('${pageContext.request.contextPath}');" >브랜드 리스트</button>
			<button class="tabLink" onclick="javascript:newBrand('${pageContext.request.contextPath}');" >브랜드 생성</button>
			</div>
			<br><br><br><br>
			
			<h2>브랜드 리스트</h2>
			
		<div  id ="brandList" class = "tabcontent">
		
			<div class="table_option">
				<div class="notice_search">
				
				<form action="brandList">
					<input type="text" name="keyword" placeholder="매장명을 입력해주세요">
					<input type="submit" value="검색">
				</form>	
							
				</div>
				
				<div class="question_category">   				      
				     <form action="brandList">   				            
<%-- 				           <input type="hidden" name="keyword" value="${viewData.keyword}"> --%>
				                  <select name="category" class = "category">
				                      <option value="">전체</option>
				                      <option value="recommand" <c:if test="${param.category == 'recommand'}">selected</c:if> <c:if test="${viewData.category == 'PACKAGE'}">selected</c:if>>추천</option>
				                      <option value="normal" <c:if test="${param.category == 'normal'}">selected</c:if>>일반</option>
				                  </select>
				             <input type="submit" value="적용">
				      </form>         				               
				</div>
			</div>
			<table>

				<caption>순번, 매장명, 추천여부, 이메일, 이름, 연락처, 가입일</caption>
				<colgroup>
					<col style="width:10%">
					<col style="width:28%">
					<col style="width:2%">
					<col style="width:*%">
					<col style="width:7%">
					<col style="width:20%">
					<col style="width:15%">
				</colgroup>
				<thead>
					<tr>
						<th>순번</th>
						<th>매장명</th>
						<th>추천여부</th>
						<th>이메일</th>
						<th>이름</th>
						<th>연락처</th>
						<th>가입일</th>
					</tr>
				</thead>
				<tbody>
				

				
<!-- 				여기서 반복문 돌려준다 -->

				<c:forEach items = "${viewData.selectAllBrandList}" var = "searchList">
				
				<c:choose>		
					<c:when test="${searchList.EXPOSURELEVEL eq 'RECOMMAND' or 'PACKAGE'}">
					<tr class = 'recommand'>
						<td>${searchList.RNUM1}</td>
						<td>${searchList.BRANDNAME}</td>
						<td >추천</td>
						<td>${searchList.OWNEREMAIL}</td>
						<td>${searchList.OWNERNAME}</td>			
						<td>			
						<c:set var="Phone1" value="${fn:substring((searchList.OWNERPHONE),0,3)}"></c:set>
                        <c:set var="Phone2" value="${fn:substring((searchList.OWNERPHONE),3,7)}"></c:set>
                        <c:set var="Phone3" value="${fn:substring((searchList.OWNERPHONE),7,11)}"></c:set>  
                                                 
						${Phone1} - ${Phone2} - ${Phone3}</td>
						<td>${searchList.OWNERREGDATE}</td>
					</tr>		
					</c:when>
					<c:when test="${searchList.EXPOSURELEVEL eq 'PACKAGE'}">
					<tr class = 'recommand'>
						<td>${searchList.RNUM1}</td>
						<td>${searchList.BRANDNAME}</td>
						<td >추천</td>
						<td>${searchList.OWNEREMAIL}</td>
						<td>${searchList.OWNERNAME}</td>
						<td>			
						<c:set var="Phone1" value="${fn:substring((searchList.OWNERPHONE),0,3)}"></c:set>
                        <c:set var="Phone2" value="${fn:substring((searchList.OWNERPHONE),3,7)}"></c:set>
                        <c:set var="Phone3" value="${fn:substring((searchList.OWNERPHONE),7,11)}"></c:set>                                                  
						${Phone1} - ${Phone2} - ${Phone3}</td>
						
						<td>${searchList.OWNERREGDATE}</td>
					</tr>		
					</c:when>
					<c:otherwise>					
					<tr>
						<td>${searchList.RNUM1}</td>
						<td>${searchList.BRANDNAME}</td>
						<td >일반</td>
						<td>${searchList.OWNEREMAIL}</td>
						<td>${searchList.OWNERNAME}</td>
						<td>			
						<c:set var="Phone1" value="${fn:substring((searchList.OWNERPHONE),0,3)}"></c:set>
                        <c:set var="Phone2" value="${fn:substring((searchList.OWNERPHONE),3,7)}"></c:set>
                        <c:set var="Phone3" value="${fn:substring((searchList.OWNERPHONE),7,11)}"></c:set>                                                   
						${Phone1} - ${Phone2} - ${Phone3}</td>
						
						<td>${searchList.OWNERREGDATE}</td>
					</tr>	
					
					</c:otherwise>				
				</c:choose>
					
				</c:forEach>	


							
				</tbody>
			</table>
			
			<c:if test="${empty viewData.selectAllBrandList}">
					<br><br><br>
                  <center><p id="none">검색결과가 없습니다.</p></center>
            </c:if>
			
			<br><br>
			
			<div class="page">
				<c:if test="${viewData.startPage !=1 }">
						<a href="brandList?page=1

							<c:if test = "${viewData.keyword != null}">						
							&keyword=${viewData.keyword}							
							</c:if>
							
							<c:if test = "${viewData.category != null}">						
							&category=${viewData.category}							
							</c:if>
							
						">[처음]</a>
						<a href="brandList?page=${viewData.startPage-1}&keyword=${viewData.keyword}">[이전]</a>
					</c:if> <c:forEach var="pageNum" begin="${viewData.startPage}"
						end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
						<c:choose>
							<c:when test="${pageNum == viewData.currentPage}">
							<b class="currentPage">${pageNum}</b>
							</c:when>
							<c:otherwise>
								<a class="remainPage" href="brandList?page=${pageNum}
							
							<c:if test = "${viewData.keyword != null}">						
							&keyword=${viewData.keyword}							
							</c:if>
							
							<c:if test = "${viewData.category != null}">						
							&category=${viewData.category}							
							</c:if>
								
								">${pageNum}</a>
							</c:otherwise>
						</c:choose>


					</c:forEach> <c:if test="${viewData.endPage < viewData.pageTotalCount}">
						<a href="brandList?page=${viewData.endPage+1}
							
							<c:if test = "${viewData.keyword != null}">						
							&keyword=${viewData.keyword}							
							</c:if>
							
							<c:if test = "${viewData.category != null}">						
							&category=${viewData.category}							
							</c:if>
						
						">[다음]</a>
						<a href="brandList?page=${viewData.pageTotalCount}

							<c:if test = "${viewData.keyword != null}">						
							&keyword=${viewData.kewword}							
							</c:if>
							
							<c:if test = "${viewData.category != null}">						
							&category=${viewData.category}							
							</c:if>							
						">[마지막]</a>
					</c:if>
			</div>			
		</div>
	</div>
	</section>
</body>	
</html>