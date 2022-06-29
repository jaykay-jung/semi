<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Pagination"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--<title>카테고리 명칭을 입력</title>-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">


<style>
#sortingfunction a {color: #999; height: 45px;}
</style>
 <!-- 상품정보 출력을 왼쪽정렬시키려고 #customer-price에 text-align: left; 적용했지만 적용이 안됨 -->
 
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="flowercategory"/>
</jsp:include>

<div class="container">
		<%
		
			
			// 해당 카테고리 번호로 정보 조회하기
			CategoryDao categoryDao = CategoryDao.getInstance();
			
			int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
			
			Category category = categoryDao.getCategoryByNo(categoryNo);
		
			
			
			
			int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
			int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
			
			ProductDao productDao = ProductDao.getInstance();
			
			// 전체 데이터의 수를 조회
			int totalRows = productDao.getTotalRows(categoryNo);
			
			// 페이징처리에 필요한 정보 제공 객체 생성
			Pagination pagination = new Pagination(rows, totalRows, currentPage);
			
			// 요청한 페이지번호에 해당하는 데이터 조회하기
			List<Product> productList = productDao.getProducts(categoryNo, pagination.getBeginIndex(), pagination.getEndIndex());
		%>

	<div id="categoryname">
		<h6></h6><!--카테고리 명칭을 입력-->
	</div>
	
	<!-- 카드 형식으로 데이터 나열 for문으로  -->
	<div class="row mb-3"> 
		<%
			for (Product product : productList) {
		%>		
		<div class="col-3 mb-3">
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
	
	<div class="row mb-3">
		<div class="col-12">
		
			 <nav aria-label="pagenavigation">
	  			<ul class="pagination justify-content-center">
	    			<li class="page-item">
	      				<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="flowercategory.jsp?categoryNo=<%=categoryNo %>&page=<%=pagination.getCurrentPage() - 1 %>" aria-label="Previous">
	        				<span aria-hidden="true">&laquo;</span>
	      				</a>
	      			</li>
	      		<%
					for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
				%>
	    			<li class="page-item">
	    				<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : "" %>" href="flowercategory.jsp?categoryNo=<%=categoryNo %>&page=<%=num %>"><%=num %>
	    				</a>
	    			</li>
	    		<%
					}
				%>
	    			<li class="page-item">
	      				<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="flowercategory.jsp?categoryNo=<%=categoryNo %>&page=<%=pagination.getCurrentPage() + 1 %>" aria-label="Next">
	        				<span aria-hidden="true">&raquo;</span>
	      				</a>
	    			</li>
	  			</ul>
			</nav>
			
		</div>
	</div>
</div>

<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="flowercategory"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	
</script>
</body>
</html>