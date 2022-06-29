<%@page import="dao.ProductDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Product"%>
<%@page import="vo.User"%>
<%@page import="dao.QaDao"%>
<%@page import="vo.Qa"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	if(user == null) {
		throw new RuntimeException("문의글 등록은 로그인 후 사용 가능합니다.");
	}

	// 요청 파라미터값 조회
	int productNo = StringUtil.stringToInt(request.getParameter("productNo"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 상품번호로 상품정보 조회하기
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(productNo);
	
	// 문의글 정보 저장
	Qa qa = new Qa();
	
	qa.setUser(user);
	qa.setProduct(product);
	qa.setTitle(title);
	qa.setContent(content);
	
	//데이터 베이스에 저장
	QaDao qaDao = QaDao.getInstance();
	qaDao.insertQa(qa);
	

	// 재요청 url
	response.sendRedirect("qalist.jsp");
%>