//다음지도 변수
var lat;
var lng;
//이미지 슬라이드 변수
var slideIndex = 0;
var numSlides;
var count;
var image;
//총 금액
var totalPrice = 0;
//ajax 페이징
var page = 1;
var brandNUM = window.location.search.substring(1);
var starGradeSum = 0;
var starGradeAverage = 0;
$(function(){
	$('#loading').css("display","none");		
	
	// // 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('55e37a8550b912ed5a050d715fba2bb7');
	theMore();

/********  다음지도 좌표로 마커찍기 api 시작 ********/
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
	center: new daum.maps.LatLng(lat,lng), // 지도의 중심좌표
	level: 8 // 지도의 확대 레벨
};

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new daum.maps.LatLng(lat,lng); 

// 마커를 생성합니다
var marker = new daum.maps.Marker({
	position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);
/********  다음지도 좌표로 마커찍기 api 끝 ********/


/********  영업중 계산 시작 ********/
var bot = $('.bot');
var strArray = bot.text().split(',');

bot.text("");
bot.text(strArray[0]+":"+strArray[1]+" ~ "+strArray[2]+":"+strArray[3]);

var openTime = strArray[0].toString()+strArray[1].toString();
var closeTime = strArray[2].toString()+strArray[3].toString();

var date = new Date();
var todayTime = date.getHours().toString() + date.getMinutes().toString();

if(todayTime < openTime || todayTime > closeTime){
	$('.open').css("display","none");
}
/********  영업중 계산 끝 ********/


/******** 이미지 슬라이드 시작 ********/
numSlides = count;

const slideshow = new Siema({
	selector: '.slider',
	loop: true,
	// startIndex: 1,
	// draggable: false,
	threshold: 200,
	onInit: updatePager,
	onChange: updatePager
});
// 슬라이드를 이동했을때 pager 업데이트하기
function updatePager(){
	var pagerIdx =this.currentSlide;
	$(".btn-nav").removeClass("active");
	$(".btn-nav").eq(pagerIdx).addClass('active');
}


$(".prev").on("click", function() {
	slideshow.prev();
	if (slideIndex <= 0) {
		slideIndex = numSlides - 1;
	} else {
		slideIndex--;
	}
	updateNav();
});

$(".next").on("click", function() {
	slideshow.next();
	if (slideIndex < numSlides - 1) {
		slideIndex++;
	} else {
		slideIndex = 0;
	}
	updateNav();
});

$(".btn-nav").on("click", function() {
	var $this = $(this),
	btnIndex = $this.data("index");

	slideIndex = btnIndex;
	slideshow.goTo(btnIndex);
	updateNav();
});

function updateNav() {
	$(".btn-nav").removeClass("active");
	$("[data-index='" + slideIndex + "']").addClass("active");
}

updateNav();
/******** 이미지 슬라이드 끝 ********/


/******** 메뉴 및 리뷰 탭기능 시작 ********/
var tab = $('.brand_tab li'),
content = $('.menu_review_list');
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



/******** 지도 및 주문함 fixed 기능 시작 ********/
var win = $(window),
header = $('.order_basket'),
headerOffset = header.outerHeight()+610;
win.scroll(function() {
	if(win.scrollTop() > headerOffset){ //윈도우가 더 밑에 있다
		header.addClass('scroll');
	} else { //윈도우가 더 위에 있다
		header.removeClass('scroll');
	}
});
/******** 지도 및 주문함 fixed 기능 끝 ********/



/******** 관심트럭 클릭 시작 ********/
$('.like').on('click',function(){
	if($('#session').val()){
		var interestCheck = false;
		if($('.like').hasClass('color')){ //관심트럭 되어있을 경우 
			interestCheck = true;
		} 

		var param = window.location.search.substring(1);
		$.ajax({
			url:'interest',
			type:'post',
			dataType:'json',
			data:{'BRANDNUM':param.substring(9),'INTERESTCHECK':interestCheck},
			success:function(data){
				if(data){ //관심트럭 추가 
					$('.like').addClass('color');
					$('.color').text('♥').css('color','#ff2d60');
				} else{ //관심트럭 삭제  
					$('.like').removeClass('color');
					$('.like').text('♡');
				}
			}
		});
	}else{
		alert("회원만 관심트럭 설정이 가능합니다.");
	}
});
/******** 관심트럭 클릭 끝 ********/



$('.not_empty_txt').hide();
/******** 메뉴 클릭 시 주문함에 넣기 시작 ********/
$('.brand_menu tr').on('click',function(e){
	e.preventDefault();

	var idx = $(this).index();
	var menuNUM = $('.brand_menu tr').eq(idx).find('.menu_num').val();
	var title = $('.brand_menu tr').eq(idx).children('.menu_title').text();
	var price = $('.brand_menu tr').eq(idx).children('.menu_price').text();

	var ul = $('.order_basket_body ul');
	var li = $("<li class='menuList'>");
	var menu_NUM = $("<input type='hidden' class='menuNUM' name='menuNUM' readonly='readonly'>");
	var menu_name = $("<input type='text' class='menu_name' name='menuName' readonly='readonly'>");
	var price_count = $("<div class='price_count'>");
	var price_div = $("<div class='price'>");
	var x = $("<a onclick='deleteRow(this)';>");
	var price_input = $("<input type='text' name='menuPrice' readonly='readonly'>");
	var won = $("<i>");
	var count_div = $("<div class='count'>");
	var count_subtract = $("<a class='subtract' onclick='subtract(this,"+price+");'>");
	var count_input = $("<input type='text' class='menu_count' name='orderQuantity' readonly='readonly'>");
	var count_add = $("<a class='add' onclick='add(this,"+price+");'>");

	var menu_counting = 1;
	//메뉴에서 클릭 시 주문함으로 값 넣을 때 확인 및 카운팅
	if($('.brand_menu tr').eq(idx).hasClass('have')){			
		$(".menu_count").each(function(){
			var data_idx = $(this).attr("data-idx");
			if(idx==data_idx){
				var orgin_count = Number($(this).val());
				$(this).val(orgin_count+1);

				var additional_price = $(this).parent().siblings('.price').children('input');
				additional_price.val((Number(price)+Number(additional_price.val())));
			}
		});
	} else{
		price_input.val(price);
		won.text("원");
		x.text("x");
		price_input.appendTo(price_div);
		won.appendTo(price_div);
		x.appendTo(price_div);

		count_add.text("+");
		count_input.val(menu_counting);
		count_subtract.text("-");
		count_subtract.appendTo(count_div);
		count_input.appendTo(count_div);
		count_add.appendTo(count_div);

		count_div.appendTo(price_count);
		price_div.appendTo(price_count);

		menu_NUM.val(menuNUM);
		menu_name.val(title);

		menu_NUM.appendTo(li);
		menu_name.appendTo(li);
		price_count.appendTo(li);

		li.appendTo(ul);
		//각 li 값란에 idx 넣고 주문함에 해당 주문 들어와있는지 확인할 have 클래스 add
		count_input.attr("data-idx",idx);
		$('.brand_menu tr').eq(idx).addClass('have');

		//해당 li 수량에 카운팅
		var totalCount = Number($('.order_basket_head p span').text());
		$('.order_basket_head p span').text(totalCount+1);	
	}
	//전체금액 계산
	totalPrice = totalPrice+Number(price);
	$('.total_price').text(totalPrice);
	$('.empty_txt').hide();
	$('.not_empty_txt').show();
});
/******** 메뉴 클릭 시 주문함에 넣기 끝 ********/



/******** submit 기능 시작 ********/
$("#orderForm").on("submit",function(){
	if($('.order_basket_body ul li').length == 0){
		return false;
	} else{
		return true;
	}	
});
/******** submit 기능 끝 ********/


/******** 브랜드 번호 숫자에 '-' 추가기능 시작 ********/
var brandPhone = $('.brandPhone').text();
if(brandPhone.length = 11){
	brandPhone.substr(0,3)+"-";
    $('.brandPhone').text(brandPhone.substr(0,3)+"-"+brandPhone.substr(3,4)+"-"+brandPhone.substr(7,4))
}
/******** 브랜드 번호 숫자에 '-' 추가기능 끝 ********/
});

/******** 주문함 수량 위아래 / 선택삭제 / 전체삭제 / 전체금액계산 기능 시작 ********/
function subtract(con,price){
	var cnt = Number($(con).siblings('input').val());
	if(cnt > 1){
		$(con).siblings('input').val(cnt-1);

		var orginPriceInput = $(con).parent().siblings('.price').children('input');
		orginPriceInput.val(Number(orginPriceInput.val()-Number(price)));

		totalPrice = totalPrice-Number(price);
		$('.total_price').text(totalPrice);
	} 
}
function add(con,price){
	var cnt = Number($(con).siblings('input').val());
	$(con).siblings('input').val(cnt+1);

	var orginPriceInput = $(con).parent().siblings('.price').children('input');
	orginPriceInput.val(Number(price)+Number(orginPriceInput.val()));

	totalPrice = totalPrice+Number(price);
	$('.total_price').text(totalPrice);
}
function deleteRow(con,price){
	var idx = $(con).parent().siblings('.count').children('.menu_count').attr("data-idx");
	$(con).closest('li').remove();
	var totalCount = Number($('.order_basket_head p span').text());
	$('.order_basket_head p span').text(totalCount-1);
	$('.brand_menu tr').eq(idx).removeClass('have');

	//전체금액 계산
	totalPrice = totalPrice-Number($(con).siblings('input').val());
	$('.total_price').text(totalPrice);
	if(totalPrice == 0){
		$('.empty_txt').show();
		$('.not_empty_txt').hide();
	}
}
function deleteRowAll(con){
	$(con).parents().find('.menuList').remove();
	$('.order_basket_head p span').text(0);
	$('.brand_menu tr').removeClass('have');

	//전체금액 계산
	totalPrice = 0;
	$('.total_price').text(0);
	$('.empty_txt').show();
	$('.not_empty_txt').hide();
}
/******** 주문함 수량 위아래 / 선택삭제 / 전체삭제 / 전체금액계산 기능 끝 ********/


/********  리뷰 리스트 ajax 요청 시작 ********/
function theMore(){	
	
//	$('.review_more_btn').hide();
	$('#loading').css("display","block");
	
	$.ajax({
		url:'reviewList',
		type:'post',
		dataType:'json',
		data:{
			'BRANDNUM':brandNUM.substring(9),
			'FISRTROW':page 
		},
		success:function(data){
			var ul = $('.review_list');
			
			for(var i=0 ; i<data.reviewListView.length ; i++){
				var li = $("<li>");
				
				var review_userinfo = $("<div class='review_userinfo'>");
				var nicname = $("<span class='nicname'>");
				var date = $("<span class='date'>");
				
				var review_score = $("<div class='review_score'>");
				var star_core = $("<span class='star'>");
				var star_gray = $("<span class='star gray'>");

				star_core.css("color","#F9D922");
				star_gray.css("color","#F2F2F2");
				
				var purchase_details = $("<span class='purchase_details'>");
				purchase_details.text("구매내역 :"+data.reviewListView[i].PURCHASEITEM);
				var review_content = $("<p class='review_content'>");
				review_content.text(data.reviewListView[i].REVIEWCONTENT);
				if(data.reviewListView[i].REVIEWPHOTO != null){
					var review_img = $("<img class='review_img' src='imagePreview?fileName="+data.reviewListView[i].REVIEWPHOTO+"'>");
				}
				
				var review_answer_area = $("<div class='review_answer_area'>");
				var review_answer_brand = $("<span class='review_answer_brand'>");
				var review_answer_date = $("<span class='review_answer_date'>");
				var review_answer = $("<p class='review_answer'>");
				
				
				nicname.text(data.reviewListView[i].NICK);
				date.text(data.reviewListView[i].REVIEWREGDATE);
				nicname.appendTo(review_userinfo);
				date.appendTo(review_userinfo);
				
				
				var tmp1 = "";
				var tmp2 = "";
				for(var k=1; k<6; k++){
					if(data.reviewListView[i].STARGRADE >= k){
						tmp1 = tmp1 + "★";  
						star_core.text(tmp1);
					}else{
						tmp2 = tmp2 + "★";
						star_gray.text(tmp2);
					}
				}
				star_core.appendTo(review_score);
				star_gray.appendTo(review_score);
				
				
				if(data.reviewListView[i].REPLYCONTENT != null){
					review_answer_brand.text("사장님");
					review_answer_brand.appendTo(review_answer_area);
					review_answer_date.text(data.reviewListView[i].REPLYREGDATE);
					review_answer_date.appendTo(review_answer_area);
					review_answer.text(data.reviewListView[i].REPLYCONTENT);
					review_answer.appendTo(review_answer_area);					
				}
				
				review_userinfo.appendTo(li);
				review_score.appendTo(li);
				purchase_details.appendTo(li);
				review_content.appendTo(li);
				if(data.reviewListView[i].REVIEWPHOTO != null){
					review_img.appendTo(li);
				}
				if(data.reviewListView[i].REPLYCONTENT != null){
					review_answer_area.appendTo(li);
				}
				li.appendTo(ul);
			}

			$('.reviewTotalCount').text(data.reviewTotalCount);
			$('#loading').css("display","none");
						
			if(data.reviewListView.length == 0){
				$('.review_more_btn').hide();
				
			}
			if(data.pageTotalCount == data.currentPage){
				$('.review_more_btn').hide();
				
			}
			
			if(page == 1){
				
				if(data.reviewTotalAverageView.length == 0 || data.reviewTotalAverageView.length == null){
					starGradeAverage = 0;
				}else{					
					for(var i=0 ; i < data.reviewTotalAverageView.length ; i++){
						starGradeSum = starGradeSum + Number(data.reviewTotalAverageView[i].STARGRADE);			
					}
					starGradeAverage = starGradeSum/data.reviewTotalAverageView.length;
				}
				theMoreAfter();
//				$('.review_more_btn').show();
			}
			
//			if(page == 2){
//				$('.review_more_btn').show();
//			}
			page++;
		}
	});
} 
function theMoreAfter(){
	$('.total-core-count').text(starGradeAverage.toFixed(1));
			
	var star_total_core = $('.star-total-core');
	var star_total_gray = $('.star-total-gray');
	
	var tmp1 = "";
	var tmp2 = "";
	for(var i=1; i<6; i++){
		if(Math.floor(starGradeAverage)>=i){
			tmp1 = tmp1 + "★";  
			star_total_core.text(tmp1);
		}
		else{
			tmp2 = tmp2 + "★";
			star_total_gray.text(tmp2);
		}
	}
}
/********  리뷰 리스트 ajax 요청 끝 ********/


/******** 카톡 공유하기 api 시작 ********/
//<![CDATA[    	
// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
function sendLink() {
  Kakao.Link.sendDefault({
    objectType: 'feed',
    content: {
      title: $('#brandName').text(),
      description: $('.brandIntroduce').text(),
      imageUrl: "http://k.kakaocdn.net/dn/lvmvK/btqnYebWCsy/2Nv6GaI9pxslgZa4BJqxK1/kakaolink40_original.png",
      link: {        	  
        mobileWebUrl: 'http://ec2-52-78-89-182.ap-northeast-2.compute.amazonaws.com/brand/brandView?brandNUM='+brandNUM.substring(9),
        webUrl: 'http://ec2-52-78-89-182.ap-northeast-2.compute.amazonaws.com/brand/brandView?brandNUM='+brandNUM.substring(9)
      }
    }
  });
}
//]]>
/******** 카톡 공유하기 api 끝 ********/


/******** 트위터 공유하기 api 시작 ********/
function shareTwitter(){
	 var content = "[Foocon] "+$('#brandName').text();
	 var link = "http://ec2-52-78-89-182.ap-northeast-2.compute.amazonaws.com/brand/brandView?brandNUM="+brandNUM.substring(9);
	 var popOption = "width=370, height=518, resizable=no, scrollbars=no, status=no;";
	 var wp = window.open("http://twitter.com/share?url=" + encodeURIComponent(link) + "&text=" + encodeURIComponent(content), 'twitter', popOption);
	 if (wp) {wp.focus();}    
}
/******** 트위터 공유하기 api 끝 ********/
	
	
/******** 페이스북 공유하기 api 시작 ********/
function shareFacebook(){
	 var link = "http://ec2-52-78-89-182.ap-northeast-2.compute.amazonaws.com/brand/brandView?brandNUM="+brandNUM.substring(9);
	 var popOption = "width=500, height=518, resizable=no, scrollbars=no, status=no;";
	 var wp = window.open("http://www.facebook.com/sharer.php?u="+encodeURIComponent(link),'facebook',popOption);
	 if ( wp ) {
	    wp.focus();
	 }    
}

/******** 트위터 공유하기 api 끝 ********/	