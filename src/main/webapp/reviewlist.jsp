<%@page import="vo.Pagination"%>
<%@page import="dao.ReviewDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@page import="vo.Review"%>
<%@page import="java.util.List"%>
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
	a {text-decoration: none; color: #000;}
	h3 {font-size: 20px;}
	table {text-align: center; font-size: 15px; }
	table tbody {font-size: 13px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="review"/>
</jsp:include>

<!-- content -->
<div class="container">
	<div class="row">
		<div class="col">
			<h3>REVIEW</h3>
		</div>
	</div>
	<%
		int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
		int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
		String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
		
		ReviewDao reviewDao = ReviewDao.getInstance();
		
		// 전체 데이터 갯수 조회
		int totalRows = reviewDao.getTotalRows();
		if (keyword.isEmpty()) {
			totalRows = reviewDao.getTotalRows();
		} else {
			totalRows = reviewDao.getTotalRows(keyword);
		}
		
		// 페이징처리에 필요한 정보 제공 객체
		Pagination pagination = new Pagination(rows, totalRows, currentPage);
		
		// 페이지 번호에 맞는 데이터 조회
		List<Review> reviewList = null;
		if(keyword.isEmpty()) {
			reviewList = reviewDao.getReviews(pagination.getBeginIndex(), pagination.getEndIndex());
		} else {
			reviewList = reviewDao.getReviews(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
		}
		
	%>
	<div>
		<div>
			<table class="table">
				<colgroup>
					<col width="5%">
					<col width="15%">
					<col width="%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>상품정보</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(Review review : reviewList) {
				%>
					<tr>
						<td><%=review.getNo() %></td>
						<td>
							<a href="#">
								<!-- 상품 이미지 출력 -->
								<img src="<%=review.getProduct().getImageName() %>">
								<span><%=review.getProduct().getName() %></span>
							</a>
						</td>
						<td style="text-align: left; padding: 10px;">
							<a id="review-title" href="reviewdetail.jsp?no=<%=review.getNo() %>"><%=review.getTitle() %></a>
						</td>
						<td><%=review.getUser().getName() %></td>
						<td><%=review.getCreatedDate() %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
		
		<!-- 로그인 전에는 글쓰기 버튼 비활성화 -->
		<div class="row">
			<div class="col text-end">
				<%
					User user = (User) session.getAttribute("LOGINED_USER");
				%>
				<a href="reviewform.jsp" class="btn btn-dark btn-sm <%=user == null ? "disabled" : "" %> " >글쓰기</a>
			</div>
		</div>
	</div>
	 
	 <!-- 페이징 -->
	 <div class="row">
	 	<div class="col">
		 	<nav>
		 		<ul class="pagination justify-content-center">
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="review.jsp?page=<%=pagination.getCurrentPage() - 1 %>">&lt;</a>
		 			</li>
		 		<%
		 			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == num ? "active" : "" %>" href="review.jsp?page=<%=num %>"><%=num %></a>
		 			</li>
		 		<%
		 			}
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="review.jsp?page=<%=pagination.getCurrentPage() + 1 %>">&gt;</a>
		 			</li>
		 		</ul>
		 	</nav>
	 	</div>
	 </div>
	
	<!-- 검색 -->
	<div class="row">
		<div class="col-9">
			<form id="search-form" method="get" action="review.jsp">
				<input type="hidden" name="page">
				<input type="text" name="<%=keyword %>" placeholder="검색">
			</form>
		</div>
		<div class="col-3">
			<button type="button" onclick="searchKeyword">검색</button>
		</div>
	</div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="review"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function searchKeyword() {
		document.querySelector("input[name=page]").value = 1;
		document.getElementById("search-form").submit;
	}
</script>
</body>
</html>