<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 게시물</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">

	<jsp:param name="mypage" value="myboardlist"/>
	
</jsp:include>

<!-- content -->
<div class="container">
            <h3><b>게시물 관리</b></h3>
</div>
<div class="container">
	<div>
		<h1>나의 게시물 작업중입니다.</h1>
	</div>
</div>

</body>
</html>