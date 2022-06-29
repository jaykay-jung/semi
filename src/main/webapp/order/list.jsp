<%@page import="vo.User"%>
<%@page import="vo.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PLANANT</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
	#orderlist-container {margin-bottom: 100px;}
	#orderlist-h3 {line-height: 40px; border-bottom: 1px solid #eee;}
	h3 {font-size: 18px; font-weight: bold;}
    #h-table {border-style: solid; border-width: 5px; margin-top: 20px; margin-bottom: 20px;}
   	.form-select {width: 170px;}
   	
   	#product-image img {width: 50px; height: 50px;}
   	.table tbody {font-size: 13px;}
   	th {text-align: center;}
   	td {vertical-align: middle; text-align: center;}
   	a {text-decoration: none; color: #000;}
   	#product-paging li {margin: 0 10px; margin-top: 30px; margin-bottom: 20px;}
</style>
<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">
	<jsp:param name="name" value="order"/>
</jsp:include>

<div class="container" id="orderlist-container">
<%
	String fail = request.getParameter("fail");
%>
<%
	if ("invalid".equals("fail")) {
%>
	<div class="alert alert-danger">
		<strong>오류</strong> 유효한 요청이 아닙니다.
	</div>
<%
	} else if ("deny".equals(fail)) {
%>
	<div class="alert alert-danger">
		<strong>거부</strong> 다른 사용자의 주문내역에 접근할 수 없습니다.
	</div>
<%
	}
%>
	<div class="row">
		<div class="col">
			<h3 id="orderlist-h3">주문조회</h3>
		</div>
	</div>
	<div>
	    <div>
	        <table id="h-table" class="table">
	            <tr>
	            	<td id="h1">
	            		<select class="form-select form-select-sm" aria-label=".form-select-sm" onchange="selectOrderList(this.value)">
						  <option selected>주문 조회</option>
						  <option value="1">결제완료</option>
						  <option value="2">배송완료</option>
						  <option value="3">취소</option>
						  <option value="4">반품</option>
						</select>
	            	</td>
	           	</tr>
	        </table>
	    </div>
    </div>
    <%
		int currentPage = StringUtil.stringToInt(request.getParameter("page"),1);
		int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
		String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
		
		OrderItemDao orderItemDao = OrderItemDao.getInstance();
		
		// 전체 데이터 갯수 조회
		int totalRows = orderItemDao.getTotalRows();
		
		// 페이징처리에 필요한 정보 제공 객체
		Pagination pagination = new Pagination(totalRows, currentPage);
		
		// 페이지 번호에 맞는 데이터 조회
		List<OrderItem> orderItemList = orderItemDao.getOrderItems(pagination.getBeginIndex(), pagination.getEndIndex());
	%>
	<div>
		<div>
			<table class="table">
				<colgroup>
					<col width="7%">
					<col width="7%">
					<col width="20%">
					<col width="7%">
					<col width="5%">
					<col width="7%">
					<col width="7%">
					<col width="7%">
					<col width="7%">
					<col width="7%">
					<col width="7%">
				</colgroup>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>상품이미지</th>
						<th>상품정보</th>
						<th>주문수량</th>
						<th>적립금</th>
						<th>사용적립금</th>
						<th>배송구분</th>
						<th>주문금액</th>
						<th>결제수단</th>
						<th>주문날짜</th>
						<th>수령일</th>
					</tr>
				</thead>
				<tbody>
				<%
					if (orderItemList.isEmpty()) {
				%>
					<tr>
						<td colspan="11" class="text-center"><strong>주문내역이 없습니다.</strong></td>
					</tr>
				<%
					} else {
						for(OrderItem item : orderItemList) {
				%>
							<tr>
								<td><%=item.getOrder().getNo() %></td>
								<td id="product-image"><a href="../flowerdetail.jsp?productNo=<%=item.getProduct().getNo()%>"><img src="../images/category/<%=item.getProduct().getImageName() %>"></a></td>
								<td><%=item.getProduct().getName() %></td>
								<td><%=item.getQuantity() %></td>
								<td><span><%=item.getOrder().getDepositPoint() %></span> 원</td>
								<td><span><%=item.getOrder().getUsedPoint() %></span> 원</td>
								<td>개별배송</td>
								<td><span><%=item.getPrice() %></span>원</td>
								<td><%=item.getOrder().getPayType() %></td>
								<td><%=item.getOrder().getCreatedDate() %></td>
								<td><%=item.getOrder().getReceiveDate() %></td>
							</tr>
				<%
						}
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
	 
	 <!-- 페이징 -->
	 <div class="row">
	 	<div class="col">
		 	<nav id="product-paging">
		 		<ul class="pagination justify-content-center">
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="list.jsp?page=<%=pagination.getCurrentPage() - 1 %>">&lt;</a>
		 			</li>
		 		<%
		 			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		 		%>
			 			<li class="page-item">
			 				<a class="<%=pagination.getCurrentPage() == num ? "active" : "" %>" href="list.jsp?page=<%=num %>"><%=num %></a>
			 			</li>
		 		<%
		 			}
		 		%>
		 			<li class="page-item">
		 				<a class="<%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="list.jsp?page=<%=pagination.getCurrentPage() + 1 %>">&gt;</a>
		 			</li>
		 		</ul>
		 	</nav>
	 	</div>
	 </div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="order"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>