<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="vo.WishList"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인여부조회
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	// 상품번호 파라미터 요청
	int productNo = Integer.parseInt(request.getParameter("productNo"));
  
	// Product 객체 생성, 전달받은 번호로 필드값 대입
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(productNo);
	
	// WishList 객체를 생성하여 관심상품 정보 저장
	WishList wishList = new  WishList();
	wishList.setUser(user);
	wishList.setProduct(product);
	
  // DB로 전송
	WishListDao wishListDao = WishListDao.getInstance();
	wishListDao.insertWishList(wishList);

  // 재요청할 URL
	response.sendRedirect("list.jsp");
  
  
%>