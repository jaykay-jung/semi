<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PLANANT</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	#p-title {border-bottom: solid 2px rgba(0, 0, 0, 0.15); font-size: larger;}
	#p-content {line-height: 50%;}
    #div-h {padding-top: 20px; padding-bottom: 20px;}
    #h_table {border-style: solid; border-width: 7px;}
   	#h1 {text-align: center; vertical-align: middle; table-layout: fixed; width: 150px;}
   	#product-table tr {text-align: center; vertical-align: middle;}
    #radio-list {list-style-type: none; margin-right: 50px;}
    #payment-method {border: 1px solid black; padding:10px;}
    #deposit-table td {padding: 10px}
    img {width: 100px; height: 100px;}

</style>
</head>
<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">
    <jsp:param name="menu" value="order"/>
</jsp:include>

<!-- content -->
<div class="container">
<%
	String fail = request.getParameter("fail");
%>
<%
	if ("invalid".equals("fail")) {
%>
	<div class="alert alert-danger">
		<strong>오류</strong> 유효한 요청이 아닙니다.
	</div>
<%
	}
%>
<%
	OrderDao orderDao = OrderDao.getInstance();
	List<Order> orders = orderDao.getOrdersByUserNo(user.getNo());
%>
    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	<div>
        <p id="p-title"><strong>주문서 작성</strong></p>
    </div>
    <div id="div-h">
        <table id="h_table" class="table">
            <tr>
            	<td id="h1" rowspan="2"><strong>혜택정보</strong></td>
                <td><strong><%=user.getName() %></strong> 님은 [<%=user.getGrade() %>] 회원입니다.</td>
            </tr>
            <tr>
                <td>가용적립금:<strong><%=user.getPoint().getAvailble()%>원</strong></td>
            </tr>
        </table>
    </div>
    
    <div>
        <table class="table">
            <tr class="table-danger text-danger">
                <td>상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</td>
                <td>&nbsp;</td>
            </tr>
            <tr class="table-secondary">
                <td><strong>배송상품 주문내역</strong></td>
                <td>
					<a href="../cart/form.jsp"><button type="button" class="btn btn-secondary" style="float:right;">이전페이지</button></a>
                </td>
            </tr>
        </table>
    </div>
    <div id="product-table">
        <table class="table">
			<thead>
                <tr>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>적립금</th>
                    <th>배송구분</th>
                    <th>배송비</th>
                    <th>합계</th>
                </tr>
            </thead>
            <tbody>
            <%
            	for (Order order : orders) {
            %>
	                <tr>
	                    <td><a href="../flowerdetail.jsp?no=<%=order.getProduct().getNo() %>"><img src="../images/category/<%=order.getProduct().getImageName() %>" alt="상품이미지"></a></td>
	                    <td><%=order.getProduct().getName()%></td>
	                    <td><strong><%=order.getProduct().getSellPrice() %>원</strong></td>
	                    <td><%=order.getOrderQuantity() %></td>
	                    <td><%=order.getProduct().getSellPrice() %>원</td>
	                    <td>개별배송</td>
	                    <td><%=order.getProduct().getDeliveryFee() %>원</td>
	                    <td><strong><%=order.getTotalPrice() %>원</strong></td>
	                </tr>
             <%
            	}
             %>
            </tbody>
        </table>
     </div>
     <div>
        <table class="table">
            <tr class="table-secondary">
                <td>[개별배송]</td>
                <td style="text-align: right;">상품구매금액 <strong>300000</strong> + 배송비 9,000 = 합계: <strong><span style="font-size: x-large;">1314142</span>원</strong></td>
            </tr>
        </table>
    </div>
    
    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	<hr style="border: solid 1px black"> 
    <div>
     <form>
        <table class="table">
        	<thead>
                <tr>
                    <td><strong>배송 정보</strong></td>
                    <td style="text-align: right;"><span style="color:Red;">*</span> 필수입력사항</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>배송지 선택</td>
                    <td>
                        <div id="radio-list" class="form-check-inline">
                            <input class="form-check-input" type="radio" name="userAddressRadio" id="radio">
                            <label class="form-check-label" for="radio">회원 정보와 동일</label>
                        </div>
                        <div id="radio-list" class="form-check-inline">
                            <input class="form-check-input" type="radio" name="newAddressRadio" id="radio">
                            <label class="form-check-label" for="radio">새로운 배송지</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>받으시는 분 <span style="color:Red;">*</span></td>
                    <td>
	                    <div class="col-sm-3">
	                    	<input type="text" class="form-control" id="userInput" name="userName" placeholder="손동훈">
	                    </div>
                    </td>
                </tr>
                <tr>
                    <td>주소 <span style="color:Red;">*</span></td>
                    <td>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="postInput" name="postNum"><button type="button" class="btn btn-light btn-sm">우편번호</button>
                            
                        </div>
                        <div class="col-sm-6 form-inline">
                           	<p><input type="text" class="form-control" id="addressInput" name="address1">기본주소</p>
                            <p><input type="text" class="form-control" id="addressInput" name="address2"> 나머지주소(선택입력가능)</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>휴대전화 <span style="color:Red;">*</span></td>
                    <td>
                    	<div class="mb-3 col-sm-3">
                            <input type="text" class="form-control" id="phoneInput" name="phone" placeholder="010-0000-000">
						</div>
                    </td>
                </tr>
                <tr>
                    <td>이메일 <span style="color:Red;">*</span></td>
                    <td>
                       	<div class="mb-3 col-sm-3">
						  <input type="email" class="form-control" id="emailInput" name="email" placeholder="name@example.com">
						</div>
						<div class="form-text">
						  <p>- 이메일을 통해 주문처리과정을 보내드립니다.</p>
						  <p>- 이메일 주소란에는 반드시 수신가능한 이메일 주소를 입력해 주세요.</p>
						</div>
                    </td>
                </tr>
                <tr>
                    <td>배송메시지</td>
                    <td>
                    	<div class="mb-3">
						  <textarea class="form-control" id="messageInput" name="message" rows="3" placeholder="배송메시지를 입력하세요"></textarea>
						</div>
                    </td>
                </tr>
            </tbody>
        </table>
     </form>
    </div>
    
    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	    <hr style="border: solid 1px black"> 
    <div>
        <div style="margin-top: 30px;">
            <p ><strong>결제 예정 금액</strong></p>
        </div>
        <form action="">
        <table class="table">
        <colgroup>
        	<col style="width:33%">
        	<col style="width:34%">
        	<col style="width:33%">
        </colgroup>
            <thead>
                <tr class="table-secondary text-center">
                	<th><strong>총 주문 금액</strong></th>
                    <th><strong>총 할인 + 부가결제 금액</strong></th>
                    <th><strong>총 결제예정 금액</strong></th>
                </tr>
            </thead>
            <tbody>
                <tr class="text-center">
                    <td><strong><span style="font-size: x-large;">1314142</span>원</strong></td>
                    <td><strong>-<span style="font-size: x-large;">0</span>원</strong></td>
                    <td><strong>=<span style="font-size: x-large;">1314142</span>원</strong></td>
                </tr>
                <tr>
                    <td><strong>총 할인금액</strong></td>
                	<td colspan="2">0원</td>
                </tr>
                <tr>
                    <td><strong>총 부가결제금액</strong></td>
                	<td colspan="2">0원</td>
                </tr>
                <tr>
                    <td>적립금</td>
                	<td id="p-content" colspan="2">
                        <p><input type="number" name="usedPoint" >원(총 사용가능 적립금: <span style="color:Red;">1,000</span>원)</p>
                        <div class="form-text">
						  	<p>- 적립금은 최소 1,000 이상일 때 결제가 가능합니다.</p>
                        	<p>- 1회 구매시 적립금 최대 사용금액은 1,000원입니다.</p>
                        	<p>- 적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</p>
						</div>
                    </td>
                </tr>
            </tbody>
        </table> 
    </form>
    </div>

    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	    <hr style="border: solid 1px black"> 
    <div>
        <div style="margin-top: 30px;">
            <p ><strong>결제 수단</strong></p>	
        </div>
    </div>
    <div id="payment-method" class="row mb-5">
    	<div class="col" style="margin-top: 10px;">
	        <div class="mb-5" style="float: left; width: 70%;">
	            <div id="radio-list" class="form-check-inline">
	                <input class="form-check-input" type="radio" name="paymentMethodRadio" id="radio">
	                <label class="form-check-label" for="radio">카드결제</label>
	            </div>
	        
	            <div id="radio-list" class="form-check-inline">
	                <input class="form-check-input" type="radio" name="paymentMethodRadio" id="radio">
	                <label class="form-check-label" for="radio">무통장입금</label>
	            </div>
	        
	            <div id="radio-list" class="form-check-inline">
	                <input class="form-check-input" type="radio" name="paymentMethodRadio" id="radio">
	                <label class="form-check-label" for="radio">카카오페이</label>
	            </div>
	        </div>
	        <div style="float: right; width: 30%;">
	            <p><strong>최종 결제금액</strong></p>
	            <p><strong><span style="font-size: x-large;">1314142</span>원</strong></p>
	            <p><button type="submit" class="btn btn-dark btn-lg">결제하기</button></p>
	            <p style="border-top : solid 1px black; border-bottom : solid 1px black;"><strong>총 적립예정금액</strong> : <span style="color:Red;">0원</span></p>
	            <p>상품별 적립금 : 0원</p>
	            <p>회원 적립금 : 0원</p>
	            <p>쿠폰 적립금 : 원</p>
	        </div>
	        <div class="table">
	            <table id="deposit-table">
					<tr>
	                    <td>입금자명</td>
	                    <td><input type="text" class="form-control" id="depositorInput" name="depositorName"></td>
	                </tr>
	                <tr>
	                    <td>입금은행</td>
	                    <td>국민은행 000000-01-123456 플라낭</td>
	                </tr>
	            </table>
	        </div>
        </div>
    </div>
    
</div>
    

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="orderform.jsp"/>
</jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function submitModifyForm() {
		let userNameField = document.querySelector("input[name=userName]");
		if (userNameField.value === '') {
			alert("받으시는 분은 필수입력값입니다.");
			userNameField.focus();
			return false;
		}
		let addressField = document.querySelector("input[name=address1]");
		if (addressField.value === '') {
			alert("주소는 필수입력값입니다.");
			addressField.focus();
			return false;
		}
		let phoneField = document.querySelector("input[name=phone]");
		if (addressField.value === '') {
			alert("전화번호는 필수입력값입니다.");
			addressField.focus();
			return false;
		}
		let emailField = document.querySelector("input[name=email]");
		if (emailField.value === '') {
			alert("이메일은 필수입력값입니다.");
			emailField.focus();
			return false;
		}
		return true;
	}

</script>
</body>
</html>