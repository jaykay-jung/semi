<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Review"%>
<%@page import="dao.ReviewDao"%>
<%@page import="util.StringUtil"%>
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
	#review-detail-container {margin-bottom: 100px;}
	h3 {font-size: 18px; font-weight: bold;}
	#review {border-bottom: 1px solid #eee; margin-bottom: 30px;}
	.reviewContent {font-size: 15px; line-height: 50px;}
	#review-product-container {border: 5px solid #eee; width: 100%; height: 150px;}
	#review-image-container {width: 150px; height: 150px; padding:20px;}
	#review-image-container img {width: 100%; height: 100%;}
	#review-product-info h4 {font-size: 18px; font-weight: bold; padding-top: 20px;}
	.table {margin-top: 20px; font-size: 15px; }
	.table th {background-color: #fbfbfb;}
	#back-button {width: 10%;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="reviewdetail"/>
</jsp:include>

<!-- content -->
<div class="container" id="review-detail-container">
	<%
		// detail.jsp?no=199
		// 리뷰 번호 조회
		int reviewNo = StringUtil.stringToInt(request.getParameter("no"));
		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
		
		// 게시글 정보 조회하기
		ReviewDao reviewDao = ReviewDao.getInstance();
		Review review = reviewDao.getReviewByNo(reviewNo);
	%>
	<div class="row">
		<div class="col" id="review">
			<h3>REVIEW</h3>
		</div>
	</div>
	<!-- 상품정보 출력 -->
	<div class="row">
		<div class="col" id="review-product-container">
			<div class="row">
				<div class="col-2" id="review-image-container">
					<!-- 상품이미지 -->
					<img src="images/category/<%=review.getProduct().getImageName() %>">
				</div>
				<div class="col-10">
					<div id="review-product-info">
						<h4><%=review.getProduct().getName() %></h4>
						<p><%=review.getProduct().getSellPrice() %> 원</p>
					</div>
					<div>
						<a class="btn btn-dark" href="flowerdetail.jsp">상품상세보기<small> ></small></a>
					</div>		
				</div>
			</div>
		</div>
	</div>
	
	<!-- 리뷰 내용 출력 -->
	<div class="row">
		<div class="col">
			<table class="table">
				<tbody>
					<tr>
						<th class="table-background">제목</th>
						<td><%=review.getTitle() %></td>
					</tr>
					<tr>
						<th class="table-background">작성자</th>
						<td><%=review.getUser().getName() %></td>
					</tr>
					<tr>
						<th colspan="2" style="background-color: #fff;">작성일 <small><%=review.getCreatedDate() %></small></th>
					</tr>
					<tr class="reviewContent">
						<td colspan="2" ><%=review.getContent() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div>
		<div>
			<a class="btn btn-outline-secondary" id="back-button" href="reviewlist.jsp">목록</a>
		</div>
		
	</div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="reviewdetail"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>