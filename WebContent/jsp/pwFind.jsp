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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/pwFind.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript" src="<%=path%>/js/pwFind.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 로그인 입력 -->
	<section class="login-area">
		<div class="container">
			<div class="login_header">
				<p><span>비밀번호</span> 찾기</p>	
			</div>
			<div class="find_password">
				<h6>가입시 입력한 이메일 주소로 비밀번호 변경 가능한 링크를 보내드립니다.</h6><br>
				<form id="findPw" name="findPw">
					<input type="text" name="MEMBEREMAIL" id="email" placeholder="이메일 주소" maxlength="40">
					<input type="submit" value="확인" class="okPW">
				</form>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>