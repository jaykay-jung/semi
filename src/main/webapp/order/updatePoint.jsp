<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@page import="dao.PointDao"%>
<%@page import="vo.Point"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인된 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	PointDao pointDao = PointDao.getInstance();
	Point point = pointDao.getPointByUserNo(user.getNo());
	
	OrderDao orderDao = OrderDao.getInstance();
	Order order = orderDao.getOrderByOrderNo(orderNo);
	
	int tot = point.getTot() + order.getDepositPoint();
	int used = point.getUsed() + order.getUsedPoint();
	int availble = tot - used;
	int unUsed = point.getUnUsed();
	
	point.setUsed(used);
	point.setAvailble(availble);
	point.setUnUsed(unUsed);
	point.setTot(tot);
	point.setUser(user);
	
	// 업데이트 메소드 실행
	pointDao.updatePoint(point);
	
	// 장바구니 아이템 삭제
	response.sendRedirect("deleteCartItem.jsp?userNo="+user.getNo());
%>