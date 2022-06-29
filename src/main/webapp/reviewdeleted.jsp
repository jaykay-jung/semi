<%@page import="vo.Review"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");

	// 요청파라미터에서 게시글 번호를 조회한다.
	int reviewNo = StringUtil.stringToInt(request.getParameter("no"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	
	// 리뷰 번호에 해당하는 정보를 조회한다.
	ReviewDao reviewDao = ReviewDao.getInstance();
	Review review = reviewDao.getReviewByNo(reviewNo);
	
	// 정보가 없으면 재요청 URL
	if (review == null) {
		throw new RuntimeException("게시글 정보가 존재하지 않습니다.");
	}
	
	// 작성자 번호와 사용자 번호가 다를 때 재요청 URL
	if (review.getUser().getNo() != user.getNo()){
		throw new RuntimeException("다른 회원이 작성한 글은 삭제할 수 없습니다.");
	}
	
	// 삭제여부를 Y로 변경
	review.setDeleted("Y");
	
	// 데이터베이스에 반영
	reviewDao.updatedReview(review);
	
	// 재요청 url
	response.sendRedirect("reviewlist.jsp");
%>
