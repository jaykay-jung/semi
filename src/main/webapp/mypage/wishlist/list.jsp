<%@page import="vo.WishList"%>
<%@page import="java.util.List"%>
<%@page import="dao.WishListDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- header -->
<jsp:include page="../../common/nav.jsp">
	<jsp:param name="mypage" value="wishlist"/>
</jsp:include>

<div class="container">
	<div class="row">
		<div class="col">
			<h1 class="fs-4 border p-2">나의 찜 목록</h1>
		</div>
	</div>
	<div class="row">
		<div class="col">
		<%
			String fail = request.getParameter("fail");
		%>
		<%
			if ("invalid".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>오류</strong> 유효한 요청이 아닙니다.
				</div>
		<%
			} else if ("deny".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>거부</strong> 다른 사용자의 찜목록을 변경할 수 없습니다.
				</div>
		<%	
			}
		%>
		
		<%
			// HttpSession객체에 저장된 사용자정보 조회하기
			User user = (User) session.getAttribute("LOGINED_USER");
			if (user == null) {
				response.sendRedirect("../loginform.jsp?fail=deny");
				return;
			}
			
			// 로그인한 사용자의 위시리스트 아이템 목록 조회
			WishListDao wishListDao = WishListDao.getInstance();
			List<WishList> wishList = wishListDao.getAllWishList(user.getNo());
		
		%>
			<p>위시리스트 목록을 확인하세요</p>
			<table class="table">
				<colgroup>
					<col width="5%">
					<col width="5%">
					<col width="*">
					<col width="15%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th>번호</th>
						<th>이미지</th>
						<th>상품이름</th>
						<th>구매가격</th>
						<th>적립금</th>
						<th>배송비</th>
						<th></th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				<%
					if (wishList.isEmpty()) {
				%>	
					<tr>
						<td colspan="8" class="text-center"><strong>위시리스트가 비어있습니다.</strong></td>
					</tr>
				<%
					} else {
						for (WishList wish : wishList) {
				%>
							<tr>
								<td><input type="checkbox" /></td>
								<td><%=wish.getNo() %></td>
								<td><a href="../product/detail.jsp?productNo=<%=wish.getProduct().getNo() %>"></a></td>
								<td><a href="../product/detail.jsp?productNo=<%=wish.getProduct().getNo() %>"><%=wish.getProduct().getName() %></a></td>
								<td><span class="text-danger"><strong><%=wish.getProduct().getSellPrice() %></strong> 원</span></td>
								<td><span class="text-danger"><strong><%=wish.getProduct().getDepositPoint() %></strong> 원</span></td>
								<td><span class="text-danger"><strong><%=wish.getProduct().getDeliveryFee() %></strong> 원</span></td>
								<td>
									<a href="delete.jsp?wishNo=<%=wish.getNo() %>" class="btn btn-danger btn-sx">삭제</a>
									<a href="../order/form.jsp?productNo=<%=wish.getProduct().getNo() %>" class="btn btn-primary btn-sx">주문</a>
								</td>
							</tr>
				<%	
						}
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
</div>


</body>
</html>