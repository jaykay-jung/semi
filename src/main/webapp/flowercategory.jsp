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
	<jsp:param name="menu" value="flowercategory" />
</jsp:include>

<div class="container">
	<div id="categoryname">
		<h6>플라워</h6><!--카테고리 명칭을 입력-->
	</div>
	<div id="sortingfunction">
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
	<!-- for문을 돌려야 함. 지금 col-4 3개 적어놓은 것은 단순히 잘 보이는지 확인하기 위함 -->
	<div class="row mb-3"> 
				
		<div class="col-3 mb-3">
			<div class="card">
  				<a href="http://localhost/semi/flowerdetail.jsp ">
  					<img src="images/category/Sample1_ConfessionSunflower.jpg" class="card-img-top" alt="..."> <!--"images/category/파일명.jpg -->
  				</a>
  				<div class="card-body">
  					<h5 class="card-title fs-6"><small>고백 해바라기 꽃다발 생화</small></h5>
    				<p class="card-text mt-2 mb-1"><small><del class="text-muted">35000원</del></small></p> 
    				<p class="text-danger"><small><strong>22900원</strong></small></p>
    				<p class="card-text mb-1"><small  class="text-muted">여름하면 생각나는 꽃 해바라기입니다.</small></p>
  				</div>	
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card">
  				<a href="http://localhost/semi/flowerdetail.jsp ">
  					<img src="images/category/Sample1_ConfessionSunflower.jpg" class="card-img-top" alt="..."> <!--"images/category/파일명.jpg -->
  				</a>
  				<div class="card-body">
  					<h5 class="card-title fs-6"><small>고백 해바라기 꽃다발 생화</small></h5>
    				<p class="card-text mt-2 mb-1"><small><del class="text-muted">35000원</del> <strong class="text-danger float-end">35000원</strong></small></p>
    				<p class="card-text mb-1"><small  class="text-muted">여름하면 생각나는 꽃 해바라기입니다.</small></p>
  				</div>	
			</div>
		</div>
		
		<div class="col-3 mb-3">
			<div class="card">
  				<a href="http://localhost/semi/flowerdetail.jsp ">
  					<img src="images/category/Sample1_ConfessionSunflower.jpg" class="card-img-top" alt="..."> <!--"images/category/파일명.jpg -->
  				</a>
  				<div class="card-body">
  					<h5 class="card-title fs-6"><small>고백 해바라기 꽃다발 생화</small></h5>
    				<p class="card-text mt-2 mb-1"><small><del class="text-muted">35000원</del></small></p> 
    				<p class="text-danger"><small><strong>22900원</strong></small></p>
    				<p class="card-text mb-1"><small  class="text-muted">여름하면 생각나는 꽃 해바라기입니다.</small></p>
  				</div>	
			</div>
		</div>
		
	</div>
	
	<div class="row mb-3">
		<div class="col-12">
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
</div>

<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="flowercategory"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>