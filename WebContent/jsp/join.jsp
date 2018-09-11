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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/join.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript"  src="<%=path%>/js/join.js"></script>
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
				<p><span>회원가입</span></p>	
			</div>
			<div class="join"> 
				<form name="frm" action="join" id="joinForm" method="post">
					<input type="text" name="MEMBEREMAIL" id="id" placeholder="아이디(이메일)을 입력해주세요." maxlength="40">
					<input type="text" name="NICK" id="nick" placeholder="닉네임을 입력하세요. (2~8자)" minlength="2" maxlength="8">
					<input type="password" name="MEMBERPASSWORD" id="password" placeholder="영어 숫자 특수문자의 비밀번호를 입력하세요.(8~20자)" minlength="8" maxlength="20">
					<input type="password" name="MEMBERPASSWORDcheck" id="passwordcheck" placeholder="비밀번호를 한번 더 입력하세요." minlength="8" maxlength="20">
					<input type="text" name="MEMBERPHONE" id="phoneNum" placeholder="휴대번호를 입력하세요.('-' 제외)" minlength="10" maxlength="11">
					<input type="submit" value="회원가입 완료">
				</form>
			</div>
			
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>