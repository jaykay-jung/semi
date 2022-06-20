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
	h3 {font-size: 20px;}
	.reviewContent {font-size: 15px; line-height: 50px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="reviewdetail"/>
</jsp:include>

<!-- content -->
<div class="container">
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
		<div class="col">
			<h3>REVIEW</h3>
		</div>
	</div>
	<!-- 상품정보 출력 -->
	<div class="row">
		<div class="col" style="border: 3px solid #eee; width: 100%; height: 150px;">
			<div class="row">
				<div class="col-2">
					<!-- 상품이미지 -->
					<img style="width: 100%; height: 100%;" src="images/catogory-flower/Sample1_ConfessionSunflower.jpg">
				</div>
				<div class="col-10">
					<div>
						<h4>상품 이름</h4>
						<p>상품 가격</p>
					</div>
					<div>
						<a class="btn btn-dark" href="#">상품상세보기<small> ></small></a>
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
						<th>제목</th>
						<td><%=review.getTitle() %></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><%=review.getUser().getName() %></td>
					</tr>
					<tr>
						<th colspan="2">작성일 <small><%=review.getCreatedDate() %></small></th>
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
			<a class="btn btn-secondary" href="review.jsp">목록</a>
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