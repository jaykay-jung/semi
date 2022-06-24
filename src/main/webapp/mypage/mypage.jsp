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
				<font><strong>마이페이지</strong></font>
			</div><div style="clear:both:"></div>
    	</div>
		<hr style="border: gray 0.7px dotted;">	
  	</div>
  	
<!-- 회원이름과 등급 -->				
	<div style="margin:20px 5px; border:1px solid gainsboro; ">
		<div class="row" style="margin:10px; height:auto;">
        	<div class="col">
        		<div style="float:left; width:90px; height:80px; line-height:30px; border-right:1px solid gainsboro;">
        			<img src="../images/mypage/login-icon.png" width="73">
				</div>
				<div style="float:left; width:80%; margin:30px 10px; color:gray;">	
					<font> 저희 쇼핑몰을 이용해주셔서 감사합니다.</font>
					<font><strong> 누리봄 </strong></font>
					<font>님은</font>
					<font><strong>[일반회원]</strong></font>
					<font>이십니다.</font>
				</div><div style="clear:both:"></div>
			</div>
    	</div>
	</div>

<!-- 회원적립금내역 -->
	<div style="margin:20px 5px; border:5px solid gainsboro; height:auto; line-height:180%;">
		<div class="row" style="margin:0px 5px; height:100px;">
			<div class="col" style="float:left; width:50%; border-right:1px solid gainsboro;">
	        	<div style="float:left; width:60%; margin:15px;margin-top:25px; margin-left:25px;">
					<font>>가용적립금</font>
					<br><font>>사용적립금</font>
				</div>
	        	<div style="float:left; width:20%;margin-top:25px;">
					<font style="color:#008bcc;">1000 원</font>
					<br><font>123456 원</font>
				</div>
	        	<div style="float:right; width:10%;margin-top:25px;">
					<a href="point/historylist.jsp" style="color:gray; text-decoration:none;"><button type="button" class="btn btn-outline-secondary btn-sm">조회</button></a>
				</div>
			</div>
			<div class="col" style="float:left; width:50%;">	
	        	<div style="float:left; width:60%; height:auto; margin-top:25px; margin-left:25px;">
					<font>>총적립금</font>
					<br><font>>총주문</font>
					
				</div>
	        	<div style="float:left; width:30%;margin-top:25px;">
					<font>123456 원</font>
					<br><font>123456 원</font>
				</div>
			</div>
		</div>
	</div>
	
<!-- 회원주문처리현황 -->	
	<div style="border:1px solid; margin:20px 5px;"> 	
		<div class="row" style="margin:0; background-color:#f0f0f0; ">
        	<div style="height:auto; line-height:30px; margin:5px;">
				<font style="font-weight:bold; font-size:15px;">나의 주문처리 현황</font>
				<font style="color:gray; font-size:10px;">(최근</font>
				<font style="color:black; font-size:10px">3개월</font>
				<font style="color:gray; font-size:10px;">기준)</font>
			</div>				
    	</div>
		<div class="row" style="margin:0; border-top:1px solid gainsboro;">
			<div class="col" style="height:100px;text-align:center; ">	
    	    	<div style="float:left; width:20%; margin-top:10px; border-right:1px dotted gainsboro;">
					<font style="font-weight:bold; ">입금전</font>
					<br><font style="font-weight:bold; font-size:28px;">0</font>
				</div>
    	    	<div style="float:left; width:20%; margin-top:10px; border-right:1px dotted gainsboro;">
					<font style="font-weight:bold; ">배송준비중</font>
					<br><font style="font-weight:bold; font-size:28px;">0</font>
				</div>
    	    	<div style="float:left; width:20%; margin-top:10px; border-right:1px dotted gainsboro;">
					<font style="font-weight:bold; ">배송중</font>
					<br><font style="font-weight:bold; font-size:28px;">0</font>
				</div>
    	    	<div style="float:left; width:20%; margin-top:10px; border-right:1px dotted gainsboro;">
					<font style="font-weight:bold; ">배송완료</font>
					<br><font style="font-weight:bold; font-size:28px;">0</font>
				</div>
    	    	<div style="float:left; width:20%; margin-top:13px;">
					<font>· 취소 : </font><font>1</font>
					<br><font>· 교환 : </font><font>1</font>
					<br><font>· 반품 : </font><font>1</font>
				</div>
    		</div>
    	</div>
	</div>
	
<!-- 상세페이지 -->
	<div style="border-top:4px solid; border-bottom:4px solid; margin:30px 5px;">
	
		<div class="row" style="margin:0px 5px; height:120px;">
			<div class="col">
        		<div style="float:left; width:40%; height:auto; margin:25px 10px; ">
        			<a class="nolinelink" href="../order/list.jsp">
        				<font style="font-weight:bold; font-size:20px; line-height:30px; ">order </font>
						<font>  주문내역  </font>
					</a>
					<a class="over" href="../order/list.jsp">
						<br><font style="color:gray;">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</font>
						<br><font style="color:gray;">비회원의 경우, 11주문서의 주문번호와 비밀번호로 주문조회가 가능합니다.</font>
					</a>
				</div>
				<div style="float: right; width:auto; height:auto; text-align:center; margin-top:20px;">	
				    <a class="nolinelink" href="../order/list.jsp"><img src="../images/mypage/order.png" height="80">></a>
				    
				</div><div style="clear:both:"></div>
			</div>	
    	</div>
		<div class="row" style="margin:0px 5px; height:120px;">
			<div class="col" style="border-top:1px solid gainsboro;">
        		<div style="float:left; width:40%; height:auto;margin:25px 10px;">
					<a class="nolinelink" href="modifyinfo.jsp">
						<font style="font-weight:bold; font-size:20px; line-height:30px; ">profile </font>
						<font>  회원정보  </font>
					</a>
					<a class="over" href="modifyinfo.jsp">
						<br><font style="color:gray;">회원이신 고객님의 개인정보를 관리하는 공간입니다.</font>
						<br><font style="color:gray;">개인정보를 최신 정보로 유지하시면 보다 간편히 쇼핑을 즐기실 수 있습니다.</font>
					</a>
				</div>
				<div style="float: right; width:auto; height:auto; text-align:center; margin-top:20px;">	
				   <a class="nolinelink" href="modifyinfo.jsp"><img src="../images/mypage/information.png" height="80">></a>
				</div><div style="clear:both:"></div>
			</div>	
    	</div>
		<div class="row" style="margin:0px 5px; height:120px;">
			<div class="col" style="border-top:1px solid gainsboro;">
        		<div style="float:left; width:40%; height:auto; margin:25px 10px; ">
					<a class="nolinelink" href="wishlist/list.jsp">
						<font style="font-weight:bold; font-size:20px; line-height:30px; ">wishlist </font>
						<font>  관심상품  </font>
					</a>
					<a class="over" href="wishlist/list.jsp">
						<br><font style="color:gray;">관심상품으로 등록하신 상품의 목록을 보여드립니다.</font>
						<br><font style="color:gray;"> </font>
					</a>
				</div>
				<div style="float: right; width:auto; height:auto; text-align:center; margin-top:20px;">	
				    <a class="nolinelink" href="wishlist/list.jsp"><img src="../images/mypage/wishlist.png" height="80">></a>
				</div><div style="clear:both:"></div>
			</div>	
    	</div>
		<div class="row" style="margin:0px 5px; height:120px;">
			<div class="col" style="border-top:1px solid gainsboro;">
        		<div style="float:left; width:40%; height:auto; margin:25px 10px; ">
					<a class="nolinelink" href="point/historylist.jsp">
						<font style="font-weight:bold; font-size:20px; line-height:30px; ">mileage </font>
						<font>  적림급  </font>
					</a>
					<a class="over" href="point/historylist.jsp">
						<br><font style="color:gray;">적립금은 상품 구매 시 사용하실 수 있습니다.</font>
						<br><font style="color:gray;">적립된 금액은 현금으로 환불되지 않습니다.</font>
					</a>
				</div>
				<div style="float: right; width:auto; height:auto; text-align:center; margin-top:20px;">	
				    <a class="nolinelink" href="point/historylist.jsp"><img src="../images/mypage/mileage.png" height="80">></a>
				</div><div style="clear:both:"></div>
			</div>	
    	</div>
		<div class="row" style="margin:0px 5px; height:120px;">
			<div class="col" style="border-top:1px solid gainsboro;">
        		<div style="float:left; width:40%; height:auto; margin:25px 10px; ">
					<a class="nolinelink" href="myreview.jsp">
						<font style="font-weight:bold; font-size:20px; line-height:30px; ">board </font>
						<font>  게시물 관리  </font>
					</a>
					<a class="over" href="myreview.jsp">
						<br><font style="color:gray;">고객님께서 작성하신 게시물을 관리하는 공간입니다.</font>
						<br><font style="color:gray;">고객님께서 작성하신 글을 한눈에 관리하실 수 있습니다.</font>
					</a>
				</div>
				<div style="float: right; width:auto; height:auto; text-align:center; margin-top:20px;">	
				    <a class="nolinelink" href="myreview.jsp">
				    	<img src="../images/mypage/review.png" height="80">>
				    </a>
				</div><div style="clear:both:"></div>
			</div>	
    	</div>
		<div class="row" style="margin:0px 5px; height:120px;">
			<div class="col" style="border-top:1px solid gainsboro;">
        		<div style="float:left; width:40%; height:auto; margin:25px 10px; ">
					<a class="nolinelink" href="address/list.jsp">
						<font style="font-weight:bold; font-size:20px; line-height:30px; ">address </font>
						<font>  배송 주소록 관리  </font>
					</a>
					<a class="over" href="address/list.jsp">
						<br><font style="color:gray;">자주 사용하는 배송지를 등록하고 관리하실 수 있습니다..</font>
						<br><font style="color:gray;"> </font>
					</a>
				</div>
				<div style="float: right; width:auto; height:auto; text-align:center; margin-top:20px;">	
				    <a class="nolinelink" href="address/list.jsp"><img src="../images/mypage/address.png" height="80">></a>
				</div><div style="clear:both:"></div>
			</div>	
    	</div>
	</div>	
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="mypage"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>