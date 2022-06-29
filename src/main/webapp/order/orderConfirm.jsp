<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//로그인 확인
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	// 파라미터
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	OrderItem orderItem = new OrderItem();
	
	// set
	OrderDao orderDao = OrderDao.getInstance();
	Order order = orderDao.getOrderByOrderNo(orderNo);
	orderItem.setOrder(order);
	
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(productNo);
	orderItem.setProduct(product);
	
	// OrderItem에 저장
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	orderItemDao.insertOrderItem(orderItem);

	// 주문 완료. 장바구니 아이템 삭제 	
	response.sendRedirect("updatePoint.jsp?userNo="+user.getNo());
%>