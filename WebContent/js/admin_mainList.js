//alert("메인리스트 js에 들어옴");


//up버튼
function btnUp(mainRank, brandNUM){

	if(mainRank == 0 || mainRank == 1 ){		
		alert("해당 배치번호는 상위버튼을 클릭할 수 없습니다.");
	}else{
		
		
		
		$.ajax({
			url:'mainRankUP',
			type:'post',	
			dataType:'json',
			data: {
				'BRANDNUM' : brandNUM,
				'MAINRANK' : mainRank
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
ㄴ
//down 버튼
function btnDown(mainRank, brandNUM){

	if(mainRank == 6){		
		alert("배치 6번은 하위버튼을 클릭할 수 없습니다.");		
	}else if(mainRank == 0){
		
		$.ajax({
			url:'zeroDown',
			type:'post',
			dataType:'json',
			data: {
				'BRANDNUM' : brandNUM,
				'MAINRANK' : mainRank
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
		
	}else{
		$.ajax({
			url:'mainRankDOWN',
			type:'post',
			dataType:'json',
			data: {
				'BRANDNUM' : brandNUM,
				'MAINRANK' : mainRank
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