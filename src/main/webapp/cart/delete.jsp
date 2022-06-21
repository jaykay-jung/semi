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
	String value = request.getParameter("itemNo");
	// 스트링으로 읽히기 때문에 정수형으로 형변환
	int itemNo = Integer.parseInt(value);
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	
	// 장바구니 아이템번호에 해당하는 장바구니 아이템 정보 조회
	CartItem item = cartItemDao.getCartItemByItemNo(itemNo);
	// 장바구니 아이템정보가 존재하지 않으면 장바구니 목록을 재요청하는 URL을 응답으로 보내기
	if (item == null) {
		response.sendRedirect("form.jsp?fail=invalid");
		return;
	}
	// 로그인한 사용자번호와 장바구니아이템의 사용자번호를 조회하여 일치하지 않으면 장바구니 목록 재요청
	if (user.getNo() != item.getUser().getNo()) {
		response.sendRedirect("form.jsp?fail=deny");
		return;
	}
	
	// 작업 후에 장바구니 목록 URL 재요청
	response.sendRedirect("form.jsp");
	
%>