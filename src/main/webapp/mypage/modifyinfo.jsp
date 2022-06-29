<%@page import="vo.Address"%>
<%@page import="util.PasswordUtil"%>
<%@page import="java.sql.Date"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("회원탈퇴는 로그인 후 사용가능한 서비스입니다.");
	}
	
	  
	// 요청파라미터에서 입력한 정보를 가져온다.
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
	int zip = Integer.parseInt(request.getParameter("zip"));
	String city = request.getParameter("addr1");
	String street = request.getParameter("addr2");
		
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	
	String birthYr = request.getParameter("birth_yr");
	String birthMonth = request.getParameter("birth_month");
	String birthDay = request.getParameter("birth_day");
	
	// 비밀번호를 암호화한다.
	String id = user.getId();
	String secretPassword = PasswordUtil.generateSecretPassword(id, password);
	
	//UserDao 획득
	UserDao userDao = UserDao.getInstance();
	
	// 세션에서 가져온 User객체에 사용자정보를 저장한다.
	user.setPassword(secretPassword);
	user.setName(name);
	
	
	
	String address = "(" + zip + ")" + city + " " + street;
	user.setAddress(address);
	
	user.setPhone(phone);
	user.setEmail(email);
	user.setGender(gender);
	
	Date birthday = Date.valueOf(birthYr + "-" + birthMonth + "-" + birthDay);	
	user.setBirthday(birthday);
	
	// 사용자정보를 데이터베이스에 업데이트
	userDao.updateUser(user);
	
	// 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("complete.jsp");
%>