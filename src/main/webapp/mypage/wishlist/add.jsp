<%@page import="vo.Product"%>
<%@page import="vo.WishList"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// ì¸ììì ë¡ê·¸ì¸ë ì¬ì©ì ì ë³´ ì¡°ííê¸°
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	// <<ëì¤ì íì¸>>
	// ìì²­URL : http://localhost/semi/mypage/wishList/add.jsp?productNo=110037 //
	// ìì²­íë¼ë¯¸í°
	//		name 			value
	//		productNo		110037
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// WishList ê°ì²´ë¥¼ ìì±í´ì ì ë¬ë°ì ì ë³´ë¥¼ ì ì¥íê¸°
	WishList wishList = new WishList();
	wishList.setNo(productNo);
	wishList.setUser(user);
	wishList.setProduct(new Product());
	
	// ììë¦¬ì¤í¸ë¥¼ ì ë¬í´ì ì ì¥íë¤.
	WishListDao wishListDao = WishListDao.getInstance();
	wishListDao.insertWishList(wishList);

	// ììë¦¬ì¤í¸ ëª©ë¡ì ì¬ìì²­íë URLì ìëµì¼ë¡ ë³´ë¸ë¤.
	response.sendRedirect("list.jsp");
	
%>