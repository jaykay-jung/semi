<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.PointHistory"%>
<%@page import="dao.PointHistoryDao"%>
<%@page import="vo.Point"%>
<%@page import="dao.PointDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("포인트내역 조회는 로그인 후 사용가능한 서비스 입니다.");
	} 
%>    
<!doctype html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link href="favicon.ico" rel="icon" type="image/x-icon" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 스타일 -->
<style type="text/css">
.nolinelink:link {color: black; text-decoration-line:none;}
.nolinelink:visited {color: black; text-decoration-line:none;}
.nolinelink:hover {color: black; text-decoration:none;}
.nolinelink:hover, .nolinelink:active {color:black; text-decoration:none;}

.over:link {color: gray; text-decoration-line:none;}
.over:visited {color: gray; text-decoration-line:none;}
.over:hover {color: gray; text-decoration:underline;}
.over:hover, .nolinelink:active {color:gray; text-decoration:underline;}
font {font-size:13px;}

<!-- pagination -->
.page-item {
 z-index: 1;
 color: #555;
 }
.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}
.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
}
.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}

</style>
</head>

<body>

<!-- header -->
<jsp:include page="/common/nav.jsp">
	<jsp:param name="menu" value="mypage"/>
</jsp:include>

<!-- content -->
<div class="container">
<!-- 개요 -->
	<div class="row">
		<div class="col">
        	<div style="float:left; width:300px; height:30px; line-height:30px;">
				<h6><strong>적립금</strong></h6>
			</div>
			<div style="float: right; width:300px; height:auto; text-align:right; color:gray;">	
				<font><a class="nolinelink" href="../../home.jsp" style="color:gray;">홈</a></font>
				<font><strong>》</strong></font>
				<font><a class="nolinelink" href="../mypage.jsp" style="color:gray;">마이페이지</a></font>
				<font><strong>》</strong></font>
				<font><strong>적립금</strong></font>
			</div><div style="clear:both:"></div>
    	</div>
		<hr style="border: gray 0.7px dotted;">	
  	</div>



<%
// 포인트를 조회한다.
int userNo = user.getNo();
PointDao pointDao = PointDao.getInstance();
Point point = pointDao.getPointByUserNo(userNo);
%>

<!-- 회원적립금내역 -->
	<div style="margin:20px 5px; border:5px solid #e8e8e8; height:auto; line-height:180%;">
		<div class="row" style="margin:0px 5px; height:140px;">
			<div class="col" style="float:left; width:50%; border-right:1px solid #e8e8e8;">
	        	<div style="float:left; width:70%; margin:15px;margin-top:25px; margin-left:25px;">
					<font>>총 적립금</font>
					<br><font>>사용된 적립금</font>
					<br><font>>환불예정 적립금</font>
				</div>
	        	<div style="float:left; width:20%;margin-top:25px; text-align:right;">
					<font><%=point.getTot() %>원</font>
					<br><font ><%=point.getUsed() %>원</font>
					<br><font>123,456 원</font>
				</div>
			</div>
			<div class="col" style="float:left; width:80%;">	
	        	<div style="float:left; width:70%; height:auto; margin-top:25px; margin-left:25px;">
					<font>>사용가능 적립금</font>
					<br><font>>미가용 적립금</font>
				</div>
	        	<div style="float:left; width:20%;margin-top:25px; text-align:right;">
					<font><%=point.getAvailble() %>원</font>
					<br><font><%=point.getUnUsed() %>원</font>
				</div>
			</div>
		</div>
	</div>
		
<!-- 회원주문처리현황 -->	

	<div style="border:1px solid #cbcdce; margin:20px 5px; height:41px; background-color:#f2f2f2; border-bottom: 1px solid #202020; ">
		<div class="row" style="margin:0; text-align: center;">
        	<div style="float:left; width:200px; height:40px; line-height:35px; background-color:#4a5164; border:1px solid #202020; margin:-1px;">
				<a href="historylist.jsp" style="text-decoration-line:none; color:#fff; font-size:13px; "><strong>적립내역보기</strong></a>
			</div>				
        	<div style="float:left; width:200px; height:39px; line-height:35px; border-right: 1px solid #cbcdce; background-color:#f2f2f2;">
				<a href="unavailablelist.jsp" style="text-decoration-line:none; color:#707070; font-size:13px;">미가용적립내역보기</a>
			</div>				
    	</div>	
	</div>

<!-- 요청파라미터에서 요청한 페이지 번호를 조회하고, 페이지번호에 맞는 목록을 출력한다.
	페이징처리에 필요한 작업을 수행한다.
-->
<%
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	
	// 적립금내역을 조회한다.
	PointHistoryDao pointHistoryDao = PointHistoryDao.getInstance();
	
	// 전체 데이터 갯수 조회
	int totalRows = 0;
	totalRows = pointHistoryDao.getTotalRows(userNo);
	
	// 페이징처리에 필요한 정보를 제공하는 객체 생성
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	
	// 요청한 페이지번호에 맞는 데이터 조회하기
	List<PointHistory> pointHistoryList = null;

	pointHistoryList = pointHistoryDao.getPointHistoryByUserNo(userNo, pagination.getBeginIndex(), pagination.getEndIndex());

%>	
	
<!-- 적립금 내역 -->
	<div class="row">
		<div class="col" style="margin:0px 5px;">
			<table class="table" style=" text-align:center; font-size: 13px; " >
				<colgroup>
					<col width="12%">
					<col width="12%">
					<col width="20%">
					<col width="*">
				</colgroup>
				<thead style="border-bottom:1px solid #202020;">
					<tr>
						<th>주문날짜</th>
						<th>적립금</th>
						<th>관련주문</th>
						<th>적립내용</th>
					</tr>
				</thead>
				<tbody>
				<%
					if (pointHistoryList.isEmpty()) {
				%>
				
					<tr>
						<td colspan="4" style="height:120px; border: 1px solid #d7d5d5; padding: 50px 0; text-align: center; color: #757575; font-weight:bold;"><strong>적립금 내역이 없습니다.</strong></td>
					</tr>
				 
					<tr style="border:1px solid white;">
				<%
					} else {

						for (PointHistory pointHis : pointHistoryList) {
				%>	
					
						<td><%=pointHis.getCreatedDate() %></td>
						<td style="text-align:right;"><%=pointHis.getPointAmount() %></td>
						<td><%=pointHis.getOrder().getNo() %></td>
						<td><%=pointHis.getTitle() %></td>
					</tr>
				<%
						}
					}					
				%>
				</tbody>
			</table>
		</div>
	</div>

<!-- 페이징처리 -->
	<div style="margin:25px 5px; height:130px; line-height:180%;">
	
		<nav aria-label="point navigation">
			<ul class="pagination pagination-sm justify-content-center" >
		  		<li class="page-item" >
		    		<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1 %>)" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		    	</li>
		    	
			<%
				for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
			%>		    	
		    	
		    	<li class="page-item <%=pagination.getCurrentPage() == num ? "active" : "" %>">
		    		<a class="page-link" href="javascript:clickPageNo(<%=num %>)"><%=num %></a>
		    	</li>
			<%
				}
			%>		    	
		  		<li class="page-item">
		    		<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1 %>)" aria-label="Next">
		        		<span aria-hidden="true">&gt;</span>
		      		</a>
		    	</li>
		 	</ul>
		</nav>
	</div>

<!-- 적립금 안내 -->	
	<div style="border:1px solid #e8e7e7; margin:9px 5px;">
		<div class="row" style="margin:0; background-color:#fbfbfb; ">
        	<div style="height:auto; margin:5px;">
				<font style="font-weight:bold;">적립금 안내</font>
			</div>				
    	</div>
		<div class="row" style="margin:0; border-top:1px solid #e8e7e7;">
			<div style="margin-top:13px; color:#707070;">
				<ol style="font-size:0.75em; font-family:Verdana,Dotum,AppleGothic,sans-serif;">
					<li>주문으로 발생한 적립금은 배송완료 후 14일 부터 실제 사용 가능한 적립금으로 전환됩니다. 배송완료 시점으로부터 14일 동안은 미가용 적립금으로 분류됩니다.</li>
					<li>미가용 적립금은 반품, 구매취소 등을 대비한 임시 적립금으로 사용가능 적립금으로 전환되기까지 상품구매에 사용하실 수 없습니다.</li>
					<li>사용가능 적립금(총적립금 - 사용된적립금 - 미가용적립금)은 상품구매 시 바로 사용가능합니다.</li>
				</ol>
			</div>
    	</div>
	</div>    	
 
</div>

<!-- footer -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="footer" value="mypage"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function changeRows() {
		document.querySelector("input[name=page]").value = 1;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}
	
	function clickPageNo(pageNo) {
		document.querySelector("input[name=page]").value = pageNo;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}
	
	function searchKeyword() {
		document.querySelector("input[name=page]").value = 1;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}
</script>

</body>
</html>