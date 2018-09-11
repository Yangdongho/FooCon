<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/question.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script type="text/javascript">
 	var num = ${num};
$(function(){
	on(num);
}) 
</script>
<script src="<%=path%>/js/question.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="header.jsp" />
	<!-- 2차 메뉴 -->
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
	<!-- 문의내역 탭  -->
	<section class="question-tab-area">
	<h2 class="hidden">question-tab-area</h2>
	<div class="container">
		<h3>1:1 문의내역</h3>
		<ul class="question_teb">
			<li>FAQ</li>
			<li>문의내역</li>
			<li>문의작성</li>
		</ul>
	</div>
	</section>
	<!-- FAQ  -->
	<section class="question-content">
	<h2 class="hidden">question-content</h2>
	<div class="container">
		<div class="questionlist_area">
			<ul class="questionlist">
				<c:forEach items="${totalMap.faqList}" var="faq">
					<li>
						<div class="question_front">
							<div class="post_label"></div>
							<a>${faq.FAQTITLE}</a>
						</div>
						<div class="question_back">
							<div class="question_back_qs">
								<p>${faq.FAQTITLE}</p>
							</div>
							<p style="text-align: right;">
								<span>작성일 ${faq.FAQREGDATE}</span>
							</p>
							<div class="question_back_ans">
								<p>${faq.FAQCONTENT}</p>
								<br>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	</section>

	<!-- 문의내역  -->
	<section class="question-content">

	<h2 class="hidden">question-content</h2>
	<div class="container">
		<div class="questionlist_area">
			<p>
				문의 <span>${totalMap.totalContent}</span> 건
			</p>
			<ul class="questionlist">
				<c:forEach items="${totalMap.userInquireList}" var="userInquire">
					<li>
						<c:choose>
							<c:when test="${userInquire.INQUREREPLYSTATUS eq 'N'}">
								<div class="question_front">
								<div class="post_label">
									<span class="answer_noncompleted">답변대기</span>
									<span>${userInquire.INQUIREDATE}</span> 
									<a>${userInquire.INQUIRETITLE}</a>
								</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="question_front">
								<div class="post_label">
									<span class="answer_completed">답변완료</span>
									<span>${userInquire.INQUIREDATE}</span> 
									<a>${userInquire.INQUIRETITLE}</a>
								</div>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="question_back">
							<div class="question_back_qs">
								<p class="title qs">문의</p>
								<p>${userInquire.INQUIRECONTENT}</p>
							</div>
						<c:choose>
							<c:when test="${!empty userInquire.INQUIREREPLYCONTENT}">
									<div class="question_back_ans">
										<p class="title ans">
											답변 <span>${userInquire.INQUIREREPLYREGDATE}</span>
										</p>
										<p>${userInquire.INQUIREREPLYCONTENT}</p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="question_back_ans">
										<p class="title ans">
										</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					</li>
				</c:forEach>
			</ul>
			<div class="page">
				<c:if test="${totalMap.startPage!=1 }">
					<a href="question?pageNum=1">[처음]</a>
					<a href="question?pageNum=${totalMap.strtPage-1}">[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${totalMap.startPage}"
					end="${totalMap.endPage < totalMap.totalCount ? totalMap.endPage : totalMap.totalCount}">
					<c:choose>
						<c:when test="${pageNum == totalMap.currentPage}">
							<b class="currentPage">${pageNum}</b>
						</c:when>
						<c:otherwise>
							<a href="question?pageNum=${pageNum}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${totalMap.endPage < totalMap.totalCount}">
					<a href="question?pageNum=${totalMap.endPage+1}">[다음]</a>
					<a href="question?pageNum=${totalMap.endPage}">[마지막]</a>
				</c:if>
			</div>
		</div>
	</div>
	</section>

	<!-- 문의 작성 -->
	<section class="question-content">
	<h2 class="hidden">write-question</h2>
	<div class="container">
		<div class="write-question">
			<div class="write_area">
				<p>1:1 문의하기</p>
				<div class="writelist">
					<form action="questionWrite" onsubmit="return nullcheck();" >
						<ul class="clearfix">
							<li>
								<div>
									<input type="hidden" value="${MemberNum}" name="MemberNum">
									<p id="ptitle">제목</p>
									<input type="text" name="INQUIRETITLE" id="title"
										placeholder="문의하실 내용의 제목을 입력해주세요(50 자 이내)" maxlength="50">
								</div>
							</li>
							<li>
								<div>
									<p id="ptext">내용</p>
									<textarea style="resize: none" 
										name="INQUIRECONTENT" id="textarea" rows="30" cols="150"
										placeholder="문의하실 내용을 입력해주세요(1000 자 이내)"></textarea>

								</div>
							</li>
						</ul>
						<input type="submit" value="확 인" class = "question">
					</form>
				</div>
			</div>
		</div>
	</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp" />
</body>
</html>