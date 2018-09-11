	$(function() {
		$("#pwCheck").on("submit", function() {
			var d = $(this).serialize();
			$.ajax({
				url : "pwCheck",
				type : 'post',
				data : d,
				dataType : 'json ',
				success : function(data) {
					if (data) {
						$(location).attr('href', 'myPage');
					} else {
						alert("틀렸다");
					}
				}
			});
			return false;
		});
	});