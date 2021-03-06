<%@page import="vo.Review"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.Qa"%>
<%@page import="java.util.List"%>
<%@page import="dao.QaDao"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
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
#hoverpoint img {
	min-width: 500px;
	max-width: 500px;
 	min-height: 500px;
 	max-height: 500px;
}

#hoverobject img {
	width : 20%;
	height: 20%;
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

#optioninfo {
	font-size:12px;
	padding: 10px;
	border-top: 1px solid #e9e9e9;
    border-bottom: 1px solid grey;
  
}

#quantitycontrol{
    border-bottom: 1px solid grey;
    margin-top : 20px;
    font-size: 13px;
	}

#priceandquantity{
	border-top: 1px solid black;
    border-bottom: 1px solid #e9e9e9;
    padding: 10px;
    margin-bottom:10px;
    
	}
		
.btn-outline-secondary{font-size: 12px; }
.btn-dark{margin-top:10px;}
.btn-outline-dark{margin-top:10px;}
.btn-outline-danger{margin-top:10px; margin-bottom:10px;}


#movingfunctionR a {color: black; font-size: 12px;}
#movingfunctionD a {color: black; font-size: 12px;}
#movingfunctionW a {color: black; font-size: 12px;}
#movingfunctionQ a {color: black; font-size: 12px;}

	
#REVIEW th{
	font-size : 12px;
	border-bottom: 1px solid black;
	}
	
#QNA th{
	font-size : 12px;
	border-bottom: 1px solid black;
	}	

#review-paging li {margin: 0 10px;}

#review {color: #000;}

#reviewlist a {text-decoration: none; color: #000;}
</style>



</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="flowerdetail" />
</jsp:include>

<div class="container">
   	<div class="row" style="border-bottom:1px solid grey; padding-bottom:20px; margin-bottom:20px;">
   		<div class="col">
   	   		<div id="hoverpoint">
   	   			<img src="images/category-detail/Sample1_1.jpg" >
   	   		</div>
   	   		<div id="hoverobject" onmousemove="changeImage(event);"><!-- onmouseout사용해서 위치했던 이미지에서 벗어난 경우 마지막 이미지 표현하는 코드 구현해야 함 -->
   	   			<img src="images/category-detail/Sample1_1.jpg"> <!--sample image1입력-->
   	   			<img src="images/category-detail/Sample1_2.jpg"> <!--sample image2입력-->
   	   			<img src="images/category-detail/Sample1_3.jpg"> <!--sample image3입력-->
   	   			<img src="images/category-detail/Sample1_4.jpg"> <!--sample image4입력-->
   	   		</div>
   	   	</div>
   	   	
   	   	<script>
		    function changeImage(e) {
		        let imgEl = e.target;
		
		        let imagePath = imgEl.getAttribute("src");
		       			
		        let gallaryImgEl = document.querySelector("#hoverpoint img");
		        gallaryImgEl.setAttribute("src", imagePath);
		    }
		   
		</script>
   		
   		<div class="col">
   		
   		<%
			// 요청파라미터에서 상품번호 조회하기
			int productNo = Integer.parseInt(request.getParameter("productNo"));
			
			// 해당 상품번호로 정보 조회하기
			ProductDao productDao = ProductDao.getInstance();
			Product product = productDao.getProductByNo(productNo);
			
			if (product == null) {
				throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
			}
		%>
		
   			<div id="productname">
   			<h6><strong><%=product.getName() %></strong></h6> 
   			</div>
   			
   			<div id="productinfo">
   				<table class="table table-borderless">
	    			<tr>
	    				<th>&nbsp;</th>
	    				<th>&nbsp;</th>
	    			</tr>
	    			
		    		<tr>
		        		<td>소비자가</td>
		        		<td><del><%=product.getCustomerPrice() %> 원</del></td>
		        		<td></td>
		        		
		    		</tr>
			    	<tr>
		        		<td><strong>판매가</strong></td>
		        		<td><strong><span id="product-price"><%=product.getSellPrice() %></span> 원</strong></td>
		        		
		    		</tr>
		    		<tr>
		        		<td>적립금</td>
		        		<td><img src="images/category-detail/card.gif"><%=product.getDepositPoint() %> 원</td>
		        		
		    		</tr>
					<tr>
		        		<td>상품번호</td>
		        		<td><%=product.getNo() %></td>
		        	
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
		        		<td><%=product.getDeliveryFee() %>원</td>
	        	
	    			</tr>
	    			<tr>
	        			<td>SNS 상품홍보</td>
	        			<td>
	        			<a href="https://ko-kr.facebook.com/"><img src="images/category-detail/Sns1.jpg"></a>
	        			<a href="https://twitter.com/i/flow/login"><img src="images/category-detail/Sns2.jpg"></a>
	        			</td>
	        		</tr>
				</table>
   			</div>
   			
   			<div id="optioninfo">
   			 <div style="color:grey;">(최소주문수량 1개 이상)</div>
   			 <div>&nbsp;</div>
   			 <div>&nbsp;수량을 선택해주세요.</div>
   			</div>
   			<!-- 상품 정보 출력 -->	
	   		<div id="quantitycontrol">
	   			<table style="width:100%">
	   				<tr>
	   					<td><%=product.getName() %></td>
	   					<td><input type="number" id="quantity" min="1" max="10" value="1" placeholder="수량"></td>
	   					<td><button type="button" onclick="caculation();">변경</button></td>
	   				</tr>
	   				<tr>
	   					<td>&nbsp;</td>
	   					<td>&nbsp;</td>
	   					<td>&nbsp;</td>
	   				</tr>
	   			</table>
	   		
	   	<!-- 선택된 상품 정보, 수량, 가격 출력 -->
	   		<div id="priceandquantity">
	   			<table style="width:100%">
	   				<tr>
	   					<td></td>
	   					<td></td>
	   				</tr>
	   				<tr>
	   					<td><font size="2"><strong>총 상품금액</strong>(수량):</font></td>
	   					<td colspan="2"><font size=2><strong><span id="total-price"><%=product.getSellPrice() %></span>원</strong>(<span id="selected-quantity">1</span>개)</font></td>
	   				</tr>	
	   			</table>
	   		</div>
	   		
	   		
	   		
	   		<div id="buttonlist">
	   			<a href="order/form.jsp?productNo=<%=product.getNo() %>&quantity=1"><button class="btn btn-dark" style="width: 100%;">바로구매</button></a>
	   			<a href="cart/add.jsp?productNo=<%=product.getNo() %>"><button class="btn btn-outline-dark" style="width: 100%;">장바구니</button></a>
	   			<a href="mypage/wishlist/add.jsp?productNo=<%=product.getNo() %>"><button class="btn btn-outline-danger" style="width: 100%;">♥ wish</button></a>
	   		</div>
   					
   		</div>
   	</div>
   	
   	<div id="movingfunctionR">
		<ul class="nav justify-content-start">
  			<li class="nav-item">
    			<a class="nav-link" href="#DETAIL">DETAIL</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="#REVIEW"><strong>REVIEW</strong></a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="#QNA">Q&A</a>
  			</li>
		</ul>
	</div>
	
	<%
	
	int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	
	// 전체 데이터 갯수 조회
	int totalRows = reviewDao.getTotalRows();
	if (keyword.isEmpty()) {
		totalRows = reviewDao.getTotalRows();
	} else {
		totalRows = reviewDao.getTotalRows(keyword);
	}
	
	// 페이징처리에 필요한 정보 제공 객체
	Pagination pagination = new Pagination(totalRows, currentPage);
	
	// 페이지 번호에 맞는 데이터 조회
	List<Review> reviewList = null;
	if(keyword.isEmpty()) {
		reviewList = reviewDao.getReviews(pagination.getBeginIndex(), pagination.getEndIndex());
	} else {
		reviewList = reviewDao.getReviews(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
	}
	
	%>
	
	<!-- 특정 상품에 대한 리뷰, for문으로 출력하기, 페이징 처리하기 -->
	<div id="REVIEW" style="margin-top:20px;">
		<table class="table" style="color:black;">
				<colgroup>
					<col width="10%">
					<col width="60%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<tr>
					<th>번호</th>
					<th style="text-align:center;">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					
				</tr>
				<tr style="font-color:black;">
				<%
					for(Review review : reviewList) {
				%>
					<td style="font-size: 14px; color:black;"><%=review.getNo() %></td>
					<td style="font-size: 14px; color:black;"><a id="review-title" href="reviewdetail.jsp?no=<%=review.getNo() %>"><%=review.getTitle() %></a></td>
					<td style="font-size: 14px; color:black;"><%=review.getUser().getName() %></td>
					<td style="font-size: 14px; color:black;"><%=review.getCreatedDate() %></td>
					
				</tr>
				<%
				}
				%>
		</table>
		<div style="text-align:end">
				<a href="reviewform.jsp"><button class="btn btn-dark" style="width: 12%;">WRITE</button></a>
				<a href="reviewlist.jsp"><button class="btn btn-secondary" style="width: 12%;">MORE</button></a> 
		</div>
		
		<div class="row mb-3">
		<div class="col-12">
		
			 <nav aria-label="pagenavigation">
	  			<ul class="pagination justify-content-center" id="review-paging" style="color:black;">
		 			<li class="page-item" style="color:black;">
		 				<a  style="color:black;" class="<%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="reviewlist.jsp?page=<%=pagination.getCurrentPage() - 1 %>">&lt;</a>
		 			</li>
		 		<%
		 			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		 		%>
		 			<li class="page-item">
		 				<a  style="color:black;" class="<%=pagination.getCurrentPage() == num ? "active" : "" %>" href="reviewlist.jsp?page=<%=num %>"><%=num %></a>
		 			</li>
		 		<%
		 			}
		 		%>
		 			<li class="page-item">
		 				<a style="color:black;" class="<%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="reviewlist.jsp?page=<%=pagination.getCurrentPage() + 1 %>">&gt;</a>
		 			</li>
		 		</ul>
			</nav>
		</div>
	</div>
	</div>
	
	
	<div id="movingfunctionD">
		<ul class="nav justify-content-center">
  			<li class="nav-item">
    			<a class="nav-link" href="#DETAIL"><strong>DETAIL</strong></a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="#REVIEW">REVIEW</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="#QNA">Q&A</a>
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
	
	<div id="movingfunctionQ">
		<ul class="nav justify-content-center">
  			<li class="nav-item">
    			<a class="nav-link" href="#DETAIL">DETAIL</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="#REVIEW">REVIEW</a>
  			</li>
  			<li class="nav-item">
    			<a class="nav-link" href="#QNA"><strong>Q&A</strong></a>
  			</li>
		</ul>
	</div>
	
	
	
	<!-- 특정 상품에 대한 문의, for문으로 출력하기, 페이징 처리하기 -->
	
	<%
	/*
		int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
		int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
		
		QaDao qaDao = QaDao.getInstance();
		
		//Qa qa = qaDao.getQaByNo(qaNo);
		// 전체 데이터 갯수 조회
		int totalRows = qaDao.getTotalRows(productNo);
		
		// 페이징처리에 필요한 정보 제공 객체
		Pagination pagination = new Pagination(rows, totalRows, currentPage);
		
		// 페이지 번호에 맞는 데이터 조회
		List<Qa> qaList = qaDao.getQas(pagination.getBeginIndex(), pagination.getEndIndex(), productNo);
	*/	
	%>
	<div id="QNA" style="margin-bottom:20px;">
		<table class="table">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th style="text-align:center;">제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<%
					//for (Qa qa : qaList) {
				%>	
				<tr>
					<td></td>
					<td>&nbsp;</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			
		</table>
		<div style="text-align:end;">
				<a href="qa/qaform.jsp"><button class="btn btn-dark" style="width: 12%;">WRITE</button></a>
				<a href="qa/qalist.jsp"><button class="btn btn-secondary" style="width: 12%;">MORE</button></a>  
		</div>
	<div class="row mb-3">
		<div class="col-12">
		
			 <nav aria-label="pagenavigation">
	  			<ul class="pagination justify-content-center">
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="qalist.jsp?page=<%=pagination.getCurrentPage() - 1 %>">&lt;</a>
		 			</li>
		 		<%
		 			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == num ? "active" : "" %>" href="qalist.jsp?page=<%=num %>"><%=num %></a>
		 			</li>
		 		<%
		 			}
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="qalist.jsp?page=<%=pagination.getCurrentPage() + 1 %>">&gt;</a>
		 			</li>
		 		</ul>
			</nav>
		</div>
	</div>
   	   		
   	   		
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="flowerdetail"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function caculation() {
		let selectedItem = '<%=product.getName() %>';
		
		let quantity = document.querySelector("#quantity").value;
		let price = document.querySelector("#product-price").textContent;
		
		let totalPrice = quantity*price;
		
		document.querySelector("#selected-quantity").textContent = quantity ;
		document.querySelector("#total-price").textContent = totalPrice;
	}
</script>	
</body>
</html>