
	$(function(){
		if($(".faq tbody tr").length>9){
			$(".add-btn").hide()
		}
		
	})
function nullcheck(){
		if($('#title').val()!="" && $('.faqContent').val()!="" ){
			return true;
		}else{
			alert("등록하실 내용을 입력해 주세요");
			return false;
		}
	}
function deleteFaq(faqNum){
		var result = confirm("삭제하시겠습니까?");
		if(result){
			$.ajax({
				type:'POST',
				url:'faqDelete', //요청할 url
				data:{'faqNum':faqNum},//서버 요청시 보낼 파라미터
				success:function(data){
					if(data){
						alert("삭제 되었습니다.");
						window.location.reload();
					}else{
						alert("삭제에 실패하였습니다.");
					}
					
				}
			})
		}

}

	//글자수 제한
	$(document).ready(function() {
		$('.faqContentst').on('keyup', function() {
			if($(this).val().length >1000) {
				$(this).val($(this).val().substring(0, 1000));
			}
		});
	});
	
	//글자수 제한
	$(document).ready(function() {
	    $('#title').on('keyup', function() {
	        if($(this).val().length >100) {
	            $(this).val($(this).val().substring(0, 100));
	        }
	    });
	});




