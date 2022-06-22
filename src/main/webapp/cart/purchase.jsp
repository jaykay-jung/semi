<%@page import="dao.OrderItemDao"%>
<%@page import="vo.Product"%>
<%@page import="vo.Order"%>
<%@page import="vo.OrderItem"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 사용자 인증
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("loginform.jsp?fail=deny");
		return;
	}
	
	// 상품정보 파라미터 요청
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int price = Integer.parseInt(request.getParameter("price"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	OrderItem orderItem = new OrderItem();
	orderItem.setNo(productNo);
	orderItem.setOrder(new Order());
	orderItem.setProduct(new Product());
	orderItem.setPrice(price);
	orderItem.setQuantity(quantity);
	
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	orderItemDao.insertOrderItem(orderItem);
	
	response.sendRedirect("../order/form.jsp");
%>