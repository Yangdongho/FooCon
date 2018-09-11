var slideIndex = 0;
var numSlides = 4;
$(function(){

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
});

