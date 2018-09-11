<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/adReference.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="<%=path%>/js/adReference.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>

<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 문의내역 탭  -->
	<section class="advertise-area">
		<h2 class="hidden">advertise-area</h2>
		<div class="container">
			<h3>광고/제휴문의</h3>
			<div class="write_area">
				<div class="writelist">
					<form class="adReferenceForm" onsubmit="return frmsubmit();">
						<ul class="clearfix">
							<li>
								<ul class="clearfix">
									<li>
										<p class="ptext">문의유형</p>
										<select name="INQUIRETYPE">
										    <option value="AD">광고</option>
										    <option value="COR">제휴</option>
										</select>
									</li>
									<li>
										<p class="ptext">이름</p>
										<input type="text" class="inquireName" name="INQUIRENAME" placeholder="담당자 성함을 입력해주세요" maxlength="10">
									</li>
									<li>
										<p class="ptext">연락처</p>
										<input type="text" class="inquirePhone" name="INQUIREPHONE" onkeydown="onlyNumber(this)" onblur="onlyNumber(this)" placeholder="'-'를 제외한 숫자만 입력해주세요" maxlength="20">
									</li>
								</ul>
							</li>
							<li>
								<div>
									<p class="ptext">업체명</p>
									<input type="text" name="INPUIREBRAND" class="inpuireBrand" placeholder="업체명을 입력해주세요" maxlength="30">
								</div>
							</li>
							<li>
								<div>
									<p class="ptext">상세주소</p>
									<input type="text" name ="INPUIREADDRESS" class="inpuireAddress" placeholder="상세한 주소를 입력해주세요" maxlength="50">
								</div>
							</li>
							<li>
								<div>
									<p class="ptext">내용</p>
									<textarea id="textarea" name="INPUIRECONTENT" class="inpuireContent" rows="30" cols="150" placeholder="문의하실 내용을 입력해주세요(2000자 이내)" maxlength="1000"></textarea>
								</div>
							</li>
						</ul>
						<input type="submit" value="확인">
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>