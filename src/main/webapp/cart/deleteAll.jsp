<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//로그인 확인
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	
	List<CartItem> cartItem = cartItemDao.getCartItemsByUserNo(userNo);
	// 장바구니 아이템정보가 존재하지 않으면 장바구니 목록을 재요청하는 URL을 응답으로 보내기
	for (CartItem items : cartItem) {
		if (items == null) {
			response.sendRedirect("form.jsp?fail=invalid");
			return;
		}
		// 로그인한 사용자번호와 장바구니아이템의 사용자번호를 조회하여 일치하지 않으면 장바구니 목록 재요청
		if (user.getNo() != items.getUser().getNo()) {
			response.sendRedirect("form.jsp?fail=deny");
			return;
		}
	}
	
	// 장바구니 아이템 삭제 메소드 실행
	cartItemDao.deleteAllCartItemByUserNo(userNo);
	
	// 작업 후에 장바구니 목록 URL 재요청
	response.sendRedirect("form.jsp");
%>