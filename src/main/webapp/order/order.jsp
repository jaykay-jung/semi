<%@page import="vo.OrderItem"%>
<%@page import="dao.OrderItemDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Address"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.Order"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인된 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	// 요청파라미터값 가져오기
	String[] productNoValues = request.getParameterValues("productNo");
	String[] quantityValues = request.getParameterValues("quantity");
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	int usedPoint = Integer.parseInt(request.getParameter("usedPoint"));
	int totalpay = Integer.parseInt(request.getParameter("totalPay"));
	int depositPoint = Integer.parseInt(request.getParameter("depositPoint"));
	String payType = request.getParameter("payType");
	AddressDao addressDao = AddressDao.getInstance();
	Address address = addressDao.getAddressByUserNo(user.getNo());
	
	// order set
	OrderDao orderDao = OrderDao.getInstance();
	int orderNo = orderDao.getSequence();
	
	Order order = new Order();
	order.setNo(orderNo);
	order.setStatus("결제완료");
	order.setTotalPrice(totalPrice);
	order.setUsedPoint(usedPoint);
	order.setTotalpay(totalpay);
	order.setDepositPoint(depositPoint);
	order.setPayType(payType);
	order.setUser(user);
	order.setAddress(address);
	// 주문정보 저장
	orderDao.insertOrder(order);
	
	// orderItem set
	ProductDao productDao = ProductDao.getInstance();
	OrderItemDao orderItemDao = OrderItemDao.getInstance();
	
	// 주문아이템 정보 저장
	for (int i = 0; i<productNoValues.length; i++) {
		OrderItem orderItem = new OrderItem();
		int productNo = StringUtil.stringToInt(productNoValues[i]);
		Product product = productDao.getProductByNo(productNo);
		orderItem.setProduct(product);
		
		int quantity = StringUtil.stringToInt(quantityValues[i]);
		orderItem.setQuantity(quantity);
		orderItem.setOrder(order);
		orderItem.setPrice(totalpay);
		orderItemDao.insertOrderItem(orderItem);
	}
	
	// 결제완료 후 포인트 정보 업데이트
	response.sendRedirect("updatePoint.jsp?userNo="+user.getNo()+"&orderNo="+orderNo);
%>
