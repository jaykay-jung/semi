<%@page import="util.PasswordUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//요청파라미터값 조회
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	
	UserDao userDao = UserDao.getInstance();
	
	// 동일한 아이디 사용자 정보가 있는지 조회
	User user = userDao.getUserById(id);
	if(user != null) {
		response.sendRedirect("registerform.jsp?fail=id&id=" + id);
		return;
	}
	
	// 동일한 이메일 사용자 정보가 있는지 조회
	user = userDao.getUserByEmail(email);
	if (user != null) {
		response.sendRedirect("registerform.jsp?fail=email&email=" + email);
		return;
	}
	
	// 비밀번호 암호화
	String secretPassword= PasswordUtil.generateSecretPassword(id, password);
	
	// 사용자 정보 저장
	user = new User();
	user.setId(id);
	user.setPassword(secretPassword);
	user.setName(name);
	user.setPhone(phone);
	user.setEmail(email);
	user.setGrade("일반");
	
	// 사용자 정보를 데이터베이스에 저장
	userDao.insertUser(user);
	
	// 세션객체에 저장
	session.setAttribute("id", id);
	session.setAttribute("email", email);
	session.setAttribute("name", name);
	
	// 재요청 URL
	response.sendRedirect("complete.jsp");
	
	
%>
