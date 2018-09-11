<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_noticeView.css">
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
			<h2>공지사항 상세보기 및 수정</h2>	
			<form action="noticeView"  enctype="multipart/form-data" method="post" onsubmit="return nullcheck();">
				<input type="hidden" name="noticeNum" value="${notice.NOTICENUM}">
				<input type="hidden" name="noticeType" value="${notice.NOTICETYPE}">
				<input type="text" id="input" name="title" placeholder="제목을 입력해주세요." maxlength="100" value="${notice.NOTICETITLE}">
				
				<!-- 여기는 에디터 들어갈 영역  Start-->
				<textarea id="edit" maxlength="100" name="content">${notice.NOTICECONTENT}</textarea>
				
				<!-- 여기는 에디터 들어갈 영역  End-->
				<div class="notice_view_option clearfix">
					<label>첨부파일</label>
					<input id="image_upload" multiple="multiple" type="file" name="file"><br><br><br>
					<c:if test="${!empty notice.UPLOADFILE1}">
						<a href="download?fileName=${notice.UPLOADFILE1}" name = uploadfile1 >첨부 파일 1 : ${fn:substringAfter(notice.UPLOADFILE1,'_')}</a><br>
					</c:if>
					<c:if test="${!empty notice.UPLOADFILE2}">
						<a href="download?fileName=${notice.UPLOADFILE2}" name = uploadfile2>첨부 파일 2 : ${fn:substringAfter(notice.UPLOADFILE2,'_')}</a><br>
					</c:if>
					<c:if test="${!empty notice.UPLOADFILE3}">
						<a href="download?fileName=${notice.UPLOADFILE3}" name = uploadfile3>첨부 파일 3 : ${fn:substringAfter(notice.UPLOADFILE3,'_')}</a>
					</c:if>
				</div>
				<div class="btn">
					<input type="submit" value="저장">
					<input type="button"  id="list-btn" value="목록" onclick="location.href='noticeList'">
				</div>
			</form>
		</div>
	</section>
	
</body>	
</html>