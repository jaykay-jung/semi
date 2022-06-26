<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 사용자정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");

	// 요청 파라미터값 조회
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 게시글 정보 저장
	Notice notice = new Notice();
	notice.setTitle(title);
	notice.setContent(content);
	
	// 데이터 베이스에 저장
	NoticeDao noticeDao = NoticeDao.getInstance();
	noticeDao.insertNotice(notice);
	
	// 재요청  URL
	response.sendRedirect("noticelist.jsp");
%>