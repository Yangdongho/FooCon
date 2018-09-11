<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_reviewList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
<script src="<%=path%>/js/sockjs.js"></script> 
<script src="<%=path%>/js/stomp.js"></script>

<script type="text/javascript">

var context = '${pageContext.request.contextPath}';
var SEQ = '${sessionScope.SEQ}';
var authority = '${sessionScope.AUTHORITY}';






</script>
<script src="<%=path%>/js/admin_reviewList.js"></script>  

<script type="text/javascript">
	
	$(function() {
		
		if (authority == 'BRAND'){
			
			$("table tbody td").css("padding","13px 0");
			
		// 	table tbody td{padding:13px 0; border-bottom:1px solid #ececec; font-weight: 350;}
				
		}
		
	});

	
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - FooCon</title>



</head>
<body>
<!-- HEADER -->

	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="question-list-area">
		
	
	<div id="myModal" class="modal">
		<span class="close">×</span>
		<img class="modal-content" id="img01">
	</div>
	
			<div class="content_container">
				<div class="submenu-list clearfix">
				
				</div>
				<h2>리뷰 관리</h2>
				<div class="table_option">
					<div class="question_category">	
		
					<form action="reviewList">	
				
							<input type="hidden" name="keyword" value="${viewData.keyword}">
						<select name="category">
						    <option value="">전체</option>
						    <option value="Y" <c:if test="${viewData.category == 'Y'}">selected</c:if>>답변완료</option>
						    <option value="N" <c:if test="${viewData.category == 'N'}">selected</c:if>>답변대기</option>

						</select>
						<input type="submit" value="적용">
					</form>			
					
					</div>
					<div class="question_search">
						<form action="reviewList">
							<input type="hidden" name="category" value="${viewData.category}">
							<input type="text" name="keyword" placeholder="이메일을 입력해주세요.">
							<input type="submit" value="검색">
						</form>
					</div>
				</div>
				<table>
					<caption>답변여부, 브랜드명, 문의내용, 이메일, 별점, 날짜, 비고</caption>
					<colgroup>
						<col style="width:10%">
						<col style="width:15%">
						<col style="width:*%">
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:18%">
						<c:if test="${AUTHORITY eq 'MASTER'}">
							<col style="width:10%">
						</c:if>
						
					</colgroup>
					<thead>
						<tr>
							<th>답변여부</th>
							<th>브랜드명</th>
							<th>리뷰제목</th>
							<th>이메일</th>
							<th>별점</th>
							<th>날짜</th>
							<c:if test="${AUTHORITY eq 'MASTER'}">
								<th>비고</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${viewData.reviewList}" var="review">
							<tr>
								<c:if test="${review.REPLYSTATUS eq 'N'}">
									<td>답변대기</td>
								</c:if>
								<c:if test="${review.REPLYSTATUS eq 'Y'}">
									<td>답변완료</td>
								</c:if>
								
								<td>${review.BRANDNAME}</td>
								<td onclick="review_modal('${review.REVIEWNUM}')" title = "${review.REVIEWCONTENT }">${review.REVIEWCONTENT }</td>
								<td>${review.MEMBEREMAIL }</td>
								<td>${review.STARGRADE}.0</td>
								
								<td><fmt:formatDate value="${review.REVIEWREGDATE}" pattern="yyyy.MM.dd"/></td>
								
								
								<c:if test="${AUTHORITY eq 'MASTER'}">
									<td><input class="deleteBtn" type="button" value="삭제" onclick="deleteReview('${review.REVIEWNUM}')"></td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				

				<c:choose>
					<c:when test="${empty viewData.reviewList && !empty viewData.keyword}">
						<p id="empty">검색 결과가 없습니다.</p>
					</c:when>
					<c:otherwise>
					<c:if test="${!empty viewData.reviewList}">
						<div class = "page">
							<c:if test="${viewData.startPage !=1 }">
							<a href = "reviewList?pageNumber=1&keyword=${viewData.keyword}&category=${viewData.category}
									<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
							">[처음]</a>
							<a href = "reviewList?pageNumber=${viewData.startPage-1}&keyword=${viewData.keyword}&category=${viewData.category}">[이전]</a>
							</c:if>	
			
							<c:forEach var = "pageNum" begin="${viewData.startPage}" end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
							<c:choose>
								<c:when test="${pageNum == viewData.currentPage}">
									<b class="currentPage">${pageNum}</b>
								</c:when>
								<c:otherwise>
									<a class="remainPage" href="reviewList?pageNumber=${pageNum}&keyword=${viewData.keyword}&category=${viewData.category}
										<c:if test = "${!empty viewData.keyword} ">&keyword=${viewData.keyword}	</c:if>
									">${pageNum}</a>	
								</c:otherwise>
							</c:choose>
							</c:forEach>
							
							<c:if test = "${viewData.endPage < viewData.pageTotalCount}">
							<a href = "reviewList?pageNumber=${viewData.endPage+1}&keyword=${viewData.keyword}&category=${viewData.category}">[다음]</a>
							<a href = "reviewList?pageNumber=${viewData.pageTotalCount}&keyword=${viewData.keyword}&category=${viewData.category}">[마지막]</a>
						</c:if>
			
						</div>
					</c:if>
					</c:otherwise>
					
				</c:choose>
				
		
				
				
			</div>
			
		
			
	</section>
<!-- 	modal -->
	<section>
	<div class="bgLayer">
	</div>
	<div class="modal-fade">
			<div class="question-modal">
				<h3>리뷰 상세내용</h3>
				<span class="close-btn"></span>
				<ul class="clearfix"id="question-view">
					<li class="content"></li>
					<li class="content1" ></li>
					<li class="content2" ></li>
				</ul>
				<textarea id="userContent" readonly ></textarea>
				<label id="fileLabel">첨부파일</label><a id="REVIEWPHOTO"></a>
				<p>답변</p>
				<form action="" id="replyForm"> 
					<textarea  id="content" name="brandReplyContent"></textarea>
					<center><input id="answer-btn" type="submit" value="답변등록"></center>
					<center><input id="answer-btn1" type="button" value="답변완료"></center>
				</form>
			</div>
	</div>
	</section>

	
	
	

</body>	
</html>