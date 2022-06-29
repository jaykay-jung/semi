<%@page import="vo.User"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Qa"%>
<%@page import="dao.QaDao"%>
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
	#qa-detail-container {margin-bottom: 100px;}
	h3 {font-size: 18px; font-weight: bold;}
	#qa {border-bottom: 1px solid #eee; margin-bottom: 30px;}
	.qaContent {font-size: 15px; line-height: 50px;}
	#qa-product-container {border: 5px solid #eee; width: 100%; height: 150px;}
	#qa-image-container {width: 150px; height: 150px; padding:20px;}
	#qa-image-container img {width: 100%; height: 100%;}
	#qa-product-info h4 {font-size: 18px; font-weight: bold; padding-top: 20px;}
	.table {margin-top: 20px; font-size: 15px; }
	.table th {background-color: #fbfbfb;}
	#back-button {width: 20%;}
	#personal-button {width: 20%;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">
	<jsp:param name="menu" value="qadetail"/>
</jsp:include>

<!-- content -->
<div class="container" id="qa-detail-container">
	<%
		// detail.jsp?no=199
		// qa 번호 조회
		int qaNo = StringUtil.stringToInt(request.getParameter("no"));
		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
		
		// 게시글 정보 조회하기
		QaDao qaDao = QaDao.getInstance();
		Qa qa = qaDao.getQaByNo(qaNo);
		
		User user = (User) session.getAttribute("LOGINED_USER");
	%>
	<div class="row">
		<div class="col" id="qa">
			<h3>QA</h3>
		</div>
	</div>
	<!-- 상품정보 출력 -->
	<div class="row">
		<div class="col" id="qa-product-container">
			<div class="row">
				<div class="col-2" id="qa-image-container">
					<!-- 상품이미지 -->
					<img src="images/category/<%=qa.getProduct().getImageName() %>">
				</div>
				<div class="col-10">
					<div id="qa-product-info">
						<h4><%=qa.getProduct().getName() %></h4>
						<p><%=qa.getProduct().getSellPrice() %> 원</p>
					</div>
					<div>
						<a class="btn btn-dark" href="flowerdetail.jsp">상품상세보기<small> ></small></a>
					</div>		
				</div>
			</div>
		</div>
	</div>
	
	<!-- qa 내용 출력 -->
	<div class="row">
		<div class="col">
			<table class="table">
				<tbody>
					<tr>
						<th class="table-background">제목</th>
						<td><%=qa.getTitle() %></td>
					</tr>
					<tr>
						<th class="table-background">작성자</th>
						<td><%=qa.getUser().getName() %></td>
					</tr>
					<tr>
						<th colspan="2" style="background-color: #fff;">작성일 <small><%=qa.getCreatedDate() %></small></th>
					</tr>
					<tr class="qaContent">
						<td colspan="2" ><%=qa.getContent() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-6">
			<a class="btn btn-outline-secondary" id="back-button" href="qalist.jsp">목록</a>
		</div>
	<%
		// 비활성화 여부
		boolean isDisabled = true;
	
		// 사용자 정보가 존재하고, qa 작성자 번호와 사용자 번호 일치하면 수정, 삭제버튼 활성화
		if (user != null && qa.getUser().getNo() == user.getNo()) {
	%>	
		<div class="col-6 text-end">
			<a href="qadeleted.jsp?no=<%=qa.getNo() %>" class="btn btn-danger" id="personal-button">삭제</a>
		</div>
	<%		
		}
	%>
		
	</div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="qadetail"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>