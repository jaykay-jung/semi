<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
 
	// 공지 번호 조회
	int noticeNo = StringUtil.stringToInt(request.getParameter("no"));
	
	// 공지 번호에 해당하는 정보 조회하기
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNotcieByNo(noticeNo);
	
	// 정보가 없을 때 
	if (notice == null) {
		throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
	}
	
	// 관리자가 아닌 사용자일 때
	if(!"Y".equals(user.getAdmin())) {
		throw new RuntimeException("관리자 권한이 필요합니다.");
	}
	
	// 삭제여부 변경하기
	notice.setDeleted("Y");
	
	// 데이터베이스에 반영하기
	noticeDao.updateNotice(notice);
	
	// 재요청 URL
	response.sendRedirect("noticelist.jsp");
%>