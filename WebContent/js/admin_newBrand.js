	$(function() {
		$("#registBrand").on("submit", function() {
			if(chkData()){
			}else{
				return false;
			}
			var d = $(this).serialize();
			$.ajax({
				url : "newBrand",
				type : 'post',
				data : d,
				dataType : 'json',
				success : function(data) {
					if (data) {
						alert("브랜드 등록에 성공하셨습니다.");
						location.href = 'newBrand'; 
					} else {
						alert("입력한 정보에 중복이 있습니다. 이메일과 휴대번호를 확인해 주세요.");
					}
				}
			});
			return false;
		});
		
		
		$("#registBrand").on("button", function() {
			
		});
		
		
		
	});
	
	function chkData() {

		//정규 표현식으로 입력자료 검사
		//이메일 정규식
		var aa = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/ // 표준식
		//닉네임 정규식
		var nm = /[a-zA-Z가-힣]{2,8}$/ //닉네임이 적합한지 검사할 정규식		
		//패스워드 정규식
		var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //패스워드가 적합한지 검사할 정규식
		//핸드폰번호 정규식
		var ph = /^[0-9]{10,11}$/ //핸드폰번호가 적합한지 검사할 정규식
		
		//이메일
		if (!frm.OWNEREMAIL.value.match(aa)) {
			alert("이메일을 정확히 입력하세요.");
			frm.OWNEREMAIL.focus();
			return false;
		}

		//이름
		if (!document.frm.OWNERNAME.value === "" || !frm.OWNERNAME.value.match(nm)) {
			frm.OWNERNAME.focus(); 
			alert("이름은 2글자 이상 8자 이하 영어 숫자 한글 이여만 합니다.")
			return false;
		}

		//비밀번호
		if (!document.frm.OWNERPASSWORD.value === ""
				|| !frm.OWNERPASSWORD.value.match(pw)) {
			alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 특수문자 이여만 합니다. ");
			return false;
		}

		//핸드폰번호 확인
		if (!frm.OWNERPHONE.value.match(ph)) {
			frm.OWNERPHONE.focus();
			alert("휴대번호를 확인해 주세요.")
			return false;
		}		
		return true;
	}
	
	function brandList(context){
		location.href= context+"/admin/brand/brandList";
	}
	
	function newBrand(context){
		location.href= context+"/admin/brand/newBrand";
	}
	
	