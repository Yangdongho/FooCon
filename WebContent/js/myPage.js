	$(function() {
		$('#quitMember').on("submit", function(){
			if(clickQuitMember()){
			}else{
				return false;
			}
			var d = $(this).serialize();
			$.ajax({
				url : "myPage",
				type : 'post',
				data : d,
				dataType : 'json ',
				success : function(data) {
					if (data) {
						alert("회원탈퇴가 완료되었습니다. 서비스 이용해 주셔서 감사합니다.");
						$(location).attr('href', 'login');
					} else {
						alert("비밀번호가 일치하지 않습니다.");
						return false;
					}
				}
			})
			return false;
		});
		//패스워드 확인 화면 ajax 적용 스크립트 종료
	

		//닉네임 변경 모달 ajax 적용 스크립트 시작
		$("#memberChangeNick").on("submit", function() {
			if(chkDataNick()){
			}else{
				return false;
			}
			
			var d = $(this).serialize(); //this는 이벤트가 발생한 요소라는 의미임
			$.ajax({
				url : "memberChangeNick", //요청이 보내지는곳인데.
				type : 'post',
				data : d,
				dataType : 'json ',
				success : function(data) {
					if (data) {
						alert("수정이 완료되었습니다.");
						$('#nick01').text($('#changeNick').val());
						
						frmNick.WANTINGNICK.value = "";
				        $(".w3-containerNick").hide();
				        bgLayerClear();
					} else {
						alert("이미 있는 닉네임입니다. 변경해 주시기 바랍니다.");
						$('#changeNick[type="text"]').val("");
					}
				}
			});
			return false; //submit에 진행을 멈춤
		});
		//닉네임 변경 모달 ajax 적용 스크립트 종료
		
		
		//비밀번호 변경 모달 ajax 적용 스크립트 시작
		$("#memberChangePw").on("submit", function() {
			if(chkDataPW()){
			}else{
				return false;
			}
			
			var d = $(this).serialize();
			$.ajax({
				url : "memberChangePw",
				type : 'post',
				data : d,
				dataType : 'json ',
				success : function(data) {
					if (data) {
						
						frmPW.ORIGINPASSWORD.value = "";
						frmPW.WANTINGPASSWORD.value = "";
						frmPW.WANTINGPASSWORDCHECK.value = "";
				        $(".w3-containerPW").hide();
				        bgLayerClear();
						
						alert("수정이 완료되었습니다.");
					} else {
						alert("비밀번호를 확인해주시기 바랍니다.");	
						$('#originPassword[type="password"]').val("");
						$('#wantingPassword[type="password"]').val("");
						$('#wantingPasswordCheck[type="password"]').val("");  
					}
				}
			});
			return false;
		});
		//비밀번호 변경 모달 ajax 적용 스크립트 종료
		
		
		//핸드폰번호 변경 모달 ajax 적용 스크립트 시작
		$("#memberChangePhoneNum").on("submit", function() {
			if(chkDataPh()){
			}else{
				return false;
			}
			
			var d = $(this).serialize();
			$.ajax({
				url : "memberChangePhoneNum",
				type : 'post',
				data : d,
				dataType : 'json ',
				success : function(data) {
					if (data) {
						alert("수정이 완료되었습니다.");
						$('#phoneNum01').text($('#changePhoneNum').val());
						var userPhone = $('#phoneNum01').text();
						if(userPhone.length = 11){
							userPhone.substr(0,3)+"-";
							$('#phoneNum01').text(userPhone.substr(0,3)+" - "+userPhone.substr(3,4)+" - "+userPhone.substr(7,4))
							$('#changePhoneNum[type="text"]').val("");
							$('#changePhoneNumDoublecheck[type="text"]').val("");
							
							frmPhoneNum.WANTINGPHONENUM.value = "";
							frmPhoneNum.WANTINGPHONENUMCHECK.value = "";
					        $(".w3-containerPhoneNum").hide();
					        bgLayerClear();
							
						}       
					} else {
						alert("핸드폰 번호를 확인해주시기 바랍니다.");
						$('#changePhoneNum[type="text"]').val("");
						$('#changePhoneNumDoublecheck[type="text"]').val("");
					}
				}
			});
			return false;
		});
		//핸드폰번호 변경 모달 ajax 적용 스크립트 종료
		
		//핸드폰번호 변경에서 숫자만 쓰도록 하는 정규식
	    $("#changePhoneNum").keyup(function(e) { 
	         if (!(e.keyCode >=37 && e.keyCode<=40)) {
	            var v = $(this).val();
	            $(this).val(v.replace(/[^0-9]/gi,''));
	         }
	    });
		
	    $("#changePhoneNumDoublecheck").keyup(function(e) { 
	         if (!(e.keyCode >=37 && e.keyCode<=40)) {
	            var v = $(this).val();
	            $(this).val(v.replace(/[^0-9]/gi,''));
	         }
	    });
	    
	    $("#changeNick").keyup(function(e) { 
	         if (!(e.keyCode >=37 && e.keyCode<=40)) {
	            var v = $(this).val();
	            $(this).val(v.replace(/[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi,''));
	         }
	    });
	});
		
		/******************************함수시작******************************/
		//회원탈퇴하기_버튼클릭
		function clickQuitMember(){
			if(confirm("탈퇴하면 모든 정보를 복구할 수 없습니다. 정말 탈퇴하시겠습니가?")==true){

			}else{
				alert("탈퇴를 취소하셨습니다.")
				$('#WDpasswordCheck[type="password"]').val("");
				return false;
			}
			return true;
		}
		
		//닉네임 정규식
		function chkDataNick() {
			
			var nk = /[a-zA-Z0-9가-힣]{2,8}$/ //닉네임이 적합한지 검사할 정규식	
			var sc = /[!@#$%^&*+=-]/ // 특수문자
	
			//닉네임
			if (!document.frmNick.WANTINGNICK.value === "" || !frmNick.WANTINGNICK.value.match(nk) || frmNick.WANTINGNICK.value.match(sc)) {
				frmNick.WANTINGNICK.focus(); //request는 생략 가능(java)
				alert("닉네임은 2글자 이상 8자 이하 영어 숫자 한글 이여만 합니다.")
				frmNick.WANTINGNICK.value = "";
				return false;
			}
			
			return true;
		}
		
		//패스워드 정규식
		function chkDataPW() {
				
			var pw = /^.*(?=^.{1,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).{8,20}$/; //패스워드가 적합한지 검사할 정규식
			if (!document.frmPW.WANTINGPASSWORD.value === ""
					|| !frmPW.WANTINGPASSWORD.value.match(pw)) {
				alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 특수문자 이여만 합니다. ");
				frmPW.ORIGINPASSWORD.value = "";
				frmPW.WANTINGPASSWORD.value = "";
				frmPW.WANTINGPASSWORDCHECK.value = "";
				return false;
			}
			//비밀번호 확인
			if (frmPW.WANTINGPASSWORD.value != frmPW.WANTINGPASSWORDCHECK.value) {
				alert("입력된 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
				frmPW.ORIGINPASSWORD.value = "";
				frmPW.WANTINGPASSWORD.value = "";
				frmPW.WANTINGPASSWORDCHECK.value = "";
				frmPW.WANTINGPASSWORDCHECK.focus();
				return false;
			}
			
			//현재 비밀번호와 변경하고자 하는 비밀번호가 같은지 확인
			if (frmPW.ORIGINPASSWORD.value == frmPW.WANTINGPASSWORD.value) {
				alert("현재 비밀번호와 변경하고자 하는 비밀번호가 같습니다. 다시 작성해주십시오.");
				frmPW.ORIGINPASSWORD.value = "";
				frmPW.WANTINGPASSWORD.value = "";
				frmPW.WANTINGPASSWORDCHECK.value = "";
				frmPW.WANTINGPASSWORDCHECK.focus();
				return false;
			}
			return true;
		}
		
		//핸드폰번호 정규식
		function chkDataPh() {
		
			var ph = /[0-9]{10,11}$/; //핸드폰번호가 적합한지 검사할 정규식
			var ft = /[a-zA-Z가-힣]$/; //번호로만 가능하도록 걸러낼 한글과 영어 특수문자
			
			//핸드폰번호
			if (!frmPhoneNum.WANTINGPHONENUM.value.match(ph) || frmPhoneNum.WANTINGPHONENUM.value.match(ft)) {
				frmPhoneNum.WANTINGPHONENUM.focus();
				alert("올바르지 않은 휴대번호입니다. 휴대번호를 확인해 주세요.")
				frmPhoneNum.WANTINGPHONENUM.value = "";
				frmPhoneNum.WANTINGPHONENUMCHECK.value = "";
				return false;
			}
			
			//비밀번호 확인
			if (frmPhoneNum.WANTINGPHONENUM.value != frmPhoneNum.WANTINGPHONENUMCHECK.value) {
				alert("입력된 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
				frmPhoneNum.WANTINGPHONENUMCHECK.value = "";
				frmPhoneNum.WANTINGPHONENUM.value = "";
				frmPhoneNum.WANTINGPHONENUMCHECK.focus();
				return false;
			}
			return true;
		}
		


/***************************닉네임 변경하기***************************/

function modalNick() {
	//모달창 켜주기
	$(".w3-containerNick").show();
	bgLayerOpen();

	//모달창 꺼주기
    $(".close-btn").on("click",function(){
    	frmNick.WANTINGNICK.value = "";
        $(".w3-containerNick").hide();
        bgLayerClear();
    });
}
//배경생성
function bgLayerOpen() {
	if (!$('.bgLayer').length) {
		$('<div class="bgLayer"></div>').appendTo($('body'));
	}
	var object = $(".bgLayer");
	var w = $(document).width() + 12;
	var h = $(document).height();

	object.css({
		'width' : w,
		'height' : h
	});
	object.fadeIn(500); //생성되는 시간 설정
}
//배경제거
function bgLayerClear() {
	var object = $('.bgLayer');

	if ($('.bgLayer').length) {
		$('.bgLayer').fadeOut(500, function() {
			$('.bgLayer').remove();
		});
	}
}

/***************************비밀번호 변경하기***************************/

function modalPW() {
	//모달창 켜주기
	$(".w3-containerPW").show();
	bgLayerOpen();

	//모달창 꺼주기
    $(".close-btn").on("click",function(){
    	frmPW.ORIGINPASSWORD.value = "";
		frmPW.WANTINGPASSWORD.value = "";
		frmPW.WANTINGPASSWORDCHECK.value = "";
        $(".w3-containerPW").hide();
        bgLayerClear();
    });
}
//배경생성
function bgLayerOpen() {
	if (!$('.bgLayer').length) {
		$('<div class="bgLayer"></div>').appendTo($('body'));
	}
	var object = $(".bgLayer");
	var w = $(document).width() + 12;
	var h = $(document).height();

	object.css({
		'width' : w,
		'height' : h
	});
	object.fadeIn(500); //생성되는 시간 설정
}
//배경제거
function bgLayerClear() {
	var object = $('.bgLayer');

	if ($('.bgLayer').length) {
		$('.bgLayer').fadeOut(500, function() {
			$('.bgLayer').remove();
		});
	}
}

/***************************휴대번호 변경하기***************************/

function modalPhone() {
	//모달창 켜주기
	$(".w3-containerPhoneNum").show();
	bgLayerOpen();

	//모달창 꺼주기
    $(".close-btn").on("click",function(){
    	frmPhoneNum.WANTINGPHONENUM.value = "";
		frmPhoneNum.WANTINGPHONENUMCHECK.value = "";
        $(".w3-containerPhoneNum").hide();
        bgLayerClear();
    });
}
//배경생성
function bgLayerOpen() {
	if (!$('.bgLayer').length) {
		$('<div class="bgLayer"></div>').appendTo($('body'));
	}
	var object = $(".bgLayer");
	var w = $(document).width() + 12;
	var h = $(document).height();

	object.css({
		'width' : w,
		'height' : h
	});
	object.fadeIn(500); //생성되는 시간 설정
}
//배경제거
function bgLayerClear() {
	var object = $('.bgLayer');

	if ($('.bgLayer').length) {
		$('.bgLayer').fadeOut(500, function() {
			$('.bgLayer').remove();
		});
	}
}

