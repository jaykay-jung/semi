<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String menu = request.getParameter("menu");
	User user = (User) session.getAttribute("LOGINED_USER");
%>
<script src="https://kit.fontawesome.com/def66b134a.js" crossorigin="anonymous"></script>
<style>
	* {margin: 0; padding: 0;}
	ul li {list-style: none; float: left;}
	div {}
	.navTop a {color: #999; height: 45px;}
	.navMain ul {height: 45px; margin: 20px 0 10px 0;}
	.navMain a {color: #222; padding: 0px 15px;}
</style>
<nav class="">
	<div class="container">
		<!-- 최상단 nav -->
		<div class="nav justify-content-end">
			<div class="navTop">
				<ul>
				<!-- 로그인 했을 때  -->
				<%
					if (user != null) {
				%>
					<li class="nav-item">
						<a class="nav-link" href="">MODIFY</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/logout.jsp">LOGOUT</a>
					</li>
				
				<!-- 로그인 전일 때 -->
				<%
					} else if (user == null) {
				%>
					<li class="nav-item">
						<a class="nav-link" href="/semi/loginform.jsp">LOGIN</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/registerform.jsp">JOIN</a>
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
						<a class="nav-link" href="/semi/review.jsp">REVIEW</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- 로고, 검색창 -->
		<div class="row">
			<div class="col-7 text-end">
				<a href="home.jsp">
					<img src="images/h_logo.png" alt="로고이미지">
				</a>
			</div>
			<div class="col-5 text-end">
				<form>
					<input type="text" name="keyword" placeholder="검색창 수정필요">
					<button>
						<i class="fa-light fa-magnifying-glass"></i>
					</button>
				</form>
			</div>
		</div>
		
		<!-- nav -->
		<div class="navMain">
			<div>
				<ul class="nav justify-content-center">
					<li class="nav-item">
						<a class="nav-link" href="">정기구독</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">플라워</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">드라이플라워</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">실크플라워</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">소품</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</nav>

