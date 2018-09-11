<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_newBrand.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript" src="<%=path%>/js/admin_newBrand.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="header_admin.jsp" />
	<!-- 메뉴 리스트 -->
	<section class="menu-list-area">
		<form id="registBrand" name="frm">
			<div class="content_container">
				<!-- 탭 추가하기  페이징으로 넘기기 -->
				<div class="brandTab">
					<input type="button" class="tabLink" value="브랜드 리스트" onclick="javascript:brandList('${pageContext.request.contextPath}');">
					<input type="button" class="tabLink" value="브랜드 생성" onclick="javascript:newBrand('${pageContext.request.contextPath}');">
				</div>
				<div class="headermenu_left">
					<h2>브랜드 생성</h2>
				</div>
				<div class="table_option"></div>
				<div class="memberInfo">
					<ul class="clearfix">
						<li class="d01"><span class="email width">이메일</span> 
						<input type="text" name="OWNEREMAIL" placeholder=" 이메일을 입력해주세요." maxlength="40"></li>
						<li class="d02"><span class="name width">이름</span> 
						<input type="text" name="OWNERNAME" placeholder=" 이름을 입력해주세요." maxlength="8"></li>
						<li class="d03"><span class="password width">비밀번호</span> 
						<input type="password" name="OWNERPASSWORD" placeholder=" 영어 숫자 특수문자의 비밀번호를 입력하세요.(8~20자)" minlength="8"  maxlength="20"></li>
						<li class="d04"><span class="phoneNum width">휴대번호</span>
						<input type="text" name="OWNERPHONE" placeholder=" '-'없이 휴대번호를 입력해주세요." maxlength="11"></li>
					</ul>
					<ul>
						<li class="notice_add">
							<input type="submit" value="등록">
						</li>
					</ul>
					<ul>
						<li class="d05"><a class="notice">
- 아이디(이메일)수정이 불가능합니다.<br>
- 닉네임, 휴대번호는 타인의 계정과 중복이 불가능 합니다.<br>
- 닉네임은 2글자 이상 8자 이하 영어 숫자 한글 이여만 합니다.(※ 특수문자는 불가능 합니다.)<br>
- 변경하고자 하는 비밀번호의 구성은 한글, 숫자, 특수문자가 필수로 입력되어야 합니다.<br>
- 입력하신 핸드폰 번호로 주문번호 및 정보가 자동발송됩니다. 신중히 입력해주시기 바랍니다.<br>
						</a></li>
					</ul>
				</div>
			</div>
		</form>
	</section>
</body>
</html>