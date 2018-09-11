<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%String path=request.getContextPath();%>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_adReferenceView.css">
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
	<!-- 광고/제휴문의 뷰페이지 -->
	<section class="advertise-area">
		<div class="content_container">
			<h2>광고/제휴문의 상세페이지</h2>	
			<div class="advertise">
				<ul class="clearfix">
					<li>
						<i>문의유형 </i>
						<c:choose>
							<c:when test="${adReferenceView.INQUIRETYPE eq 'AD'}">
								<span>광고문의</span>	
							</c:when>
							<c:otherwise>
								<span>제휴문의</span>
							</c:otherwise>
						</c:choose>
					</li>
					<li>
						<i>이름 </i>
						<span>${adReferenceView.INQUIRENAME}</span>
					</li>
					<li>
						<i>연락처</i>
						<span>${adReferenceView.INQUIREPHONE}</span>
					</li>
					<li>
						<i>날짜 </i>
						<span>${adReferenceView.ADINQUIREDATE}</span>
					</li>
					<li>
						<i>업체명 </i>
						<span>${adReferenceView.INPUIREBRAND}</span>
					</li>
					<li>
						<i>상세주소 </i>
						<span>${adReferenceView.INPUIREADDRESS}</span>
					</li>
				</ul>
				<!-- 여기는 에디터 들어갈 영역  Start-->
				<textarea class="edit" readonly="readonly">
					${adReferenceView.INPUIRECONTENT}
				</textarea>
			</div>
		</div>
	</section>
</body>	
</html>