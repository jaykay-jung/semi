<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.footerContainer {margin-top: 100px;}
	p .productExplain {color: #666;}
	.seemoreButton {margin: 20px 0;}
	.textBold {font-weight: bold;}
</style>

</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="home"/>
</jsp:include>

<!-- content -->
<div class="container-fluid">
	<%
	
	%>
	<div class="row mb-3">
		<div class="col-12">
			<!-- 슬라이드 이미지 -->
			<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
		  		<div class="carousel-indicators">
		    		<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    		<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    		<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
		    		<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="3" aria-label="Slide 4"></button>
		  		</div>
		  	<div class="carousel-inner">
		    	<div class="carousel-item active" data-bs-interval="10000">
		    		<a href="#">
		    			<img src="images/h_banner_1.jpg" class="d-block w-100" alt="슬라이드 이미지">
		    		</a>
		    	</div>
		    	<div class="carousel-item" data-bs-interval="2000">
		      		<a href="#">
		    			<img src="images/h_banner_2.jpg" class="d-block w-100" alt="슬라이드 이미지">
		    		</a>
		    	</div>
		    	<div class="carousel-item" data-bs-interval="3000">
		      		<a href="#">
		    			<img src="images/h_banner_3.jpg" class="d-block w-100" alt="슬라이드 이미지">
		    		</a>
		    	</div>
		    	<div class="carousel-item" data-bs-interval="4000">
		      		<a href="#">
		    			<img src="images/h_banner_4.jpg" class="d-block w-100" alt="슬라이드 이미지">
		    		</a>
		    	</div>
		  	</div>
		  		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
		    		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    		<span class="visually-hidden">Previous</span>
		  		</button>
		  		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
		    		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		    		<span class="visually-hidden">Next</span>
		  		</button>
			</div>
		</div>
	</div>
	
	<!-- 이벤트 배너 -->
	
</div>

<div class="container">
	<div class="row mb-3">
		<div class="col-6 m-0 p-0 bannerImageA">
			<a href="#">
				<img src="images/e_banner_1.jpg" alt="이벤트 배너 이미지" style="min-width: 100%; max-width: 100%;">
			</a>
		</div>
		<div class="col-6 m-0 p-0 bannerImageB">
			<a href="#">
				<img src="images/e_banner_2.jpg" alt="이벤트 배너 이미지" style="min-width: 100%; max-width: 100%;">
			</a>
		</div>
	</div>
</div>

<div class="container">
	<div>
		<div class="text-center">
			<h3>Best</h3>
		</div>
		<div class="row">
			<div class="col-4">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col text-center">
			<a class="btn btn-light btn-outline-secondary mx-auto seemoreButton" href="">
				SEEMORE
			</a>
		</div>
	</div>
	<div>
		<div class="text-center">
			<h3>드라이 플라워</h3>
		</div>
		<div class="row">
			<div class="col-3">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>			
			</div>
			<div class="col-3">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>			
			</div>
			<div class="col-3">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>			
			</div>
			<div class="col-3">
				<div class="card">
					<div style="border: 1px solid #eee; margin: 25px;">					
						<p>상품사진</p>
					</div>
					<div class="card-body">
						<p class="textBold">상품명</p>
						<p class="textBold">가격</p>
						<p><small class="productExplain">설명</small></p>
					</div>
				</div>			
			</div>
		</div>
		
	</div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="home"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>