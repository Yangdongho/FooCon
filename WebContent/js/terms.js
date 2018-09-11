
// 전체 체크버튼 선택/해제
function allCheckFunc( obj ) {
		$("[name=oneAgree]").prop("checked", $(obj).prop("checked") );
}

// 체크박스 체크시 전체선택 체크 여부
function oneCheckFunc( obj )
{
	var allObj = $("[name=allAgree]");
	var objName = $(obj).attr("name");

	if( $(obj).prop("checked") )
	{
		checkBoxLength = $("[name="+ objName +"]").length;
		checkedLength = $("[name="+ objName +"]:checked").length;

		if( checkBoxLength == checkedLength ) {
			allObj.prop("checked", true);
		} else {
			allObj.prop("checked", false);
		}
	}
	else
	{
		allObj.prop("checked", false);
	}
}

$(function(){
	$("[name=allAgree]").click(function(){
		allCheckFunc( this );
	});
	$("[name=oneAgree]").each(function(){
		$(this).click(function(){
			oneCheckFunc( $(this) );
		});
	});
	
});
// 전체 체크버튼 선택/해제 끝

// 체크박스 체크여부 확인
	function passCheckFunc() {
		var chk1 = $('input:checkbox[id="oneAgree"]').is(":checked");
		var chk2 = $('input:checkbox[id="twoAgree"]').is(":checked");

		if (!chk1) {
			alert('약관1에 동의해 주세요');
			return false;
		}
		if (!chk2) {
			alert('약관2에 동의해 주세요');
			return false;
		}
		return true;
	}

	$(function() {

		$("#termsForm").click(function() {
			if (passCheckFunc()) {
				$(location).attr('href', 'join');
			} else {
				return false;
			}
		});
	});
	// 체크박스 체크여부 확인 끝