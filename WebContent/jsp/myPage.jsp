<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/myPage_modal.css">
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/myPage.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/myPage.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 2차 메뉴 -->
	<section class="two-depth-menu">
		<h2 class="hidden">two-depth-menu</h2>
		<div class="container">
			<ul class="clearfix">
				<li><a href="<%=path%>/point/pointList" class="menu_pointlist">적립금 관리</a></li>
				<li><a href="<%=path%>/order/orderList" class="menu_orderlist">주문내역</a></li>
				<li><a href="<%=path%>/member/interest?memberPK=${sessionScope.SEQ}" class="menu_likelist">관심트럭</a></li>
				<li><a href="<%=path%>/board/question" class="menu_question">1:1 문의내역</a></li>
				<li><a href="<%=path%>/member/pwCheck" class="menu_mypage">개인정보 수정/탈퇴</a></li>
			</ul>
		</div>
	</section>
	<!-- 포인트 게시판  -->
	<section class="mypage-area">
		<h2 class="hidden">"mypage-area"</h2>
		<div class="container">
			<h3>개인정보 수정/탈퇴</h3>
			<div class="memberInfo">
				<ul class="clearfix">
					<h4>개인정보 수정</h4>
					<li class="d01"><a class="email">이메일</a></li>
					<li class="d02"><a class="email01">${member.MEMBEREMAIL}</a></li>
					<li class="d03"><a class="nick">닉네임</a></li>
					<li class="d04"><a class="joinDate" id="nick01">${member.NICK}</a>&nbsp;&nbsp;&nbsp;<button onclick="modalNick()">변경</button></li>
					<li class="d05"><a class="password">비밀번호</a></li>
					<li class="d06"><button onclick="modalPW()" class="w3-button w3-black">변경</button></li>
					<li class="d07"><a class="phoneNum">휴대번호</a></li>
					<li class="d08"><a class="joinDate" id="phoneNum01">
						<c:set var="Phone1" value="${fn:substring((member.MEMBERPHONE),0,3)}"></c:set>
                        <c:set var="Phone2" value="${fn:substring((member.MEMBERPHONE),3,7)}"></c:set>
                        <c:set var="Phone3" value="${fn:substring((member.MEMBERPHONE),7,11)}"></c:set>
                           ${Phone1} - ${Phone2} - ${Phone3}
                        </a>&nbsp;&nbsp;&nbsp;<button onclick="modalPhone()" class="w3-button w3-black">변경</button></li>
					<li class="d09"><a class="notice">
	- 아이디(이메일)수정이 불가능합니다.<br>
	- 닉네임, 휴대번호는 타인의 계정과 중복이 불가능 합니다.<br>
	- 닉네임은 2글자 이상 8자 이하 영어 숫자 한글 이여만 합니다.(※ 특수문자는 불가능 합니다.)<br>
	- 변경하고자 하는 비밀번호의 구성은 한글, 숫자, 특수문자가 필수로 입력되어야 합니다.<br>
	</a></li>
				</ul>
			</div>

			<div class="withdraw">
					<form id="quitMember">
						<ul class="clearfix">
							<h4>회원탈퇴</h4>
							<li class="d01"><a class="ment">탈퇴를 하시면 적립금 및 모든 정보가 사라집니다. 정말 탈퇴하시겠습니까?</a></li>
							<li class="d02"><input type="password" name="MEMBERPASSWORD" id="WDpasswordCheck" placeholder="비밀번호를 입력하세요."  maxlength="20">
							<li class="d03"><input type="submit" value="탈퇴하기"></li>
						</ul>
					</form>
				</div>
			</div>

<!-- 모달 시작 -->	
<!-- ****************************************************************************** -->		
	<!-- 닉네임 변경하기 -->
	<div class="bgLayer">
   	</div>
   	<div class="modal-fade">
		<div class="w3-containerNick">
			<div class="changeNick_header">
				<a class="close-btn"></a>
				<h3>닉네임 변경하기</h3>
			</div>
			<div class="changeNick_form">
				<form id="memberChangeNick" name="frmNick">
					<input type="text" name="WANTINGNICK" id="changeNick" placeholder="변경할 닉네임을 입력하세요." maxlength="8">
					<a>닉네임은 2글자 이상 8자 이하 영어 숫자 한글 이여만 합니다.</a>
					<input id="updateNick-btn"type="submit" value="수정완료">
				</form>
			</div>
		</div>
	</div>

<!-- ****************************************************************************** -->
	<!-- 비밀번호 변경하기 -->
	<div class="bgLayer"></div>
	<div class="modal-fade">
		<div class="w3-containerPW">
			<div class="changePW_header">
				<a class="close-btn"></a>
				<h3>비밀번호 변경하기</h3>
			</div>
			<div class="changepw_form">
				<form id="memberChangePw" name="frmPW">
					<input type="password" name="ORIGINPASSWORD" id="originPassword" placeholder="현재 비밀번호를 입력하세요." maxlength="20"> 
					<input type="password" name="WANTINGPASSWORD" id="wantingPassword" placeholder="변경하려는 영어 숫자 특수문자의 비밀번호를 입력하세요.(8~20자)" minlength="8"  maxlength="20"> 
					<input type="password" name="WANTINGPASSWORDCHECK" id="wantingPasswordCheck" placeholder="변경하려는 비밀번호를 한번 더 입력하세요." minlength="8"  maxlength="20"> 
					<input id="updatePW-btn"type="submit" value="수정완료">
				</form>
			</div>
		</div>
	</div>

<!-- ****************************************************************************** -->			
	<!-- 휴대번호 변경하기 -->
	<div class="bgLayer"></div>
	<div class="modal-fade">
		<div class="w3-containerPhoneNum">
			<div class="changePhoneNum_header">
				<a class="close-btn"></a>
				<h3>휴대폰 변경하기</h3>
			</div>
			<div class="changePhoneNum_form">
				<form id="memberChangePhoneNum" name="frmPhoneNum">
					<input type="text" name="WANTINGPHONENUM" id="changePhoneNum" placeholder="휴대번호를 입력하세요.('-' 제외)" minlength="10" maxlength="11">
					<input type="text" name="WANTINGPHONENUMCHECK" id="changePhoneNumDoublecheck" placeholder="한 번 더 휴대번호를 입력하세요.('-' 제외)" minlength="10" maxlength="11">
					<input id="updatePhone-btn"type="submit" value="확인">
				</form>
			</div>
		</div>
	</div>

<!-- modal 끝 -->
<!-- ****************************************************************************** -->		
		
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>

	
</body>	
</html>