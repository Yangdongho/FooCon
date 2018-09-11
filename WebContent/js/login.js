	$(function() {
		//회원 및 비회원 탭기능 시작
		var tab = $('.login_tab li'),
			content = $('.login_form');
			
			content.hide();
			
			tab.click(function(e){
				e.preventDefault();
				var idx = $(this).index();
				
				content.hide();
				content.eq(idx).show();
				
				tab.removeClass('active');
				$(this).addClass('active');
				
			});
			tab.eq(0).trigger('click');
		//회원 및 비회원 탭기능 종료
		
		
		//로그인화면 ajax 적용 스크립트 시작
		$("#loginForm").on("submit", function() {
			//정규식에 의거 입력확인
			if(chkData()){
			}else{
				return false;
			}
			
			var d = $(this).serialize();
			$.ajax({
				url : "login",
				type : 'post',
				data : d,
				dataType : 'json',
				success : function(data) {
					if (data) {
						location.href= context+"/";   
					} else {
						alert("이메일 또는 비밀번호를 확인해주세요");
					}
				}
			});
			return false;
		});
	});
	
	//이메일, 비밀번호
	function chkData() {

		//정규 표현식으로 입력자료 검사
		//이메일 정규식
		var aa = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/ // 표준식
		
		//이메일
		if (!frm.MEMBEREMAIL.value.match(aa)) {
			alert("이메일을 정확히 입력하세요.");
			frm.MEMBEREMAIL.focus();
			return false;
		}
		return true;
	}
	
	   function temp(){
		  
		      var orderNumber = $("#orderNum").val();
		        $.ajax({
		             type : 'post',
		             url  : context+'/order/nonMemberOrderCheck',
		             data : {orderNumber:orderNumber},
		             dataType:"json" ,
		             success : function(result) {
		                if(result){
		                   location.href = context+'/order/orderList?orderNumber='+orderNumber;    
		                }else{
		                   alert("주문번호를 확인해주세요.");    
		                }
		             },
		             error : function(error) {                
		         }
		     });
		}
	
	