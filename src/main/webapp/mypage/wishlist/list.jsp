<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.WishList"%>
<%@page import="java.util.List"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("위시아이템 조회는 로그인 후 사용가능한 서비스 입니다.");
	} 
	int userNo = user.getNo();
%>  
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
<jsp:include page="/common/nav.jsp">
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


<!-- 요청파라미터에서 요청한 페이지 번호를 조회하고, 페이지번호에 맞는 목록을 출력한다.
	페이징처리에 필요한 작업을 수행한다.
-->
<%
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	
	// 위시리스트 내역을 조회한다.
	WishListDao wishListDao = WishListDao.getInstance();
	
	// 전체 데이터 갯수 조회
	int totalRows = 0;
	totalRows = wishListDao.getTotalRows(userNo);
	
	// 페이징처리에 필요한 정보를 제공하는 객체 생성
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	
	// 요청한 페이지번호에 맞는 데이터 조회하기
	List<WishList> wishList = null;
	wishList = wishListDao.getAllWishListByUserNo(userNo, pagination.getBeginIndex(), pagination.getEndIndex());

%>	



<!-- 위시리스트 목록 -->
	<form id="delete-wish" action="delete.jsp">
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
						<th><input type="checkbox" id="allCheck" ></th>
						<th>이미지</th>
						<th>상품정보</th>
						<th>판매가</th>
						<th>적립금</th>
						<th>배송구분</th>
						<th>배송비</th>
						<th>합계</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				
				<%
					if (wishList.isEmpty()) {
				%>
				
				<tr>
					<td colspan="9" class="text-center"><strong>위시리스트가 비어있습니다.</strong></td>
				</tr>
				<%
					} else {

						for (WishList item : wishList) {
				%>						
					<tr style="height:80px; border:1px solid black; margin:5%;">
						<td><input type="checkbox" name="wishNo" value="<%=item.getNo() %>"/></td>
						<td style="height:80px;"><img src="../../images/category-detail/<%=item.getProduct().getImageName() %>" ></td>
						<td style="text-align:left;"><%=item.getProduct().getName() %></td>
						<td style="text-align:right;"><%=item.getProduct().getSellPrice() %>원</td>
						<td><%=item.getProduct().getDepositPoint() %>원</td>
						<td>개별배송</td>
						<td><%=item.getProduct().getDeliveryFee() == 0 ? "무료배송" : item.getProduct().getDeliveryFee() %></td>
						<td style="text-align:right;"><%=item.getProduct().getSellPrice() %>원</td>
						<td>
							<a href="../../order/form.jsp?productNo=<%=item.getProduct().getNo() %>>"><img src="../../images/mypage/wishlist-order.png" width="89px;"></a>
							<a href="../../cart/add.jsp?productNo=<%=item.getProduct().getNo() %>"><img src="../../images/mypage/wishlist-addcart.png" width="89px;"></a>
							<a href="delete.jsp?wishNo=<%=item.getNo() %>"><img src="../../images/mypage/wishlist-delete.png" width="89px;"></a>
						</td>
					</tr>
				<%
						}
					}					
				%>									
				</tbody>
			</table>
		</div><div style="clear:both:"></div>
		
<!-- 관심상품 삭제 및 주문버튼 -->
			<div class="row">
				<div class="col">
			       	<div style="float:left; width:50%; height:40px;">
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
			</div><div style="clear:both:"></div>
		</div>
	</form>
	
<!-- 페이징처리 -->
	<div style="margin:25px 5px; height:130px; line-height:180%;">
	
		<nav aria-label="point navigation">
			<ul class="pagination pagination-sm justify-content-center" >
		  		<li class="page-item" >
		    		<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1 %>)" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		    	</li>
		    	
			<%
				for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
			%>		    	
		    	
		    	<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
		    		<a class="page-link" href="javascript:clickPageNo(<%=num %>)"><%=num %></a>
		    	</li>
			<%
				}
			%>		    	
		  		<li class="page-item">
		    		<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1 %>)" aria-label="Next">
		        		<span aria-hidden="true">&gt;</span>
		      		</a>
		    	</li>
		 	</ul>
		</nav>
	</div>
		<div class="col-4">
			<form id="search-form" class="row g-3" method="get" action="list.jsp">
				<input type="hidden" name="page" />
				<input type="hidden" name="rows" />
				<div class="col-9">
				</div>
				<div class="col-3">
				</div>
			</form>
		</div>
				
</div>

<!-- footer -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="footer" value="mypage"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">


	// id가 allcheck인 체크박스를 누르면, input type이 checkbox인 항목이 전부 선택되거나 선택해제가 된다.
	document.getElementById('allCheck').onclick = function() {
	    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
	    for (var checkbox of checkboxes) {
	        checkbox.checked = !checkbox.checked;
	    }
	}



	// 선택박스를 누르면 delete로 wishNo가 전송된다.
	function deleteAddress() {
	
		// input 속성 중 name이 wishNo인 엘리먼트를 조회해서 배열로 생성.
		// 선택한 위시아이템리스트 배열 가져와서 길이 측정
		// 아무것도 선택하지 않았다면 삭제할 상품을 선택하라는 경고가 나온다.
		let checkedLength = document.querySelectorAll("input[name=wishNo]:checked").length;
		if (checkedLength  === 0) {
			alert("삭제할 상품을 선택하세요");
			return;
		}
	
		// id가 delete-wish인것 조회한다.
		let form =	 document.getElementById("delete-wish");
		form.submit();
	
	}
	
	
	
	
	function clickPageNo(pageNo) {
		document.querySelector("input[name=page]").value = pageNo;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}
	
</script>
</body>
</html> 	