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
	
	// 요청파라미터값으로 주소번호를 조회한다.
	int addressNo = Integer.parseInt(request.getParameter("addressNo"));
	// 요청파라미터에서 수정된 주소값들을 조회한다.
	String nickname = request.getParameter("nickname");
	String name = request.getParameter("name");
	int zip = Integer.parseInt(request.getParameter("zip"));
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String phone = request.getParameter("phone");
	
	// Address 객체를 생성, 전달받은 주소번호와 같은 주소를 꺼내온다.
	AddressDao addressDao = AddressDao.getInstance();
	Address address = addressDao.getAddress(addressNo);

	// 주소정보가 없으면 재요청 URL을 응답으로 보낸다.
	if (address == null) {
		throw new RuntimeException("존재하지 않는 주소입니다.");
	}
	if (address.getUser().getNo() != user.getNo()) {
		throw new RuntimeException("다른 사용자의 주소록은 수정할 수 없습니다.");
	}
	
	// Address객체의 필드를 수정된 값을 바꾼다.
	address.setNickName(nickname);
	address.setName(name);
	address.setZip(zip);
	address.setCity(addr1);
	address.setStreet(addr2);
	address.setTel(phone);
	
	// 갱신한 주소정보를 데이터베이스에 반영한다.
	addressDao.updateAddress(address);
	
	// 주소록 목록을 재요청 URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
	
%>