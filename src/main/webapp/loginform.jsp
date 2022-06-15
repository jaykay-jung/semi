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
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="login"/>
</jsp:include>

<!-- content -->
<div class="container">
	<div>
		<h1>LOGIN</h1>
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
			<div>
				<input type="text" placeholder="아이디" name="id">
				<input type="password" placeholder="비밀번호" name="password">
			</div>
			<div>
				<button type="submit" class="btn btn-dark">로그인</button>
			</div>
		</form>
	</div>
</div>


<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="registerform"/>
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