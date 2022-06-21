<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PLANANT</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
	#content {text-align: center;}
</style>
<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">
	<jsp:param name="name" value="order"/>
</jsp:include>

<div class="container">
   <div class="p-5 mb-4 bg-light rounded-3">
   	<div id="content" class="container-fluied py-3">
   		<h1 class="display-5 fw-bold">결제 완료</h1>
   		<p class="fs-4">결제가 완료되었습니다.</p>
   		<a href="../home.jsp" class="btn btn-primary byn-lg">HOME</a>	
   		<a href="../mypage/order/list.jsp" class="btn btn-primary byn-lg">주문내역</a>	
   	</div>
   </div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="order"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>