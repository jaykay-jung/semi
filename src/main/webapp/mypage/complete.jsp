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

<!-- 스타일 -->
<style type="text/css">

input {
    height: 18px;
    line-height: 15px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
   
.vertical-align-content {display:flex; align-items:center; justify-content: center; color:white; width:150px; height:40px; margin:5px; font-size:12px;}
.vertical-align-content2 {display:flex; align-items:center; justify-content: center; color:white; width:150px; height:30px; margin:5px; font-size:12px;}

.nolinelink:link {color: black; text-decoration-line:none;}
.nolinelink:visited {color: black; text-decoration-line:none;}
.nolinelink:hover {color: black; text-decoration:none;}
.nolinelink:hover, .nolinelink:active {color:black; text-decoration:none;}

.over:link {color: gray; text-decoration-line:none;}
.over:visited {color: gray; text-decoration-line:none;}
.over:hover {color: gray; text-decoration:underline;}
.over:hover, .nolinelink:active {color:gray; text-decoration:underline;}
font {font-size:13px;}
</style>





</head>
<body>

<!-- header -->
<jsp:include page="../common/nav.jsp">
	<jsp:param name="menu" value="mypage"/>
</jsp:include>

<!-- content -->
<div class="container">
<!-- 개요 -->
	<div class="row">
		<div class="col">
        	<div style="float:left; width:300px; height:30px; line-height:30px;">
				<h6><strong>마이페이지</strong></h6>
			</div>
			<div style="float: right; width:300px; height:auto; text-align:right; color:gray;">	
				<font><a class="nolinelink" href="../home.jsp" style="color:gray;">홈</a></font>
				<font><strong>》</strong></font>
				<font><a class="nolinelink" href="mypage.jsp" style="color:gray;">마이페이지</a></font>
				<font><strong>》</strong></font>
				<font><strong>회원정보수정</strong></font>
			</div><div style="clear:both:"></div>
    	</div>
		<hr style="border: gray 0.7px dotted;">	
  	</div>
  	
  	
<!-- 내용 -->				
	<div style="margin:20px 5px; border:1px solid gainsboro; ">
		<div class="row" style="margin:40px; height:auto;">
        	<div class="col">
        		<div style="line-height:50px; margin:30px 10px;">
   					<h1 style="text-align:center; font-weight:bold; ">회원정보 수정이 완료되었습니다.</h1>
				</div>
			</div>
		</div>
		<div class="row" style="margin:30px 470px; height:auto; background-color:gainsboro;">
       		<div class="col" style="width:20%; height:60; margin:20px 10px; text-align:center; ">
       			<a class="nolinelink" href="mypage.jsp" style="height:50px; margin-left:7px; ">
					<font style="font-weight:bold; font-size:30px; line-height:30px; ">[ MYPAGE ]</font>
					<font style="font-weight:bold; font-size:12px; line-height:30px; ">    마이페이지로 돌아가기  </font>
				</a>
			</div>
		</div>	
	</div>
</div>

<!-- footer -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="footer" value="mypage"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>




</body>
</html>