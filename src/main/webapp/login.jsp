<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 값 조회
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	
	//아이디로 사용자 조회
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserById(id);
	
	// 회원정보 없음
	if (user == null) {
		
	}
	
	// 탈퇴한 회원
	if ("Y".equals(user.getDeleted())) {
		
	}
	
	// 비밀번호 일치하는지 확인
	if(!user.getPassword().equals(password)) {
		
	}
	
	// 세션ㄴ객체에 저장
	session.setAttribute("LOGINED_USER", user);
	
	// 재요청 URL
	response.sendRedirect("home.jsp");
	
%>