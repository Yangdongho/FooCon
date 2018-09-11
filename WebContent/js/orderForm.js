var orderList;
var delivery = 'D';
var reservation = 'R';

$(function(){
	/******** 이메일 정규식 시작 ********/
	$('.email_certified_reservation').on("blur",function(){
		var mm = $('.email_certified_reservation').val();
		var pw = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if(pw.test(mm)){
			
		}else{
			alert("이메일 형식이 아닙니다.");
			$('.email_certified_reservation').val("");
		}
	});	
	
	$('.email_certified_delivery').on("blur",function(){
		var mm = $('.email_certified_delivery').val();
		var pw = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if(pw.test(mm)){
		}else{
			alert("이메일 형식이 아닙니다.");
			$('.email_certified_delivery').val("");
		}
	});	
	/******** 이메일 정규식 끝 ********/
	
	/******** 브랜드번호 숫자에 '-' 추가기능 시작 ********/
	var brandPhone = $('.brandPhone').text();
	if(brandPhone.length = 11){
		brandPhone.substr(0,3)+"-";
	    $('.brandPhone').text(brandPhone.substr(0,3)+"-"+brandPhone.substr(3,4)+"-"+brandPhone.substr(7,4))
	}
	/******** 브랜드번호 숫자에 '-' 추가기능 끝 ********/
	
	
	/******** 핸드폰 숫자에 '-' 추가기능 시작 ********/
	var userPhone = $('.user_phone').text();
	if(userPhone.length = 22){
	    userPhone.substr(0,3)+"-";
	    $('.user_phone').text(userPhone.substr(0,3)+"-"+userPhone.substr(3,4)+"-"+userPhone.substr(7,4))
	}
	/******** 핸드폰 숫자에 '-' 추가기능 끝 ********/
	
	
	//포인트 기본셋팅
	$('.point_price').val(0);
	bill();
	
	/******** 메뉴 및 리뷰 탭기능 시작 ********/
	var tab = $('.payment_tab li'),
	content = $('.payment_form_list');
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
	/******** 메뉴 및 리뷰 탭기능 끝 ********/
	
	
	
	/******** 주문내역 fixed 기능 시작 ********/
	var win = $(window),
	header = $('.payment_bill'),
	headerOffset = header.outerHeight()-240;

	win.scroll(function() {
		if(win.scrollTop() > headerOffset){ //윈도우가 더 밑에 있다
			header.addClass('scroll');
		} else { //윈도우가 더 위에 있다
			header.removeClass('scroll');
		}
	});
	/******** 주문내역 fixed 기능 끝 ********/
	

	
	/******** 할인부분 기능 시작 ********/
	var fristTotalPrice = $('.total_price').val();
	if($("#session").val()){ //회원일 경우
		$('.point_into').show();
		
		$('.point').blur(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			
			var point_price = $('.point_price');
			var point = $('.point');
			var point_having = $('.point_having');
			
			if(point.val() == 0){
				point_price.val(0);
			} else if(Number(point.val()) > Number(point_having.text())){
				alert('보유하신 포인트가 부족합니다.');
				point.val("");
				point_price.val(0);
			} else if(Number(point.val()) > Number(fristTotalPrice)){
				alert('주문 금액보다 포인트가 많습니다.');
				point.val("");
				point_price.val(0);
			} else{
				if(((parseInt(Number(point.val())/1000))*1000)==0){
					point.val("");
				} else {
					point.val((parseInt(Number(point.val())/1000))*1000);
				}
				point_price.val((parseInt(Number(point.val())/1000))*1000);
			}	
			bill();
		});
	}else{ //비회원 일 경우
		$('.point_into').hide();
		
		$('.phone_certified').blur(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		$('.phone_certified').keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	}
	/******** 할인부분 기능 끝 ********/
	

	
	/******** 현재시간 기능 시작 ********/
	var d = new Date();
	$('.crrent_time p span').text(d.getHours()+":"+d.getMinutes());
	/******** 현재시간 기능 끝 ********/
	
	
});



/******** 약관 체크박스 기능 시작 ********/
function acceptClick(chk){
	var chkAll = document.order_form.chk_all;
	var chk1 = document.order_form.chk_1;
	var chk2 = document.order_form.chk_2;
	var chk3 = document.order_form.chk_3;
	
	if(chk == chkAll){ //this가 chkAll일 경우
		if(chk.checked == true){
			chk1.checked = true;
			chk2.checked = true;
			chk3.checked = true;
		} else{
			chk1.checked = false;
			chk2.checked = false;
			chk3.checked = false;
		}
	} else if(chk == chk1 || chk == chk2 || chk == chk3){ //this가 chk1또는 chk2일 경우
		if(chk.checked == false){//chk1,chk2 둘 중 하나가 false일 경우 
			chkAll.checked = false;
		} else if(chk == chk1){//this가 chk1이면서 chk2.checked가 true인 경우 
			if(chk2.checked == true && chk3.checked == true){
				chkAll.checked = true;
			}
		} else if(chk == chk2){//this가 chk2이면서 chk1.checked가 true인 경우
			if(chk1.checked == true && chk3.checked == true){
				chkAll.checked = true;
			} 
		} else if(chk == chk3){//this가 chk3이면서 chk1.checked가 true인 경우
			if(chk1.checked == true && chk2.checked == true){
				chkAll.checked = true;
			} 
		}
	}
};	
/******** 약관 체크박스 기능 끝 ********/



/******** 포인트 전액사용 시작 ********/
function pointAllUse(){
	var point_having = Number($('.point_having').text());
	
	if(parseInt(point_having/1000) < 1){
		$('.point_price').val(0);
		alert('보유하신 포인트가 부족합니다.');
	}else{
		$('.point').val(parseInt(point_having/1000)*1000);
		$('.point_price').val(parseInt(point_having/1000)*1000);		
	}
	
	var fristTotalPrice = $('.total_price').val();
	if(Number($('.point').val()) > Number(fristTotalPrice)){
		alert('주문 금액보다 포인트가 많습니다.');
		$('.point').val("");
		$('.point_price').val(0);
	}
	bill();		
		 
};
/******** 포인트 전액사용 끝 ********/



/******** 주문내역 계산 기능 시작 ********/
function bill(){
	var addMenuPrice = 0;
	$(".menu_price").each(function(){
		addMenuPrice = Number($(this).val())+Number(addMenuPrice);
	});
	
	var totalPrice = Number(addMenuPrice)-Number($('.point_price').val());
	$('.total_price').val(totalPrice);
}
/******** 주문내역 계산 기능 끝 ********/



/******** 포인트 숫자만 입력기능 시작 ********/
function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}
/******** 포인트 숫자만 입력기능 끝 ********/



/******** submit 기능 시작 ********/
function frmsubmit(){
	var tab = $('.payment_tab li'); 	
	
	if($("#session").val()){ //회원		
		if(tab.eq(0).hasClass('active')){ //배달탭
			memberDelivertTab();
		} else if(tab.eq(1).hasClass('active')){ //예약탭
			reservationTab();
		} 
	} else{ //비회원
		if(tab.eq(0).hasClass('active')){ //배달탭
			noMemberDelivertTab();
		} else if(tab.eq(1).hasClass('active')){ //예약탭
			noReservationTab();
		} 
	}
	return false;
}

function noMemberDelivertTab(){
	var chk1 = document.order_form.chk_1.checked;
	var chk2 = document.order_form.chk_2.checked;
	if(!($('#sample6_postcode').val()) || !($('#sample6_address').val()) || !($('#sample6_address2').val())){
		alert('주소를 상세히 입력해주세요');
	} else if(!($('.phone_certified_delivery').val())){
		alert('핸드폰 번호를 입력해주세요');
	} else if(!($('.email_certified_delivery').val())){
		alert('이메일을 입력해주세요');
	} else if(chk1 == false || chk2 == false){
		alert('약관을 모두 동의해주세요');
	} else if($('#credit_card').is(":checked")){
		iamportAccount(delivery);
	} else if($('#phone_billing').is(":checked")){
		iamportPhone(delivery);
	}
}

function memberDelivertTab(){
	var chk1 = document.order_form.chk_1.checked;
	var chk2 = document.order_form.chk_2.checked;
	if(!($('#sample6_postcode').val()) || !($('#sample6_address').val()) || !($('#sample6_address2').val())){
		alert('주소를 상세히 입력해주세요');
	} else if(chk1 == false || chk2 == false){
		alert('약관을 모두 동의해주세요');
	} else if($('#credit_card').is(":checked")){
		iamportAccount(delivery);
	} else if($('#phone_billing').is(":checked")){
		iamportPhone(delivery);
	}
}

function noReservationTab(){
	var chk1 = document.order_form.chk_1.checked;
	var chk2 = document.order_form.chk_2.checked;
	if(!($('.booker').val())){
		alert('예약자명을 입력해주세요');
	} else if(!($('.phone_certified_reservation').val())){
		alert('휴대번호를 입력해주세요');
	} else if(!($('.email_certified_reservation').val())){
		alert('이메일을 입력해주세요');
	} else if(chk1 == false || chk2 == false){
		alert('약관을 모두 동의해주세요');
	} else if($('#credit_card').is(":checked")){
		iamportAccount(reservation);
	} else if($('#phone_billing').is(":checked")){
		iamportPhone(reservation);
	}
}

function reservationTab(){
	var chk1 = document.order_form.chk_1.checked;
	var chk2 = document.order_form.chk_2.checked;
	if(!($('.booker').val())){
		alert('예약자명을 입력해주세요');
	} else if(chk1 == false || chk2 == false){
		alert('약관을 모두 동의해주세요');
	} else if($('#credit_card').is(":checked")){
		iamportAccount(reservation);
	} else if($('#phone_billing').is(":checked")){
		iamportPhone(reservation);
	}
}
/******** submit 기능 끝 ********/



/******** iamport 신용카드 다날PG 시작 ********/
function iamportAccount(e){
	/******** iamport 다날PG 선언 시작 ********/
	var IMP = window.IMP; // 생략가능
	IMP.init('imp02079060'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	/******** iamport 다날PG 선언 끝 ********/
	
	var delivery = 'D';
	var reservation = 'R';
	
	var phone_certified;
	var email_certified;
	if(e == 'D'){
		phone_certified = $('.phone_certified_delivery').val();
		email_certified = $('.email_certified_delivery').val(); 
	}else if(e == 'R'){
		phone_certified = $('.phone_certified_reservation').val();
		email_certified = $('.email_certified_reservation').val();
	}
	
	var d1 = new Date ()
	var d2 = new Date (d1);
	d2.setMinutes ( d1.getMinutes() + 30 );	
	
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    amount : $('.total_price').val(),
	    buyer_email : 'iamport@siot.do',
	    buyer_name : $('.booker').val(),
	    buyer_tel : $('.user_phone').text().substr(0,13),
	    buyer_addr : $('#sample6_address').val()+" "+$('#sample6_address2').val(),
	    buyer_postcode : $('#sample6_postcode').val(),
	    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	}, function(rsp) {
	    if ( rsp.success ) {
	    	
	    	$.ajax({
				url:'orderPaymentResulut',
				type:'post',
				dataType:'json',
				data: {
		    		'고유ID' : rsp.imp_uid,
		    		'상점 거래ID' : rsp.merchant_uid,
		    		'PAYMENTAMOUNT' : rsp.paid_amount,
		    		'카드 승인번호' : rsp.apply_num,
		    		'APPROVALDATE' : rsp.paid_at,
		    		'PAYMENT' : rsp.pay_method,
		    		'STATUS' : rsp.pay_status,
		    		'RESERNAME' : rsp.buyer_name,
		    		'MEMBERPHONE' : rsp.buyer_tel,
		    		'DELIADDRESS' : rsp.buyer_addr,
		    		'DELIPOSTCODE' : rsp.buyer_postcode,
		    		'USEDPOINT' : $('.point').val(),
		    		'DELIMEMO' : $('.requests').val(),
		    		'NONMEMBERPHONE' : phone_certified,
		    		'NONMEMBEREMAIL' : email_certified,
		    		'RECEIVINGTIME' : d2.getFullYear()+"년"+(d2.getMonth()+1)+"월"+d2.getDate()+"일 "+d2.getHours()+"시"+d2.getMinutes()+"분",
		    		'ORDERLIST' : orderList,
		    		'BRANDNUM' : $('.brandNUM').val(),
		    		'DELIVREGICHECK' : e
	    		},
				success:function(data){
					if(data){						
						$(location).attr('href', 'success');
						return true;						
					}else{
						alert("다시 결제 시도해주세요.");
					}
				}
			});
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        alert(msg);
	        return false;
	    }
	});
}
/******** iamport 신용카드 다날PG 끝 ********/



/******** iamport 핸드폰 다날PG 시작 ********/
function iamportPhone(e){
	/******** iamport 다날PG 선언 시작 ********/
	var IMP = window.IMP; // 생략가능
	IMP.init('imp84921177'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	/******** iamport 다날PG 선언 끝 ********/
	
	var delivery = 'D';
	var reservation = 'R';
	
	var phone_certified;
	var email_certified;
	if(e == 'D'){
		phone_certified = $('.phone_certified_delivery').val();
		email_certified = $('.email_certified_delivery').val(); 
	}else if(e == 'R'){
		phone_certified = $('.phone_certified_reservation').val();
		email_certified = $('.email_certified_reservation').val();
	}
	
	var d1 = new Date ()
	var d2 = new Date (d1);
	d2.setMinutes ( d1.getMinutes() + 30 );	
	
	IMP.request_pay({
	    pg : 'danal', //아임포트 관리자에서 danal_tpay를 기본PG로 설정하신 경우는 생략 가능
	    pay_method : 'phone', //card(신용카드), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
	    merchant_uid : 'merchant_' + new Date().getTime(), //상점에서 관리하시는 고유 주문번호를 전달
	    name : '주문명:결제테스트',
	    amount : $('.total_price').val(),
	    buyer_email : 'iamport@siot.do',
	    buyer_name : $('.booker').val(),
	    buyer_tel : $('.user_phone').text().substr(0,13), //누락되면 카드사 인증에 실패할 수 있으니 기입해주세요
	    buyer_addr : $('#sample6_address').val()+" "+$('#sample6_address2').val(),
	    buyer_postcode : $('#sample6_postcode').val()
	}, function(rsp) {
	    if ( rsp.success ) {
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	$.ajax({
	    		url: 'orderPaymentResulut', //cross-domain error가 발생하지 않도록 주의해주세요
	    		type: 'POST',
	    		dataType: 'json',
	    		data: {
	    			'고유ID' : rsp.imp_uid,
		    		'상점 거래ID' : rsp.merchant_uid,
		    		'PAYMENTAMOUNT' : rsp.paid_amount,
		    		'카드 승인번호' : rsp.apply_num,
		    		'APPROVALDATE' : rsp.paid_at,
		    		'PAYMENT' : rsp.pay_method,
		    		'STATUS' : rsp.pay_status,
		    		'RESERNAME' : rsp.buyer_name,
		    		'MEMBERPHONE' : rsp.buyer_tel,
		    		'DELIADDRESS' : rsp.buyer_addr,
		    		'DELIPOSTCODE' : rsp.buyer_postcode,
		    		'USEDPOINT' : $('.point').val(),
		    		'DELIMEMO' : $('.requests').val(),
		    		'NONMEMBERPHONE' : phone_certified,
		    		'NONMEMBEREMAIL' : email_certified,
		    		'RECEIVINGTIME' : d2.getFullYear()+"년"+(d2.getMonth()+1)+"월"+d2.getDate()+"일 "+d2.getHours()+"시"+d2.getMinutes()+"분",
		    		'ORDERLIST' : orderList,
		    		'BRANDNUM' : $('.brandNUM').val(),
		    		'DELIVREGICHECK' : e
	    		}
	    	}).done(function(data) {
	    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	    		if (data) {
	    			$(location).attr('href', 'success');
					return true;
	    		} else {
	    			alert("다시 결제 시도해주세요.");
	    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		}
	    	});
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        
	        alert(msg);
	    }
	});
}
/******** iamport 핸드폰 다날PG 끝 ********/



/******** 다음 우편번호API 기능 시작 ********/
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}
/******** 다음 우편번호API 기능 끝 ********/

//수령시간
Date.prototype.addMinutes = function(minutes) {
    this.setMinutes(this.getMinutes() + minutes);
    return this;
};


/******** 이메일 정규식 기능 시작 ********/
function emailCheckTwo(){	
	
	
//	$(obj).keyup(function(){
//        $(this).val($(this).val().replace(/[^0-9]/g,""));
//   }); 
}
/******** 이메일 정규식 기능 끝 ********/