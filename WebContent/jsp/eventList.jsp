<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/eventList.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">


</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - FooCon</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 로그인 입력 -->
	<section class="login-area">
		<h2 class="hidden">event</h2>
		<div class="container">
			<div class="login_header">
				<span>이벤트</span>	
			</div>
			
			<div class="eventList">
				<ul class="clearfix">
				
				<c:forEach items="${eventList}" var="event">
					<li>
						
						<img onclick="location.href='eventView?eventNum=${event.EVENTNUM}'" src="thumbnailImg?eventNum=${event.EVENTNUM}" alt="썸네일 이미지 "/>
						<span>${event.EVENTTITLE}</span><br>
						<span>${event.EVENTSTARTDATE } ~ ${event.EVENTENDDATE }</span>
					</li>
				</c:forEach>

				</ul>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>