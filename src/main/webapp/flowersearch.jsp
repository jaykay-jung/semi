<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
#sortingfunction a {color: black; height: 45px; font-size:14px;}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="flowercategory"/>
</jsp:include>


<div class="container">
		<%
		
			int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
			int rows = StringUtil.stringToInt(request.getParameter("rows"), 15);
			String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
			
			ProductDao productDao = ProductDao.getInstance();
			
			// 전체 데이터의 수를 조회
			int totalRows = productDao.getTotalRows(keyword);
						
			// 페이징처리에 필요한 정보 제공 객체 생성
			Pagination pagination = new Pagination(rows, totalRows, currentPage);
			
			// 요청한 페이지번호에 해당하는 데이터 조회하기
			List<Product> productList = productDao.getProducts(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);				
		%>


	<div id="pageexplanation" style="padding:30px; margin-bottom:30px; border-bottom:1px dashed grey;">
			<div style="float:left; font-size:14px;">
				<p><strong>상품검색</strong></p>
			</div>
			<div style="float:right; display:inline-block; font-size:14px;">
				<p style="color:grey;'">홈 >> 상품검색</p>
			</div>
	</div>

	<div style="padding:10px; margin-bottom:10px;">
	<p style="text-align: center;"> <strong><%=keyword %></strong>(으)로 조회한 상품이 <strong><%=totalRows %></strong>건 존재합니다.</p> 
	</div>

	<div id="sortingfunction">
			<ul class="nav justify-content-end" style="border-bottom:1px dashed grey;">
	  			<li class="nav-item">
	    			<a class="nav-link" href="#">NEW</a>
	  			</li>
	  			<li class="nav-item">
	    			<a class="nav-link" href="#">TITLE</a>
	  			</li>
	  			<li class="nav-item">
	    			<a class="nav-link" href="#">LOW PRICE</a>
	  			</li>
	  			<li class="nav-item">
	    			<a class="nav-link" href="#">HIGH PRICE</a>
	  			</li>
			</ul>
		</div>
		
	<!-- 카드 형식으로 데이터 나열 for문으로  -->
	<div class="row mb-3"> 
		<%
			for (Product product : productList) {
		%>		
		<div class="col-3 mb-3" style="padding:10px;">
			<div class="card">
				<a href="flowerdetail.jsp?productNo=<%=product.getNo() %>&page=<%=pagination.getCurrentPage() %>">
				<img src="images/category/<%=product.getImageName() %>" class="card-img-top" alt="...">
				</a>
  				<div class="card-body">
  					<h5 class="card-title fs-6"><small><%=product.getName() %></small></h5>
    				<p class="card-text mt-2 mb-1"><small><del class="text-muted"><%=product.getCustomerPrice() %>원</del></small></p> 
    				<p class="text-danger"><small><strong><%=product.getSellPrice() %>원</strong></small></p>
    				<p class="card-text mb-1"><small  class="text-muted"><%=product.getDescription() %></small></p>
  				</div>	
			</div>
			
		</div>
		<%
			}
		%>
	</div>

</div>


<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="flowercategory"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>