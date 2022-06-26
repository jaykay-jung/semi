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
	#noticeform-container {margin-bottom: 100px;}
	#h3-box {margin-bottom: 20px;}
	#notice-h3 {line-height: 40px; border-bottom: 1px solid #eee;}
	table {border-top: 2px solid #eee; border-bottom: 2px solid #eee;}
	.table th {background-color: #fbfafa}
	.table #notice-content {width: 100%; padding: 30px; height: 300px;}
	.btn {width: 20%;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="noticeform"/>
</jsp:include>

<!-- content -->
<div class="container" id="noticeform-container">
	<div class="row">
		<div class="col" id="h3-box">
			<h3 id="notice-h3">Notice</h3>
		</div>
	</div>
	
	<div>
		<form method="post" action="notice.jsp">
			<table class="table">
				<tbody>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="title" placeholder="제목입력, 첨부파일 추가">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input id="notice-content" type="text" name="content" placeholder="내용입력">
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
		</form>
	</div>
	<div class="row">
		<div class="col-6">
			<a href="noticelist.jsp" class="btn btn-outline-secondary">목록</a>
		</div>
		<div class="col-6 text-end">
			<form action="notice.jsp" method="post">
				<button type="submit" class="btn btn-dark ">등록</button>
			</form>
		</div>
	</div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="noticeform"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>