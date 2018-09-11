<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/termsView.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</script> 
<script src="<%=path%>/js/termsView.js"></script>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 2차 메뉴 -->
	<section class="two-depth-menu">
		<h2 class="hidden">two-depth-menu</h2>
		<div class="container">
			<ul class="clearfix">
				<li><a href="#" class="menu_pointlist">적립금 관리</a></li>
				<li><a href="#" class="menu_orderlist">주문내역</a></li>
				<li><a href="#" class="menu_likelist">관심트럭</a></li>
				<li><a href="#" class="menu_question">1:1 문의내역</a></li>
				<li><a href="#" class="menu_mypage">개인정보 수정/탈퇴</a></li>
			</ul>
		</div>
	</section>
	<!-- 약관 탭  -->
	<section class="terms-tab-area">
		<h2 class="hidden">terms-tab-area</h2>
		<div class="container">
			<ul class="terms_teb">
				<li>이용약관</li>
				<li>개인정보 수집 및 이용동의</li>
				<li>위치정보 이용약관</li>
			</ul>
		</div>
	</section>
	<!-- 이용약관  -->
	<section class="terms-content">
		<h2 class="hidden">terms-content</h2>
		<div class="container">
			<div class="terms_area">
				<p id="title">이용약관</p>
				<div class="content">
					<p>제 1 조 (목적)</p><br>
					<p>이 이용약관(이하 '약관'이라 합니다)은 ㈜Foocon(이하 '회사'라 합니다)와 이용 고객(이하 '회원'이라 합니다.)간에 회사가 제공하는 서비스(이하 '서비스'라 합니다)를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.</p><br>
					
					<p>제 2 조 (정의)</p><br>
					<p>1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>																											
					<ul class="clearfix">
						<li class="con">"Foocon"란 회사가 “서비스”를 이용자에게 제공하기 위하여 컴퓨터를 이용하여 배달음식 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 ”Foocon”를 운영하는 사업자의 의미로도 사용합니다.	</li>																								
						<li class="con">“Foocon서비스”란 회사가 운영하는 사이트를 통해 이용자가 원하는 음식을 주문하면, 주문이 완료된 음식을 푸드트럭(이하 “공급자”라 함)이 이용자에게 배달 또는 판매하는 서비스를 기본으로 하되, 맛집배달대행, 테이크아웃 등 “Foocon” 사이트 상의 제공 서비스 전체를 의미합니다.	</li>																									
						<li class="con">"이용자"란 “Foocon”에 접속하여 본 약관에 따라 Foocon가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>														
						<li class="con">"회원”이라 함은 “Foocon”에 개인정보를 제공하여 회원등록을 한 자로서, “Foocon”의 정보를 지속적으로 제공받으며, “Foocon”가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>																										
						<li class="con">"비회원”이라 함은 회원에 가입하지 않고 “Foocon”가 제공하는 서비스를 이용하는 자를 말합니다.</li>																					
						<li class="con">“가맹점”이란 회사와 가맹계약을 맺고 회사가 운영하는 Foocon서비스에서 음식물을 공급하는 사업자를 말하며, 회사의 대리인이나 피용자로 간주되지 아니합니다.</li>																									
						<li class="con">“적립금”이란 서비스의 효율적 이용을 위해 회사가 임의로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 서비스 상의 가상 데이터를 의미합니다.	</li>
						<li class="con"> 본 약관에서 정의되지 않은 용어는 관련법령이 정하는 바에 따릅니다.</li>
					</ul><br>
					<p>제3조 (약관의 명시와 설명 및 개정))</p><br>
					<ul class="clearfix">
						<li class="con">“Foocon”는 본 약관의 내용과 상호, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등), 통신판매업신고번호, 개인정보관리책임자 등을 이용자가 알 수 있도록 "Foocon" 쇼핑몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.</li>																								
						<li class="con">“Foocon”는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회 ? 배송책임 ? 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.	</li>																									
						<li class="con">"Foocon"는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진 및 정보보호 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.</li>														
						<li class="con">"Foocon"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 “Foocon”의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “Foocon”는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.</li>																										
						<li class="con">"Foocon"가 약관을 개정할 경우에는 개정약관의 효력발생일 이후 회원이 서비스를 이용하는 경우, “Foocon”는 회원이 개정약관에 동의한 것으로 봅니다.</li>																					
						<li class="con">개정 약관조항은 개정 약관의 적용일자 이후에 체결된 계약에 한하여 적용되는 것을 원칙으로 합니다. 다만, “Foocon”가 지정하는 방식에 따라 회원이 동의를 한 경우에는 개정약관 조항이 적용됩니다.</li>																									
						<li class="con">변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 “Foocon”에서 책임지지 않습니다. 단, 회원이 개정 약관에 동의하지 아니할 때에는 회원은 “Foocon”에 대하여 회원의 탈퇴 기타 이용계약을 해지할 수 있습니다.</li>
						<li class="con">본 약관에서 정하지 아니한 사항과 본 약관의 해석에 관하여는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</li>
					</ul><br>
					<p>제4조 (서비스의 제공 및 변경, 개별적 중단)</p><br>
					<ul class="clearfix">
						<li class="con">"Foocon"는 다음과 같은 업무를 수행합니다.</li>																								
							<ul class="clearfix">
								<li class="conn">음식과 관련한 전자상거래 중개대행</li>
								<li class="conn">음식 또는 관련 용역에 대한 정보 제공 및 구매계약의 체결</li>
								<li class="conn">기타 "Foocon"가 정하는 업무</li>																						
							</ul>
						<li class="con">"Foocon"는 음식 또는 용역의 품절 또는 기술적 사양의 변경 등의 사유가 발생하는 경우 장차 체결되는 계약에 의해 제공할 Foocon서비스의 내용을 변경할 수 있으며, 오로지 가맹점의 사정(가맹점의 고의나 과실로 “Foocon” 사이트에 음식메뉴 업데이트가 이루어지지 않는 것을 포함하나 이에 한하지 아니함)으로 인해 해당 관련 서비스의 중단이 불가피한 사정이 있는 경우에는 이미 체결된 계약의 해당 주문 건에 대한 서비스를 개별적으로 중단할 수 있습니다. 위 각 경우에는 변경된 음식·용역의 내용 및 제공일자를 명시하여 현재의 음식 ? 용역의 내용을 게시한 곳에 즉시 공지합니다.</li>
						<li class="con">“Foocon”가 이용자와 계약을 체결한 서비스의 내용을 전항의 사유로 변경하거나 중단할 경우에는 그 사유를 이용자에게 통지 가능한 연락처(주소, 전자우편, 전화 등)로 즉시 통지합니다.</li>
						<li class="con">전항의 경우 "Foocon"는 이로 인하여 이용자가 입은 손해를 배상합니다. 단, "Foocon"가 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</li>	
					</ul>
					<p>제5조 (서비스의 중지)</p><br>
					<ul class="clearfix">
						<li class="con">"Foocon"는 다음 각 호 중 어느 하나에 해당하는 사유가 발생하는 경우에는 이용자의 서비스 이용을 제한하거나 중지할 수 있습니다.</li>																								
							<ul class="clearfix">
								<li class="conn">컴퓨터 등 정보통신설비의 보수점검 ? 교체 및 고장</li>
								<li class="conn">전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지하는 등 통신의 두절</li>
								<li class="conn">국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 경우</li>
								<li class="conn">기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우</li>																						
							</ul>
						<li class="con">제1항에 의한 서비스 중지의 경우에는 ""Foocon""는 제9조에 정한 방법으로 이용자에게 통지합니다.</li>
						<li class="con">"Foocon"는 제1항의 사유로 서비스의 제공이 일시적으로 중지됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "Foocon"에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.</li>
					</ul><br>
					<p>제6조 (회원가입)</p><br>
					<ul class="clearfix">
						<li class="con"> 이용자는 "Foocon"가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</li>																								
						<li class="con">"Foocon"는 제1항과 같은 회원가입 신청에 대하여 승낙함으로써 회원가입계약이 성립하며, 다음 각 호 중 어느 하나에 해당하는 이용자의 회원가입 신청에 대해서는 이를 거부할 수 있습니다.</li>
							<ul class="clearfix">
								<li class="conn">가입신청자가 본 약관 제9조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제9조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "Foocon"의 회원 재가입 승낙을 얻은 경우에는 예외로 합니다.</li>
								<li class="conn">등록 내용에 허위, 기재누락, 오기가 있는 경우</li>
								<li class="conn"> 기타 회원으로 등록하는 것이 "Foocon"의 기술상 현저히 지장이 있다고 판단되는 경우</li>																						
							</ul>
					</ul><br>
				</div>
				
			</div>
		</div>
	</section>	
	<!-- 개인정보 -->
	<section class="terms-content">
		<h2 class="hidden">personal-content</h2>
		<div class="container">
			<div class="terms_area">
				<p id="title">개인정보 수집 및 이용동의</p>
				<div class="content">
					<p>제 1 조 (목적)</p><br>
					<p>이 이용약관(이하 '약관'이라 합니다)은 ㈜Foocon(이하 '회사'라 합니다)와 이용 고객(이하 '회원'이라 합니다.)간에 회사가 제공하는 서비스(이하 '서비스'라 합니다)를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.</p><br>
					
					<p>제 2 조 (정의)</p><br>
					<p>1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>																											
					<ul class="clearfix">
						<li class="con">"Foocon"란 회사가 “서비스”를 이용자에게 제공하기 위하여 컴퓨터를 이용하여 배달음식 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 ”Foocon”를 운영하는 사업자의 의미로도 사용합니다.	</li>																								
						<li class="con">“Foocon서비스”란 회사가 운영하는 사이트를 통해 이용자가 원하는 음식을 주문하면, 주문이 완료된 음식을 푸드트럭(이하 “공급자”라 함)이 이용자에게 배달 또는 판매하는 서비스를 기본으로 하되, 맛집배달대행, 테이크아웃 등 “Foocon” 사이트 상의 제공 서비스 전체를 의미합니다.	</li>																									
						<li class="con">"이용자"란 “Foocon”에 접속하여 본 약관에 따라 Foocon가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>														
						<li class="con">"회원”이라 함은 “Foocon”에 개인정보를 제공하여 회원등록을 한 자로서, “Foocon”의 정보를 지속적으로 제공받으며, “Foocon”가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>																										
						<li class="con">"비회원”이라 함은 회원에 가입하지 않고 “Foocon”가 제공하는 서비스를 이용하는 자를 말합니다.</li>																					
						<li class="con">“가맹점”이란 회사와 가맹계약을 맺고 회사가 운영하는 Foocon서비스에서 음식물을 공급하는 사업자를 말하며, 회사의 대리인이나 피용자로 간주되지 아니합니다.</li>																									
						<li class="con">“적립금”이란 서비스의 효율적 이용을 위해 회사가 임의로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 서비스 상의 가상 데이터를 의미합니다.	</li>
						<li class="con"> 본 약관에서 정의되지 않은 용어는 관련법령이 정하는 바에 따릅니다.</li>
					</ul><br>
					<p>제3조 (약관의 명시와 설명 및 개정))</p><br>
					<ul class="clearfix">
						<li class="con">“Foocon”는 본 약관의 내용과 상호, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등), 통신판매업신고번호, 개인정보관리책임자 등을 이용자가 알 수 있도록 "Foocon" 쇼핑몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.</li>																								
						<li class="con">“Foocon”는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회 ? 배송책임 ? 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.	</li>																									
						<li class="con">"Foocon"는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진 및 정보보호 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.</li>														
						<li class="con">"Foocon"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 “Foocon”의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “Foocon”는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.</li>																										
						<li class="con">"Foocon"가 약관을 개정할 경우에는 개정약관의 효력발생일 이후 회원이 서비스를 이용하는 경우, “Foocon”는 회원이 개정약관에 동의한 것으로 봅니다.</li>																					
						<li class="con">개정 약관조항은 개정 약관의 적용일자 이후에 체결된 계약에 한하여 적용되는 것을 원칙으로 합니다. 다만, “Foocon”가 지정하는 방식에 따라 회원이 동의를 한 경우에는 개정약관 조항이 적용됩니다.</li>																									
						<li class="con">변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 “Foocon”에서 책임지지 않습니다. 단, 회원이 개정 약관에 동의하지 아니할 때에는 회원은 “Foocon”에 대하여 회원의 탈퇴 기타 이용계약을 해지할 수 있습니다.</li>
						<li class="con">본 약관에서 정하지 아니한 사항과 본 약관의 해석에 관하여는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</li>
					</ul><br>
					<p>제4조 (서비스의 제공 및 변경, 개별적 중단)</p><br>
					<ul class="clearfix">
						<li class="con">"Foocon"는 다음과 같은 업무를 수행합니다.</li>																								
							<ul class="clearfix">
								<li class="conn">음식과 관련한 전자상거래 중개대행</li>
								<li class="conn">음식 또는 관련 용역에 대한 정보 제공 및 구매계약의 체결</li>
								<li class="conn">기타 "Foocon"가 정하는 업무</li>																						
							</ul>
						<li class="con">"Foocon"는 음식 또는 용역의 품절 또는 기술적 사양의 변경 등의 사유가 발생하는 경우 장차 체결되는 계약에 의해 제공할 Foocon서비스의 내용을 변경할 수 있으며, 오로지 가맹점의 사정(가맹점의 고의나 과실로 “Foocon” 사이트에 음식메뉴 업데이트가 이루어지지 않는 것을 포함하나 이에 한하지 아니함)으로 인해 해당 관련 서비스의 중단이 불가피한 사정이 있는 경우에는 이미 체결된 계약의 해당 주문 건에 대한 서비스를 개별적으로 중단할 수 있습니다. 위 각 경우에는 변경된 음식·용역의 내용 및 제공일자를 명시하여 현재의 음식 ? 용역의 내용을 게시한 곳에 즉시 공지합니다.</li>
						<li class="con">“Foocon”가 이용자와 계약을 체결한 서비스의 내용을 전항의 사유로 변경하거나 중단할 경우에는 그 사유를 이용자에게 통지 가능한 연락처(주소, 전자우편, 전화 등)로 즉시 통지합니다.</li>
						<li class="con">전항의 경우 "Foocon"는 이로 인하여 이용자가 입은 손해를 배상합니다. 단, "Foocon"가 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</li>	
					</ul>
					<p>제5조 (서비스의 중지)</p><br>
					<ul class="clearfix">
						<li class="con">"Foocon"는 다음 각 호 중 어느 하나에 해당하는 사유가 발생하는 경우에는 이용자의 서비스 이용을 제한하거나 중지할 수 있습니다.</li>																								
							<ul class="clearfix">
								<li class="conn">컴퓨터 등 정보통신설비의 보수점검 ? 교체 및 고장</li>
								<li class="conn">전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지하는 등 통신의 두절</li>
								<li class="conn">국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 경우</li>
								<li class="conn">기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우</li>																						
							</ul>
						<li class="con">제1항에 의한 서비스 중지의 경우에는 ""Foocon""는 제9조에 정한 방법으로 이용자에게 통지합니다.</li>
						<li class="con">"Foocon"는 제1항의 사유로 서비스의 제공이 일시적으로 중지됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "Foocon"에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.</li>
					</ul><br>
					<p>제6조 (회원가입)</p><br>
					<ul class="clearfix">
						<li class="con"> 이용자는 "Foocon"가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</li>																								
						<li class="con">"Foocon"는 제1항과 같은 회원가입 신청에 대하여 승낙함으로써 회원가입계약이 성립하며, 다음 각 호 중 어느 하나에 해당하는 이용자의 회원가입 신청에 대해서는 이를 거부할 수 있습니다.</li>
							<ul class="clearfix">
								<li class="conn">가입신청자가 본 약관 제9조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제9조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "Foocon"의 회원 재가입 승낙을 얻은 경우에는 예외로 합니다.</li>
								<li class="conn">등록 내용에 허위, 기재누락, 오기가 있는 경우</li>
								<li class="conn"> 기타 회원으로 등록하는 것이 "Foocon"의 기술상 현저히 지장이 있다고 판단되는 경우</li>																						
							</ul>
					</ul><br>
				</div>
			</div>
		</div>
	</section>	
	<!-- 위치정보  -->
	<section class="terms-content">
		<h2 class="hidden">GPS-content</h2>
		<div class="container">
			<div class="terms_area">
				<p id="title">위치정보 이용약관</p>
				<div class="content">
					<p>제 1 조 (목적)</p><br>
					<p>이 이용약관(이하 '약관'이라 합니다)은 ㈜Foocon(이하 '회사'라 합니다)와 이용 고객(이하 '회원'이라 합니다.)간에 회사가 제공하는 서비스(이하 '서비스'라 합니다)를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.</p><br>
					
					<p>제 2 조 (정의)</p><br>
					<p>1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>																											
					<ul class="clearfix">
						<li class="con">"Foocon"란 회사가 “서비스”를 이용자에게 제공하기 위하여 컴퓨터를 이용하여 배달음식 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 ”Foocon”를 운영하는 사업자의 의미로도 사용합니다.	</li>																								
						<li class="con">“Foocon서비스”란 회사가 운영하는 사이트를 통해 이용자가 원하는 음식을 주문하면, 주문이 완료된 음식을 푸드트럭(이하 “공급자”라 함)이 이용자에게 배달 또는 판매하는 서비스를 기본으로 하되, 맛집배달대행, 테이크아웃 등 “Foocon” 사이트 상의 제공 서비스 전체를 의미합니다.	</li>																									
						<li class="con">"이용자"란 “Foocon”에 접속하여 본 약관에 따라 Foocon가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>														
						<li class="con">"회원”이라 함은 “Foocon”에 개인정보를 제공하여 회원등록을 한 자로서, “Foocon”의 정보를 지속적으로 제공받으며, “Foocon”가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>																										
						<li class="con">"비회원”이라 함은 회원에 가입하지 않고 “Foocon”가 제공하는 서비스를 이용하는 자를 말합니다.</li>																					
						<li class="con">“가맹점”이란 회사와 가맹계약을 맺고 회사가 운영하는 Foocon서비스에서 음식물을 공급하는 사업자를 말하며, 회사의 대리인이나 피용자로 간주되지 아니합니다.</li>																									
						<li class="con">“적립금”이란 서비스의 효율적 이용을 위해 회사가 임의로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 서비스 상의 가상 데이터를 의미합니다.	</li>
						<li class="con"> 본 약관에서 정의되지 않은 용어는 관련법령이 정하는 바에 따릅니다.</li>
					</ul><br>
					<p>제3조 (약관의 명시와 설명 및 개정))</p><br>
					<ul class="clearfix">
						<li class="con">“Foocon”는 본 약관의 내용과 상호, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등), 통신판매업신고번호, 개인정보관리책임자 등을 이용자가 알 수 있도록 "Foocon" 쇼핑몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.</li>																								
						<li class="con">“Foocon”는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회 ? 배송책임 ? 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.	</li>																									
						<li class="con">"Foocon"는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진 및 정보보호 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.</li>														
						<li class="con">"Foocon"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 “Foocon”의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “Foocon”는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.</li>																										
						<li class="con">"Foocon"가 약관을 개정할 경우에는 개정약관의 효력발생일 이후 회원이 서비스를 이용하는 경우, “Foocon”는 회원이 개정약관에 동의한 것으로 봅니다.</li>																					
						<li class="con">개정 약관조항은 개정 약관의 적용일자 이후에 체결된 계약에 한하여 적용되는 것을 원칙으로 합니다. 다만, “Foocon”가 지정하는 방식에 따라 회원이 동의를 한 경우에는 개정약관 조항이 적용됩니다.</li>																									
						<li class="con">변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 “Foocon”에서 책임지지 않습니다. 단, 회원이 개정 약관에 동의하지 아니할 때에는 회원은 “Foocon”에 대하여 회원의 탈퇴 기타 이용계약을 해지할 수 있습니다.</li>
						<li class="con">본 약관에서 정하지 아니한 사항과 본 약관의 해석에 관하여는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</li>
					</ul><br>
					<p>제4조 (서비스의 제공 및 변경, 개별적 중단)</p><br>
					<ul class="clearfix">
						<li class="con">"Foocon"는 다음과 같은 업무를 수행합니다.</li>																								
							<ul class="clearfix">
								<li class="conn">음식과 관련한 전자상거래 중개대행</li>
								<li class="conn">음식 또는 관련 용역에 대한 정보 제공 및 구매계약의 체결</li>
								<li class="conn">기타 "Foocon"가 정하는 업무</li>																						
							</ul>
						<li class="con">"Foocon"는 음식 또는 용역의 품절 또는 기술적 사양의 변경 등의 사유가 발생하는 경우 장차 체결되는 계약에 의해 제공할 Foocon서비스의 내용을 변경할 수 있으며, 오로지 가맹점의 사정(가맹점의 고의나 과실로 “Foocon” 사이트에 음식메뉴 업데이트가 이루어지지 않는 것을 포함하나 이에 한하지 아니함)으로 인해 해당 관련 서비스의 중단이 불가피한 사정이 있는 경우에는 이미 체결된 계약의 해당 주문 건에 대한 서비스를 개별적으로 중단할 수 있습니다. 위 각 경우에는 변경된 음식·용역의 내용 및 제공일자를 명시하여 현재의 음식 ? 용역의 내용을 게시한 곳에 즉시 공지합니다.</li>
						<li class="con">“Foocon”가 이용자와 계약을 체결한 서비스의 내용을 전항의 사유로 변경하거나 중단할 경우에는 그 사유를 이용자에게 통지 가능한 연락처(주소, 전자우편, 전화 등)로 즉시 통지합니다.</li>
						<li class="con">전항의 경우 "Foocon"는 이로 인하여 이용자가 입은 손해를 배상합니다. 단, "Foocon"가 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</li>	
					</ul>
					<p>제5조 (서비스의 중지)</p><br>
					<ul class="clearfix">
						<li class="con">"Foocon"는 다음 각 호 중 어느 하나에 해당하는 사유가 발생하는 경우에는 이용자의 서비스 이용을 제한하거나 중지할 수 있습니다.</li>																								
							<ul class="clearfix">
								<li class="conn">컴퓨터 등 정보통신설비의 보수점검 ? 교체 및 고장</li>
								<li class="conn">전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지하는 등 통신의 두절</li>
								<li class="conn">국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 경우</li>
								<li class="conn">기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우</li>																						
							</ul>
						<li class="con">제1항에 의한 서비스 중지의 경우에는 ""Foocon""는 제9조에 정한 방법으로 이용자에게 통지합니다.</li>
						<li class="con">"Foocon"는 제1항의 사유로 서비스의 제공이 일시적으로 중지됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "Foocon"에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.</li>
					</ul><br>
					<p>제6조 (회원가입)</p><br>
					<ul class="clearfix">
						<li class="con"> 이용자는 "Foocon"가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</li>																								
						<li class="con">"Foocon"는 제1항과 같은 회원가입 신청에 대하여 승낙함으로써 회원가입계약이 성립하며, 다음 각 호 중 어느 하나에 해당하는 이용자의 회원가입 신청에 대해서는 이를 거부할 수 있습니다.</li>
							<ul class="clearfix">
								<li class="conn">가입신청자가 본 약관 제9조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제9조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "Foocon"의 회원 재가입 승낙을 얻은 경우에는 예외로 합니다.</li>
								<li class="conn">등록 내용에 허위, 기재누락, 오기가 있는 경우</li>
								<li class="conn"> 기타 회원으로 등록하는 것이 "Foocon"의 기술상 현저히 지장이 있다고 판단되는 경우</li>																						
							</ul>
					</ul><br>
				</div>
			</div>
		</div>
	</section>	

	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>