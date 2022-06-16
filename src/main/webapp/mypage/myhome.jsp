<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">

	<jsp:param name="menu" value="mypage"/>
	
</jsp:include>

<!-- content -->
<div class="container">
            <h1><b>나의 정보</b></h1>
</div>
<div class="container">
	<div>
		<h3>내정보 작업중입니다.</h3>
	</div>
</div>

</body>
</html>