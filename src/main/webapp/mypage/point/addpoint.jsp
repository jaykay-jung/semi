<%@page import="vo.Point"%>
<%@page import="dao.PointDao"%>
<%@page import="dao.PointHistoryDao"%>
<%@page import="vo.PointHistory"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션에 저장된 로그인된 사용자 정보 조회하기
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("포인트 적립은 로그인 후에만 사용되는 서비스입니다.");
	}
	// 유저번호를 가져온다.
	int userNo = user.getNo(); 
	
	// 요청파라미터값을 조회한다.
	String title = request.getParameter("title");
	
	int pointAmount = 0;
	if ("신규가입".equals(title)) {
		pointAmount = 1000;
	} else if ("상품주문".equals(title)) {
		pointAmount = StringUtil.stringToInt(request.getParameter("pointAmount"));
	} else if ("리뷰작성".equals(title)) {
		pointAmount = 500;
	}

	// 1. 우선 Point를 update한다.
	
	// 사용자번호에 해당하는 포인트번호를 조회한다.
	PointDao pointDao = PointDao.getInstance();
	Point point = pointDao.getPointByUserNo(userNo);

	// 포인트정보는 가입할때 생성되므로 없을수가 없도록 만든다.
	// 포인트 정보가 없으면 재요청 URL을 응답으로 보낸다.
	if (point == null) {
		throw new RuntimeException("사용자의 포인트 정보가 존재하지 않습니다.");
	}
	// 사용자정보와 포인트정보가 일치하지 않으면 오류!
	if (point.getUser().getNo() != user.getNo()) {
		throw new RuntimeException("다른 사용자의 포인트를 수정할 수 없습니다.");
	}
	// 조회된 포인트 실황을 갱신한다.
	point.setTot(point.getTot() + pointAmount);
	point.setAvailble(point.getAvailble() + pointAmount);
	point.setUnUsed(point.getUnUsed() + pointAmount);
	// 갱신된 포인트정보를 DB에 반영시킨다.
	pointDao.updatePoint(point);
	
	
	// 2. PointHistory에 insert한다.
	
	// PointHistory객체를 생성해서, parameter로 받은 값을 Setter()로 정보를 저장한다.
	PointHistory pointHis = new PointHistory();
	pointHis.setTitle(title);
	pointHis.setPointAmount(pointAmount);
	pointHis.setUser(user);
	
	// 저장한 PoinHistroy 정보를 DB에 저장시킨다.
	PointHistoryDao pointHistoryDao = PointHistoryDao.getInstance();
	pointHistoryDao.insertPointHistory(pointHis);
	
	// 주소록 목록을 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
	
	
	// 재요청URL을 응답으로 보낸다.
	if ("신규가입".equals(title)) {
		response.sendRedirect("/complete.jsp");
	} else if ("상품주문".equals(title)) {
		response.sendRedirect("/order/list.jsp");
	} else if ("리뷰작성".equals(title)) {
		response.sendRedirect("/reviewlist.jsp");
	}
	
	
	
	
%>