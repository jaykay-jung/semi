<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	#register-complete-container {margin-bottom: 100px;}
	h3 {font-size: 18px; font-weight: bold;}
	#complete-h {margin-bottom: 30px;}
	#complete-h3 {border-bottom: 1px solid #eee; line-height: 40px;}
	#complete-box {margin-top: 30px; border: 1px solid #eee; padding: 40px;}
	#complete-h1 {font-size: 25px; font-weight: bold; color: #666; text-align: center;}
	#complete-h2 {font-size: 23px; font-weight: bold; text-align: center;}
	#complete-info {margin-bottom: 30px;}
	table {margin: 0 auto; border: 1px solid #eee; width: 40%;}
	thead th {background: #fbfbfb url("images/important.gif") no-repeat 10px center; padding: 10px 30px; font-size: 15px;}
	table td {padding: 8px 50px; font-size: 13px;}
	table .arrow-image {background: url("images/arrow.png") no-repeat 7px;}
	
	#complete-bottom {margin: 0 auto; width: 30%;}
	#complete-bottom p {font-size: 15px; text-align: center;}
	#complete-bottom a {width: 100%;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="registercomplete"/>
</jsp:include>

<div class="container" id="register-complete-container">
	<div class="row">
		<div class="col">
			<h3 id="complete-h3">회원가입 완료</h3>
		</div>
	</div>
	<div id="complete-box">
		<div id="complete-h">
			<h1 id="complete-h1">회원가입</h1>
			<h2 id="complete-h2">회원가입이 완료되었습니다.</h2>
		</div>
		<div id="complete-info">
		<%
			
		%>
			<!-- 고객정보 출력 -->
			<div>
				<table>
					<thead>
						<tr>
							<th colspan="3">저희 쇼핑몰을 이용해주셔서 감사합니다.</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td rowspan="3">
								<img src="images/member_image.gif">
							</td>
							<td class="arrow-image">아이디</td>
							<td></td>
						</tr>
						<tr>
							<td class="arrow-image">이름</td>
							<td></td>
						</tr>
						<tr>
							<td class="arrow-image">이메일</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div id="complete-bottom">
			<div>
				<p>임소연 님은 [일반회원] 회원이십니다.</p>
			</div>
			<div class="row">
				<div class="col-6">
					<a class="btn btn-dark" href="loginform.jsp">로그인</a>
				</div>
				<div class="col-6">
					<a class="btn btn-secondary" href="home.jsp">메인으로 이동</a>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="reviewdetail"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>