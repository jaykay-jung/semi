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
	#nav-container ul li a {font-size: 13px;}
	ul li {list-style: none; float: left;}
	.navTop a {color: #999; height: 45px; padding: 10px;;}
	button svg {background-color: #fff; border: 0px solid #fff;}
	.navMain ul {height: 45px; margin: 20px 0 10px 0;}
	.navMain a {color: #222; padding: 0px 15px;}
</style>
<nav class="">
	<div class="container" id="nav-container">
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
						<a class="nav-link" href="/semi/cart/form.jsp">CART</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/order/form.jsp">ORDER</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/mypage/myhome.jsp">MYPAGE</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/reviewlist.jsp">REVIEW</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/noticelist.jsp">NOTICE</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- 로고, 검색창 -->
		<div class="row">
			<div class="col-7 text-end">
				<a href="home.jsp">
					<img src="/semi/images/h_logo.png" alt="로고이미지">
				</a>
			</div>
			<div class="col-5 text-end">
				<form id="search-form" method="get" action="flowercategory.jsp">
					<input type="text" name="keyword"placeholder="검색창 수정필요">
					<button class="border-0 bg-white">
						<svg xmlns="               http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
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
						<a class="nav-link" href="/semi/flowercategory.jsp">플라워</a>
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

