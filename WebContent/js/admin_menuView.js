$(function(){
	$('.menuPrice').blur(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
});
/******** submit 기능 시작 ********/
function frmsubmit(){
	if($('.menuName').val() && $('.menuPrice').val()){
		var formData = $('.menuViewForm').serialize();
		$.ajax({
			url:'menuSave',
			type:'get',
			dataType:'json',
			data: formData,
			success:function(data){
				if(data){						
					alert("저장되었습니다.");
					$(location).attr('href','menuList');
					return true;
				}else{
					alert("다시 입력해주세요.");
				}
			}
		});			
	}else{
		if(!($('.menuName').val())){
			alert("메뉴 이릅을 입력해주세요.");
		}else if(!($('.menuPrice').val())){
			alert("메뉴 가격을 입력해주세요.");
		}
	}
	return false;
};
/******** submit 기능 끝 ********/



/******** 숫자만 입력 기능 시작 ********/
function onlyNumber(obj){
   $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
};
/******** 숫자만 입력 기능 끝 ********/