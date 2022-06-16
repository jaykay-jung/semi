<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>플라워</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	h6 {text-align:center;}
	.sortingfunction {border-bottom: 1px solid grey;}
	.sortingfunction a {color: grey;}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="flowercategory" />
</jsp:include>

<div class="container">
	<div class="categoryname">
		<h6>플라워</h6>
	</div>
	<div class="sortingfunction">
		<ul class="nav justify-content-end">
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
	<div class="categoryproduct">
	
	</div>
	
	<div class="paging">
		<nav aria-label="pagenavigation">
  			<ul class="pagination justify-content-center">
    			<li class="page-item">
      			<a class="page-link" href="#" aria-label="Previous">
        			<span aria-hidden="true">&laquo;</span>
      			</a>
    			</li>
    			<li class="page-item">
    			<a class="page-link" href="#">1</a>
    			</li>
    			<li class="page-item">
    			<a class="page-link" href="#">2</a>
    			</li>
    			<li class="page-item">
    			<a class="page-link" href="#">3</a>
    			</li>
    			<li class="page-item">
      				<a class="page-link" href="#" aria-label="Next">
        				<span aria-hidden="true">&raquo;</span>
      			</a>
    			</li>
  			</ul>
		</nav>
	</div>
   
</div>

<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="flowercategory"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>