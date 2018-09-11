	$(function(){
		$('.deleteBtn').click(function() {
			var result = confirm('정말 삭제하시겠습니까?');
			if(result){
				return true;
			}
			return false;
		});

	})