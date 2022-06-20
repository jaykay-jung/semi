<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	#loginform-container {margin-bottom: 100px;}
	h3 {font-size: 18px; font-weight: bold;}
	#login {border: 1px solid #eee; border-top: 3px solid #000; width: 80%; margin: 0 auto; padding: 30px; margin-top: 100px;}
	#login-box {width: 40%; margin: 0 auto;}
	#login-h3 {border-bottom: 1px solid #eee; line-height: 40px;}
	#login-form {margin-top: 20px;}
	#login-id {width: 100%; margin-bottom: 5px;}
	#login-pw {width: 100%;}
	#security p {line-height: 40px; margin-bottom: 0; font-size: 15px; color: #757575;}
	#login-button {width: 100%;}
	#login-register {background-color: #f9f9f9; margin-top: 40px;}
	#login-register p {line-height: 50px; font-size: 13px; color: #999; padding-left: 40px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="login"/>
</jsp:include>

<!-- content -->
<div class="container" id="loginform-container">
	<div id="login">
		<div id="login-box">
			<h3 id="login-h3">LOGIN</h3>
			<%
				String fail = request.getParameter("fail");
			%>
				<!--
					아이디 혹은 비밀번호가 일치하지 않는 경우
				-->
			<%
				if ("invalid".equals(fail)) {
			%>
				<div class="alert alert-danger">
					<strong>로그인 실패</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
				</div>
			<%
				}
			%>
			<form method="post" action="login.jsp" onsubmit="return loginForm()">
				<div id="login-form">
					<input id="login-id" type="text" placeholder="아이디" name="id">
					<input id="login-pw" type="password" placeholder="비밀번호" name="password">
				</div>
				<div id="security">
					<p>
						<img src="images/login/security.gif">
						보안접속
					</p>
				</div>
				<div>
					<button id="login-button" type="submit" class="btn btn-dark">로그인</button>
				</div>
			</form>
		</div>
		<div id="login-register">
			<p>가입하시면 다양한 혜택이 준비되어 있습니다. <span><a href="registerform.jsp">회원가입</a></span></p>
		</div>
	</div>
</div>


<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="login"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function loginForm() {
		let id = document.querySelector("input[name=id]");
		if(id.value == '') {
			alert("아이디는 필수 입력값입니다.");
			id.focus();
			return false;
		}
		let password = document.querySelector("input[name=password]");
		if(password.value == '') {
			alert("비밀번호는 필수 입력값입니다.");
			password.focus();
			return false;
		}
		return true;
	}
</script>
</body>
</html>