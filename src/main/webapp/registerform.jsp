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
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="registerform"/>
</jsp:include>

<!-- content -->
<div class="container">
	<div>
		<h1>회원가입</h1>
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
			<input type="text" name="id" placeholder="아이디">
			<input type="password" name="password" placeholder="비밀번호">
			<input type="text" name="name" placeholder="이름">
			<input type="text" name="phone" placeholder="핸드폰번호">
			<input type="text" name="email" placeholder="이메일">
		</div>
		
		<!-- 이용약관동의, 개인정보수집동의 만들기 -->
		
		<div>
			<button type="submit">회원가입</button>
		</div>
	</form>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="registerform"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>