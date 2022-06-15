<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션객체를 무효화
	session.invalidate();

	// 재요청URL
	response.sendRedirect("home.jsp");
%>