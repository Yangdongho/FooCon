function nullcheck(){
		if($('#input').val()!="" && $('#edit').val()!="" && $('#category').val()!=""){
			return true;
		}else{
			alert("등록하실 내용을 입력해 주세요");
			return false;
		}
	}
function deleteNotice(noticeNum){
	var result = confirm("삭제하시겠습니까?");
		if(result){
			$.ajax({
				type:'POST',
				url:'noticeDelete',
				data:{'noticeNum':noticeNum},
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
$(document).ready(function() {
	  $('#edit').summernote({
		  placeholder: '내용을 입력하세요',
	      tabsize: 2,
	      height: 500,
	      lang: 'ko-KR'
	      });
	 
	});
	
