<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PLANANT</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.p_title {border-bottom: solid 2px rgba(0, 0, 0, 0.15); font-size: larger;}
	.p_content {line-height: 50%;}
    .h_table {border-style: solid; border-width: 10px;}
   	.alignright {text-align:right;}
   	#h1 {text-align: center; vertical-align: middle;}
    div.div_payment {border:1px solid; padding:10px;}
    div.left {width: 70%; float: left;}
    div.right {width: 30%; float: right;}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
    <jsp:param name="menu" value="orderform"/>
</jsp:include>

<div class="container">
    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	<div>
        <p class="p_title"><strong>주문서 작성</strong></p>
    </div>
    <div id="h_table">
        <table class="table table-bordered">
            <tbody>
                <tr>
                	<td id="h1" rowspan="2"><strong>혜택정보</strong></td>
                    <td><strong>손동훈</strong> 님은, [일반] 회원입니다.</td>
                </tr>
                <tr>
                    <td>가용적립금:<strong>1000원</strong><span style="padding-left:30px;"></span> 쿠폰:<strong>0개</strong></td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div>
        <table class="table">
            <tr class="table-danger text-danger">
                <td>상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</td>
            </tr>
            <tr class="table-secondary">
                <td><strong>배송상품 주문내역</strong></td>
                <td>
					<button type="button" class="btn btn-outline-primary" style="float:right;">이전페이지</button>
                </td>
            </tr>
        </table>
    </div>
    <div>
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
                <tr>
                    <td>상품이미지</td>
                    <td>자나장미 꽃다발 100송이장미, 50송이 150송이 생화</td>
                    <td><strong>100000원</strong></td>
                    <td>10</td>
                    <td>300원</td>
                    <td>개별배송</td>
                    <td>3000원</td>
                    <td><strong>103000원</strong></td>
                </tr>
                <tr>
                    <td>상품이미지</td>
                    <td>자나장미 꽃다발 100송이장미, 50송이 150송이 생화</td>
                    <td><strong>100000원</strong></td>
                    <td>10</td>
                    <td>300원</td>
                    <td>개별배송</td>
                    <td>3000원</td>
                    <td><strong>103000원</strong></td>
                </tr>
                <tr>
                    <td>상품이미지</td>
                    <td>자나장미 꽃다발 100송이장미, 50송이 150송이 생화</td>
                    <td><strong>100000원</strong></td>
                    <td>10</td>
                    <td>300원</td>
                    <td>개별배송</td>
                    <td>3000원</td>
                    <td><strong>103000원</strong></td>
                </tr>
            </tbody>
        </table>
     </div>
     <div>
        <table class="table">
            <tbody>
                <tr class="table-secondary">
                    <td>[개별배송]</td>
                    <td class="alignright">상품구매금액 <strong>300000</strong> + 배송비 9,000 = 합계: <strong><big>1314143</big>원</strong></td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div class="row">
		<div class="col" style="margin-top: 10px;">
			<h1 class="fs-4 borderless p-2"></h1>
		</div>
	</div>
	<hr style="border: solid 1px black"> 
    <div>
    <form action="">
        <table class="table">
        	<thead>
                <tr>
                    <td><strong>배송 정보</strong></td>
                    <td class="alignright"><span style="color:Red;">*</span> 필수입력사항</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>배송지 선택</td>
                    <td><input type="radio" name="userAddress" value="배송지">회원 정보와 동일 <input type="radio" name="anotherAddress" value="배송지">새로운 배송지</td>
                </tr>
                <tr>
                    <td>받으시는 분 <span style="color:Red;">*</span></td>
                    <td><input type="text" name="userName" value="손동훈" minlength="2" maxlength="20"></td>
                </tr>
                <tr>
                    <td>주소 <span style="color:Red;">*</span></td>
                    <td>
                        <p><input type="number" name="postNumber" > 우편번호</p>
                        <p><input type="text" name="address1" > 기본주소</p>
                        <p><input type="text" name="address2" > 나머지주소(선택입력가능)</p>
                    </td>
                </tr>
                <tr>
                    <td>휴대전화 <span style="color:Red;">*</span></td>
                    <td><input type="text" name="userPhone" ></td>
                </tr>
                <tr>
                    <td>이메일 <span style="color:Red;">*</span></td>
                    <td>
                        <p><input type="text" name="userEmail" ></p>
                        <p class="p_content"><small>- 이메일을 통해 주문처리과정을 보내드립니다.</small></p>
                        <p class="p_content"><small>- 이메일 주소란에는 반드시 수신가능한 이메일 주소를 입력해 주세요.</small></p>
                    </td>
                </tr>
                <tr>
                    <td>배송메시지</td>
                    <td><textarea name="memo" cols="50" rows="3" placeholder="배송메시지를 입력하세요"></textarea></td>
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
                    <td><strong><big>1314143</big>원</td>
                    <td><strong><big>0</big>원</td>
                    <td><strong>=<big>1314143</big>원</td>
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
                	<td colspan="2">
                        <p><input type="text" name="usedPoint" >원(총 사용가능 적립금: <span style="color:Red;">1,000</span>원)</p>
                        <p class="p_content">- 적립금은 최소 1,000 이상일 때 결제가 가능합니다.</p>
                        <p class="p_content">- 1회 구매시 적립금 최대 사용금액은 1,000원입니다.</p>
                        <p class="p_content">- 적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</p>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>