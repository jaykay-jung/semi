<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>리뷰</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="review"/>
</jsp:include>
<div class="container">
   <div class="row">
      <div class="col">
      	<h1 class="fs-4 border p-2">리뷰 게시판</h1>
      </div>
   </div>
   <div>
      <%
      	User user = (User) session.getAttribute("LOGINED_USER");
      %>
      <table>
		<colgroup>
			<col width="5%">
			<col width="10%">
			<col width="%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
      </table>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>