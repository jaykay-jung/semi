<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--<title>조회중인 상품 명칭을 입력</title>-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

#hoverobject img {
	width : 20%;
 	height: 20%;
	}

#hoverobject img:hover {
	}
	
	
#hoverpoint {
	position: relative;
	}

#productname { 
	border : 1px solid black; 
	text-align : center; 
	padding:15px;
	}
	
#productinfo {	
	font-size:12px;
	padding:10px;
	}

#productoption {
   font-size:12px;
    width: 100%;
    border-top: 1px solid grey;
    padding: 10px;
  }
#priceandquantity{
	border-top: 1px solid black;
    border-bottom: 1px solid grey;
    padding: 10px;
	}

.btn-dark{width: 100%; margin-top:10px;}
.btn-outline-dark{width: 100%; margin-top:10px;}
.btn-outline-danger{width: 100%; margin-top:10px; margin-bottom:10px;}

#movingfunction a {color: #999; height: 45px;}
	
</style>

</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="flowerdetail" />
</jsp:include>

<div class="container">
   	<div class="row" style="border-bottom:1px solid grey; padding-bottom:20px; margin-bottom:20px;">
   		<div class="col">
   	   		<div id="big-image-box">
   	   			<img id="i1" src="images/category-detail/Sample1_1.jpg">
   	   		</div>
   	   		<div id="hoverobject" >
   	   			<img id="i1" src="images/category-detail/Sample1_1.jpg"> <!--sample image1입력-->
   	   			<img id="i2" src="images/category-detail/Sample1_2.jpg"> <!--sample image2입력-->
   	   			<img id="i3" src="images/category-detail/Sample1_3.jpg"> <!--sample image3입력-->
   	   			<img id="i4" src="images/category-detail/Sample1_4.jpg"> <!--sample image4입력-->
   	   		</div>
   	   	</div>
   	   	
   	   	<script>
		    function changeImage(event) {
		        let imgEl = event.target;
		
		        let imagePath = imgEl.getAttribute("src");
		       			
		        let gallaryImgEl = document.querySelector("#big-image-box img");
		        gallaryImgEl.setAttribute("src", imagePath);
		    }
		</script>
   		
   		<div class="col">
   			<div id="productname">
   			<h6><strong>고백 해바라기 꽃다발 생화</strong></h6> <!--  &nbsp;<h6>고백 해바라기 꽃다발 생화</h6> -->
   			</div>
   			
   			<div id="productinfo">
   				<table style="width:100%">
	    			<tr>
	    				<th>&nbsp;</th>
	    				<th>&nbsp;</th>
	    			</tr>
	    			
		    		<tr>
		        		<td>소비자가</td>
		        		<td><del>35000원</del></td>
		        		<td></td>
		        		
		    		</tr>
			    	<tr>
		        		<td><strong>판매가</strong></td>
		        		<td><strong>22900원</strong></td>
		        		
		    		</tr>
		    		<tr>
		        		<td>적립금</td>
		        		<td><img src="images/category-detail/card.gif">229원</td>
		        		
		    		</tr>
					<tr>
		        		<td>상품번호</td>
		        		<td>testNum</td>
		        	
		    		</tr>
		    		<tr>
		        		<td>국내해외배송</td>
		        		<td>국내배송</td>
		        	
		    		</tr>
		    		<tr>
		        		<td>배송방법</td>
		        		<td>택배</td>
		        	
		    		</tr>
		    		<tr>
		        		<td>배송비</td>
		        		<td>3000원</td>
	        	
	    			</tr>
	    			<tr>
	        			<td>SNS 상품홍보</td>
	        			<td><a href="https://ko-kr.facebook.com/"><img src="images/category-detail/Sns1.jpg"></a></td>
	        		</tr>
				</table>
   			</div>
   			
   			<div id="productoption">
   				<table style="width:100%">
   					<tr>
   						<td>희망수령일(월/일/형식)[선택]</td>
   						<td>&nbsp;<input type="text"></td>
   					</tr>
   					<tr>
   						<td>편지</td>
   						<td></td>
   					</tr>
   					<tr>
   						<td>화병</td>
   						<td></td>
   					</tr>	
   					<tr>
	   					<td style="color:grey"><font size="1">(최소주문수량 1개 이상)</font></td>
	   					<td></td>
	   				</tr>
	   				<tr>
	   					<td>&nbsp;</td>
	   				</tr>
	   				</table>
	   		</div>
	   			
	   		<div id=productselected>
	   			<table style="width:100%">
	   				<tr>
	   					<td colspan="3"><font size="1">&nbsp;위 옵션박스를 선택하시면 아래에 상품이 추가됩니다.</font></td>
	   				</tr>
	   				<tr>
	   					<td><!-- 선택된 상품 정보 출력할 란 --></td>
	   					<td></td>
	   					<td></td>
	   				</tr>
	   			</table>
	   		</div>
	   		
	   		<div id="priceandquantity">
	   			<table style="width:100%">
	   				<tr>
	   					<td></td>
	   					<td></td>
	   				</tr>
	   				<tr>
	   					<td><font size="2"><strong>총 상품금액</strong>(수량):</font></td>
	   					<td colspan="2"><font size=2><strong><!--선택된 상품가격--></strong>(<!--선택된 상품의 수-->개)</font></td>
	   				</tr>	
	   			</table>
	   		</div>
	   		
	   		<div id="buttonlist">
	   			<a href="orderform.jsp"><button class="btn btn-dark">바로구매</button></a>
	   			<a href="<!--cart.jsp -->"><button class="btn btn-outline-dark">장바구니</button></a>
	   			<a href="<!--cart.jsp -->"><button class="btn btn-outline-danger">♥ wish</button></a>
	   		</div>
   					
   		</div>
   	</div>
   	
   	<div id="movingfunction">
		<ul class="nav justify-content-start">
  			<li class="nav-item">
    			<a class="nav-link" href="#DETAIL">DETAIL</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="">WITH ITEM</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="">REVIEW</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="">Q&A</a>
  			</li>
		</ul>
	</div>
	
	<div id="DETAIL">
		<img src="images/category-detail/CommonDetail1.png">
		<img src="images/category-detail/CommonDetail2.png">
		<img src="images/category-detail/CommonDetail3.jpg">
		<img src="images/category-detail/Sample1_1.jpg"> <!-- 추후에 조회중인 제품의 이미지에 해당하는 값이 들어가도록 설정 -->
		<img src="images/category-detail/CommonDetail4.png">
	</div>
</div>
   	   		
   	   		
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="flowerdetail"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>