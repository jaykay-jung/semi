<%@page import="vo.WishList"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%
		
	// 요청 URL : http://localhost/mypage/wishList/delete.jsp?wishNo=130021
	// 요청 파라미터
	//		name	value
	//		wishNo	130021
	
	// 세션객체에서 로그인한 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	// 로그인한 사용자정보가 존재하지 않으면 loginform.jsp를 재요청하는 응답을 보내고, jsp의 실행을 즉시 중단한다.
	if (user == null) {
		response.sendRedirect("../../loginform.jsp?fail=deny");
		return;
	}	
	
	int wishNo = Integer.parseInt(request.getParameter("wishNo"));
	
	
	WishListDao wishListDao = WishListDao.getInstance();
	WishList wishList = wishListDao.getWishListByWishListNo(wishNo);
	
	
	// 로그인한 사용자번호와 위시리스트의 사용자번호가 일치하지 않으면, 다른 사람의 위시리스트 아이템을 삭제하는 것이므로
	// 위시리스트 목록을 재요청하는 URL을 응답으로 보내고, 요청파라미터에 오류정보를 추가한다.
	if (user.getNo() != wishList.getUser().getNo()) {
		response.sendRedirect("list.jsp?fail=deny");
		return;
	}	
	
	// 장바구니 아이템번호와 일치하는 장바구니 아이템 삭제하기
	wishListDao.deleteWishItem(wishNo);
	
	// 저장소에 대한 변경(추가/변경/삭제)작업 후에는 재요청 URL을 응답으로 보낸다.
	// 현재 URL :     localhost/book-store/cart/delete.jsp?itemNo=130021
	// 기준 URL :     localhost/book-store/cart/
	// 재요청할 URL : localhost/book-store/cart/list.jsp
	
	response.sendRedirect("list.jsp");
						

%>