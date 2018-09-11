<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="aaa">
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
	<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
</div>
	<script>
	var temp = '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>';
		$(window).scroll(function() {
			var scrollHeight = $(document).height();
			var scrollPosition = $(window).height() + $(window).scrollTop();
			if ((scrollHeight - scrollPosition) / scrollHeight === 0) {
				$("#aaa").append(temp);
				$("#aaa").append(temp);
				$("#aaa").append(temp);
				$("#aaa").append(temp);
				$("#aaa").append(temp);
				$("#aaa").append(temp);
			} else {
				$("body").css("background","white");
			}
		});
	</script>
</body>
</html>