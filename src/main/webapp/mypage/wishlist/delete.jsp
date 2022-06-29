<%@page import="util.StringUtil"%>
<%@page import="vo.WishList"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		
	// 요청 URL : http://localhost/mypage/wishList/delete.jsp?wishNo=20&wishNo=15
	// 요청 파라미터
	//		name		value
	//		wishNo		20
	//		wishNo		15
	
	// 세션객체에서 로그인한 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	// 로그인한 사용자정보가 존재하지 않으면 loginform.jsp를 재요청하는 응답을 보내고, jsp의 실행을 즉시 중단한다.
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	// 요청파라미터값 조회하기
	String[] values = request.getParameterValues("wishNo");
	for (String value : values) {
		int wishNo = StringUtil.stringToInt(value);
	
		// 위시번호와 일치하는 위시객체 조회
		WishListDao wishListDao = WishListDao.getInstance();
		WishList wishList = wishListDao.getWishListByWishListNo(wishNo);
		
		// 위시객체가 조회되지 않으면, 위시리스트로 다시 돌아가는 URL을 응답으로 보내고, 요청파라미터에 오류정보를 추가한다.
		if (wishList == null) {
			response.sendRedirect("list.jsp?fail=invalid");
			return;
		}
		
		// 로그인된 사용자정보와 위시리스트 번호의 사용자정보가 일치하지 않으면 다른 사람의 위시리스트를 삭제하는 것이므로, 위시리스트를 요청하는 URL을 응답으로 보내고, 요청파라미터에 오류정보를 추가한다.
		if (user.getNo() != wishList.getUser().getNo()) {
			response.sendRedirect("list.jsp?fail=deny");
			return;
		}
		
		// 위시번호와 일치하는 위시객체를 위시리스트테이블에서 삭제한다.
		wishListDao.deleteWishItem(wishNo);
	}

	// 저장소에 대한 변경(추가/변경/삭제)작업 후에는 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
						
%>