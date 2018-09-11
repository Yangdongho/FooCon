<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
<!-- include summernote-ko-KR -->
<script src="<%=path%>/js/summernote-ko-KR.js"></script>
<script src="<%=path%>/js/admin_notice.js"></script>


<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_noticeWrite.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
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
			<h2>공지사항 등록 및 수정</h2>	
			<form action="noticeWrite"  enctype="multipart/form-data" method="post" onsubmit="return nullcheck();">
				<input type="text" id="input" name="title" placeholder="제목을 입력해주세요." maxlength="100">
				
				<!-- 여기는 에디터 들어갈 영역  Start-->
				<textarea id="edit"  name="content"></textarea>
				
				<!-- 여기는 에디터 들어갈 영역  End-->
				<div class="notice_view_option clearfix">
					<div class="option">
						<label>공지유형</label>
						<select name="category" id="category">
						    <option value="">전체</option>
						    <option value="IMPORTANT">공지</option>
						    <option value="NORMAL">일반</option>
						</select>
					</div>
					<div>
						<label>첨부파일</label>
						<input id="image_upload" multiple="multiple" type="file" name="file">
					</div>
				</div>
				<input type="submit"value="등록" class="save">
			</form>
		</div>
	</section>
</body>	
</html>