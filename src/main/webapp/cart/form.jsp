<%@page import="vo.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="dao.CartItemDao"%>
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
	#content-height {line-height: 50%;}
	#content-height input  {width: 70px; height: 30px;}
    #div-h {padding-top: 20px; padding-bottom: 20px;}
    #h-table {border-style: solid; border-width: 7px;}
    #product-table tr {text-align: center; vertical-align: middle;}
   	#h1 {text-align: center; vertical-align: middle; table-layout: fixed; width: 150px;}
    #payment-Method {list-style-type: none; margin-left: 50px;}
    img {width: 100px; height: 100px;}
    
</style>
</head>
<body>
<!-- header -->
<jsp:include page="../common/nav.jsp">
    <jsp:param name="menu" value="cart"/>
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
	} else if ("deny".equals(fail)) {
%>
	<div class="alert alert-danger">
		<strong>거부</strong> 다른 사용자의 장바구니에 접근할 수 없습니다.
	</div>
<%
	}
%>
<%
	CartItemDao cartItemDao = CartItemDao.getInstance();
	List<CartItem> cartItems = cartItemDao.getCartItemsByUserNo(user.getNo());
%>
    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	<div>
        <p id="p-title"><strong>장바구니</strong></p>
    </div>
    <div id="div-h">
        <table id="h-table" class="table">
            <tr>
            	<td id="h1" rowspan="2"><strong>혜택정보</strong></td>
                <td><strong><%=user.getName() %></strong> 님은 [<%=user.getGrade() %>] 회원입니다.</td>
            </tr>
            <tr>
                <td>가용적립금: <strong><%=user.getPoint().getAvailble() %>원</strong></td>
            </tr>
        </table>
    </div>
    
    <div>
        <table class="table">
            <tr class="table-secondary">
                <td><strong>일반상품 (상품개수)</strong></td>
            </tr>
        </table>
    </div>
    <div id="product-table">
        <table class="table">
			<thead>
                <tr>
                    <th><input class="form-check-input" type="checkbox" name="checkAll" id="checkbox-toggle" onchange="toggleCheckbox();"></th>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>적립금</th>
                    <th>배송구분</th>
                    <th>배송비</th>
                    <th>합계</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
            <%
				if (cartItems.isEmpty()) {
			%>
					<tr>
						<td colspan="10" class="text-center"><strong>장바구니가 비어있습니다.</strong></td>
					</tr>
			<%
				} else {
					for (CartItem item : cartItems) {
			%>
		                <tr>
		                    <td><input class="form-check-input" type="checkbox" name="productNo"></td>
		                    <td><a href="../flowerdetail.jsp?no=<%=item.getProduct().getNo() %>"><img src="../images/category/<%=item.getProduct().getImageName() %>" alt="이미지"></a></td>
		                    <td><%=item.getProduct().getName() %></td>
		                    <td><strong><%=item.getProduct().getSellPrice() %>원</strong></td>
		                    <td id="content-height">
		                        <p><input type="number" name="quantity" maxlength="5" value="<%=item.getQuantity() %>"></p>
		                        <p><button type="button" class="btn btn-light btn-sm">변경</button></p>
		                    </td>
		                    <td><%=item.getProduct().getDepositPoint() %>원</td>
		                    <td>개별배송</td>
		                    <td><%=item.getProduct().getDeliveryFee() %>원</td>
		                    <td><strong><%=item.getOrderPrice() %>원</strong></td>
		                    <td>
		                    	<p><a href="purchase.jsp?productNo=<%=item.getNo() %>&price=<%=item.getOrderPrice() %>&quantity=<%=item.getQuantity() %>"><button type="button" class="btn btn-dark btn-sm">주문하기</button></a></p>
		                    	<p><a href="../mypage/wishlist/add.jsp?productNo=<%=item.getNo() %>"><button type="button" class="btn btn-light btn-sm">관심상품등록</button></a></p>
		                    	<p><a href="delete.jsp?productNo=<%=item.getNo() %>"><button type="button" class="btn btn-light btn-sm">삭제</button></a></p>
		                    </td>
		                </tr>
             <%
					}
				}
             %>
                
            </tbody>
        </table>
    </div>
    <div>
        <table class="table">
            <tr class="table-secondary">
                <td>[개별배송]</td>
                <td style="text-align: right;">상품구매금액 <strong></strong> + 배송비 9,000 = 합계: <strong><span style="font-size: x-large;">1314142</span>원</strong></td>
            </tr>
            <tr>
                <td><span style="color:Red;">!</span><span style="font-size: small;"> 할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.</span></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="border-bottom: none;">
                    <strong>선택상품을 </strong><button type="button" class="btn btn-secondary btn-sm">삭제하기</button>
                </td>
                <td style="border-bottom: none;">
                    <a href="deleteAll.jsp?userNo=<%=user.getNo() %>"><button type="button" class="btn btn-light btn-sm" style="float: right;">장바구니비우기</button></a>
                </td>
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
            </tbody>
        </table> 
    </form>
    </div>
    <div style="padding-top: 10px; padding-bottom: 70px; text-align: center; padding-left: 120px;">
        <button type="button" class="btn btn-dark">전체상품주문</button>
        <button type="button" class="btn btn-secondary">선택상품주문</button>
        <button type="button" class="btn btn-outline-dark" style="float: right;">쇼핑계속하기</button>
    </div>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="cartform.jsp"/>
</jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>

	function toggleCheckbox() {
	    let checkboxToggleCheckedState = document.getElementById('checkbox-toggle').checked;
	    let productCheckboxs = document.querySelectorAll('input[name=productNo]');
	    
	    for (let index = 0; index < productCheckboxs.length; index++) {
	        let productCheckboxs = productCheckboxs[index];
	        productCheckboxs.checked = checkboxToggleCheckedState;
	    }
	}

</script>
</body>
</html>