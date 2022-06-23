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
    <form action="../order/form.jsp" id="cart-form">
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
		                    <td><input id="product-number" class="form-check-input" type="checkbox" name="productNo" value="<%=item.getProduct().getNo() %>" onchange="updateProductPrice(); updateDeliveryPrice(); updateTotalPrice();"></td>
		                    <td><a href="../flowerdetail.jsp?no=<%=item.getProduct().getNo()%>"><img src="../images/category/<%=item.getProduct().getImageName()%>" alt="이미지"></a></td>
		                    <td><%=item.getProduct().getName()%></td>
		                    <td><strong id="product-price-<%=item.getProduct().getNo() %>"><%=item.getProduct().getSellPrice()%>원</strong></td>
		                    <td id="content-height">
		                        <p><input id="quantity-<%=item.getNo() %>" type="number" maxlength="5" name="quantity" value="<%=item.getQuantity()%>"></p>
		                        <p><button id="change-quantity" type="submit" class="btn btn-light btn-sm">변경</button></p>
		                    </td>
		                    <td><%=item.getProduct().getDepositPoint()%>원</td>
		                    <td>개별배송</td>
		                    <td id="delivery-fee-<%=item.getProduct().getNo() %>"><%=item.getProduct().getDeliveryFee()%>원</td>
		                    <td><strong id="order-price-<%=item.getProduct().getNo() %>"><%=item.getProduct().getSellPrice() + item.getProduct().getDeliveryFee()%>원</strong></td>
		                    <td>
		                    	<p><button type="button" class="btn btn-dark btn-sm" onclick="buy(<%=item.getProduct().getNo() %>, this);" data-item-no="<%=item.getNo() %>">주문하기</button></p>
		                    	<p><a href="addwish.jsp?productNo=<%=item.getProduct().getNo() %>"><button type="button" class="btn btn-light btn-sm">관심상품등록</button></a></p>
		                    	<p><a href="delete.jsp?itemNo=<%=item.getNo()%>"><button type="button" class="btn btn-light btn-sm">삭제</button></a></p>
		                    </td>
		                </tr>
             <%
					}
				}
             %>
            </tbody>
        </table>
    </form>
    </div>
    <div>
        <table class="table">
            <tr class="table-secondary">
                <td>[개별배송]</td>
                <td style="text-align: right;">상품구매금액 <strong id="total-product-price"></strong> + 배송비 <span id="total-delivery-fee"></span> = 합계: <strong><span id="total-order-price" style="font-size: x-large;"></span>원</strong></td>
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
        <div style="margin-top: 30px;">
            <p ><strong>결제 예정 금액</strong></p>
        </div>
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
                    <td><strong><span id="total-order-price" style="font-size: x-large;"></span>원</strong></td>
                    <td><strong>-<span style="font-size: x-large;">0</span>원</strong></td>
                    <td><strong>=<span id="total-order-price" style="font-size: x-large;"></span>원</strong></td>
                </tr>
            </tbody>
        </table> 
        <div style="padding-top: 10px; padding-bottom: 70px; text-align: center; padding-left: 120px;">
        	<button type="button" class="btn btn-dark" onclick="buyAll();">전체상품주문</button>
        	<button type="button" class="btn btn-secondary">선택상품주문</button>
        	<a href="../flowercategory.jsp"><button type="button" class="btn btn-outline-dark" style="float: right;">쇼핑계속하기</button></a>
    	</div>
</div>
    
<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="cartform.jsp"/>
</jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	
	// 전체 체크박스 제어
	function toggleCheckbox() {
		let checkAllboxCheckStatus = document.getElementById("checkbox-toggle").checked;
		// NodeList
        let productCheckboxList = document.querySelectorAll("input[name=productNo]:checked");
        for (let index = 0; index < productCheckboxList.length; index++){
            let productCheckbox = productCheckboxList[index];
            productCheckbox.checked = checkAllboxCheckStatus;
        }
	}
	
	// 체크박스로 선택한 상품 금액 합계
	function updateProductPrice() {
		let totalProductPrice = 0;
		let checkboxes = document.querySelectorAll("input[name=productNo]:checked");
		
		for (let i = 0; i<checkboxes.length; i++) {
			let checkbox = checkboxes[i];
			let productNo = checkbox.value;
			let strong = document.querySelector("#product-price-" + productNo);
			let productPrice = parseInt(strong.textContent);
			
			totalProductPrice += productPrice;
		}
		document.querySelector("#total-product-price").textContent = totalProductPrice;
	}
	
	// 체크박스로 선택한 상품 배달비용 합계
	function updateDeliveryPrice() {
		let totalDeliveryFee = 0;
		let checkboxes = document.querySelectorAll("input[name=productNo]:checked");
		
		for (let i = 0; i<checkboxes.length; i++) {
			let checkbox = checkboxes[i];
			let productNo = checkbox.value;
			let strong = document.querySelector("#delivery-fee-" + productNo);
			let deliveryFee = parseInt(strong.textContent);
			
			totalDeliveryFee += deliveryFee;
		}
		document.querySelector("#total-delivery-fee").textContent = totalDeliveryFee;
	}	
	
	// 체크박스로 선택한 상품 총 주문금액 합계
	function updateTotalPrice() {
		let totalOrderPrice = 0;
		let checkboxes = document.querySelectorAll("input[name=productNo]:checked");
		
		for (let i = 0; i<checkboxes.length; i++) {
			let checkbox = checkboxes[i];
			let productNo = checkbox.value;
			let strong = document.querySelector("#order-price-" + productNo);
			let orderPrice = parseInt(strong.textContent);
			
			totalOrderPrice += orderPrice;
		}
		document.querySelector("#total-order-price").textContent = totalOrderPrice;
	}
	
	// 상품 하나만 주문하기 (상품 오른쪽 주문버튼)
	// productNo 주문할 상품번호
	// btn this로 호출한 자기자신의 엘리먼트 (버튼)
	function buy(productNo, btn) {
		// btn엘리먼트의 data속성(장바구니아이템번호)를 가져오기
		let itemNo = btn.getAttribute("data-item-no");
		// id가 'quantity-장바구니아이템번호' 인 엘리먼트 가져오기
		let input = document.getElementById("quantity-" + itemNo);
		// 가져온 엘리먼트의 값을 변수에 넣기
		let quantity = input.value;
		
		// location.href = "ㅁㄴㅇㄹㅁㄴㅇ" -> 해당 주소링크로 이동하는 메소드
		// productNo 인자값으로 받아온 상품번호
		// quantity 인자값 btn의 data속성과 같은 아이템 번호를 가진 엘리먼트의 값 (아이템 수량)
		location.href = "../order/form.jsp?productNo="+ productNo+"&quantity="+quantity;
	}
	
	// 전체상품주문
	function buyAll() {
		// productNo 이름을 가진 모든 체크박스 엘리먼트 조회
		let checkboxes = document.querySelectorAll("input[name='productNo']");
		// 조회된 모든 체크박스 체크하기
		for (let i=0; i<checkboxes.length; i++) {
			checkboxes[i].checked = true;
		}
		// id가 cart-form인 엘리먼트의 submit() 메소드 실행
		document.getElementById("cart-form").submit();
	}
	
</script>
</body>
</html>