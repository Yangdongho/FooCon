	$(function() {
		$("#adminLoginForm").on("submit", function() {
			var d = $(this).serialize();
			$.ajax({
				url : "admin",
				type : 'post',
				data : d,
				dataType : 'json',
				success : function(data) {
					if (data) {
						alert("로그인완료, 어서오세요 Foocon 관리자 페이지입니다.");
//						$(location).attr('href', 'admin/brand/newBrand');
						$(location).attr('href', 'admin/main');
					} else {
						alert("아이디 또는 비밀번호를 확인해주십시오.");
					}
				}
			});
			return false;
		});
	});