$(function(){
	connect();
})
	
	
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
