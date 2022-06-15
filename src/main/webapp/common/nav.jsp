<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String menu = request.getParameter("menu");
	User user = (User) session.getAttribute("LOGINED_USER");
%>
<style>
	div {border: 1px solid #000;}
</style>
<nav class="">
	<div class="container">
		<div class="">
			<div class="col-3 mb-6"></div>
			<div class="col-3 mb-6">
				<ul>
				<!-- 로그인 했을 때  -->
				<%
					if (user != null) {
				%>
					<li class="nav-item">
						<a class="nav-link" href="">MODIFY</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">LOGOUT</a>
					</li>
				<%
					} else if (user == null) {
				%>
					<li class="nav-item">
						<a class="nav-link" href="/semi/loginform.jsp">LOGIN</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">JOIN</a>
					</li>
				<%	
					}
				%>
					<li class="nav-item">
						<a class="nav-link" href="">CART</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">ORDER</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">MYPAGE</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">LOGIN</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</nav>