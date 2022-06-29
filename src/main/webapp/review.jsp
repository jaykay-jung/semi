<%@page import="util.MultipartRequest"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Product"%>
<%@page import="vo.User"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 사용자 정보 조회
	User user = (User) session.getAttribute("LOGINED_USER");
	if(user == null) {
		throw new RuntimeException("리뷰 등록은 로그인 후 사용 가능합니다.");
	}

	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\attached-file");
	
	// 요청 파라미터값 조회
	int productNo = StringUtil.stringToInt(mr.getParameter("productNo"));
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String filename = mr.getFilename("upfile");
	
	// 상품번호로 상품정보 조회하기
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(productNo);
	
	// 리뷰 정보 저장
	Review review = new Review();
	
	review.setUser(user);
	review.setProduct(product);
	review.setTitle(title);
	review.setContent(content);
	review.setFilename(filename);
	
	//데이터 베이스에 저장
	ReviewDao reviewDao = ReviewDao.getInstance();
	reviewDao.insertReview(review);
	

	// 재요청 url
	response.sendRedirect("reviewlist.jsp");
%>