<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
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
	h3 {font-size: 18px; font-weight: bold;}
	textarea {width: 100%;}
	#reviewform-container {margin-bottom: 100px;}
	#h3-box {margin-bottom: 20px;}
	#review-h3 {line-height: 40px; border-bottom: 1px solid #eee;}
	table {font-size: 15px; border-top: 2px solid #eee;}
	table tbody {font-size: 13px;}
	.table th {background-color: #fbfafa; }
	.table input {width: 70%; text-align: left; line-height: 23px;}
	#input-content {height: 300px; margin-bottom: 20px;}
	#input-content input {width: 100%; height: 100%;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="reviewform"/>
</jsp:include>

<!-- content -->
<div class="container" id="reviewform-container">
	<div class="row">
		<div class="col" id="h3-box">
			<h3 id="review-h3">REVIEW</h3>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<!--  주문상품 선택  -->
		</div>
	</div>
	
	<div>
		<form method="post" action="review.jsp" enctype="multipart/form-data">
			<table class="table">
				<tbody>
					<tr>
						<th>상품 리스트</th>
						<td>
							<select name="productNo">
								<option>선택하세요</option>
							<%
								ProductDao productDao = ProductDao.getInstance();
								List<Product> productList = productDao.getProductList();
								
								for (Product product : productList) {
							%>
								<option value="<%=product.getNo() %>"><%=product.getName() %></option>
							<%
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="title" placeholder="수정사항 : 왼쪽으로 정렬">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea rows="10" name="content"></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<input type="file" name="upfile">
						</td>
					</tr>
				</tbody>
			</table>
			<div class="row">
				<div class="col-6">
					<a href="reviewlist.jsp" class="btn btn-outline-primary">목록</a>
				</div>
				<div class="col-6 text-end">
					<button type="submit" class="btn btn-primary">등록</button>
					<a href="reviewlist.jsp" class="btn btn-outline-secondary">취소</a>
				</div>
			</div>
		
		</form>
	</div>
</div>
<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="reviewform"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>