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
	#h3-box {margin-bottom: 20px;}
	#review-h3 {line-height: 40px; border-bottom: 1px solid #eee;}
	table {text-align: center; font-size: 15px; border-top: 2px solid #eee;}
	table tbody {font-size: 13px;}
	.table th {background-color: #fbfafa;}
	.table input {width: 50%; text-align: left;}
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
<div class="container">
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
		<form method="post" action="review.jsp">
			<table class="table">
				<tbody>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="title" placeholder="수정사항 : 왼쪽으로 정렬">
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 리뷰 내용 -->
			<div id="input-content">
				<input type="text" name="content" placeholder="수정 사항 : 엔터 안 됨, 위에서부터 입력 시키기">
			</div>
		</form>
	</div>
	
	<div class="row">
		<div class="col-6">
			<a href="reviewlist.jsp" class="btn">목록</a>
		</div>
		<div class="col-6 text-end">
			<a href="#" class="btn">등록</a>
			<a href="reviewlist.jsp" class="btn">취소</a>
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