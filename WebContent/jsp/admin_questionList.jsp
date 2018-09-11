<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_questionList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
<script src="<%=path%>/js/admin_questionList.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>

</head>
<body>
<!-- HEADER -->

	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="question-list-area">
			<div class="content_container">
				<div class="submenu-list clearfix">
					<a href="<%=path%>/admin/board/questionList">1:1문의 관리</a>
					<a href="<%=path%>/admin/board/adReferenceList">광고/제휴문의 관리</a>
					
				</div>
				<h2>1:1문의 관리</h2>
				<div class="table_option">
				<form action="questionList"method="post">
					<div class="question_category">				
						<select name="cate">
						    <option value="">전체</option>
						    <option value="답변완료">답변완료</option>
						    <option value="답변대기">답변대기</option>
						</select>
						<input type="submit" value="적용" class="search">
					</div>
				</form>
				<form action="questionList"method="post">
					<div class="question_search">
						<input type="text" name="keyword" placeholder="제목,이메일을 입력해주세요.">
						<input type="submit" value="검색" class="search">
					</div>
				</form>
				</div>
				<table>
					<caption>답변여부, 문의제목, 이메일, 닉네임, 연락처, 날짜</caption>
					<colgroup>
						<col style="width:7%">
						<col style="width:*%">
						<col style="width:15%">
						<col style="width:7%">
						<col style="width:13%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>
							<th>답변여부</th>
							<th>문의제목</th>
							<th>이메일</th>
							<th>닉네임</th>
							<th>연락처</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${inquireList.adminInquireList}" var="inquire" >
							<tr>
								<c:choose>
									<c:when test="${inquire.INQUREREPLYSTATUS eq 'N'}">
										<td class="reply">답변대기</td>
									</c:when>
									<c:otherwise>
										<td class="reply">답변완료</td>
									</c:otherwise>
								</c:choose>
								
								<td title="${inquire.INQUIRETITLE}" class="t-title" onclick="modal('${inquire.INQUIRENUM}','${inquire.INQUREREPLYSTATUS}')">${inquire.INQUIRETITLE}</td>
								<td>${inquire.MEMBEREMAIL}</td>
								<td>${inquire.NICK}</td>
								<td>
								<!-- 휴대폰번호 자르기 -->
								<c:set var="Phone1" value="${fn:substring((inquire.MEMBERPHONE),0,3)}"></c:set>
								<c:set var="Phone2" value="${fn:substring((inquire.MEMBERPHONE),3,7)}"></c:set>
								<c:set var="Phone3" value="${fn:substring((inquire.MEMBERPHONE),7,11)}"></c:set>
									${Phone1} - ${Phone2} - ${Phone3}
								</td>
								<td>${inquire.INQUIREDATE}</td>
							</tr>
						</c:forEach>
					</tbody> 
				</table>
				<c:if test="${(empty inquireList.adminInquireList) and (!empty inquireList.keyword or !empty inquireList.cate)}">
				     <center><p id="none">검색결과가 없습니다.</p></center>
               </c:if>
			<div class="page">
				<c:if test="${inquireList.startPage!=1 }">
					<a href="questionList?pageNum=1">[처음]</a>
					<a href="questionList?pageNum=${inquireList.strtPage-1}&keyword=${inquireList.keyword}&cate=${inquireList.cate}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${inquireList.startPage}"
					end="${inquireList.endPage < inquireList.totalCount ? inquireList.endPage : inquireList.totalCount}">
					<c:choose>
						<c:when test="${pageNum == inquireList.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a class="remainPage" href="questionList?pageNum=${pageNum}&keyword=${inquireList.keyword}&cate=${inquireList.cate}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${inquireList.endPage < inquireList.totalCount}">
					<a href="questionList?pageNum=${inquireList.endPage+1}&keyword=${inquireList.keyword}&cate=${inquireList.cate}">[다음]</a>
					<a href="questionList?pageNum=${inquireList.endPage}&keyword=${inquireList.keyword}&cate=${inquireList.cate}">[마지막]</a>
				</c:if>
			</div>
			</div>

			
	<div class="modal-fade">
		<form class="inquire-reply" onsubmit="return nullcheck();">
		<input type="hidden" value="" name="">
			<div class="question-modal">
				<h3>1:1문의 상세내용</h3>
				<span class="close-btn"></span>
				<ul class="clearfix">
					<li id ="title"></li>
					<li class="content"></li>
					<li class="content1" ></li>
					<li class="content2" ></li>
				</ul>
				<textarea class="inquireContent" readonly="readonly"></textarea>
				<p>답변</p>
				<textarea id="reply_content"  placeholder="답변내용을 입력하세요.(1500자 이내)" maxlength="1500"></textarea>
				<center><input id="answer-btn" class="dsds" type="button" value="답변등록"></center>
			</div>
		</form>
	</div>
	</section>
<!-- 	modal -->
	<section>
	<div class="bgLayer">
	</div>
	</section>
</body>	
</html>