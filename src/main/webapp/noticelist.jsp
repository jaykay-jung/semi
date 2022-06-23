<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.NoticeDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	h3 {font-size: 18px; font-weight: bold;}
	#noticelist-h3 {line-height: 40px; border-bottom: 1px solid #eee;}
	table {text-align: center; font-size: 15px;}
	table tbody {font-size: 13px;}
	table td {vertical-align: middle; line-height: 30px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="noticelist"/>
</jsp:include>

<!-- content -->
<div class="container">
	<div class="row">
		<div class="col">
			<h3 id="noticelist-h3">NOTICE</h3>
		</div>
	</div>
	<%
		int currentPage = StringUtil.stringToInt(request.getParameter("page"));
		int rows = StringUtil.stringToInt(request.getParameter("rows"),5);
		String keyword = StringUtil.nullToBlank(request.getParameter("keyword"));
		
		NoticeDao noticeDao = NoticeDao.getInstance();
		
		// 전체 공지 갯수 조회
		int totalRows = noticeDao.getTotalRows();
		if(keyword.isEmpty()) {
			totalRows = noticeDao.getTotalRows();
		} else {
			totalRows = noticeDao.getTotalRows(keyword);
		}
		
		// 페이징 처리에 필요한 정보 제공
		Pagination pagination = new Pagination(totalRows, currentPage);
		
		List<Notice> noticeList = null;
		if(keyword.isEmpty()) {
			noticeList = noticeDao.getNotices(pagination.getBeginIndex(), pagination.getEndIndex());
		} else {
			noticeList = noticeDao.getNotices(pagination.getBeginIndex(), pagination.getEndIndex(), keyword);
		}
		
	%>
	<div class="row">
		<div class="col">
			<table class="table">
				<colgroup>
					<col width="5%">
					<col width="">
					<col width="5%">
					<col width="10%">
					<col width="5%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(Notice notice : noticeList) {
				%>
					<tr>
						<td><%=notice.getNo() %></td>
						<td><%=notice.getTitle() %></td>
						<td>관리자</td>
						<td><%=notice.getCreatedDate() %></td>
						<td><%=notice.getViewCount() %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col">
	
		</div>
	</div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="noticelist"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>