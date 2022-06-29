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
	// 파라미터
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	// 장바구니 아이템 삭제 메소드 실행
	cartItemDao.deleteAllCartItemByUserNo(userNo);
	
	// 결제완료 페이지
	response.sendRedirect("complete.jsp");
%>