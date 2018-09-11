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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/terms.css">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>

<script type="text/javascript"  src="<%=path%>/js/terms.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배달부터 예약까지 - 푸콘</title>
</head>
<body>
<!-- HEADER -->
	<jsp:include page="header.jsp"/>
	<!-- 로그인 입력 -->
	<section class="login-area">
		<div class="container">
			<div class="login_header">
				<p><span>이용 약관 동의</span></p>
			</div>
				<label for="allAgree" style="cursor:pointer"><input type="checkbox" id="allAgree" name="allAgree">
				전체동의</label>
			<div class="terms">
				<form>
				<br>
					<div class="check">
						<label for="oneAgree" style="cursor:pointer"><input type="checkbox" id="oneAgree" name="oneAgree" style="width:13px; height:13px;">
						서비스 이용 약관 동의[필수]</label>
					</div>
					<br>
					<textarea rows="10" cols="100">
Foocon 이용약관

제1조 (목적)

이 이용약관(이하 '약관'이라 합니다)은 ㈜Foocon(이하 '회사'라 합니다)와 이용 고객(이하 '회원'이라 합니다.)간에 회사가 제공하는 서비스(이하 '서비스'라 합니다)를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.

제2조 (정의)

1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
① "Foocon"란 회사가 “서비스”를 이용자에게 제공하기 위하여 컴퓨터를 이용하여 배달음식 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 ”Foocon”를 운영하는 사업자의 의미로도 사용합니다.
② “Foocon서비스”란 회사가 운영하는 사이트를 통해 이용자가 원하는 음식을 주문하면, 주문이 완료된 음식을 푸드트럭(이하 “공급자”라 함)이 이용자에게 배달 또는 판매하는 서비스를 기본으로 하되, 맛집배달대행, 테이크아웃 등 “Foocon” 사이트 상의 제공 서비스 전체를 의미합니다.
③ "이용자"란 “Foocon”에 접속하여 본 약관에 따라 Foocon가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
④ ”회원”이라 함은 “Foocon”에 개인정보를 제공하여 회원등록을 한 자로서, “Foocon”의 정보를 지속적으로 제공받으며, “Foocon”가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
⑤ ”비회원”이라 함은 회원에 가입하지 않고 “Foocon”가 제공하는 서비스를 이용하는 자를 말합니다.
⑥ “가맹점”이란 회사와 가맹계약을 맺고 회사가 운영하는 Foocon서비스에서 음식물을 공급하는 사업자를 말하며, 회사의 대리인이나 피용자로 간주되지 아니합니다.
⑦ “적립금”이란 서비스의 효율적 이용을 위해 회사가 임의로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 서비스 상의 가상 데이터를 의미합니다.
⑧ 본 약관에서 정의되지 않은 용어는 관련법령이 정하는 바에 따릅니다.

제3조 (약관의 명시와 설명 및 개정)

① “Foocon”는 본 약관의 내용과 상호, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등), 통신판매업신고번호, 개인정보관리책임자 등을 이용자가 알 수 있도록 "Foocon" 쇼핑몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
② “Foocon”는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회 ∙ 배송책임 ∙ 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
③ "Foocon"는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진 및 정보보호 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
④ "Foocon"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 “Foocon”의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “Foocon”는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.
⑤ "Foocon"가 약관을 개정할 경우에는 개정약관의 효력발생일 이후 회원이 서비스를 이용하는 경우, “Foocon”는 회원이 개정약관에 동의한 것으로 봅니다.
⑥ 개정 약관조항은 개정 약관의 적용일자 이후에 체결된 계약에 한하여 적용되는 것을 원칙으로 합니다. 다만, “Foocon”가 지정하는 방식에 따라 회원이 동의를 한 경우에는 개정약관 조항이 적용됩니다.
⑦ 변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 “Foocon”에서 책임지지 않습니다. 단, 회원이 개정 약관에 동의하지 아니할 때에는 회원은 “Foocon”에 대하여 회원의 탈퇴 기타 이용계약을 해지할 수 있습니다.
⑧ 본 약관에서 정하지 아니한 사항과 본 약관의 해석에 관하여는 전자상거래 등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.

제4조 (서비스의 제공 및 변경, 개별적 중단)

① "Foocon"는 다음과 같은 업무를 수행합니다.
1. 음식과 관련한 전자상거래 중개대행
2. 음식 또는 관련 용역에 대한 정보 제공 및 구매계약의 체결
3. 기타 "Foocon"가 정하는 업무
② "Foocon"는 음식 또는 용역의 품절 또는 기술적 사양의 변경 등의 사유가 발생하는 경우 장차 체결되는 계약에 의해 제공할 Foocon서비스의 내용을 변경할 수 있으며, 오로지 가맹점의 사정(가맹점의 고의나 과실로 “Foocon” 사이트에 음식메뉴 업데이트가 이루어지지 않는 것을 포함하나 이에 한하지 아니함)으로 인해 해당 관련 서비스의 중단이 불가피한 사정이 있는 경우에는 이미 체결된 계약의 해당 주문 건에 대한 서비스를 개별적으로 중단할 수 있습니다. 위 각 경우에는 변경된 음식·용역의 내용 및 제공일자를 명시하여 현재의 음식 ∙ 용역의 내용을 게시한 곳에 즉시 공지합니다.
③ “Foocon”가 이용자와 계약을 체결한 서비스의 내용을 전항의 사유로 변경하거나 중단할 경우에는 그 사유를 이용자에게 통지 가능한 연락처(주소, 전자우편, 전화 등)로 즉시 통지합니다.
④ 전항의 경우 "Foocon"는 이로 인하여 이용자가 입은 손해를 배상합니다. 단, "Foocon"가 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.

제5조 (서비스의 중지)

① "Foocon"는 다음 각 호 중 어느 하나에 해당하는 사유가 발생하는 경우에는 이용자의 서비스 이용을 제한하거나 중지할 수 있습니다.
1. 컴퓨터 등 정보통신설비의 보수점검 ∙ 교체 및 고장
2. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지하는 등 통신의 두절
3. 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 경우
4. 기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우
② 제1항에 의한 서비스 중지의 경우에는 "Foocon"는 제9조에 정한 방법으로 이용자에게 통지합니다.
③ "Foocon"는 제1항의 사유로 서비스의 제공이 일시적으로 중지됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "Foocon"에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.

제6조 (회원가입)

① 이용자는 "Foocon"가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
② "Foocon"는 제1항과 같은 회원가입 신청에 대하여 승낙함으로써 회원가입계약이 성립하며, 다음 각 호 중 어느 하나에 해당하는 이용자의 회원가입 신청에 대해서는 이를 거부할 수 있습니다.
1. 가입신청자가 본 약관 제9조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제9조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "Foocon"의 회원 재가입 승낙을 얻은 경우에는 예외로 합니다.
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
3. 기타 회원으로 등록하는 것이 "Foocon"의 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립시기는 "Foocon"의 승낙이 회원에게 도달한 시점으로 합니다.
④ 회원은 제18조 제1항에 의한 등록사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 "Foocon"에 대하여 그 변경사항을 알려야 합니다.
⑤ 개인정보 보호를 위하여 만 14세 미만 아동의 회원 가입은 제한됩니다.
⑥ 외국인 또는 해외교민은 "회사"가 제공하는 가입조건을 만족할 경우, 가입이 가능합니다.

제7조 (회원의 권리)

① 회원으로 등록하시면 Foocon서비스의 모든 메뉴를 제약 없이 사용하실 수 있습니다.
② "Foocon"가 제공하는 다양한 생활정보 서비스와 각종 이벤트에 참가할 자격이 주어집니다.
③ Foocon 서비스의 치신정보와 혜택 수신을 원하는 경우에는 전자우편/ 서신우편/ 문자메시지/ 앱푸쉬 등의 매체로 받아보실 수 있습니다.

제8조 (서비스 이용요금)

① 회사가 제공하는 서비스는 기본적으로 무료입니다.
② 회사는 유료 서비스 이용요금을 회사와 계약한 전자지불업체에서 정한 방법에 의하거나 회사가 정한 청구서에 합산하여 청구할 수 있습니다.
③ 유료서비스 이용을 통하여 결제된 대금에 대한 취소 및 환불은 회사의 결제 이용약관 등 관계법에 따릅니다.
④ 이용자의 정보도용 및 결제사기로 인한 환불요청 또는 결제자의 개인정보 요구는 법률이 정한 경우 외에는 거절될 수 있습니다.
⑤ 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며 가입한 각 이동통신사의 정책에 따릅니다. MMS 등으로 게시물을 등록할 경우 발생하는 요금은 이동통신사의 정책에 따릅니다.

제9조 (휴면계정 전환, 회원 탈퇴 및 자격 상실 등)

① “Foocon”는 회원이 자신 계정의 마지막 로그인 일시로부터 1년이 초과되는 시점까지 다시 로그인을 하지 않은 경우, 해당 회원의 계정을 휴면계정으로 전환합니다. 또한 전환과 동시에 “Foocon” 개인정보처리방침에 따라 해당 회원의 개인정보는 3년 간 보관되며, 해당 기간에 한하여 계정 복구도 가능합니다.
② 회원은 "Foocon"에 언제든지 탈퇴를 요청할 수 있으며 "Foocon"는 해당 요청을 받는 즉시 회원탈퇴를 처리합니다. 단, 회원 재가입, 임의해지 등을 반복적으로 행함으로써 “Foocon”가 제공하는 각종 할인쿠폰, 이벤트 혜택 등의 경제상의 이익을 편법적으로 수취하는 것을 방지하기 위하여 “Foocon”는 개인정보처리방침에 따라 해당 회원의 개인정보를 90일 간 보관합니다.
③ "Foocon"는 회원이 다음 각 호에 해당되는 경우 별도의 통보절차 없이 회원의 자격을 정지할 수 있습니다.
1. 회원가입 신청이나, 회원정보의 변경 시 허위내용을 작성한 경우
2. 타인의 명의를 임의로 사용하는 경우
3. 타인에게 피해를 주거나 기타 미풍양속을 현저히 저해하는 행위를 한 경우
4. Foocon서비스에 제공되는 정보를 변경 및 수정하는 등 Foocon서비스의 정상적인 운영을 고의 또는 중과실로 방해하는 행위를 한 경우
5. Foocon서비스를 이용하여 구입한 상품 등의 대금, 기타 메뉴 몰의 이용에 관련하여 회원이 부담하는 채무를 기일 내에 지급하지 않는 경우
6. "Foocon"에 귀속하는 저작권 등 지적재산권을 침해한 경우
7. "Foocon"의 명예를 대외적으로 훼손시켰다고 인정되는 경우
8. 기타 "Foocon"가 정한 회원가입요건이 미비 되었거나 회원으로서의 자격을 지속시키는 것이 부적절하다고 판단되는 경우
9. 기타 본 약관에 위반한 행위를 한 경우
④ "Foocon"가 회원자격을 상실 시키는 경우에는 회원등록을 말소합니다. 본 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.

제10조 (회원에 대한 통지)

① "Foocon"가 회원에 대한 통지를 하는 경우, 회원이 "Foocon"와 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.
② "Foocon"는 불특정다수 회원에 대한 통지의 경우 1주일 이상 "Foocon" 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.

제11조 ("Foocon"와 "Foocon" 연결 사이트 간의 관계)

① "Foocon"는 "Foocon" 연결 사이트가 취급하는 상품 또는 용역에 대하여 보증책임을 지지 않습니다.
② "Foocon"와 "Foocon" 연결 사이트는 독자적으로 가맹점을 운영하는 것으로 "Foocon"는 "Foocon" 연결 사이트와 이용자 간에 행해진 거래에 대하여 어떠한 책임도 지지 않습니다.

제12조 (구매신청)

Foocon 이용자는 "Foocon" 상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “Foocon”는 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. 단, 회원인 경우 제2호 내지 제4호의 적용을 제외할 수 있습니다.
1. 음식 등의 검색 및 선택
2. 성명, 주소, 전자우편주소, 전화번호(또는 이동전화번호) 등의 입력
3. 약관내용, 청약철회권이 제한되는 서비스, 배달료 등의 비용부담과 관련한 내용에 대한 확인
4. 본 약관에 동의하고 위 3호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)
5. 음식의 구매신청 및 이에 관한 확인 또는 “Foocon”의 확인에 대한 동의
6. "결제방법의 선택

제13조 (계약의 성립)

① "Foocon"는 다음 각호에 해당하는 경우 제12조의 구매신청을 승낙하지 않을 수 있습니다.
1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 음식 및 용역을 구매하는 경우
3. 기타 구매신청에 승낙하는 것이 "Foocon" 기술상 현저히 지장이 있다고 판단하는 경우
② "Foocon"의 승낙이 제15조 제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.
③ “Foocon”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.
④ 미성년자가 제12조의 구매신청을 하는 경우, 법정대리인이 구매 금액에 대한 처분을 사전에 동의한 것으로 간주하여 유효한 구매신청으로 판단합니다. 다만, 이미 음식이 조리 또는 배달된 경우를 제외하고, 해당 구매신청에 대하여 법정대리인의 동의가 없는 경우, 미성년자 본인 또는 법정대리인은 해당 구매신청을 취소할 수 있습니다.

제14조 (이용자의 대금지급방법)

“Foocon”에서 구매한 음식 또는 용역에 대한 대금지급방법은 다음 각호의 방법 중 가용한 방법으로 할 수 있습니다. 단, “Foocon”는 이용자의 지급방법에 대하여 음식 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
3. 온라인무통장입금
4. 전자화폐에 의한 결제
5. 수령 시 대금지급
6. 마일리지 등 “Foocon”가 지급한 포인트에 의한 결제
7. “Foocon”와 계약을 맺었거나 “Foocon”가 인정한 상품권에 의한 결제
8. 기타 전자적 지급 방법에 의한 대금 지급 등

제15조 (주문성공의 통지 및 구매신청 변경 및 취소)

① 이 "Foocon" 기술상 현저히 지장이 있다고 판단하는 경우"Foocon"는 이용자의 구매신청이 있는 경우, 구매정보가 가맹점에 정확히 전달되면 이용자(또는 회원)와 가맹점에 주문 성공 메시지를 전송하여 통지를 합니다.
② 확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 확인통지를 받은 후 즉시, 직접 “Foocon” 연락처로 구매신청 변경 및 취소를 요청할 수 있습니다. 단, 이용자의 귀책사유로 인한 구매신청의 변경 또는 취소는 가맹점의 사정에 따라 받아들여지지 아니할 수 있으며, 이로 인하여 이용자에게 발생하는 손해에 대하여 ”Foocon”는 고의 또는 과실이 없는 한 책임을 부담하지 않습니다.
③ 신용카드에 의한 결제에 따른 지급의 경우에 신용카드회사가 "Foocon"에 대하여 신용카드의 연체, 무효 또는 기타 사유로 인한 지급 불능 등을 통지한 경우, "Foocon"는 회원 등 이용자에게 지급방법의 변경 여부 등에 관한 확인을 할 수 있습니다. 회원 등 이용자가 제공한 주소, 전화번호 또는 전자우편 주소를 통하여 이러한 확인에 이르지 못하는 경우, "Foocon"는 당해 회원 등 이용자와의 카드결제를 통한 매매계약을 취소할 수 있습니다.

제16조 (배달)

① "Foocon"는 이용자의 주문내용 정보와 고객의 결제내역에 대한 정보를 가맹점에 정확히 전달함으로 책임을 다하며, 가맹점이 배달을 완료합니다.
② 가맹점의 배달은 예약주문의 경우는 예약 시간 내에 배달을 완료하고, 실시간 주문의 경우는 상품의 주문정보가 전달된 때로부터 1시간 내로 배달을 완료함을 원칙으로 하되, 각 가맹점의 사정에 따라 차이가 있을 수 있습니다.
③ "Foocon"는 이용자가 구매한 상품이 시간을 초과하여 배달되거나 약속한 시간 내에 배달되지 않음으로 인한 이용자의 손해를 배상할 의무가 없으며 배달지연에 대한 책임은 가맹점에서 집니다.
④ 해당 가맹점의 고의 또는 과실로 약정 배달시간을 초과한 경우에는 그로 인한 이용자의 손해를 해당 가맹점에서 배상합니다.

제17조 (환불, 반품 및 교환)

① "Foocon"는 이용자가 구매 신청한 상품을 부득이 한 사정으로 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고, 이미 상품대금을 받은 경우에는 대금을 받은 후 3일 이내에 환급절차를 취합니다.
② 다음 각 호의 경우에는 가맹점은 배달된 또는 수령한 상품일지라도 상품을 반품 받은 날의 다음 영업일 이내에 이용자의 요구에 따라 즉시 환급, 반품 및 교환 조치를 합니다. 다만, 이용자의 환급, 반품 및 교환 요구기한은 상품이 배달된 또는 수령한 당일로 한정됩니다.
1. 배달된 또는 수령한 상품이 주문내용과 현저히 상이할 경우
2. 배달된 또는 수령한 상품이 변질, 손상되었거나 오염되었을 경우
③ 전항에 따라 상품 또는 용역의 구매가 취소된 경우 상품의 반환에 필요한 일체의 비용은 가맹점이 부담합니다.
④ 이용자가 주문이 최종적으로 완료되기 전에 인터넷 창을 닫는 등의 사용방법을 충분히 숙지하지 못하여 발생하는 주문의 실패에 대해서 "Foocon"는 책임지지 않습니다.

제18조 (개인정보보호)

Foocon”는 이용자의 개인정보 보호를 위하여 별도의 개인정보처리방침을 마련하였으므로, 구체적인 내용은 해당 개인정보처리방침을 확인하여 주시기 바랍니다.

제19조 ("Foocon"의 의무)

① "Foocon"는 법령과 본 약관이 금지하거나 공서양속(사회의 일반적 도덕 및 기타 사회의 공공적 질서)에 반하는 행위를 하지 않으며 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 음식·용역을 제공하는 데 최선을 다하여야 합니다.
② "Foocon"는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.
③ "Foocon"의 상품이나 용역에 대해 “Foocon”의 고의 또는 과실로 인하여 「표시·광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시·광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다. 단, 가맹점의 부당한 표시 ∙ 광고행위로 인한 이용자의 손해에 대해서는 “Foocon”가 책임을 부담하지 아니합니다.

제20조 (회원의 ID 및 비밀번호에 대한 의무)

① 제18조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 아니 되며, 회원이 이를 위반하여 발생하는 손해에 대해서는 “Foocon”가 책임을 부담하지 아니합니다.
③ 회원이 자신의 ID 및 비밀번호를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "Foocon"에 통보하고 "Foocon"의 안내가 있는 경우에는 그에 따라야 합니다.

제21조 (이용자의 의무)

이용자는 다음 행위를 하여서는 안됩니다.
1. 신청 또는 변경 시 허위내용의 등록
2. 타인의 정보 도용
3. "Foocon"에 게시된 정보의 변경
4. "Foocon"가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시
5. "Foocon" 및 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. "Foocon" 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지·화상·음성 기타 공서양속(사회의 일반적 도덕 및 기타 사회의 공공적 질서)에 반하는 정보를 "Foocon"에 공개 또는 게시하는 행위
8. 배달된 또는 수령한 음식에 대한 맛의 평가와 관련하여 의도적으로 악의적인 게시글을 올리는 행위

제22조 ("Foocon"와 “Foocon” 연결 사이트 간의 관계)

Foocon는 “Foocon” 연결 사이트가 독자적으로 제공하는 음식·용역에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않는다는 뜻을 "Foocon"의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증책임을 지지 않습니다.

제23조 (저작권의 귀속 및 이용제한)

① "Foocon"가 작성한 저작물에 대한 저작권 기타 지적재산권은 "Foocon"에 귀속합니다.
② 게시물에 대한 권리와 책임은 게시자에게 있으며, “Foocon”는 게시물에 대한 사용권한을 갖습니다. 이 경우 회사는 저작권법의 내용을 준수하며, 게시자는 언제든지 고객센터 또는 서비스 내 관리기능을 통해 해당 게시물에 대해 삭제, 검색 결과 제외, 비공개 등의 조치를 취할 수 있습니다.
③ "Foocon"는 Foocon서비스 내 게재 이외의 다른 목적으로 사용할 경우에는 저작권법에 따라 저작물의 이용허락을 받아야 하며, 게시물에 대한 게시자를 반드시 명시해야 됩니다.
④ 이용자는 "Foocon"을 이용함으로써 얻은 정보 중 “Foocon”에게 지적재산권이 귀속된 정보를 "Foocon"의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
⑤ “Foocon”는 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.
⑥ "Foocon"는 이용자의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다. 단, 회사의 귀책사유로 인한 것일 때에는 회사가 정한 바에 따라 이용자가 입은 손해에 대해 조치를 합니다.
⑦ “Foocon”는 이용자가 주민등록법을 위반한 명의 도용 및 결제 도용, 저작권법 및 정보통신망 이용촉진 및 정보보호 등에 관한 법률을 위반한 불법통신 및 해킹, 악성프로그램의 배포 등과 같이 관련 법령을 위반한 경우에는 해당 이용자에 대해 즉시 영구이용정지를 할 수 있습니다. 본 항에 따른 영구 이용정지 시 해당 이용자가 보유 중인 이용할인쿠폰 및 기타 혜택 등도 모두 소멸되며, 회사는 이에 대해 별도로 보상하지 않습니다.

제24조 (게시물)

① 회사는 귀하가 작성하는 리뷰 등 게시물(이하 “게시물”이라 함)을 소중하게 생각하며 변조, 훼손, 삭제되지 않도록 최선을 다하여 보호합니다. 다만, 다음 각 호의 어느 하나에 해당하는 게시물에 대해서는 이용자에게 공개적 또는 개별적으로 경고한 후 삭제할 수 있습니다. 단, 상기 경고는 회사의 판단에 따라 생략할 수 있습니다.
1. 스팸(spam)성 게시물(예: 행운의 편지, 특정사이트 또는 음식점의 광고 등)의 경우
2. 게시물의 내용에 욕설 및 타인 또는 타 음식점에 대한 비방이 과도하게 포함된 경우
3. 게시물의 내용에 명백한 거짓 사실을 포함하고 있는 경우
4. 타인을 비방할 목적으로 허위 사실을 유포하여 타인의 명예를 훼손하는 글 또는 타 음식점을 비방하는 게시물의 경우
5. 게시물이 회사 또는 제 3자의 상표권 또는 저작권 등 지적재산권을 침해하는 경우
6. 게시물에 첨부된 사진이 부적절한 경우(사진과 음식이 일치하지 않거나 게시물의 내용과 상관 없는 사진이 포함된 경우)
7. 기타 게시판 주제와 관련 없는 내용의 게시물 또는 사회통념 상인 경우
② 회사는 바람직한 게시판 문화를 활성화하기 위하여 동의 없이 타인 또는 타 음식점의 정보를 게시물에 노출한 경우 또는 게시물에 욕설이 포함된 경우, 문제가 되는 부분을 삭제하거나 기호 등으로 수정할 수 있습니다.
③ 귀하의 게시물은 회사가 홍보나 마케팅 등의 목적을 위하여 별도의 대가지급 없이 이용할 수 있습니다.
④ 다른 주제의 게시판으로 이동 가능한 내용일 경우 해당 게시물에 이동 경로를 밝혀 오해가 없도록 하고 있습니다.
⑤ 근본적으로 게시물에 관련된 제반 권리와 책임은 작성자 개인에게 있습니다. 특히, 해당 게시물이 제3자의 저작권 등 권리를 침해하는 경우, 침해에 대한 모든 법적 책임은 작성자 개인이 집니다. 또한 게시물을 통해 자발적으로 공개된 정보는 보호받기 어려우므로 정보 공개 전에 심사숙고 하시기 바랍니다.
⑥ 귀하가 Foocon서비스에서 탈퇴하는 경우, 회사는 귀하의 게시물을 귀하의 별도의 동의 없이 삭제할 수 있습니다. 또한 회사는 필요하다고 판단되는 경우, 해당 게시물을 삭제하지 않고 Foocon서비스 내에 그대로 게시하거나 사업적 협력관계에 있는 제3자와 공유할 수 있는 권한을 가집니다.

제25조 (할인쿠폰 서비스)

① 회사는 구매서비스를 이용하는 회원에게 서비스 제공 시 일정 금액 또는 일정 비율을 할인 받을 수 있는 할인 쿠폰을 발급할 수 있습니다. 이 쿠폰은 회사에서 그 사용 대상, 사용 방법, 사용 기간, 할인 금액 등을 정할 수 있습니다. 할인쿠폰의 종류 또는 내용은 회사의 정책에 따라 달라질 수 있습니다.
② 회사는 할인쿠폰의 사용 대상, 사용 방법, 사용 기간, 할인 금액 등을 할인쿠폰 또는 서비스 화면에 별도로 표시하거나 통지합니다.
③ 회원은 할인쿠폰을 회원 본인의 구매에 사용할 수 있는 권한만을 가지며, 어떠한 경우에도 이를 타인에게 실질적으로 매매 또는 양도할 수 없습니다.
④ 할인쿠폰은 현금 및 현금화되는 수단으로 환급될 수 없으며, 할인쿠폰의 사용 기간이 만료되거나 이용계약이 종료되면 소멸합니다.

제26조 (정보의 제공)

① 회사는 서비스 이용에 관한 다양한 정보를 전자우편/ 서신우편/ 문자서비스/ 앱푸쉬 등의 방법으로 회원에게 제공할 수 있으며 회원은 수신을 거부할 수 있습니다.
② 회원이 전항에 의해 수신을 거부하는 경우, 회사는 서비스 이용에 필수적으로 요구되는 정보(예: 관련 규정/정책의 변경 등)를 홈페이지에 공시하는 방법으로 정보의 제공을 갈음할 수 있으며, 회원이 수신을 거부하고 홈페이지에 공시된 정보의 제공을 확인하지 아니함에 따라 발생하는 손해에 대해서 회사는 책임을 부담하지 아니합니다.

제27조 (광고성 정보 전송)

① 회사는 귀하의 명시적인 수신거부의사에 반하여 영리목적의 광고성 정보를 전송하지 않습니다.
② 회사는 귀하가 마케팅 정보 수신동의를 한 경우 마케팅성 매체(전자우편/서신우편/문자서비스/앱푸쉬)의 제목란 및 본문란에 다음 각 호와 같이 귀하가 쉽게 알아 볼 수 있도록 조치합니다.
1. 제목란 : (광고)라는 문구를 제목란에 표시하지 않을 수 있으며, 본문란의 주요 내용을 표시합니다.
2. 본문란 : 제목란에 표시하지 않은 경우 본문란에 (광고)표시를 하며, 귀하가 수신거부의 의사표시를 할 수 있는 전송자의 명칭, 수신거부 또는 수신동의 철회방법, 전화번호 및 주소를 명시합니다.
3. 귀하가 수신 거부의 의사를 쉽게 표시할 수 있는 방법을 명시합니다.
③ 회사는 상품정보 안내 등 온라인 마케팅을 위해 광고성 정보를 전자우편 등으로 전송하는 경우 전자우편의 제목란 및 본문란에 다음 각 호와 같이 귀하가 쉽게 알아 볼 수 있도록 조치합니다.
1. 전자우편의 제목란: (광고) 또는 (성인광고)라는 문구를 제목란의 처음에 빈칸 없이 한글로 표시하고 이어서 전자우편 본문란의 주요 내용을 표시합니다.
2. 전자우편의 본문란: 귀하가 수신거부의 의사표시를 할 수 있는 전송자의 명칭, 전자우편주소, 전화번호 및 주소를 명시합니다.
3. 귀하가 수신 거부의 의사를 쉽게 표시할 수 있는 방법을 한글 및 영문으로 각 각 명시합니다. 귀하가 동의를 한 시기 및 내용을 명시합니다.
④ 청소년에게 유해한 정보를 전송하는 경우에는 다음 각 호와 같이 “(성인광고)” 문구를 표시합니다.
1. 본문란에 다음 각 목의 어느 하나에 해당하는 것이 부호/문자/영상 또는 음향의 형태로 표현된 경우(해당 전자우편의 본문란에는 직접 표현 되어있지 아니하더라도 수신자가 내용을 쉽게 확인할 수 있도록 기술적 조치가 되어 있는 경우를 포함한다)에는 해당 전자우편의 제목란에 "(성인광고)" 문구를 표시합니다.
가. 청소년(19세 미만의 자를 말한다. 이하 같습니다)에게 성적인 욕구를 자극하는 선정적인 것이거나 음란한 것
나. 청소년에게 포악성이나 범죄의 충동을 일으킬 수 있는 것
다. 성폭력을 포함한 각종 형태의 폭력행사와 약물의 남용을 자극하거나 미화하는 것
라. 청소년보호법에 의하여 청소년 유해 매체물로 결정 고시된 것
2. 홈페이지를 알리는 경우에는 해당 전자우편의 제목란에 “(성인광고)” 문구를 표시합니다.

제28조 (위치기반서비스의 내용)

“Foocon”는 이용자의 위치정보 보호 및 위치기반 서비스 이용을 위하여 별도의 위치기반 서비스 이용약관을 마련하였으므로, 구체적인 내용은 해당 위치기반 서비스 이용약관을 확인하여 주시기 바랍니다.

제29조 (서비스의 해제 · 해지 · 청약철회)

① 회원이 이용 계약을 해지하고자 할 때는 언제든지 “Foocon” 홈페이지 상의 회원 탈퇴 신청을 통해 이용계약 해지를 요청할 수 있습니다. 단, 신규가입 후 일정시간 이내에는 서비스 부정이용 방지 등의 사유로 즉시 탈퇴가 제한될 수 있습니다.
② 회사는 회원이 본 약관에서 정한 회원의 의무를 위반한 경우 등 비정상적인 이용 또는 부당한 이용 등을 이유로 회원에게 사전에 고지하고, 계약을 해지할 수 있습니다. 다만, 회원이 현행법 위반 및 고의 또는 중대한 과실로 회사에 손해를 입힌 경우에는 사전 통보 없이 이용계약을 해지할 수 있습니다.
③ 회사는 회원이 원활하게 계약을 해지할 수 있도록 계약 체결 시 사용한 방법에 추가하여 계약 해지의 수단으로서 아래와 같은 방법을 제공합니다.
- 고객센터 전화: [02-3447-3612]
- 고객센터 팩스: [02-501-6098]
④ 유료서비스를 이용하는 이용고객은 관련법령에 따라 청약을 철회할 수 있습니다.

제30조 (손해배상)

① 회사가 법률 및 본 약관을 위반한 행위로 이용자에게 손해가 발생한 경우 이용자는 회사에 대하여 손해배상 청구를 할 수 있습니다. 이 경우 회사는 고의, 과실이 없음을 입증하지 못 하는 경우 책임을 면할 수 없습니다.
② “Foocon”는 이용자와 가맹점 간의 음식 구매계약에 대해 중개대행 서비스를 제공할 뿐이므로, 이용자가 가맹점으로부터 구매하신 음식 또는 용역의 품질이나 가맹점의 신뢰도에 대해서는 보증하지 않습니다.
③ “Foocon”는 이용자가 가맹점으로부터 구매한 음식 또는 용역에 대해 보증하거나 별도의 책임을 지지 않으며, 음식 또는 용역과 관련한 일체의 책임은 가맹점에게 있습니다.
④ 회사에게 손해배상을 청구하는 경우에는 청구사유, 청구금액 및 산출근거를 기재하여 서면으로 제출하여야 합니다.

제31조 (면책조항)

① 회사는 전시, 사변 등 국가 비상사태 및 천재지변 기타 이에 준하는 불가항력인 상황으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제됩니다.
② 회사는 기간통신사업자 등 전기통신사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우에 대해서 회사의 고의 또는 중대한 과실이 없는 한 책임이 면제됩니다.
③ 회사는 사전에 공지된 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 서비스가 중지되거나 장애가 발생한 경우에 대해서 회사의 고의 또는 중대한 과실이 없는 한 책임이 면제됩니다.
④ 회사는 회원의 귀책사유로 인한 서비스 이용의 중지, 장애 또는 손해가 발생한 경우에 대해서 회사의 고의 또는 중대한 과실이 없는 한 책임이 없습니다.
⑤ 회사는 회원이 서비스를 이용하여 기대하는 수익을 얻지 못하거나 상실한 것에 대하여, 회사의 고의 또는 중대한 과실이 없는 한 책임이 없습니다.
⑥ 회사는 회원이 서비스를 이용하면서 얻은 정보나 자료로 인한 손해 및 타 회원으로 인해 손해가 발생한 경우에 대하여 회사의 고의 또는 중대한 과실이 없는 한 책임을 지지 않습니다.
⑦ 회사는 이용고객의 컴퓨터 오류에 의해 손해가 발생한 경우 또는 회원이 회원정보 또는 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우에 대해서는 회사의 고의 또는 중대한 과실이 없는 한 책임을 부담하지 않습니다.
⑧ 회사는 회원이 서비스에 게재한 게시물 등 각종 정보의 신뢰도, 정확성 등 내용에 대하여 회사의 고의 또는 중대한 과실이 없는 한 책임을 부담하지 않습니다.
⑨ 회사는 사용 사용 기간이 경과한 할인쿠폰, 포인트 등에 대하여 사용권을 보장하지 않습니다.

제32조 (분쟁해결)

① "Foocon"는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치 ∙ 운영합니다.
② "Foocon"는 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 줍니다.
③ “Foocon”와 이용자간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시 ∙ 도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.
④ “Foocon”는 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 개인정보분쟁조정위원회에 조정을 신청하거나 방송통신위원회에 재정을 신청할 수 있습니다.

제33조 (재판권 및 준거법)

① “Foocon”와 이용자간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 따릅니다.
② "Foocon"과 이용자간의 분쟁은 본 약관 및 한국법을 적용합니다.

제34조 (별정통신 서비스에 관한 공지 사항)

① Foocon서비스 중 전화주문 방식에 사용되는 050 개인번호 서비스는 델피콤㈜가 회사와의 제휴를 통하여 제공합니다.
② 050 개인번호 서비스 이용 시, 해당 번호는 이용자의 핸드폰에 해당 공급자의 상호명으로 자동 저장됩니다.

부칙

[제1조] 본 약관은 2018년 1월 8일에 개정되었으며, 2018년 2월 7일부터 시행됩니다.

					</textarea><br>
					
					<br>
					<div class="check">
						<label for="twoAgree" style="cursor:pointer"><input type="checkbox" id="twoAgree" name="oneAgree" style="width:13px; height:13px;">
						개인정보 수집 및 이용 동의[필수]</label>
					</div>
					<br>
					<textarea rows="10" cols="100">
1. 수집하는 개인정보의 항목

①회원 가입 시 수집하는 개인정보의 범위
가. 필수항목 : 이메일주소, 비밀번호, 휴대전화번호
나. 선택항목 : 닉네임
②서비스 이용과정이나 사업처리과정에서의 자동생성 정보
가.서비스 이용기록, 접속로그, 쿠키, 접속 IP정보, 결제기록, 이용정지기록, 기기고유번호(디바이스 아이디 또는 IMEI)

2. 이용목적

①회사는 다음과 같은 목적을 위하여 개인정보를 수집하고 있으며 목적이 변경될 경우에는 사전에 이용자의 동의를 구하도록 하겠습니다.
가. 이메일주소, 비밀번호 : 회원제 서비스 이용에 따른 본인 식별 절차에 이용
나. 이메일주소, 휴대전화번호 : 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보, 새로운 서비스/신상품이나 이벤트 정보 안내, 서비스 이용에 대한 리뷰 작성 권유, 고객문의 및 답변을 위한 본인 식별, 그 밖에 회사가 제공하는 서비스 안내 및 광고성 정보 전송
다. 닉네임 : 고객문의 및 답변을 위한 본인 식별
라. 그 외 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료
②이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 의료정보 등)는 수집하지 않습니다.

3. 수집하는 개인정보의 보유 및 이용기간

①회사는 회원의 개인정보를 서비스 이용 시점부터 서비스를 제공하는 기간 동안에만 제한적으로 이용하고 있습니다.
②1년 간 회원의 서비스 이용기록이 없는 경우, 『정보통신망 이용촉진 및 정보보호등에 관한 법률』 제29조에 근거하여 회원에게 사전 통지하고 개인정보를 별도로 분리하여 휴면계정 전환일로부터 3년 간 저장합니다.
③회원 탈퇴 또는 회원 자격 정지 후 회원 재가입, 임의해지 등을 반복적으로 행하여 회사가 제공하는 할인쿠폰, 이벤트 혜택 등으로 경제상의 이익을 취하거나 이 과정에서 명의를 무단으로 사용하는 등 편법행위 또는 불법행위를 하는 회원을 차단하고자 회사는 회원 탈퇴 후 90일 간 회원의 정보를 보관합니다.
					
					</textarea><br>
					
					<br>
					<div class="check">
						<label for="threeAgree" style="cursor:pointer"><input type="checkbox" id="threeAgree" name="oneAgree" style="width:13px; height:13px;">
						위치정보 이용 약관</label>
					</div>
					<br>
					<textarea rows="10" cols="100">
제 1 조 (목적) 
본 약관은 ㈜Foocon(이하 "회사"라 합니다)가 운영, 제공하는 위치기반서비스(이하 “서비스”)를 이용함에 있어 회사와 고객 및 개인위치정보주체의 권리, 의무 및 책임사항에 따른 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다. 

제 2 조 (이용약관의 효력 및 변경) 
1. 본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다. 
2. 신청자가 모바일 단말기, PC 등에서 약관의 "동의하기" 버튼을 선택하였을 경우 본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다. 
3. 회사는 위치정보의 보호 및 이용 등에 관한 법률, 콘텐츠산업 진흥법, 전자상거래 등에서의 소비자보호에 관한 법률, 소비자 기본법 약관의 규제에 관한 법률 등 관련 법령을 위배하지 않는 범위에서 본 약관을 변경할 수 있습니다. 
4. 회사가 약관을 변경할 경우에는 변경된 약관과 사유, 적용일자를 명시하여 그 적용일자 10일 전부터 적용일 이후 상당한 기간 동안 공지만을 하고, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스내 게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다. 
5. 회사가 전항에 따라 회원에게 통지하면서 공지일로부터 적용일 7일 후까지 거부의사를 표시하지 아니하면 개정 약관에 승인한 것으로 간주합니다. 회원이 개정 약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.

제 3 조 (관계법령의 적용) 
본 약관은 신의성실의 원칙에 따라 공정하게 적용하며, 본 약관에 명시되지 아니한 사항에 대하여는 관계법령 또는 상관례에 따릅니다. 

제 4 조 (서비스의 내용) 
회사는 위치정보사업자로부터 제공받은 위치정보수집대상의 위치정보 및 상태 정보를 이용하여 다음과 같은 내용으로 서비스한다. 
1. 위치정보수집대상의 실시간 위치확인
2. 이용자의 위치에서 근접한 상가, 근린시설, 업소정보 제공
3. QR 코드를 통한 현장 포인트 적립

 제 5 조 (서비스내용변경 통지) 
1. 회사가 서비스 내용을 변경하거나 종료하는 경우 회사는 등록된 전자우편 주소로 이메일을 통하여 서비스 내용의 변경 사항 또는 종료를 통지할 수 있습니다.
2. 1항의 경우 불특정 다수인을 상대로 통지를 함에 있어서는 웹사이트 등 기타 회사의 공지사항을 통하여 회원에게 통지할 수 있습니다. 

제 6 조 (서비스이용의 제한 및 중지) 
1. 회사는 이용자가 다음 각호에 해당하는 경우에는 회원의 서비스 이용을 제한하거나 중지시킬 수 있습니다.
1) 회원이 회사 서비스의 운영을 고의 또는 중과실로 방해하는 경우
2) 서비스용 설비 점검, 보수 또는 공사로 인하여 부득이한 경우
3) 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우
4) 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때
5) 기타 중대하 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우
2. 회사는 전항의 규정에 의하여 서비스의 이용을 제한하거나 중지한 때에는 그 사유 및 제한기간 등을 회원에게 알려야 합니다.

제 7 조 (서비스 이용요금) 
고객은 본 서비스를 무료로 이용할 수 있습니다. 다만 위치정보를 확인하기 위하여 이동통신망에 접속할 때 발생하는 비용인 통신요금이 발생할 수 있습니다. 통신 요금은 고객의 데이터 사용량, 이동통신사 등에 따라 변동될 수 있습니다. 

제 8 조 (개인위치정보의 이용 또는 제공) 
1. 회사는 개인위치정보를 이용하여 서비스를 제공하고자 하는 경우에는 미리 이용약관에 명시한 후 개인위치정보주체의 동의를 얻어야 합니다.
2. 회원 및 법정대리인의 권리와 그 행사방법은 제소 당시의 이용자의 주소에 의하며, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
3. 회사는 타사업자 또는 이용 고객과의 요금정산 및 민원처리를 위해 위치정보 이용, 제공, 사실 확인자료를 자동 기록 및 보존하며, 해당 자료는 1년간 보관합니다.
4. 회사는 개인위치정보를 회원이 지정하는 제 3자에게 제공하는 경우에는 개인위치정보를 수집한 당해 통신 단말장치로 매 회 회원에게 제공받는 자, 제공 일시 및 제공목적을 즉시 통보합니다. 단, 아래 각호의 1에 해당하는 경우에는 회원이 미리 특정하여 지정한 통신 단말장치 또는 전자우편주소로 통보합니다.
1) 개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우
2) 개인위치정보주체가 온라인 게시 등의 방법으로 통보할 것을 미리 요청한 경우

 제 9 조 (개인위치정보주체의 권리) 
1.회원은 회사에 대하여 언제든지 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제 3자 제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다. 이 경우 회사는 수집한 개인위치정보 및 위치정보 이용, 제공사실 확인자료를 파기합니다.
2. 회원은 회사에 대하여 언제든지 개인위치정보의 이용 또는 제공의 일시적인 중지를 요구할 수 있습니다. 이 경우 회사는 요구를 거절하지 아니하며, 이를 위한 기술적 조치를 취합니다. 
3. 회사에 대해 아래 각 호의 자료에 대한 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다. 이 경우 회사는 정당한 이유 없이 요구를 거절하지 아니합니다. 
1) 개인위치정보주체에 대한 위치정보 이용•제공사실 확인자료 
2) 개인위치정보주체의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법률의 규정에 의해 제3자에게 제공된 이유 및 내용
4. 회원은 제1항 내지 제3항의 권리행사를 위해 회사 소정의 절차를 통해 회사에 요구할 수 있습니다. 

제 10 조 (법정대리인의 권리) 
1. 회사는 14세 미만 아동의 개인위치정보를 이용. 제공하고자 하는 경우(개인위치정보주체가 지정하는 제3자에게 제공하는 서비스를 하고자 하는 경우 포함)에는 14세 미만의 아동과 그 법정대리인의 동의를 받아야 합니다. 이 경우 법정대리인은 제9조에 의한 회원의 권리를 모두 가집니다.
2. 회사는 14세 미만의 아동의 개인위치정보 또는 위치정보 이용, 제공사실 확인자료를 이용약관에 명시 또는 고지한 범위를 넘어 이용하거나 제3자에게 제공하고자 하는 경우에는 14세미만의 아동과 그 법정대리인의 동의를 받아야 합니다. 단, 아래의 경우는 제외합니다.
1) 위치정보 및 위치기반서비스 제공에 따른 요금정산을 위하여 위치정보 이용, 제공사실 확인자료가 필요한 경우
2) 통계작성, 학술연구 또는 시장조사를 위하여 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우 

제 11 조 (8세 이하의 아동 등의 보호의무자의 권리) 
1. 회사는 아래의 경우에 해당하는 자(이하 “8세 이하의 아동”등이라 한다)의 보호의무자가 8세 이하의 아동 등의 생명 또는 신체보호를 위하여 개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다. 
1) 8세 이하의 아동
2) 금치산자
3) 장애인복지법제2조제2항제2호의 규정에 의한 정신적 장애를 가진 자로서 장애인고용촉진및직업재활법 제2조제2호의 규정에 의한 중증장애인에 해당하는 자(장애인복지법 제29조의 규정에 의하여 장애인등록을 한 자에 한한다) 
2. 8세 이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무자임을 증명하는 서면을 첨부하여 회사에 제출하여야 합니다. 
3. 보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 개인위치 정보주체 권리의 전부를 행사할 수 있습니다. 

제 12 조 (위치정보관리책임자의 지정) 
1. 회사는 위치정보를 적절히 관리, 보호하고 개인위치정보주체의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 지위에 있는 자를 위치정보관리책임자로 지정해 운영합니다. 
2. 위치정보관리책임자는 위치기반서비스를 제공하는 부서의 부서장으로서 구체적인 사항은 본 약관의 부칙에 따릅니다. 

제 13 조 (손해배상의 범위) 
1. 회사가 위치정보의보호및이용등에관한법률 15조 내지 26조의 규정의 위반한 행위로 회원에게 손해가 발생한경우회원은 회사에 대해 손해배상을 청구할 수 있습니다. 이 경우 회사는 고의 또는 과실이 없음을 입증하지 아니하면 책임을 면할 수 없습니다. 
2. 회원이 본 약관의 규정을 위반하여 회사에 손해가 발생한 경우 회사는 회원에 대해 손해배상을 청구할 수 있습니다. 이 경우 회원은 고의 또는 과실이 없음을 입증하지 아니하면 책임을 면할 수 없습니다.

제 14 조 (면책)
1. 회사는 다음 각 호의 경우로 서비스를 제공할 수 없는 경우 이로 인하여 회원에게 발생한 손해에 대해서는 책임을 부담하지 않습니다.
1) 천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우
2) 서비스 제공을 위하여 회사와 서비스 제휴계약을 체결한 제 3자의 고의적인 서비스 방해가 있는 경우
3) 회원의 귀책사유로 서비스 이용에 장애가 있는 경우
4) 제1호 내지 제3호를 제외한 기타 회사의 고의, 과실이 없는 사유로 인한 경우
2. 회사는 서비스 및 서비스에 게재된 정보, 자료, 사실의 신뢰도, 정확성 등에 대해서는 보증을 하지 않으며 이로 인해 발생한 회원의 손해에 대하여는 책임을 부담하지 아니합니다.

제 15 조 (규정의 준용)
1. 본 약관은 대한민국법령에 의하여 규정되고 이행됩니다.
2. 본 약관에 규정되지 않은 사항에 대해서는 관계법령 및 상관습에 의합니다.

제 16 조 (분쟁의 조정 및 기타) 
1. 회사는 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 위치정보의 보호 및 이용 등에 관한 법률 제28조 규정에 의한 방송통신위원회에 재정을 신청할 수 있습니다. 
2. 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 개인정보보호법 제43조 규정에 의한 개인정보분쟁조정위원회에 조정을 신청할 수 있습니다. 

부 칙
2015년 7월 27일부터 시행되던 종전의 약관은 본 약관으로 대체하며, 본 약관은 2015년 11월 1일부터 적용됩니다. 
					
					</textarea><br>
					<button id="termsForm" type="button">확인</button>
<!-- 					<input type="submit" value="확인"> -->
				</form>
			</div>
		</div>
	</section>
	<!-- FOOTER -->
	<jsp:include page="footer.jsp"/>
</body>	
</html>