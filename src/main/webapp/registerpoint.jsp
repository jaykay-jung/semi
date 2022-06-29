<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Point"%>
<%@page import="dao.PointDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserByRownum(1);
	
	// 가입시 제공할 포인트 정보 저장. 기본포인트 1000원 제공
	Point point = new Point();
	point.setTot(1000);
	point.setAvailble(1000);
	point.setUser(user);
	
	PointDao pointDao = PointDao.getInstance();
	pointDao.insertPoint(point);
	
	// 회원가입 완료 페이지로 이동
	response.sendRedirect("complete.jsp");
%>