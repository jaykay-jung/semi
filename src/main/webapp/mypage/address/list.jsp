<%@page import="vo.Address"%>
<%@page import="java.util.List"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 스타일 -->
<style type="text/css">
.vertical-align-content {display:flex; align-items:center; justify-content: center; color:white; width:150px; height:40px; margin:5px; font-size:12px;}
.vertical-align-content2 {display:flex; align-items:center; justify-content: center; color:white; width:150px; height:30px; margin:5px; font-size:12px;}

.nolinelink:link {color: black; text-decoration-line:none;}
.nolinelink:visited {color: black; text-decoration-line:none;}
.nolinelink:hover {color: black; text-decoration:none;}
.nolinelink:hover, .nolinelink:active {color:black; text-decoration:none;}

.over:link {color: gray; text-decoration-line:none;}
.over:visited {color: gray; text-decoration-line:none;}
.over:hover {color: gray; text-decoration:underline;}
.over:hover, .nolinelink:active {color:gray; text-decoration:underline;}
font {font-family: 'Lato',sans-serif; font-size:13px; }
</style>
</head>
<body>
<!--  	1) 주소록 기본으로 고정하는것 아직 안함
		2) 주소록 선택박스 선택해서, 수정버튼 누르면, form.jsp로 넘어갈때 같이 addressNo 넘어가면, 수정폼에 정보 그대로 나오도록.

 -->
<!-- header -->
<jsp:include page="../../common/nav.jsp">
	<jsp:param name="menu" value="mypage"/>
</jsp:include>

<!-- content -->
<div class="container">
<!-- 개요 -->
	<div class="row">
		<div class="col">
        	<div style="float:left; width:300px; height:30px; line-height:30px;">
				<h6><strong>배송 주소록 관리</strong></h6>
			</div>
			<div style="float: right; width:300px; height:auto; text-align:right; color:gray;">	
				<font><a class="nolinelink" href="../../home.jsp" style="color:gray;">홈</a></font>
				<font><strong>》</strong></font>
				<font><a class="nolinelink" href="../mypage.jsp" style="color:gray;">마이페이지</a></font>
				<font><strong>》</strong></font>
				<font><strong>배송 주소록 관리</strong></font>
			</div><div style="clear:both:"></div>
    	</div>
		<hr style="border: gray 0.7px dotted;">	
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
				<strong>거부</strong> 다른 사용자의 주소록을 변경할 수 없습니다.
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
			
			// 사용자에 맞는 주소록 데이터 가져오기
			AddressDao addressDao = AddressDao.getInstance();
			List<Address> addressList = addressDao.getAllAddress(user.getNo());
			
		%>		
		
		
			<table class="table" style="text-align:center; font-size:13px;">
				<colgroup>
					<col width="2%" style="border: 1px solid red;">
					
					<col width="8%">
					<col width="8%" style="border: 1px solid red;">
					<col width="8%">
					<col width="15%" style="border: 1px solid red;">
					<col width="*">
					<col width="7%" style="border: 1px solid red;">
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th><input type="button" />주소록 고정</th>
						<th>배송지명</th>
						<th>수령인</th>
						<th>전화번호</th>
						<th>주소</th>
						<th><input type="button" />수정</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				<%
					if (addressList.isEmpty()) {
				%>	
					<tr>
						<td colspan="6" class="text-center"><strong>주소록이 비어있습니다.</strong></td>
					</tr>
				<%
					} else {
						for (Address address : addressList) {
				%>
							<tr>
								<td><input type="checkbox" /></td>
								<td><a href="fix.jsp?addressNo=<%=address.getNo() %>"><img src="../../images/mypage/address-fix.png"></a></td>
								<td><span class="text-danger"><strong></strong> <%=address.getNickName() %>></span></td>
								<td><%=address.getName() %>></td>
								<td><span class="text-danger"><strong></strong> <%=address.getTel() %></span></td>
								<td>(<%=address.getZip() %>) <%=address.getCity() %> <%=address.getStreet() %></td>
								<td>
									<a href="form.jsp?addressNo=<%=address.getNo() %>"><span><img src="../../images/mypage/address-modify.png"></span></a>
								</td>
							</tr>
				</tbody>
			</table>
			
<!-- 주소록 삭제 및 등록버튼 -->
			<div class="row">
				<div class="col">
			       	<div style="float:left; border:1px solid red; width:50%; height:40px;">
						<a href="delete.jsp?addressNo=<%=address.getNo() %>"><img src="../../images/mypage/address-delete.png"></a>
					</div>
			       	<div class="vertical-align-content2" style="float:right; background-color:black; ">
			       		<a class="nolinelink" href="form.jsp" style="color:white;">
						<font>배송지 등록</font>
						</a>
					</div>
				</div>
			</div>
				<%	
						}
					}
				%>
		</div>
	</div>

<!-- 배송 주의사항 -->	
	<div style="border:1px solid #e8e7e7; margin:9px 5px;">
	
		<div class="row" style="margin:0; background-color:#fbfbfb; ">
        	<div style="height:auto; margin:5px;">
				<font style="font-weight:bold;">배송주소록 유의사항</font>
			</div>				
    	</div>
		<div class="row" style="margin:0; border-top:1px solid #e8e7e7;">
			<div style="margin-top:13px; color:#707070;">
				<ol style="font-size:0.75em; font-family:Verdana,Dotum,AppleGothic,sans-serif;">
					<li>배송 주소록은 최대 10개까지 등록할 수 있으며, 별도로 등록하지 않을 경우 최근 배송 주소록 기준으로 자동 업데이트 됩니다.</li>
					<li>자동 업데이트를 원하지 않을 경우 주소록 고정 선택을 선택하시면 선택된 주소록은 업데이트 대상에서 제외됩니다.</li>
					<li>기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.</li>
				</ol>
			</div>
    	</div>
	</div>	
</div>

<!-- footer -->
<jsp:include page="../../common/footer.jsp">
	<jsp:param name="footer" value="register"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 	
