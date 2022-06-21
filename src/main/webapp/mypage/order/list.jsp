<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PLANANT</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
	#p-title {border-bottom: solid 2px rgba(0, 0, 0, 0.15); font-size: larger;}
	#div-h {padding-top: 20px; padding-bottom: 20px;}
    #h_table {border-style: solid; border-width: 7px;}
   	#h1 {text-align: center; vertical-align: middle; table-layout: fixed; width: 150px;}
   	.form-select {width: 170px;}
</style>
<body>
<!-- header -->
<jsp:include page="../../common/nav.jsp">
	<jsp:param name="name" value="order"/>
</jsp:include>

<div class="container">

   <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	<div>
        <p id="p-title"><strong>주문 조회</strong></p>
    </div>
    <div id="div-h">
        <table id="h_table" class="table">
            <tr>
            	<td id="h1">
            		<select class="form-select form-select-sm" aria-label=".form-select-sm">
					  <option selected>전체 주문처리상태</option>
					  <option value="1">입금전</option>
					  <option value="2">배송완료</option>
					  <option value="3">취소</option>
					  <option value="4">반품</option>
					</select>
            	</td>
            	<td>날짜</td>
           	</tr>
        </table>
    </div>
    
</div>

<!-- footer -->
<jsp:include page="../../common/footer.jsp">
	<jsp:param name="footer" value="order"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>