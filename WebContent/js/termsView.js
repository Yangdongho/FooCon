$(function(){
	
	var tab = $('.terms_teb li'),
		content = $('.terms-content');
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
	});