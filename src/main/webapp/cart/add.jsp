<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.CartItem"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 세션에서 로그인된 사용자 정보 조회하기
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	// 상품번호 파라미터 요청
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// 상품정보 객체에 저장
	ProductDao productDao = ProductDao.getInstance();
	Product product = new Product();
	product.setNo(productNo);
	
	// CartItem 객체를 생성하여 장바구니 아이템 정보 저장
	CartItem cartItem = new CartItem();
	cartItem.setUser(user);
	cartItem.setProduct(product);
	cartItem.setQuantity(1);
	
	// 장바구니 아이템정보를 전달하여 수량을 변경 혹은 저장
	CartItemDao cartItemDao = CartItemDao.getInstance();
	cartItemDao.mergeCartItem(cartItem);
	
	// 장바구니 목록으로 돌아가기
	response.sendRedirect("form.jsp");
%>