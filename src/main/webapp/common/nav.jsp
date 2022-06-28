<%@page import="vo.Product"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
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
	#navMain {margin: 20px 0;}
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
						<a class="nav-link" href="/semi/order/list.jsp">ORDER</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/semi/mypage/mypage.jsp">MYPAGE</a>
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
         <%
         int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
         int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
         String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
         
         ProductDao productDao = ProductDao.getInstance();
         
         
         int totalRows = 0;
         totalRows = productDao.getTotalRows(keyword);
                  
         
         Pagination pagination = new Pagination(rows, totalRows, currentPage);
         
      
         List<Product> productList = null;
         
         productList = productDao.getProducts(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);            
         %>
            <form id="search-form" method="get" action="flowersearch.jsp">
               <input type="text" name="keyword" value="<%=keyword %>">
               <button class="border-0 bg-white" onclick="searchKeyword()">
                  <svg xmlns="               http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                       <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                  </svg>
               </button>
            </form>
         </div>
      </div>
		
		<!-- nav -->
		<div class="row justify-content-center" id="navMain">
			<div class="col-6">
				<ul class="nav justify-content-center">
			<%
			CategoryDao categoryDao = CategoryDao.getInstance();
			List<Category> categoryList = null;
			categoryList = categoryDao.getCategoryList();
			for (Category category : categoryList) {
			%>
				<li class="nav-item">	
						<a style="color:black;" class="nav-link" href="/semi/flowercategory.jsp?categoryNo=<%=category.getNo() %>&page=1"><%=category.getName() %></a>
				</li>
			<%
			}
			%>
				</ul>
			</div>
		</div>
		
	</div>
</nav>

