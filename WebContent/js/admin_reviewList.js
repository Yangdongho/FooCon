$(function(){
		var currentPositionQ = parseInt($(".question-modal").css("top"));
		var currentPositionP = parseInt($(".payment-modal").css("top"));
		
		$(".close-btn").on("click",function(){
			$(".question-modal").hide("fast");
			bgLayerClear();
		});
		$("#answer-btn1").on("click",function(){
			$(".question-modal").hide("fast");
			bgLayerClear();
		});
		
		connect();

		$(window).scroll(function(){
			 var position = $(window).scrollTop();
			 	$(".question-modal").stop().animate({"top":position+currentPositionQ+"px"},100);
		});
		

		
	})
	
	function deleteReview(reviewNum){
		var result = confirm('정말 삭제하시겠습니까?');
		if(result){
			location.href='deleteReview?reviewNum='+reviewNum;
		}
		
	}


 	function connect(){
		sock = new SockJS(context+'/review');
		stompClient = Stomp.over(sock);
		stompClient.connect({},function(){
			//서버로 부터 메셎가 들어오면 처리하겟다 특정 url메세지에 대해 구독
			//서버가 해당 url로 메세지를 보내면 메세지를 처리
			
		 	 stompClient.subscribe("/topic/msg/"+SEQ,function(message){
				//json 형태로 반환이 된다
				alert(message.body);
			});  
		});
	};
	
	
 	//리뷰 답변 내용의 값이 있는지 확인
	function check(){
 	
 		var content = $("#content").val();
 		if(content.length>0){
 			return true;	
 		}
 		else{
 			alert("답변 내용을 입력하세요");
 			return false;
 		} 
	}
	
 	function getReview(reviewNum){
 		
 		 $.ajax({
  			url:"getReview",	
  			type:"post",
  			data: {reviewNum:reviewNum},
  			dataType: "json",
  			success : function(data){
  				$(".content").text(data.MEMBEREMAIL);
  				$(".content1").text(data.STARGRADE+".0");
  				$(".content2").text(data.REVIEWREGDATE);
  				if(data.REVIEWPHOTO!=null){
  					var temp = data.REVIEWPHOTO.split('_');
  					$("#REVIEWPHOTO").text(temp[1]);	
  				}else{
  					$("#REVIEWPHOTO").text("첨부 이미지가 없습니다.");
  					
  				}
  				if(data.REPLYCONTENT!=null){
  					$("#content").text(data.REPLYCONTENT);
  					$("#content").attr("readonly","readonly");
  					$("#answer-btn1").show();
  					$("#answer-btn").hide();
  				}else{
  					$("#content").text('');
  					$("#content").removeAttr("readonly");
  					$("#answer-btn1").hide();
  					$("#answer-btn").show();
  				}  				
  				
				$("#userContent").val(data.REVIEWCONTENT);
  			}
  		});
 		 
 		$("#REVIEWPHOTO").on("click",function(){
 			var modal = document.getElementById('myModal');
 			
 			// Get the image and insert it inside the modal - use its "alt" text as a caption
 			var img = document.getElementById('REVIEWPHOTO');
 			var modalImg = document.getElementById("img01");

 			
		    modal.style.display = "block";
		    modalImg.src = "reviewImg?reviewNum="+reviewNum;
		    var span = document.getElementsByClassName("close")[0];
			
			// When the user clicks on <span> (x), close the modal
			span.onclick = function() { 
			    modal.style.display = "none";
			}
 		})
		
 		//리뷰 submit ajax
		$("#replyForm").on("submit",function(){
			if(authority=='MASTER'){
				alert('브랜드만 답변등록 가능합니다');
				return null;
			}
			
			if(check()){
				var content = $("#content").val();
				
				$.ajax({
					url:"writeReply",	
					type:"post",
					data: {content:content,reviewNum:reviewNum},
					dataType: "json",
					success : function(result){
						if(result){			
							alert("리뷰 답글이 등록되었습니다.");
							 location.reload();
						}
					}
				});	
				
			}else{
				alert("답변 내용을 입력하세요.");
			}
				
				return false;
		});
		 
 		
 	}
	
	function review_modal(reviewNum){
		
		getReview(reviewNum);
		$(".question-modal").show("fast");
		bgLayerOpen();
		
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