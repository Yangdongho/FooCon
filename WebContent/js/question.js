var tab;
var content;
var pageNum;

function on(num){
	var num1 = num;
	$(function(){
		//FAQ, 문의내역, 문의작성 탭기능
		tab = $('.question_teb li');
		content = $('.question-content');
		
		content.hide();
		
		tab.click(function(e){
			
			e.preventDefault();
			var idx = $(this).index();
			console.log(idx);
			
			content.hide();
			content.eq(idx).show();
			
			tab.removeClass('active');
			$(this).addClass('active');
		});
		tab.eq(num1).trigger('click');
		
		
		
		//아코디언 메뉴 기능
		var accordian = $('.question_back');
		accordian.hide();
		
		$('.question_front').click(function(){
			$(this).siblings(accordian).slideToggle(0);
		});
	});
}
	function nullcheck(){
		if($('#title').val()!="" && $('#textarea').val()!="" ){
			return true;
		}else{
			alert("등록하실 내용을 입력해 주세요");
			return false;
		}
	}
	//글자수 제한
	$(document).ready(function() {
		$('#textarea').on('keyup', function() {
			if($(this).val().length >1000) {
				$(this).val($(this).val().substring(0, 1000));
			}
		});
	});

