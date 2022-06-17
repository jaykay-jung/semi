<%@page import="dao.OrderItemDao"%>
<%@page import="vo.OrderItem"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<jsp:param name="menu" value="order"/>
</jsp:include>
<div class="container">
	<div class="row">
		<div class="col">
			<h1 class="fs-4 border p-2">내 주문내역</h1>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<%
				// HttpSession객체에 저장된사용자 정보 조회
				User user = (User) session.getAttribute("LOGINED_USER");
				if (user == null) {
					response.sendRedirect("../loginform.jsp?fail=deny");
					return;
				}
				
				// 로그인한 사용자의 주문내역 정보를 조회하기
				OrderItemDao orderItemDao = OrderItemDao.getInstance();
				List<OrderItem> orderItemList = orderItemDao.getOrderItemsByUserNo(user.getNo());
			%>
				<p>주문내역을 확인하세요</p>
				<table class="table">
				    <colgroup>
						<col style="width:135px;"/>
						<col style="width:93px;"/>
						<col style="width:auto;"/>
						<col style="width:61px;"/>
						<col style="width:111px;"/>
						<col style="width:111px;"/>
						<col style="width:111px;"/>
					</colgroup>
				</table>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>이미지</th>
						<th>상품정보</th>
						<th>수량</th>
						<th>상품구매금액</th>
						<th>주문처리상태</th>
						<th>취소/교환/반품</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				<%
					if (orderItemList.isEmpty()) {
				%>		
					<tr>
						<td colspan="8" class="text-center"><strong>주문 내역이 없습니다.</strong></td>
					</tr>	
				<%		
					} else {
						for (OrderItem orderItem : orderItemList) {
				%>		
							
					<tr>
						<td><input type="checkbox" /><%=orderItem.getNo() %></td>
						<td><a href="../product/detail.jsp?productNo=<%=orderItem.getProduct().getNo()%>"></a></td>
						<td><a href="../product/detail.jsp?productNo=<%=orderItem.getProduct().getNo()%>"><%=orderItem.getProduct().getDescription() %></a></td>
						<td><span class="text-danger"><strong><%=orderItem.getQuantity()%></strong>개</span></td>
						<td><span class="text-danger"><strong><%=orderItem.getPrice()%></strong>원</span></td>
						<td><span class="text-danger"><strong>배송중</strong></span></td>
					</tr>
					
				<%
						}
					}
				%>
				</tbody>
		</div>
	</div>
   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>