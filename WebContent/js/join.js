	$(function() {
		$("#joinForm").on("submit", function() {
			if(chkData()){
			}else{
				return false;
			}
			var d = $(this).serialize();
			$.ajax({
				url : "join",
				type : 'post',
				data : d,
				dataType : 'json ',
				success : function(data) {
					if (data) {
						alert("회원가입이 완료되었습니다.");
						location.href = 'login'; 
					} else {
						alert("중복된 이메일, 닉네임 혹은 휴대번호입니다. 다시작성해주시기 바랍니다.");
						return false;
					}
				}
			});
			return false;
		});
		
		//핸드폰번호 변경에서 숫자만 쓰도록 하는 정규식
	    $("#phoneNum").keyup(function(e) { 
	         if (!(e.keyCode >=37 && e.keyCode<=40)) {
	            var v = $(this).val();
	            $(this).val(v.replace(/[^0-9]/gi,''));
	         }
	    });
	    
	    $("#nick").keyup(function(e) { 
	         if (!(e.keyCode >=37 && e.keyCode<=40)) {
	            var v = $(this).val();
	            $(this).val(v.replace(/[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi,''));
	         }
	    });
	});
	
	
	//함수시작
	//이메일, 닉네임, 비밀번호, 비밀번호 확인, 휴대번호
	function chkData() {

		//정규 표현식으로 입력자료 검사
		//이메일 정규식
		var aa = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/; // 표준식
		//닉네임 정규식
		var nk = /[a-zA-Z0-9가-힣]{2,8}$/; //닉네임이 적합한지 검사할 정규식		
		//패스워드 정규식
		var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //패스워드가 적합한지 검사할 정규식
		//핸드폰번호 정규식
		var ph = /^[0-9]{10,11}$/; //핸드폰번호가 적합한지 검사할 정규식
		
		//이메일
		if (!frm.MEMBEREMAIL.value.match(aa)) {
			alert("이메일을 정확히 입력하세요.");
			frm.MEMBEREMAIL.focus();
			return false;
		}

		//닉네임
		if (!document.frm.NICK.value === "" || !frm.NICK.value.match(nk)) {
			frm.NICK.focus(); //request는 생략 가능(java)
			alert("닉네임은 2글자 이상 8자 이하 영어 숫자 한글 이여만 합니다.")
			return false;
		}

		//비밀번호
		if (!document.frm.MEMBERPASSWORD.value === ""
				|| !frm.MEMBERPASSWORD.value.match(pw)) {
			alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 특수문자 이여만 합니다. ");
			frm.MEMBERPASSWORDcheck.value = "";
			frm.MEMBERPASSWORD.value = "";
			return false;
		}

		//비밀번호 확인
		if (frm.MEMBERPASSWORD.value != frm.MEMBERPASSWORDcheck.value) {
			alert("입력된 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
			frm.MEMBERPASSWORDcheck.value = "";
			frm.MEMBERPASSWORD.value = "";
			frm.MEMBERPASSWORDcheck.focus();
			return false;
		}

		//핸드폰번호 확인
		if (!frm.MEMBERPHONE.value.match(ph)) {
			frm.MEMBERPHONE.focus();
			alert("휴대번호를 확인해 주세요.")
			return false;
		}
		return true;
	}