<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.CartItem"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../../loginform.jsp?fail=deny");
		return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	OrderItem orderItem = new OrderItem();
	orderItem.setNo(productNo);
	
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	orderItemDao.insertOrderItem(orderItem);
	
	response.sendRedirect("list.jsp");
%>