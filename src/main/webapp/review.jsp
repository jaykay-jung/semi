<%@page import="dao.ReviewDao"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	

	// 재요청 url
	// response.sendRedirect("reviewlist.jsp");
%>