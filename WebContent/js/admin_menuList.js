var currentPage;
var menuCounting;
/******** 삭제기능 시작 ********/
function menuDelete(e,brandMenuNUM){
	if($('#authority').val() == "MASTER"){
		alert("해당 브랜드만 변경 가능합니다.");
	}else{
		var deleteCheck = confirm("정말 삭제하시겠습니까");
		if(deleteCheck){
			$.ajax({
				url:'menuDelete',
				type:'post',
				dataType:'json',
				data: {'BRANDMENUNUM' : brandMenuNUM},
				success:function(data){
					if(data){						
						alert("삭제되었습니다.");
						window.location.reload();
					}else{
						alert("다시 삭제해주세요.");
					}
				}
			});		
		}			
	}
}
/******** 삭제기능 끝 ********/


/******** 메뉴 순번 업기능 시작 ********/
function menuUp(brandMenuNUM,menuTurn){
	if($('#authority').val() == "MASTER"){
		alert("해당 브랜드만 변경 가능합니다.");
	}else{
		if(menuCounting == menuTurn && currentPage==1){
			alert("제일 상단에 있는 메뉴입니다.");
		}else{	
			$.ajax({
				url:'menuUp',
				type:'post',
				dataType:'json',
				data: {
					'BRANDMENUNUM' : brandMenuNUM,
					'MENUTURN' : menuTurn
				},
				success:function(data){
					if(data){						
						alert("변경되었습니다.");
						window.location.reload();
					}else{
						alert("다시 선택해주세요.");
					}
				}
			});							
		}
	}
}
/******** 메뉴 순번 업기능 시작 ********/


/******** 메뉴 순번 업다운 시작 ********/
function menuDown(brandMenuNUM,menuTurn){
	if($('#authority').val() == "MASTER"){
		alert("해당 브랜드만 변경 가능합니다.");
	}else{
		if(menuTurn == 1){
			alert("제일 마지막에 있는 메뉴입니다.");
		}else{
			$.ajax({
				url:'menuDown',
				type:'post',
				dataType:'json',
				data: {
					'BRANDMENUNUM' : brandMenuNUM,
					'MENUTURN' : menuTurn
				},
				success:function(data){
					if(data){						
						alert("변경되었습니다.");
						window.location.reload();
					}else{
						alert("다시 선택해주세요.");
					}
				}
			});							
		}
	}
}
/******** 메뉴 순번 업다운 시작 ********/