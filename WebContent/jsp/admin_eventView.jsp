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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_eventView.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  		crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function(){

		startCalendar = '${event.EVENTSTARTDATE}';
		endCalendar = '${event.EVENTENDDATE}';
		type = '${type}';
	});

</script>  
<script src="<%=path%>/js/admin_eventView.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - FooCon</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 뷰페이지 -->
	<section class="notice-list-area">
		<div class="content_container">
			<div class="submenu-list clearfix">
				<a href="${pageContext.request.contextPath}/admin/board/noticeList">공지사항</a>
				<a href="${pageContext.request.contextPath}/admin/board/eventList">이벤트</a>
				<a href="${pageContext.request.contextPath}/admin/board/faqList">FAQ</a>
			</div>
			<h2>이벤트 등록 및 수정</h2>	
			<form action="eventWrite?type=${type}&eventNum=${event.EVENTNUM}" enctype="multipart/form-data" 
				  method="post" onsubmit="return check();">
				<input id="title" type="text" name="title" placeholder="제목을 입력해주세요." value="${event.EVENTTITLE}">
				
					
					<c:if test="${type==1}">
						<span id="regDate">등록날짜 : ${event.EVENTREGDATE}</span>
						<span>조회수 ${event.EVENTVIEWCOUNT}</span>
					</c:if>
					
					<div class="option">
						<label>기간</label>
						<input type="text" id="startCalendar" class="datepicker" name="startCalendar" > ~ 
						<input type="text" id="endCalendar" class="datepicker" name="endCalendar" readonly="readonly">
					
					</div>
					<div class="clearfix" id="imgCategory">
						<ul>
							<li><label>이벤트 상세 이미지</label></li>
							<li><input id="imgInp" type="file" name="eventImg"></li>
						</ul>
						<ul class="clearfix">
							<li><label>썸네일 첨부파일</label></li>
							<li><input type="file" name="thumnail" id="thumnail"></li>
						</ul>
					</div>
				<!-- 여기는 에디터 들어갈 영역  Start-->
				<div class="edit">
					<br>
						<img id="blah1" src="eventImg?eventNum=${event.EVENTNUM}&type=1" alt="상세 이미지 미리보기"  />
						<img id="blah2" src="eventImg?eventNum=${event.EVENTNUM}&type=2" alt="썸네일" />
					
				</div>
				<!-- 여기는 에디터 들어갈 영역  End-->
			
				<div class="notice_view_option clearfix">
				
					<!-- <div>
						<label>썸네일 첨부파일</label>
						<input type="file" name="thumnail" id="thumnail">						
					</div> -->
				</div>
				<input type="submit" value="저장">
			</form>
		</div>
	</section>
</body>
</html>