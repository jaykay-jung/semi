<%@page import="util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="vo.CartItem"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	// 로그인 확인
	// 로그인 안했을 경우 로그인창으로 이동
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	// 요청파라미터 이름으로 값 조회
	// 정수형으로 형변환
	int itemNo = Integer.parseInt(request.getParameter("itemNo"));
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	
	// 상품 삭제
	cartItemDao.deleteCartItem(itemNo);
	
	// 작업 후에 장바구니 목록 URL 재요청
	response.sendRedirect("form.jsp");
	
%>