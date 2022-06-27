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
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	int usedPoint = Integer.parseInt(request.getParameter("usedPoint"));
	int totalpay = Integer.parseInt(request.getParameter("totalpay"));
	int depositPoint = Integer.parseInt(request.getParameter("depositPoint"));
	String payType = request.getParameter("payType");
	int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
	// 주소
	AddressDao addressDao = AddressDao.getInstance();
	Address address = addressDao.getAddressByUserNo(user.getNo());
	// 상품
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(productNo);
	
	Order order = new Order();
	order.setStatus("결제완료");
	order.setTotalPrice(totalPrice);
	order.setUsedPoint(usedPoint);
	order.setTotalpay(totalpay);
	order.setDepositPoint(depositPoint);
	order.setPayType(payType);
	order.setUser(user);
	order.setAddress(address);
	order.setProduct(product);
	order.setOrderQuantity(orderQuantity);
	
	// 주문정보 저장 메소드 실행
	OrderDao orderDao = OrderDao.getInstance();
	orderDao.insertOrder(order);
	
	// 결제완료 페이지
	response.sendRedirect("deleteCartItem.jsp");
%>