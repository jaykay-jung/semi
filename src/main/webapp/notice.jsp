<%@page import="util.MultipartRequest"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 사용자정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");

	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\attached-file");

	// 요청 파라미터값 조회
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String filename = mr.getFilename("upfile");
	
	// 게시글 정보 저장
	Notice notice = new Notice();
	notice.setTitle(title);
	notice.setContent(content);
	notice.setFilename(filename);
	
	// 데이터 베이스에 저장
	NoticeDao noticeDao = NoticeDao.getInstance();
	noticeDao.insertNotice(notice);
	
	// 재요청  URL
	response.sendRedirect("noticelist.jsp");
%>