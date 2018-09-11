function frmsubmit(){
	var inquireName = $('.inquireName');
	var inquirePhone = $('.inquirePhone');
	var inpuireBrand = $('.inpuireBrand');
	var inpuireAddress = $('.inpuireAddress');
	var inpuireContent = $('.inpuireContent');
	
	
	if(inquireName.val() && inquirePhone.val() && inpuireBrand.val() 
		&& inpuireAddress.val() && inpuireContent.val()){
		
		var formData = $('.adReferenceForm').serialize();
		$.ajax({
			url:'adReferenceResult',
			type:'post',
			dataType:'json',
			data:formData,
			success:function(data){
				if(data){
					alert("등록되었습니다.");
					inquireName.val("");
					inquirePhone.val("");
					inpuireBrand.val("");
					inpuireAddress.val("");
					inpuireContent.val("");
					return true;
				}else{
					alert("다시 등록해주세요.");
					return false;
				}
			}
		});
		return false;
	}else if(!($('.inquireName').val())){
		alert("이름을 입력해주세요.");
	}else if(!($('.inquirePhone').val())){
		alert("연락처를 입력해주세요.");
	}else if(!($('.inpuireBrand').val())){
		alert("업체명을 입력해주세요.");
	}else if(!($('.inpuireAddress').val())){
		alert("상세주소를 입력해주세요.");
	}else if(!($('.inpuireContent').val())){
		alert("내용을 입력해주세요.");
	}
	return false;
}
/******** 숫자만 입력기능 시작 ********/
function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}
/******** 숫자만 입력기능 끝 ********/