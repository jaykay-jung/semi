<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("회원탈퇴는 로그인 후 사용가능한 서비스입니다.");
	}
	
	
	// -> POST 방식으로 얘를 가져오려면, POST form에서 submit 버튼 2개 사용 가능? action2개 중첩...??
			
	// 요청파라미터에서 비밀번호를 조회한다.
	String password = request.getParameter("password");
	
	// 사용자번호에 해당하는 사용자정보를 조회한다.
	UserDao userDao = UserDao.getInstance();
	
	// 사용자의 비밀번호와, 입력한 비밀번호가 다르면 재요청 URL을 응답으로 보낸다.
	if (!("password".equals(user.getPassword()))) {
		throw new RuntimeException("비밀번호가 일치하지 않습니다.");
	}

	// 사용자의 비밀번호와, 입력한 비밀번호가 같다면, 사용자정보의 삭제여부를 'Y'로 변환한다.
	user.setDeleted("Y");
	// 변경된 사용자정보를 데이터베이스에 반영시킨다.
	userDao.updateUser(user);
	
	// 홈페이지로 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("/home.jsp");
		
%>