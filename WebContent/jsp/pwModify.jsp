<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/pwModify.css">
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
				<p><span>비밀번호</span> 변경</p>	
			</div>
			<div class="change_password">
				<h6>회원님의 비밀번호는 안전하게 암호화되어 'Foocon'에서도 <br>알 수 없습니다. 새로운 비밀번호를 설정해주세요.<br>(8~20자리, 영문 대/소문자 구분, 영문/숫자/특수문자 1개씩 필수)</h6><br>
				<form>
					<input type="text" name="password" id="password" placeholder="변경하려는 비밀번호를 입력하세요.">
					<input type="text" name="passwordcheck" id="passwordcheck" placeholder="변경하려는 비밀번호를 한번 더 입력하세요.">
					<input type="submit" value="확인">
				</form>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>