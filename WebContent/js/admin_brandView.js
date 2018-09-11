//지도 변수
var mapContainer;
var map;
var marker;
var geocoder;
//파일미리보기 변수
var thumbnail_file = [];
var detail_file = [];
$(function(){
	$('.text').css("display","none");
	
	$('.OwnerPassword').on("blur",function(){
		var mm = $('.OwnerPassword').val();
		var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

		if(pw.test(mm)){
			$('.OwnerPasswordText').css("display","none");
			$('.OwnerPasswordText').text("");
		}else{
			$('.OwnerPasswordText').css("display","block");
			$('.OwnerPasswordText').text("");
			$('.OwnerPasswordText').text("비밀번호는 8글자 이상 20자 이하 영어 숫자, 특수문자이여만 합니다.");
			$('.OwnerPassword').val("");
		}
	});
	
	$('.OwnerPasswordChange').on("blur",function(){
		var mm = $('.OwnerPasswordChange').val();
		var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		
		if(pw.test(mm)){
			$('.OwnerPasswordChangeText').css("display","none");
			$('.OwnerPasswordChangeText').text("");
		}else{
			$('.OwnerPasswordChangeText').css("display","block");
			$('.OwnerPasswordChange').val("");
			$('.OwnerPasswordChangeText').text("비밀번호는 8글자 이상 20자 이하 영어 숫자, 특수문자이여만 합니다.");
			$('.OwnerPasswordChange').val("");
		}
	});
	
	/******** 파일업로드 미리보기 시작 ********/
	$('.thumnailImg_wrap').hide();
	$('.thumnailImage').on("change",thumbnailHandleImgFileSelect);
	$('.detailImg_wrap').hide();
	$('.detailImages').on("change",detailHandleImgFileSelect);
	/******** 파일업로드 미리보기 끝 ********/
	
	
	/******** 다음지도 마커로 좌표찾기 api-1 시작 ********/
	mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	geocoder = new daum.maps.services.Geocoder();

	marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	        if (status === daum.maps.services.Status.OK) {
	        	
	            var detailAddr = !!result[0].road_address ? result[0].road_address.address_name : '';
	            detailAddr += result[0].address.address_name;
	            
	            var content = detailAddr;
	            
	            $('.brandAddress').val("");
	            $('.brandAddress').val(result[0].address.address_name);
	            // 마커를 클릭한 위치에 표시합니다 
	            marker.setPosition(mouseEvent.latLng);
	            marker.setMap(map);
	        }   
	    });
	});
	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'idle', function() {
	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	});
	/******** 다음지도 마커로 좌표찾기 api-1 끝 ********/
	
	
	
	/******** 등록한 것들을 보여주는 부분 시작 ********/
	if($('.brandAddress').val()){
		mapAddress();
	}
	
	if($('.exposureLevel').val()){
		if($('.exposureLevel').val() == 'NORMAL'){
			$('.recommand_normal').attr('checked','checked');
			$('.main_normal').attr('checked','checked');
		}else if($('.exposureLevel').val() == 'RECOMMAND'){
			$('.recommand').attr('checked','checked');
			$('.main_normal').attr('checked','checked');
		}else if($('.exposureLevel').val() == 'MAIN'){
			$('.recommand_normal').attr('checked','checked');
			$('.main').attr('checked','checked');
		}else if($('.exposureLevel').val() == 'PACKAGE'){
			$('.recommand').attr('checked','checked');
			$('.main').attr('checked','checked');
		}
	}
	
	if($('.brandOpenTime').val()){
		var brandOpenTime = $('.brandOpenTime').val();
		var split = brandOpenTime.split(',');
		  
		$(".OPEN_TIME_HOUR").val(split[0]).attr("selected", "selected");
		$(".OPEN_TIME_MINUTE").val(split[1]).attr("selected", "selected");
		$(".CLOSE_TIME_HOUR").val(split[2]).attr("selected", "selected");
		$(".CLOSE_TIME_MINUTE").val(split[3]).attr("selected", "selected");
	}
	
	if($('.brandDeliveryStatus').val() == 'Y'){
		$('#delivery_on').prop('checked',true);
	}
	
	if($('.brandReservationStatus').val() == 'Y'){
		$('#reservation_on').prop('checked',true);
	}
	
	/******** 등록한 것들을 보여주는 부분 끝 ********/
	$('.pwSpan').hide();
});
/******** 다음지도 마커로 좌표찾기 api-2 시작 ********/
function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);    
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
    $('.brandLongitude').val("");
    $('.brandLongitude').val(coords.getLng());
    $('.brandLatitude').val("");
    $('.brandLatitude').val(coords.getLat());
}

//지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === daum.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');
    }    
}
/******** 다음지도 마커로 좌표찾기 api-2 끝 ********/



/******** 다음지도 주소로 좌표찾기 api 시작 ********/
function mapAddress(){
	var address = $('.brandAddress').val();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	        $('.brandLongitude').val("");
	        $('.brandLongitude').val(result[0].x);
	        $('.brandLatitude').val("");
	        $('.brandLatitude').val(result[0].y);
	        
	        
	        marker.setMap(null);
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        	marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
}
/******** 다음지도 주소로 좌표찾기 api 끝 ********/

function frmsubmit(){	
	var brandName = $('.brandname').val();
	var ownerPhone = $('.ownerPhone').val();
	var brandAddress = $('.brandAddress').val();
	var brandPhone = $('.brandPhone').val();
	
	if(brandName && ownerPhone && brandAddress && brandPhone){
		var formData = new FormData($(".brandViewForm")[0]);

		for(var i=0 ; i < detail_file.length ; i++){
			var name = "IMAGE"+i;
			formData.append(name,detail_file[i]);
		}
		formData.append("DETAILIMAGECOUNT",detail_file.length);
		formData.append("THUMNAILIMAGECOUNT",thumbnail_file.length);
		formData.append("THUMNAILIMAGE",thumbnail_file[0]);
		
		$.ajax({
			url:'brandSave',
			type:'post',
	        processData: false,  
	        contentType: false,
	        cache: false,
			data: formData,
			success : function(data){
				if(data){						
					alert("저장되었습니다.");
					window.location.reload();
					return true;
				}else{
					alert("다시 입력해주세요.");
				}
			},
			error: function (data, textStatus, jqXHR) {
				alert("data "+data);
				alert("textStatus "+textStatus);
				alert("jqXHR "+jqXHR);
			}
		});	
		return false;		
	}else{
		if(!brandName){
			alert("푸드트럭명을 입력해주세요");
		}else if(!ownerPhone){
			alert("계정정보의 휴대번호를 입력해주세요");
		}else if(!brandAddress){
			alert("기본정보의 주소를 입력해주세요");
		}else if(!brandPhone){
			alert("기본정보의 전화번호를 입력해주세요");
		}
		return false;
	}
}

/******** 비밀번호 변경 버튼 시작 ********/
function passwordChange(){
	$('.pwChangeBtn').css('margin-left','64px');
	
	if($('.pwChangeBtn').val() == '비밀번호 변경'){
		$('.pwChangeBtn').val("저장하기");
		$('.pwSpan').show();
	} else if($('.pwChangeBtn').val() == '저장하기'){
		if($('.OwnerPassword').val() && $('.OwnerPasswordChange').val()){
			$.ajax({
				url:'brandOwnerPasswordChange',
				type:'post',
				dataType:'json',
				data: {
					OWNERPASSWORD:$('.OwnerPassword').val(),
					OWNERPASSWORDCHANGE:$('.OwnerPasswordChange').val()
				},
				success : function(data){
					if(data){						
						alert("비밀번호가 변경되었습니다.");
						$('.pwChangeBtn').css('margin-left','0px');
						$('.pwChangeBtn').val("비밀번호 변경");
						$('.pwSpan').hide();
						$('.OwnerPassword').val("");
						$('.OwnerPasswordChange').val("");
					}else{
						alert("비밀번호가 틀렸습니다.");
						$('.OwnerPassword').val("");
						$('.OwnerPasswordChange').val("");
					}
				}
			});			
		}else{
			$('.OwnerPassword').val("");
			$('.OwnerPasswordChange').val("");
			$('.OwnerPasswordText').css("display","none");
			$('.OwnerPasswordChangeText').css("display","block");
			$('.OwnerPasswordChangeText').text("변경할 비밀번호 또는 기존 비밀번호를 입력해주세요");
		}
	}
}
/******** 비밀번호 변경 버튼 끝 ********/



/******** 파일업로드 미리보기 시작 ********/
function thumbnailHandleImgFileSelect(e){
	$('.thumnailImg_wrap').empty();
	
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	var index = 999;
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		thumbnail_file.push(f);
		
		var reader = new FileReader();
		reader.onload = function(e){
//			var img_html = "<img class=\"img thumnailImg\" src=\""+e.target.result+"\" />";
			var img_html = "<a class=\"deleteImage\" onclick=\"thumnailDeleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img class=\"img thumnailImg\" src=\""+e.target.result+"\" data-file='"+f.name+"'></a>";
			$(".thumnailImg_wrap").append(img_html);
			index++;
		}
		$('.thumnailImg_wrap').show();
		reader.readAsDataURL(f);
	});
}

function detailHandleImgFileSelect(e){
	$('.detailImg_wrap').empty();
	
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);	
	var index = 0;
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		detail_file.push(f);
		
		var reader = new FileReader();
		reader.onload = function(e){
			var img_html = "<a class=\"deleteImage\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img class=\"img\" src=\""+e.target.result+"\" data-file='"+f.name+"'></a>";
			$(".detailImg_wrap").append(img_html);
			index++;
		}
		$('.detailImg_wrap').show();
		reader.readAsDataURL(f);
	});	
}

function thumnailDeleteImageAction(index){
	thumbnail_file.splice(0,1);
	
	var imge_id = "#img_id_"+index;
	$(imge_id).remove();
}
function deleteImageAction(index){
	detail_file.splice(index,1);
	
	var imge_id = "#img_id_"+index;
	$(imge_id).remove();
}

/******** 파일업로드 미리보기 끝 ********/



/******** 포인트 숫자만 입력기능 시작 ********/
function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
    
    $(obj).blur(function(){
    	 $(this).val($(this).val().replace(/[^0-9]/g,""));
    });
}
/******** 포인트 숫자만 입력기능 끝 ********/


/******** 비밀번호 정규식 시작 ********/
//function me(){
//	alert("xxxx");
//	$('.OwnerPassword').on("blur",function(){
//		alert("dddd");
//	});
//	
//	var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
//	if(!(pw.test($('.OwnerPassword').val()))){
//		alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 이여만 합니다. ");
//		$('.OwnerPassword').val("");
//	}
	
	
//}



//function onlyPw(obj) {
//	var pwCheck = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
//    $(obj).keyup(function(){
//    	 alert("2131 "+$(this).val().replace(pwCheck,""));
//         $(this).val($(this).val().replace(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/,""));
//    }); 
//}
//
//function onlyPassword(obj) {
//    $(obj).keyup(function(){
//    	var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
//    	if(!(pw.test(obj))){
//    		alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 이여만 합니다. ");
//    	}
//  
////         $(this).val($(this).val().replace(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/,""));
//    }); 
////    정규식
//    $(obj).blur(function(){
//    	var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
//    	if(!(pw.test(obj))){
//    		alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 이여만 합니다. ");
//    	}
//    });
//}
//
//function ogPass(){
//	
//	var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
//	if(!(pw.test($('.OwnerPassword').val()))){
//		alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 이여만 합니다. ");
//		$('.OwnerPassword').val("");
//	}
//}
//
//function changePass(){
//	var pw = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
//	if(!(pw.test($('.OwnerPasswordChange').val()))){
//		alert("zz비밀번호는 8글자 이상 20자 이하 영어 숫자 이여만 합니다. ");
//		$('.OwnerPasswordChange').val("");
//	}
//}

//alert("비밀번호는 8글자 이상 20자 이하 영어 숫자 이여만 합니다. ");
//var ph = /^[0-9]{10,11}$/ //핸드폰번호가 적합한지 검사할 정규식
//	  alert("휴대번호를 확인해 주세요.")
/******** 비밀번호 정규식 끝 ********/