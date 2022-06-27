<%@page import="vo.WishList"%>
<%@page import="java.util.List"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 스타일 -->
<style type="text/css">
.vertical-align-content {display:flex; align-items:center; justify-content: center; color:white; width:150px; height:40px; margin:5px; font-size:12px;}

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
<jsp:include page="../../common/nav.jsp">
	<jsp:param name="menu" value="mypage"/>
</jsp:include>

<!-- content -->
<div class="container">
<!-- 개요 -->
	<div class="row">
		<div class="col">
        	<div style="float:left; width:300px; height:30px; line-height:30px;">
				<h6><strong>관심상품</strong></h6>
			</div>
			<div style="float: right; width:300px; height:auto; text-align:right; color:gray;">	
				<font><a class="nolinelink" href="../../home.jsp" style="color:gray;">홈</a></font>
				<font><strong>》</strong></font>
				<font><a class="nolinelink" href="../mypage.jsp" style="color:gray;">마이페이지</a></font>
				<font><strong>》</strong></font>
				<font><strong>관심상품</strong></font>
			</div><div style="clear:both:"></div>
    	</div>
		<hr style="border: gray 0.7px dotted;">	
  	</div>		

<!-- 위시리스트 목록 -->
	<div class="row">
		<div class="col">
			<table class="table" style="text-align:center; vertical-align: center; font-size:13px;">
				<colgroup>
					<col width="2%">
					<col width="8%">
					<col width="*">
					<col width="8%">
					<col width="8%">
					<col width="8%">
					<col width="8%">
					<col width="8%">
					<col width="8%">
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th style="border:1px solid red;">이미지</th>
						<th>상품정보</th>
						<th style="border:1px solid red;">판매가</th>
						<th>적립금</th>
						<th style="border:1px solid red;">배송구분</th>
						<th>배송비</th>
						<th style="border:1px solid red;">합계</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				
				<tr>
					<td colspan="9" class="text-center"><strong>위시리스트가 비어있습니다.</strong></td>
				</tr>
					
					<tr style="height:80px; border:1px solid black; margin:5%;">
						<td><input type="checkbox" /></td>
						<td style="height:80px; background-color:gold;">이미지</td>
						<td style="text-align:left;">20번 상품번호의 해바라기</td>
						<td>원</td>
						<td>198원</td>
						<td>개별배송</td>
						<td>무료</td>
						<td>합계</td>
						<td>
							<a href="../../order/form.jsp?productno=20"><img src="../../images/mypage/wishlist-order.png" width="89px;"></a>
							<a href="../../cart/add.jsp?productno=20"><img src="../../images/mypage/wishlist-addcart.png" width="89px;"></a>
							<a href="delete.jsp?wishno=20"><img src="../../images/mypage/wishlist-delete.png" width="89px;"></a>
						</td>
					</tr>				
				</tbody>
			</table>
			
<!-- 관심상품 삭제 및 주문버튼 -->
			<div class="row">
				<div class="col">
			       	<div style="float:left; border:1px solid red; width:50%; height:40px;">
						<font><strong>선택상품을</strong></font>
						<a href="delete.jsp?wishno=20&wishno=21&wishno=22"><span><img src="../../images/mypage/wishlist-delete2.png"></span></a>
						
						<a href="../../cart/add.jsp?productno=20&productno=21&productno=22"><span><img src="../../images/mypage/wishlist-addcart.png"></span></a>
					</div>
			       	<div class="vertical-align-content" style="float:right; background-color:lightgray;">
			       		<a class="nolinelink" href="delete.jsp?productno=20&productno=21&productno=22" style="color:white;">
						<font>관심상품 비우기</font>
						</a>
					</div>
					
			       	<div  class="vertical-align-content" style="float:right; background-color:black;">
			       		<a class="nolinelink" href="../../order/form.jsp?productno=20&productno=21&productno=22?" style="color:white;">
						<font>전체상품 주문</font>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


</body>
</html>