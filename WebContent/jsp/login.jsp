<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/login.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	var context = '${pageContext.request.contextPath}';
	
</script>
<script type="text/javascript"  src="<%=path%>/js/login.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
	<!-- HEADER -->
	<jsp:include page="header.jsp" />
	<!-- 로그인 입력 -->
	<section class="login-area">
	<h2 class="hidden">login</h2>
	<div class="container">
		<div class="login_header">
			<p>
				<span>로그인</span>하고, 혜택받으세요!
			</p>
		</div>
		<ul class="login_tab">
			<li>회원</li>
			<li>비회원</li>
		</ul>
		<div class="login_user login_form">
			<form name="frm" id="loginForm" method="post">
				<input type="text" name="MEMBEREMAIL" id="id" placeholder="이메일" maxlength="40"> 
				<input type="password" name="MEMBERPASSWORD" id="pw" placeholder="비밀번호" minlength="8" maxlength="20"> 
				<input type="submit" value="로그인">
					
				<div class="login_option">
					<div class="auto_login">
						<input type="checkbox" id="ch01" name="AUTO" value="on"
							checked="checked"> <label for="ch01">자동 로그인</label>
					</div>
					<div class="login_link_text">
						<a href="pwFind" class="login_link_pw">비밀번호 찾기</a> 
						<a href="terms" class="login_link_join">회원가입</a>
					</div>
				</div>
			</form>
<!-- 			<div class="login_sns"> -->
<!-- 				<p>간편로그인</p> -->
<!-- 				<div id="naver_id_login"></div> -->
<!-- 				<a id="kakao-login-btn"></a> -->
<!-- 				<div class="fb-login-button" scope="public_profile,email" onlogin="checkLoginState();" data-max-rows="1" data-size="large" -->
<!-- 					data-button-type="login_with" data-show-faces="false" -->
<!-- 					data-auto-logout-link="false" data-use-continue-as="false"></div> -->


<!-- 				<ul> -->
<!-- 					<li class="login_sns_facebook">페이스북</li> -->
<!-- 					<li class="login_sns_naver">네이버</li> -->
<!-- 					<li class="login_sns_kakaotalk">카카오톡</li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
		</div>
		<div class="login_user login_form">
			<form class="nonMemberForm">
				<input type="text" name="orderNum" id="orderNum" placeholder="주문번호">
				<input type="button" value="주문내역 조회" onclick="temp();">
			</form>
		</div>
	</div>

	<!-- 네아로 스크립 시작 
	<div id="naver_id_login"></div>
	<script type="text/javascript"
		src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
		charset="utf-8">
	</script> 
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-1.11.3.min.js">
	</script> 
	<script type="text/javascript">
		var clientId = "GyFAYwNEfD_LO18hVCeQ";
		var callbackUrl = "http://localhost:8089/truckNarae/member/login";
		var naver_id_login = new naver_id_login(clientId, callbackUrl);
		var state = naver_id_login.getUniqState();
		/*버튼크기 조절*/
		naver_id_login.setButton("green", 3, 50);
		naver_id_login.setDomain("http://localhost:8089/truckNarae/member/login");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
	</script>
	<script type="text/javascript">
	  var naver_id_login = new naver_id_login("GyFAYwNEfD_LO18hVCeQ", "http://localhost:8089/truckNarae/member/login");
	  // 접근 토큰 값 출력
	  alert(naver_id_login.oauthParams.access_token);
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	  function naverSignInCallback() {
	    alert(naver_id_login.getProfileData('email'));
	    alert(naver_id_login.getProfileData('name'));
	    console.log(naver_id_login.getProfileData('email'));
	    console.log(naver_id_login.getProfileData('name'));
	  }
	</script>
	 네아로 스크립 끝 --> 
	
	<!-- 카카오 스크립 시작 
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type='text/javascript'>
 	//<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('d64f769a90b135af53628078782e8b53');
    Kakao.Auth.createLoginButton({
        container: '#kakao-login-btn',
        success: function(authObj) {
          // 로그인 성공시, API를 호출합니다.
          Kakao.API.request({
            url: '/v2/user/me',
            success: function(res) {
              alert(JSON.stringify(res));
              console.log(JSON.stringify(res.properties.account_email));
              console.log(JSON.stringify(res.id));
              console.log(JSON.stringify(res.properties.profile_image));
              console.log(JSON.stringify(res.kakao_account.email));
            },
            fail: function(error) {
              alert(JSON.stringify(error));
            }
          }); 
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
	</script>
 	카카오 스크립 끝 --> 
 	
 	<!-- 페이스북 스크립 시작 
 	<div id="fb-root"></div>
 	<script>
 		
 		function statusChangeCallback(response) {
 		    console.log('statusChangeCallback');
 		    console.log(response);
		 	    if (response.status === 'connected') {
 	        alert("로그인 되었습니다.")
 		        $('#status').after('<button id="logout">로그아웃</button>');
 		      testAPI();
 		    } else {
 		      document.getElementById('status').innerHTML = 'Please log ' +
 		        'into this app.';
 		    }
 		  }


 	
//		최신 로그인 상태를 얻기 위한 태그
		function checkLoginState() {
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
		}
		window.fbAsyncInit = function() {
			FB.init({
				appId : '217306985779055',
				cookie : true,
				xfbml : true,
				version : '{api-version}'
			});
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
			FB.AppEvents.logPageView();
			};
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.0&appId=217306985779055&autoLogAppEvents=1';
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
		
		function testAPI() {
			console.log('콘솔나오는지 확인 testAPI')
			FB.api('/me',{fields:'email,name'}, function(response) {
			    console.log(JSON.stringify(response));
			    console.log('Successful Name: ' + response.name);
		        console.log('Successful Email: ' + response.email);
			});	
		}
	</script>
	페이스북 스크립 끝 -->
 	
 	
 </section>
<!-- FOOTER -->
	<jsp:include page="footer.jsp" />
</body>
</html>