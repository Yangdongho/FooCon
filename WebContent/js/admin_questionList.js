	// 모달창이 스크롤이 내려갔을때 따라 내려오는 기능
	$(function(){
		var currentPosition = parseInt($(".question-modal").css("top")); 
		$(window).scroll(function() { var position = $(window).scrollTop(); 
		$(".question-modal").stop().animate({"top":position+currentPosition+"px"},300); });
	})
	
	function modal(INQUIRENUM,INQUREREPLYSTATUS){
		//모달창 켜주기
		
		if(INQUREREPLYSTATUS =='N'){
			$("#answer-btn").val("답변 등록");
				$("#answer-btn").on("click",function(){
					var content = $('#reply_content').val();
					if(content.length>0){
						//댓글 창에서 받아온 내용이 있을 때 이벤트 처리
						inquireReply(INQUIRENUM);
						$(".question-modal").hide();
						bgLayerClear();
						$('.reply')
					}else{
						//댓글 창에서 받아온 내용이 없을 때 이벤트 처리
						alert("댓글을 입력해 주세요");
						
					}
				
			});
		}else{
			$(".dsds").val("답변 완료");
			$("#answer-btn").on("click",function(){
				$(".question-modal").hide();
				bgLayerClear();
			});
		}
		
		showModal(INQUIRENUM);
		$(".question-modal").show();
		bgLayerOpen();
		
		//모달창 꺼주기
		$(".close-btn").on("click",function(){
			$(".question-modal").hide();
			bgLayerClear();
		});
	}
	function showModal(INQUIRENUM){
		$.ajax({
			url:'showModal',
			data: {INQUIRENUM :INQUIRENUM},
			dateType : 'json',
			type :'POST',
			success : function(data){
				$('#title').text("제목 : "+data.INQUIRETITLE);
				$('.content').text(data.MEMBEREMAIL);
				$('.content1').text(data.MEMBERPHONE);
				$('.content2').text(data.INQUIREDATE);
				$('.inquireContent').val(data.INQUIRECONTENT);
				$('#reply_content').val(data.INQUIREREPLYCONTENT);
				
			}
		})
	}
	//답글달아주는 함수
	function inquireReply(INQUIRENUM){
		
		var INQUIRENUM = INQUIRENUM;
		$.ajax({
			 url : 'inquireReply',
			 data : {replyContent:$('#reply_content').val(),INQUIRENUM:INQUIRENUM},
			 type : 'POST',
			 success : function(result){
				 if(result){
					 location.reload();
				 }else{
					 alert("댓글 달기 실패");
				 }
			 }
		})
	}
	//배경생성
	function bgLayerOpen() {
	    if(!$('.bgLayer').length) {
	        $('<div class="bgLayer"></div>').appendTo($('body'));
	    }
	    var object = $(".bgLayer");
	    var w = $(document).width()+12;
	    var h = $(document).height();

	    object.css({'width':w,'height':h}); 
	    object.fadeIn(500);   //생성되는 시간 설정
	}
	//배경제거
	function bgLayerClear(){
	    var object = $('.bgLayer');

	if($('.bgLayer').length) {
		$('.bgLayer').fadeOut(500, function() {
			$('.bgLayer').remove();
	});
	    }
	}
	
	function nullcheck(){
		if($('#reply_content').val()!=""){
			return true;
		}else{
			alert("등록하실 내용을 입력해 주세요");
			return false;
		}
	}
