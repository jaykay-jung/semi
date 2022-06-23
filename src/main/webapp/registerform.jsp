<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	#registerform-container {margin-bottom: 100px;}
	h3 {font-size: 18px; font-weight: bold;}
	.agreeBox {padding: 20px; border: 1px solid #ddd; background-color: #fbfafa;}
	.agreeText {overflow: scroll; height: 200px; width: 100%; background-color: #fff; line-height: 30px; font-size: 13px;}
	#register-h3 {line-height: 40px; border-bottom: 1px solid #eee;}
	#register-button {margin: 0 auto; width: 30%; margin-top: 20px;}
	.table {color: #353535; font-size: 15px; border-top: 2px solid #eaeaea;}
	.table th {background-color: #fbfafa;}
	.register-button {line-height: 40px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="register"/>
</jsp:include>

<!-- content -->
<div class="container" id="registerform-container">
	<div>
		<h3 id="register-h3">회원가입</h3>
	</div>
	<%
		String fail = request.getParameter("fail");
	%>
	<!-- 아이디 중복일 경우 -->
	<%
		if ("id".equals(fail)) {
			String duplicatedId = request.getParameter("id");
	%>
		<div class="alert alert-danger">
			[<%=duplicatedId %>]은 이미 사용 중인 아이디 입니다.
		</div>
	<%
		}
	%>
	
	<!-- 이메일 중복일 경우 -->
	<%
		if ("email".equals(fail)) {
			String duplicatedEmail = request.getParameter("email");
	%>
		<div class="alert alert-danger">
			[<%=duplicatedEmail %>]은 이미 사용 중인 이메일 입니다.
		</div>
	<%
		}
	%>
	
	<!-- 핸드폰 번호 중복일 경우?????????? -->
	<% %>
	
	<form action="register.jsp" method="post">
		<div>
			<table class="table">
				<tbody>
					<tr>
						<th>아아디 <img src="images/require.gif"></th>
						<td>
							<input type="text" name="id" placeholder="아이디">
							<span>(조건)</span>
						</td>
					</tr>
					<tr>
						<th>비밀번호 <img src="images/require.gif"></th>
						<td>
							<input type="password" name="password" placeholder="비밀번호">
							<span>(조건)</span>
						</td>
					</tr>
					<tr>
						<th>이름 <img src="images/require.gif"></th>
						<td>
							<input type="text" name="name" placeholder="이름">
						</td>
					</tr>
					<tr>
						<th>휴대전화 <img src="images/require.gif"></th>
						<td>
							<input type="text" name="phone" placeholder="핸드폰번호">
						</td>
					</tr>
					<tr>
						<th>이메일 <img src="images/require.gif"></th>
						<td>
							<input type="email" name="email" placeholder="이메일">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 이용약관동의, 개인정보수집동의 만들기 -->
		
		<div>
			<h3>이용약관 동의 <small>(필수)</small></h3>
			<div class="agreeBox">
				<div class="agreeText">
					제1조(목적)<br>
					이 약관은 OO 회사(전자상거래 사업자)가 운영하는 OO 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리?의무 및 책임사항을 규정함을 목적으로 합니다.<br>
					※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」<br>
					<br>
					제2조(정의)<br>
					① “몰”이란 OO 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br>
					② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>
					③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.<br>
					④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.<br>
					<br>
					제3조 (약관 등의 명시와 설명 및 개정)<br>
					① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호?모사전송번호?전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보보호책임자등을 이용자가 쉽게 알 수 있도록 00 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br>
					② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회?배송책임?환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br>
					③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
					④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.<br>
					⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br>
					⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.<br>
				</div>
				<div>
					<p>
						<small>이용약관에 동의하십니까?</small>
						<input type="checkbox" required="required">
						<label>동의함</label>
					</p>
				</div>
			</div>
		</div>
		
		<div id="register-button" class="row">
			<button type="submit" class="btn btn-dark col-6 register-button">회원가입</button>
			<a href="home.jsp" class="btn btn-secondary col-6 register-button">회원가입 취소</a>
		</div>
	</form>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="register"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>