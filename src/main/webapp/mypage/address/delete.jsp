<%@page import="vo.Address"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청 URL : http://localhost/semi/address/delete.jsp?addressNo=20
	// 요청 파라미터
	//		name		value
	//		addressNo	20
	
	// 세션객체에서 로그인한 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	// 로그인한 사용자정보가 존재하지 않으면 loginform.jsp를 재요청하는 응답을 보내고, jsp의 실행을 즉시 중단한다.
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}	
	
	// 요청파라미터값 조회하기
	String value = request.getParameter("addressNo");
	int addressNo = Integer.parseInt(value);
	
	// 주소번호에 해당하는 주소정보 조회
	AddressDao addressDao = AddressDao.getInstance();
	Address address = addressDao.getAddress(addressNo);
	
	// 주소정보가 조회되지 않으면, 주소록으로 다시 돌아가는 URL을 응답으로 보내고, 요청파라미터에 오류정보를 추가한다.
	if (address == null) {
		response.sendRedirect("list.jsp?fail=invalid");
		return;
	}
	
	// 로그인된 사용자정보와 주소록번호의 사용자정보가 일치하지 않으면 다른 사람의 주소록을 삭제하는 것이므로, 주소록을 요청하는 URL을 응답으로 보내고, 요청파라미터에 오류정보를 추가한다.
	if (user.getNo() != address.getUser().getNo()) {
		response.sendRedirect("list.jsp?fail=deny");
		return;
	}
	
	// 주소록번호와 일치하는 주소를 주소록에서 삭제한다.
	addressDao.deleteAddressByNo(addressNo);
	
	// 저장소에 대한 변경(추가/변경/삭제)작업 후에는 재요청 URL을 응답으로 보낸다.
	// 현재 URL :     localhost/semi/address/delete.jsp?addressNo=20
	// 기준 URL :     localhost/semi/address/
	// 재요청할 URL : localhost/semi/address/list.jsp
	
	response.sendRedirect("list.jsp");
	
%>