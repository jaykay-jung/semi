<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@page import="vo.WishList"%>
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
	
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getAllProductByNo(productNo);
	
	// WishList 객체를 생성하여 관심상품 정보 저장
	WishList wishList = new  WishList();
	
	wishList.setUser(user);
	wishList.setProduct(product);
	
	WishListDao cartItemDao = WishListDao.getInstance();
	cartItemDao.insertWishList(wishList);
	
	// 장바구니 목록으로 돌아가기
	response.sendRedirect("form.jsp");
%>