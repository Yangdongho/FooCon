$(function(){
	var selectBox = $('.selectBox').val();
	if(selectBox == null && selectBox == ""){
		$("#selectBox > option:eq(0)").attr("selected","selected");
	}else if(selectBox == "AD"){
		$("#selectBox > option:eq(1)").attr("selected","selected");
	}else if(selectBox == "COR"){
		$("#selectBox > option:eq(2)").attr("selected","selected");
	}
});
