<%@page import="dao.PointDao"%>
<%@page import="vo.Point"%>
<%@page import="vo.Address"%>
<%@page import="dao.AddressDao"%>
<%@page import="vo.Product"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ProductDao"%>
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
	#title {border-bottom: solid 2px rgba(0, 0, 0, 0.15); font-size: larger;}
	#p-content {line-height: 50%;}
    #div-h {padding-top: 20px; padding-bottom: 20px;}
    #h_table {border-style: solid; border-width: 7px;}
   	#h1 {text-align: center; vertical-align: middle; table-layout: fixed; width: 150px;}
   	#product-table tr {text-align: center; vertical-align: middle;}
    #payment-method {border: 1px solid black; padding:10px;}
    #deposit-table td {padding: 10px}
    img {width: 100px; height: 100px;}
    hr {border: solid 1px black; margin-top: 70px;}
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
	// 장바구니폼에서 보내준 productNo의 value값 가져오기 (List형식)
	String[] productNoValues = request.getParameterValues("productNo");
	// 장바구니폼에서 보내준 quantity의 value값 가져오기 (List형식)
	String[] quantityValues = request.getParameterValues("quantity");
	
	// 상품정보
	ProductDao productDao = ProductDao.getInstance();
	// 로그인한 사용자의 주소정보 가져오기
	AddressDao addressDao = AddressDao.getInstance();
	Address address = addressDao.getAddressByUserNo(user.getNo());
	// 로그인한 사용자의 포인트정보 가져오기
	PointDao pointDao = PointDao.getInstance();
	Point point = pointDao.getPointByUserNo(user.getNo());
	
%>

	<form action="complete.jsp" id="order-form" method="post" onsubmit="return inputCheck()">

	    <div class="row">
			<div class="col" style="margin-top: 10px;">
				<h1 id="title" class="fs-4 borderless p-2">주문서 작성</h1>
				    <div id="div-h">
				        <table id="h_table" class="table">
				            <tr>
				            	<td id="h1" rowspan="2"><strong>혜택정보</strong></td>
				                <td><strong><%=user.getName() %></strong> 님은 [<%=user.getGrade() %>] 회원입니다.</td>
				            </tr>
				            <tr>
				                <td>가용적립금:<strong><%=point.getAvailble()%>원</strong></td>
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
				            	int totalOrderPrice = 0; // 총 주문금액
				            	int totalProductPrice = 0; // 총 상품금액(*수량)
				            	int totalDeliveryFee = 0; // 총 배달비용
				            	int totalDepositPoint = 0; // 총 적립금액
				            	for (int i = 0; i<productNoValues.length; i++) {
				            		// productNoValues 리스트에서 상품번호를 꺼내 productNo 변수에 담기 (+ 형변환 필요)
				            		int productNo = StringUtil.stringToInt(productNoValues[i]);
				            		// quantityValues 리스트에서 주문수량을 꺼내 quantity 변수에 담기 (+ 형변환 필요)
				            		int quantity = StringUtil.stringToInt(quantityValues[i]);
				            		// 꺼낸 상품번호로 Dao메소드를 사용. 상품정보 불러오기
				            		Product product = productDao.getProductByNo(productNo);
				            		
				            		// 수량과 배송비를 포함해 계산한 상품가격 변수 만들기
				            		int productPrice = (product.getSellPrice()*quantity) + product.getDeliveryFee();
				            		// 필요한 변수 만들기
				            		totalOrderPrice += productPrice;
				            		totalProductPrice += product.getSellPrice()*quantity;
				            		totalDeliveryFee += product.getDeliveryFee();
				            		totalDepositPoint += product.getDepositPoint();
				            		
				            		// 테이블에 값 사용
				            %>
					                <tr>
					                    <td><a href="../flowerdetail.jsp?no=<%=product.getNo() %>"><img src="../images/category/<%=product.getImageName() %>" alt="상품이미지"></a></td>
					                    <td><%=product.getName()%></td>
					                    <td><strong><%=product.getSellPrice() %>원</strong></td>
					                    <td><%=quantity %></td>
					                    <td><%=product.getDepositPoint() %>원</td>
					                    <td>개별배송</td>
					                    <td><%=product.getDeliveryFee() %>원</td>
					                    <td><strong id="product-price-<%=product.getNo() %>"><%=product.getSellPrice()*quantity + product.getDeliveryFee() %></strong>원</td>
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
				                <td style="text-align: right;">상품구매금액 <strong><%=totalProductPrice %></strong> + 배송비 <%=totalDeliveryFee %> = 합계: <strong><span style="font-size: x-large;"><%=totalOrderPrice %></span>원</strong></td>
				            </tr>
				        </table>
				    </div>
					<hr> 
				    <div>
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
				                            <input class="form-check-input" type="radio" name="radioAddress" id="radio-address" onclick="getUserInfo('<%=user.getName() %>','<%=user.getPhone() %>','<%=user.getEmail() %>');">
				                            <label class="form-check-label" for="radio">회원 정보와 동일</label>
				                        </div>
				                        <div id="radio-list" class="form-check-inline">
				                            <input class="form-check-input" type="radio" name="radioAddress" id="radio-address" onclick="getNewInfo();">

				                            <label class="form-check-label" for="radio">새로운 배송지</label>
				                        </div>
				                    </td>
				                </tr>
				                <tr>
				                    <td>받으시는 분 <span style="color:Red;">*</span></td>
				                    <td>
					                    <div class="col-sm-3">

					                    	<input type="text" class="form-control" id="name-input" name="userName" placeholder="이름" value="">

					                    </div>
				                    </td>
				                </tr>
				                <tr>
				                    <td>주소 <span style="color:Red;">*</span></td>
				                    <td>
				                        <div class="col-sm-2">

				                            <input type="text" class="form-control" style="float:left;" id="post-code" name="postNo" value="" placeholder="우편번호" disabled>
				                        </div>
				                        <div class="col-sm-3">
				                        	<input type="button" class="btn btn-light btn-sm" style="float:right;" onclick="daumPostAPI();" value="주소찾기">
				                        </div>
				                        <div class="col-sm-6">
				                           	<p><input type="text" class="form-control" id="road-address" name="roadAddress" value="" placeholder="기본주소" disabled></p>
				                            <p><input type="text" class="form-control" id="detail-address" name="detailAddress" value="" placeholder="나머지주소 (선택입력)"></p>

				                        </div>
				                    </td>
				                </tr>
				                <tr>
				                    <td>휴대전화 <span style="color:Red;">*</span></td>
				                    <td>
				                    	<div class="mb-3 col-sm-3">

				                            <input type="text" class="form-control" id="phone-input" name="phone" value="" placeholder="010-0000-0000">

										</div>
				                    </td>
				                </tr>
				                <tr>
				                    <td>이메일 <span style="color:Red;">*</span></td>
				                    <td>
				                       	<div class="mb-3 col-sm-3">

										  <input type="email" class="form-control" id="email-input" name="email" value="" placeholder="name@example.com">

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

										  <textarea class="form-control" id="message-input" name="message" rows="3" placeholder="배송메시지를 입력하세요"></textarea>

										</div>
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				    </div>
				    <hr> 
				    <div>
					    <div style="margin-top: 30px;">
					        <p><strong>결제 예정 금액</strong></p>
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
					                <td><strong><span style="font-size: x-large;"><%=totalOrderPrice %></span>원</strong></td>
					                <td><strong>-<span style="font-size: x-large;">0</span>원</strong></td>
					                <td><strong>=<span style="font-size: x-large;"><%=totalOrderPrice %></span>원</strong></td>
					            </tr>
					            <tr>
					                <td><strong>총 할인금액</strong></td>
					            	<td colspan="2">0원</td>
					            </tr>
					            <tr>
					                <td><strong>총 부가결제금액</strong></td>

					            	<td colspan="2">0 원</td>

					            </tr>
					            <tr>
					                <td>적립금</td>
					            	<td id="p-content" colspan="2">

					                    <p><input type="number" id="use-point" name="usePoint" min="0" >원(총 사용가능 적립금: <span style="color:Red;"><%=point.getAvailble()%></span>원)</p>

					                    <div class="form-text">
							  				<p>- 적립금은 최소 1,000원 이상일 때 결제가 가능합니다.</p>
					                    	<p>- 1회 구매시 적립금 최대 사용금액은 1,000원입니다.</p>
					                    	<p>- 적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</p>
										</div>
					                </td>
					            </tr>
					        </tbody>
					    </table> 
				    </div>
			    <hr> 
			    <div>
			        <div style="margin-top: 30px;">
			            <p ><strong>결제 수단</strong></p>	
			        </div>
			    </div>
			    <div id="payment-method" class="row mb-5">
			    	<div class="col" style="margin-top: 10px;">
				        <div class="mb-5" style="float: left; width: 70%;">
				            <div id="radio-list" class="form-check-inline">

				                <input class="form-check-input" type="radio" name="paymentMethod" id="radio-payment-card" onclick="displayPaymentInfo()">

				                <label class="form-check-label" for="radio">카드결제</label>
				            </div>
				        
				            <div id="radio-list" class="form-check-inline">

				                <input class="form-check-input" type="radio" name="paymentMethod" id="radio-payment-bankbook" onclick="displayPaymentInfo()">

				                <label class="form-check-label" for="radio">무통장입금</label>
				            </div>
				        
				            <div id="radio-list" class="form-check-inline">

				                <input class="form-check-input" type="radio" name="paymentMethod" id="radio-payment-kakaopay" onclick="displayPaymentInfo()">

				                <label class="form-check-label" for="radio">카카오페이</label>
				            </div>
				        </div>
				        <div style="float: right; width: 30%;">
				            <p><strong>최종 결제금액</strong></p>
				            <p><strong><span style="font-size: x-large;"><%=totalOrderPrice %></span>원</strong></p>
				            <p><button type="submit" class="btn btn-dark btn-lg">결제하기</button></p>
				            <p style="border-top : solid 1px black; border-bottom : solid 1px black;"><strong>총 적립예정금액</strong> : <span style="color:Red;"><%=totalDepositPoint %>원</span></p>
				            <p>상품별 적립금 : <%=totalDepositPoint %>원</p>
				            <p>회원 적립금 : 0원</p>
				            <p>쿠폰 적립금 : 0원</p>
				        </div>

				        <div id="payment-info-card" style="display:none;">
				        	<p><strong>카드 결제</strong></p>
				        	<span style="color:Red;">!</span> 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
				        </div>
				        <div id="payment-info-bankbook" class="table" style="display:none;">
				        	<p><strong>무통장입금 결제</strong></p>

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
				        <div id="payment-info-kakaopay" style="display:none;">
				        	<p><strong>카카오페이 결제</strong></p>
				        	<span style="color:Red;">!</span> 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
				        </div>
			        </div>
		    	</div>
		 	</div>
		 </div>
	</form>
</div>

<!-- footer -->
<jsp:include page="../common/footer.jsp">
	<jsp:param name="footer" value="orderform.jsp"/>
</jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


	// 회원정보와 동일 라디오 버튼 메소드
	function getUserInfo(userName, userPhone, userEmail) {
		document.getElementById("name-input").value = userName;
		document.getElementById("phone-input").value = userPhone;
		document.getElementById("email-input").value = userEmail;
		
		function disableInput() {
			document.getElementById("name-input").setAttribute('disabled',true);
			document.getElementById("phone-input").setAttribute('disabled',true);
			document.getElementById("email-input").setAttribute('disabled',true);
		}
		disableInput();
	}
	
	// 새로운 배송지 라디오 버튼 메소드
	function getNewInfo() {
		document.getElementById("name-input").value = '';
		document.getElementById("phone-input").value = '';
		document.getElementById("email-input").value = '';
		
		function useableInput() {
			document.getElementById("name-input").removeAttribute('disabled');
			document.getElementById("phone-input").removeAttribute('disabled');
			document.getElementById("email-input").removeAttribute('disabled');
		}
		useableInput();
	}

	// 주소찾기 버튼 메소드
	// 다음주소 API 

	function daumPostAPI() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                let extra = '';
                let road = '';


                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.

                    // document.getElementById("extraAddress").value = extraAddr;
                } else {
                    // document.getElementById("extraAddress").value = '';
                    extraAddr = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("post-code").value = data.zonecode;
                document.getElementById("road-address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detail-address").focus();

            }
        }).open();
    }
	

	// 결제수단 라디오버튼 처리
	function displayPaymentInfo() {

		let card = document.getElementById("radio-payment-card").checked;
		let bankbook = document.getElementById("radio-payment-bankbook").checked;
		let kakaopay = document.getElementById("radio-payment-kakaopay").checked;
		
		if (card == true) {
			document.getElementById("payment-info-card").style.display = "block";	
		} else {
			document.getElementById("payment-info-card").style.display = "none";
		}
	
		if (bankbook == true) {
			document.getElementById("payment-info-bankbook").style.display = "block";	
		} else {
			document.getElementById("payment-info-bankbook").style.display = "none";
		}
		
		if (kakaopay == true) {
			document.getElementById("payment-info-kakaopay").style.display = "block";	
		} else {
			document.getElementById("payment-info-kakaopay").style.display = "none";
		}
		
	}
	
	// 배송정보 입력에 필수입력값이 없으면 페이지 이동을 막는 메소드
	function inputCheck() {
		let name = document.getElementById("name-input");
		let postCode = document.getElementById("post-code");
		let address = document.getElementById("road-address");
		let phone = document.getElementById("phone-input");
		let email = document.getElementById("email-input");
		
		if (name.value.length == '') {
			alert("받으실 분 성함을 입력하세요");
			return false;
		}
		
		if (postCode.value.length == 0) {
			alert("주소를 입력하세요");
			return false;
		}
		
		if (address.value.length == '') {
			alert("주소를 입력하세요");
			return false;
		}
		
		if (phone.value.length == '') {
			alert("연락처를 입력하세요");
			return false;
		}
		
		if (email.value.length == '') {
			alert("이메일을 입력하세요");
			return false;
		}
		
		return true;
	}
	
</script>
</body>
</html>