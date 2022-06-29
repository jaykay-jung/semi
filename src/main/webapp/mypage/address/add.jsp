<%@page import="dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.Address"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션에서 로그인된 사용자 정보 조회하기
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	int userNo = user.getNo();
	
	// 요청파라미터값을 조회한다.
	String nickname = request.getParameter("nickname");
	String name = request.getParameter("name");
	int zip = StringUtil.stringToInt(request.getParameter("zip"));
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String phone = request.getParameter("phone");
	String basic = request.getParameter("basic");
	
	// Address 객체를 생성해서 파라미터로 받은 값을 저장하기
	Address address = new Address();
	address.setNickName(nickname);
	address.setName(name);
	address.setZip(zip);
	address.setCity(addr1);
	address.setStreet(addr2);
	address.setTel(phone);
	address.setUser(user);
	
	// Address정보를 데이터베이스에 저장시킨다.
	
	// AddressDao 객체를 생성한다.
	AddressDao addressDao = AddressDao.getInstance();
	
	if ("T".equals(basic)) {
		
		// addressDao로 사용자의 모든 주소록을 가져온다.
		List<Address> addressList = addressDao.getAllAddress(userNo);
		
		// 모든 주소록의 basic 값을 F로 만든다.
		for (Address addr : addressList) {
			addr.setBasic("F");
			addressDao.updateAddress(addr);
		}
		// 우리가 생성했던 객체는 Basic값을 "T"로 준다. 
		address.setBasic("T");
		
		//UserDao 획득
		UserDao userDao = UserDao.getInstance();
		// 세션에서 가져온 User객체에 사용자정보를 저장(수정)한다.
		String basicAddress = "(" + zip + ")" + addr1 + " " + addr2;
		user.setAddress(basicAddress);
		// 사용자정보를 데이터베이스에 업데이트
		userDao.updateUser(user);
		
	} else {
		address.setBasic("F");
	}

	addressDao.insertAddress(address);
	
	// 주소록 목록을 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
	
%>