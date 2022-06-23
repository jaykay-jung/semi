<%@page import="dao.CartItemDao"%>
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
	
	// 상품번호, 수량 파라미터 요청
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantityNo"));

	// 장바구니 아이템정보를 전달하여 수량을 변경 혹은 저장
	CartItemDao cartItemDao = CartItemDao.getInstance();
	cartItemDao.updateCartItemQuantity(quantity, productNo);
	
	// 장바구니 목록으로 돌아가기
	response.sendRedirect("form.jsp");
%>