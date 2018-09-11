<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common_admin.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/admin_main.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>  

  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 서비스명</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header_admin.jsp"/>
	<!-- 공지사항 리스트 -->
	<section class="notice-list-area">
	
<!-- 		마스터 계정으로 들어왔을 때 -->
		<c:if test='${sessionScope.AUTHORITY eq "MASTER"}'>
		<div class="content_container">		
			<!-- 첫번째 박스 -->
			<div class="box">
			
					<h2 id = "dash">주문관리</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div >
						<ul>
							<li style="float:left">누적주문&nbsp;<span>${MasterCount.ORDERTOTALCOUNT}</span>건</li>
							<li style="float:left">배&nbsp;달&nbsp;<span>${MasterCount.NDELIVERTOTALCOUNT}</span>건</li>
							<li style="float:left">배달취소&nbsp;<span>${MasterCount.cancleDeli}</span>건</li>
							<li style="float:left">예&nbsp;약&nbsp;<span>${MasterCount.ORDERTOTALCOUNT}</span>건</li>
							<li style="float:left">예약취소&nbsp;<span>${MasterCount.cancleReser}</span>건</li>
						</ul>
					</div>
			</div>
			
			<!-- 두번째 박스 -->
			<div class="box">
			
					<h2>리뷰관리</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div>
						<ul>
							<li style="float:left">누적리뷰&nbsp;<span>${MasterCount.reviewTotal}</span>건</li>
							<li style="float:left">신규리뷰&nbsp;<span>${MasterCount.todayReview}</span>건</li>
						</ul>
					</div>
			</div>	
			
			<!-- 세번째 박스 -->
			<div class="box">
			
					<h2>1:1 문의관리</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div>
						<ul>
							<li style="float:left">누적문의&nbsp;<span>${MasterCount.inquireTotal}</span>건</li>
							<li style="float:left">신규문의&nbsp;<span>${MasterCount.inquireToday}</span>건</li>
						</ul>
					</div>
			</div>	
			
			<!-- 네번째 박스 -->
			<div class="box">
			
					<h2>광고/제휴&nbsp;문의관리</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div>
						<ul>
							<li style="float:left">누적문의&nbsp;<span>${MasterCount.adTotal}</span>건</li>
							<li style="float:left">신규문의&nbsp;<span>${MasterCount.adToday}</span>건</li>
						</ul>
					</div>
			</div>
			
			<!-- 다섯번째 박스 -->
			<div class="box">
			
					<h2>매출현황</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div>
						<ul>
							<li style="float:left">누적매출&nbsp;<span>${MasterCount.salesTotal}</span>원</li>
							<li style="float:left">이번&nbsp;달&nbsp;매출&nbsp;<span>${MasterCount.salesMonth}</span>원</li>
						</ul>
					</div>
			</div>			
		</div>
		</c:if>
		
		<!--브랜드 계정으로 들어왔을 때 -->
		<c:if test='${sessionScope.AUTHORITY eq "BRAND"}'>
		<div class="content_container">
			<!-- 첫번째 박스 -->
			<div class="box">			
					<h2 id = "dash">주문관리</h2>					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div >
						<ul>
							<li style="float:left">누적주문&nbsp;<span>${BrandCount.ORDERTOTALCOUNT}</span>건</li>
							<li style="float:left">배&nbsp;달&nbsp;<span>${BrandCount.NDELIVERTOTALCOUNT}</span>건</li>
							<li style="float:left">배달취소&nbsp;<span>${BrandCount.cancleDeli}</span>건</li>
							<li style="float:left">예&nbsp;약&nbsp;<span>${BrandCount.NREGITOTALCOUNT}</span>건</li>
							<li style="float:left">예약취소&nbsp;<span>${BrandCount.cancleReser}</span>건</li>
						</ul>
					</div>
			</div>
			
			<!-- 두번째 박스 -->
			<div class="box">
			
					<h2>리뷰관리</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div>
						<ul>
							<li style="float:left">누적리뷰&nbsp;<span>${BrandCount.reviewTotal}</span>건</li>
							<li style="float:left">신규리뷰&nbsp;<span>${BrandCount.todayReview}</span>건</li>
						</ul>
					</div>
			</div>	

			<!-- 다섯번째 박스 -->
			<div class="box">
			
					<h2>매출현황</h2>
					
					<HR width="98%"  style="background-color:#808080; height:1%; border:none" />
					
					<div>
						<ul>
							<li style="float:left">누적매출&nbsp;<span>${BrandCount.salesTotal}</span>원</li>
							<li style="float:left">이번&nbsp;달&nbsp;매출&nbsp;<span>${BrandCount.salesMonth}</span>원</li>
						</ul>
					</div>
			</div>			
		</div>
		</c:if>		
	</section>
</body>	
</html>