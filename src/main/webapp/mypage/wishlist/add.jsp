<%@page import="vo.Product"%>
<%@page import="vo.WishList"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%
	// 세션에서 로그인된 사용자 정보 조회하기
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	// <<나중에 확인>>
	// 요청URL : http://localhost/semi/mypage/wishList/add.jsp?productNo=110037 //
	// 요청파라미터
	//		name 			value
	//		productNo		110037
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// WishList 객체를 생성해서 전달받은 정보를 저장하기
	WishList wishList = new WishList();
	wishList.setNo(productNo);
	wishList.setUser(user);
	wishList.setProduct(new Product());
	
	// 위시리스트를 전달해서 저장한다.
	WishListDao wishListDao = WishListDao.getInstance();
	wishListDao.insertWishList(wishList);

	// 위시리스트 목록을 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
	
%>