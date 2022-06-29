<%@page import="vo.User"%>
<%@page import="vo.Notice"%>
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
<style type="text/css">
	h3 {font-size: 18px; font-weight: bold;}
	#notice {border-bottom: 1px solid #eee; margin-bottom: 30px;}
	.table {border-top: 1px solid #eee}
	.table th {background-color: #fbfbfb;}
	
	#notice-content td {line-height: 35px; padding: 30px;}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="noticedetail"/>
</jsp:include>

<!-- content -->
<div class="container">
	<%
		// 공지 번호 조회
		int noticeNo = StringUtil.stringToInt(request.getParameter("no"));
		int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
		
		// 공지글 정보 조회하기
		NoticeDao noticeDao = NoticeDao.getInstance();
		Notice notice = noticeDao.getNotcieByNo(noticeNo);
		
		// 조회수 증가시키기
		notice.setViewCount(notice.getViewCount() + 1);
		noticeDao.updateNotice(notice);
	%>
	<div class="row">
		<div class="col" id="notice">
			<h3>Notice</h3>
		</div>
	</div>
	<!-- 공지 출력 -->
	<div class="row">
		<div class="col">
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<tbody>
					<tr>
						<th>제목</th>
						<td colspan="3"><%=notice.getTitle() %></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td><%=notice.getCreatedDate() %></td>
						<th>조회수</th>
						<td><%=notice.getViewCount() %></td>
					</tr>
					<tr id="notice-content">
						<td colspan="4"><%=notice.getContent() %></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
					<%
						if (notice.getFilename() != null) {
					%>
							<span><%=notice.getFilename() %></span>
							<a href="" class="btn btn-secondary btn-sx">다운로드</a>
					<%	
						} else {
					%>
							<span>없음</span>
					<%
						}
					%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col text-start">
			<a href="noticelist.jsp" class="btn btn-secondary">목록</a>
		</div>
		<div class="col text-end">
		<%
			// 비활성화 여부
			User user = (User) session.getAttribute("LOGINED_USER");
			boolean isDisabled = true;
		
			if (user != null && "Y".equals(user.getAdmin())) {
		%>
			<a href="noticedeleted.jsp?no=<%=notice.getNo() %>" class="btn btn-danger">삭제</a>
		<%
			}
		%>
		</div>
	</div>
	
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="noticedetail"/>
</jsp:include>
</body>
</html>