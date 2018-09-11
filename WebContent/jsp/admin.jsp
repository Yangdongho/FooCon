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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript" src="<%=path%>/js/admin.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
	<!-- 로그인 입력 -->
	<section class="login-area">
		<h2 class="hidden">login</h2>
		<div class="container">
			<div class="login_header">
				<p><span>관리자님 </span>환영합니다!</p>	
			</div>
			<div class="login_user login_form">
				<form name="frm" id="adminLoginForm" method="post">
					<input type="text" name="MASTER" id="id" placeholder="아이디" maxlength="40">
					<input type="password" name="OFFICEPASSWORD" id="pw" placeholder="비밀번호" maxlength="20">
					<input type="submit" value="로그인">
					<div class="login_option">
						<div class="auto_login">
							<input type="checkbox" id="ch01" name="AUTO" value="on" checked="checked">
							<label for="ch01">자동 로그인</label>	
						</div>
						<div class="login_link_text">
							<a href="admin/member/pwFind" class="login_link_pw">비밀번호 찾기</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
</body>	
</html>