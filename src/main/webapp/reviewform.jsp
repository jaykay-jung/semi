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
	h3 {font-size: 20px;}
	table {text-align: center; font-size: 15px;}
	table tbody {font-size: 13px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="reviewform"/>
</jsp:include>

<!-- content -->
<div class="container">
	<div class="row">
		<div class="col">
			<h3>REVIEW</h3>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<!--  주문상품 선택  -->
			
		</div>
	</div>
	
	<div>
		<!-- 리뷰 작성 -->
	</div>
	
	<div class="row">
		<div class="col-6">
			<a href="review.jsp">목록</a>
		</div>
		<div class="col-6 text-end btn">
			<a href="#">등록</a>
			<a href="#">취소</a>
		</div>
	</div>
	
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="reviewform"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>