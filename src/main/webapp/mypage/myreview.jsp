<%@page import="dao.MyBoardDao"%>
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
	h3 {font-size: 20px;}
	table {text-align: center; font-size: 15px;}
	table tbody {font-size: 13px;}
</style>
</head>

<body>
<!-- header -->
<jsp:include page="/common/nav.jsp">

	<jsp:param name="mypage" value="myreview"/>
</jsp:include>

<!-- content -->
<div class="container">
	<div class="row">
		<div class="col">
			<div style="width:300px; height:30px; line-height:30px; float: left; margin-left:10px;">
				<h6><strong>게시물 관리</strong></h6>
			</div>
			<div style="width:300px; height:40px; line-height:30px; color=gray; font-weight:bold; font-size:12px; border:1px solid green; float: right; text-align:right; ">	
				<a href="../home.jsp" style="color:gray; text-decoration:none; hover:underline;">홈</a>
				<h6 style="color:gray;">>></h6>
				<a href="myhome.jsp" style="color:gray; text-decoration:none;">마이쇼핑</a>
				<h6 style="color:gray;">>></h6>
				<h6 style="color:gray;">게시물관리</h6>
			</div><div style="clear:both:"></div>
		</div>
	</div>
	<hr style="border: gray 0.7px dotted; margin-left:15px;">	

	<div class="row">
		<div class="col">
		<%
			String fail = request.getParameter("fail");
		%>
		<%
			if ("invalid".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>오류</strong> 유효한 요청이 아닙니다.
				</div>
		<%
			} else if ("deny".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>거부</strong> 다른 사용자의 게시물을 조회할 수 없습니다.
				</div>
		<%	
			}
		%>
		
		<%
			// HttpSession객체에 저장된 사용자정보 조회하기
			User user = (User) session.getAttribute("LOGINED_USER");
			if (user == null) {
				response.sendRedirect("../loginform.jsp?fail=deny");
				return;
			}
	
		%>
		<%
			int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
			int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
			String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));

			// 로그인한 사용자의 리뷰 목록 조회하기
			MyBoardDao myBoardDao = MyBoardDao.getInstance();
			// 사용자번호 추출
			int userNo = user.getNo();
			// 내가 쓴 전체 게시물 갯수 조회
			int totalRows = 0;
			if(keyword.isEmpty()) {
				totalRows = myBoardDao.getTotalRowsByNo(userNo);
			} else {
				totalRows = myBoardDao.getTotalRowsByKeyNByNo(keyword, userNo);
			}
			
			// 페이징 처리에 필요한 정보 제공
			Pagination pagination = new Pagination(rows, totalRows, currentPage);
			
			// 요청한 페이지 번호마다 맞는 데이터를 조회한다.
			List<Review> myBoardList = null;
			if(keyword.isEmpty()) {
				myBoardList = myBoardDao.getReviewsByNo(pagination.getBeginIndex(), pagination.getEndIndex(), userNo);
			} else {
				myBoardList = myBoardDao.getReviewsByKeyNByNo(pagination.getBeginIndex(), pagination.getEndIndex(), userNo, keyword);
			}
				
		%>

			<table class="table">
				<colgroup>
					<col width="5%">
					<col width="10%">
					<col width="%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>상품정보</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				<%
					if (myBoardList.isEmpty()) {
				%>	
					<tr>
						<td colspan="6" class="text-center"><strong>게시물이 없습니다.</strong></td>
					</tr>
				<%
					} else {
						for(Review myReview : myBoardList) {
				%>
						<tr>
							<td><%=myReview.getNo() %></td>
							<td><a href="../flowerdetail.jsp?no=<%=myReview.getProduct().getNo() %>"><%=myReview.getProduct().getName() %></a></td>
							<td><a href="../reviewdetail.jsp?no=<%=myReview.getNo() %>"><%=myReview.getTitle() %></a></td>
							<td><%=myReview.getCreatedDate() %></td>
						</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
	</div>	
	 <div class="row">
	 	<div class="col">
	 <!-- 
	 	 요청한 페이지번호에 맞는 페이지번호를 출력
	 	 요청한 페이지번호와 일치하는 페이지번호는 하이라이트
	 	 요청한 페이지가 1페이지인 경우 이전 버튼을 비활성화
	 	 요청한 페이지가 맨 마지막인 경우 다음 버튼을 비활성화 -->
		 	<nav>
		 		<ul class="pagination justify-content-center">
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="myreview.jsp?page=<%=pagination.getCurrentPage() - 1 %>">이전</a>
		 			</li>
		 		<%
		 			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == num ? "active" : "" %>" href="myreview.jsp?page=<%=num %>"><%=num %></a>
		 			</li>
		 		<%
		 			}
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="myreview.jsp?page=<%=pagination.getCurrentPage() + 1 %>">다음</a>
		 			</li>
		 		</ul>
		 	</nav>
	 	</div>
	 </div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="myreview"/>
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