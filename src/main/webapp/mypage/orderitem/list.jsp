<%@page import="vo.OrderItem"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
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
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../../common/nav.jsp">
	<jsp:param name="menu" value="orderitem"/>
</jsp:include>
<div class="container">
<%
	String fail = request.getParameter("fail");
%>
<%
	if ("invaild".equals("fail")) {
%>		
	<div class="alert alert-danger">
		<strong>오류</strong> 유효한 요청이 아닙니다.
	</div>	
<%		
	} else if ("invaild".equals("deny")) {		
%>
	<div class="alert alert-danger">
		<strong>거부</strong> 다른 사용자의 주문내역을 조회하실 수 없습니다.
	</div>
<%
	}
%>
   <div class="row">
   		<div class="col">
   			<h1 class="fs-4 border p-2">주문 조회</h1>
   		</div>
   		<form method="GET" id="orderItemList" class="orderItemList" >
   		<p>검색기간 설정</p>
   			<div class="stateSelect">
   				<select id="orders-status" name="orders-status" class="select">
   					<option selected="selected">전체 주문처리상태</option>
   					<option value="1">입금전</option>
   					<option value="2">배송중</option>
   					<option value="3">배송완료</option>
   					<option value="4">취소</option>
   					<option value="5">반품</option>
   				</select>
   			</div>
<%
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
	
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	
	int totalRows = orderItemDao.getTotalRows();
	
	Pagination pagination = new Pagination(totalRows, currentPage);
	
	List<OrderItem> orderItemList = orderItemDao.getOrderItems(pagination.getBeginIndex(), pagination.getEndIndex());
%>
   		</form>
   		<div class="title">
   			<h3>주문 상품 정보</h3>
   		</div>
   		<table>
   			<p>주문 상품 정보</p>
   			<colgroup>
	   			<col width="10%" />
				<col width="*" />
				<col width="15%" />
				<col width="10%" />
				<col width="16%" />
				<col width="19%" />
				<col width="11%" />
   			</colgroup>
	   		<thead>
	   			<tr>
	   				<th>주문일자</th>
	   				<th>이미지</th>
	   				<th>상품정보</th>
	   				<th>수량</th>
	   				<th>상품구매금액</th>
	   				<th>주문처리상태</th>
	   				<th class="text-end pe-4">취소/교환/반품</th>
	   				<th class="text-center"></th>
	   			</tr>
	   		</thead>
	   		<tbody class="table-group-divider">
	   		<%
	   			if (orderItemList.isEmpty()) {
	   		%>
	   			<tr>
	   				<td colspan="10" class="text-danger"><strong>주문내역이 없습니다.</strong></td>
	   			</tr>
	   		<%		
	   			} else {
	   				for (OrderItem orderItem : orderItemList) {
	   					
	   		%>
	   			<tr>
	   				<td><%=orderItem.getOrder().getCreatedDate() %></td>
	   				<td id="product-image"><a href="../flowerdetail.jsp?productNo="<%=orderItem.getProduct().getNo() %>"><img src="../images/category/<%=orderItem.getProduct().getImageName()%>"></a></td>
	   				<td><%=orderItem.getOrder().getDepositPoint() %></td>
	   				<td><%=orderItem.getQuantity() %></td>
	   				<td><strong><%=orderItem.getPrice() %></strong> 원</td>
	   				<td>배송준비</td>
	   			</tr>
	   		<%		
	   				}
	   			}
	   		%>
	   		</tbody>
   		</table>
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
<jsp:include page="../../common/footer.jsp">
	<jsp:param name="footer" value="notice"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>