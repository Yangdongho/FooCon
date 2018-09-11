
$(function(){
		var DELIVREGICHECK = getQuerystring('DELIVREGICHECK');
		
	 	connect();
		if(DELIVREGICHECK ==0){
			$("#filter2").css("color",'red');
		}else if(DELIVREGICHECK ==1){
			$("#filter3").css("color",'red');
		}else{
			$("#filter1").css("color",'red');
		}
		
	    $('#content').on('keyup', function() {
	           if($(this).val().length >200) {
	               $(this).val($(this).val().substring(0, 200));
	           }	
	    });
	    
	   
		if(session=="" || session==null){
			$(".two-depth-menu").css('margin-top','0px');
		}
		
 		var currentPositionQ = parseInt($(".question-modal").css("top"));
 		var currentPositionP = parseInt($(".payment-modal").css("top"));
 		
 		$("#answer-btn").on("click",function(){
			$(".question-modal").hide("fast");
			bgLayerClear();
		});
 		
 		$(".close-btn").on("click",function(){
			$(".question-modal").hide("fast");
			$(".payment-modal").hide("fast");
			$('#reviewForm')[0].reset();
			$('.score').text('0.0');
			bgLayerClear();
		});
 		
 		$("#attach").on("change",function(){
 			if( $("#attach").val() != "" ){
				var ext = $('#attach').val().split('.').pop().toLowerCase();
				     if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				    	 $("#attach").val("");
						 alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
						 return;
				      }
			}
 			
 		})
 
 		$(".rate-area input[type=radio]").on("click",function(){
 			
 			var checkedRadio = $(this).val();
 			$(".score").text(checkedRadio+".0");
 		});
 			
 		//스크롤 따라서 모달 이동
 		$(window).scroll(function(){
 			 var position = $(window).scrollTop();
 			 	$(".question-modal").stop().animate({"top":position+currentPositionQ+"px"},100);
 		});
 		//스크롤 따라서 모달 이동
 		$(window).scroll(function(){
			 var position = $(window).scrollTop();
			 	$(".payment-modal").stop().animate({"top":position+currentPositionP+"px"},100);
		});
 		
 	})
 	
 	
 	 function connect(){
		sock = new SockJS(context+'/review');
		stompClient = Stomp.over(sock);
		stompClient.connect({},function(){
			//서버로 부터 메셎가 들어오면 처리하겟다 특정 url메세지에 대해 구독
			//서버가 해당 url로 메세지를 보내면 메세지를 처리
			
		 	stompClient.subscribe("/topic/msg/TEMP",function(message){
				//json 형태로 반환이 된다
				alert(message.body);
			});  
		});
	};
	
	function sendMsg(brandNum){
		//번호 글쓴이
		var msg = "새로운 리뷰가 등록되었습니다.";
		stompClient.send("/client/greeting/"+brandNum,{},msg);
	};
 	
 	
 	
 	
 	
	//url-파라미터값-읽어오기 
 	function getQuerystring(paramName){ 
 		var _tempUrl = window.location.search.substring(1);//url에서 처음부터 '?'까지 삭제
 				if(_tempUrl==""){
 					return null;			
 				}
 		var _tempArray = _tempUrl.split('&'); // '&'을 기준으로 분리하기 
 
 		for(var i = 0; i<_tempArray.length; i++){
 			var _keyValuePair = _tempArray[i].split('='); // '=' 을 기준으로 분리하기 
	 		if(_keyValuePair[0] == paramName){ // _keyValuePair[0] : 파라미터 명 // _keyValuePair[1] : 파라미터 값 
	 			return _keyValuePair[1]; 
	 		}
 		}
 		
 		return null;
 	} 




	function review_modal(brandNum,orderNum,brandOwnerNum){
	
		$("#brandNum").val(brandNum);
		$("#brandOwnerNum").val(brandOwnerNum);
		$("#orderNum").val(orderNum);
		
		
		$(".question-modal").show("fast");
		bgLayerOpen();

	}

 	 function sendReview() {
         var formData = new FormData($("#reviewForm")[0]);
   			//평점이랑 content확인content
   			 var star = $(':input[name=rating]:radio:checked').val();
				
			if($("#content").val()!="" && star!=null){
				 $.ajax({
		             type : 'post',
		             url  : 'writeReview',
		             data : formData,
		             processData : false,
		             contentType : false,
		             success : function(html) {
		            	 location.reload();
		                 alert("리뷰 작성 성공하였습니다");
		                 //성공했을때 해당 브랜드 오너 번호를 가져와서 웹소켓을 통해 컨트롤러로  메세지와 함께 전송
		                 
		                 sendMsg($("#brandOwnerNum").val());
		             },
		             error : function(error) {
		            	 alert("리뷰 작성 실패하였습니다.");
		                 console.log(error);
		                 console.log(error.status);
		                
	             }
	         });
	         
		         $(".question-modal").hide("fast");
				 $(".payment-modal").hide("fast");
				 bgLayerClear();
				 $('#reviewForm')[0].reset();
				 return false; 
			}else{
				alert("평점과 리뷰 내용을 입력하세요.");
			}

     }


 	function payment_modal(orderNum,NONMEMBERNUM){
 		
 		
 		if(NONMEMBERNUM!=""){
 			//비회원
 			$.ajax({
 				url:"nonMemberOrderInfo",	
 				type:"post",
 				data: {orderNumber:orderNum},
 				dataType: "json",
 				success : function(data){
	 				if(data.DELIVREGICHECK=='D'){
	 					$("#check").hide();
	 				}else{
	 					$("#check").show();
	 					$("#pay1").text(data.RESERNAME);	
	 				}
	 					
	 				$(".paymentForm h6").text("주문번호 : "+data.ORDERNUMBER);	
	 				$("#pay2").text(data.MEMBERPHONE); 
	 				$("#pay3").text(data.PAYMENT);
	 				$("#pay4").text(data.PAYMENTAMOUNT);
	 				$("#pay5").text("-"+data.USEDPOINT);
	 				$("#pay6").text((data.PAYMENTAMOUNT)-(data.USEDPOINT));
 				}
 			});
 			
 		}
 		else{
 			
 			 $.ajax({
 				url:"orderInfo",	
 				type:"post",
 				data: {orderNum:orderNum},
 				dataType: "json",
 				success : function(data){
	 				if(data.DELIVREGICHECK=='D'){
	 					$("#check").hide();
	 				}else{
	 					$("#check").show();
	 					$("#pay1").text(data.RESERNAME);	
	 				}
	 					
	 				$(".paymentForm h6").text("주문번호 : "+data.ORDERNUMBER);	
	 				$("#pay2").text(data.MEMBERPHONE); 
	 				$("#pay3").text(data.PAYMENT);
	 				$("#pay4").text(data.PAYMENTAMOUNT);
	 				$("#pay5").text("-"+data.USEDPOINT);
	 				$("#pay6").text((data.PAYMENTAMOUNT)-(data.USEDPOINT));
 				}
 			});
 		}
 		$(".payment-modal").show("fast");
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
    
    function getOrder(currentPage){
    	$("#getOrderBtn").parent().remove();
    	$("#loading").show();
    	var DELIVREGICHECK = getQuerystring('DELIVREGICHECK');
    	currentPage++;
    	 $.ajax({
 			url:"additionalOrderList",	
 			type:"post",
 			data: {pageNum:currentPage,DELIVREGICHECK:DELIVREGICHECK},
 			dataType: "json",
 			success : function(data){
	
	 				var filler = '&nbsp;&nbsp;&nbsp;';
	 				
	 				$(data.ordertList).each(function(i,order){
	 					 
	 					var menuList="";
	 					
	 					$(order.menuList).each(function(){
	 						menuList = menuList+this.MENUNAME+" "+String(this.ORDERQUANTITY)+"개"+filler;  
	 					});
	 					
	 					var temp;
	 					
	 					if(order.checkReview==null){										
	 						temp = "<button onclick='review_modal(\""+order.BRANDNUM+"\",\""+order.ORDERNUM+"\",\""+order.BRANDOWNERNUM+"\")'>리뷰 작성 하기<br><span>(50p적립)</span></button>"; 
	 					}
	 				
	 					else{
	 						temp = "<span class='tag-default'>리뷰 작성 완료</span>";
	 					}
	 					
	 					var check;
	 					
	 					if(order.DELIVREGICHECK=='D'){
	 						check = "<span class='orderOption'>배달</span>";
	 					}else{
	 						check = "<span class='orderOption'>예약</span>";
	 					}
	 							
	 					var order = "<div class='orderList'><strong><h4>"+order.BRANDNAME+"</h4></strong><span class='menuList'>"+menuList+"</span><ul><li><span>주문번호</span><b>"+order.ORDERNUMBER+"</b></li><li><span>주소</span><b>"+order.BRANDADDRESS+"</b></li><li><span>전화번호</span><b>"+order.BRANDPHONE+"</b></li><li><span>주문날짜</span><b>"+order.ORDERDATE+"</b></li><li><span>결제금액</span><b>"+order.PAYMENTAMOUNT+"원</b></li></ul><div class='btn'>"+temp+"<button onclick='payment_modal("+order.ORDERNUMBER+")'>결제 내역 확인</button></div>"+check+"</div>";
	 					$(".order-container").append(order);

 				});
	 				
	 			var loading	= "<center><img id='loading' src='/FoodTruck/img/25.gif' alt='loading'></center>";
	 			var btn = "<center><button id='getOrderBtn' onclick='getOrder("+data.currentPage+")'>더보기</button></center>";
	 			$("#loading").remove();
	 			if(data.pageTotalCount>data.currentPage){
 					$(".order-container").append(loading);
 					$("#loading").hide();
 					$(".order-container").append(btn);		
 				}
 					
 			}
 		});
    }
	
	