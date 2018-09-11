	$(function() {
		$("#findPw").on("submit", function() {
			if(chkData()){
			}else{
				return false;
			}
			var d = $(this).serialize();
			$.ajax({
				url : "pwFind",
				type : 'post',
				data : d,
				dataType : 'json',
				success : function(data) {
					if (data.result == true) {
						alert("임시비밀번호가 발송되었습니다. 이메일을 확인하세요.");
						location.href = 'login';
					}else{
						alert("가입한 이력이 없는 이메일 주소입니다.");
						return false;
					}
				},error : function(request,status,err){
					alert("request : " + request);
					alert("status : " + status);
					alert("err : " + err);
				}
			});
			return false;
		});
	});
	function chkData() {
		//이메일 정규식
		var aa = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/ // 표준식
		
		if (!findPw.MEMBEREMAIL.value.match(aa)) {
			alert("이메일을 정확히 입력하세요.");
			findPw.MEMBEREMAIL.focus();
			return false;
		}else{
			return true;
		}
	}
	