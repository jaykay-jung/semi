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
<jsp:include page="common/nav.jsp">
    <jsp:param name="menu" value="cartform"/>
</jsp:include>

<!-- content -->
<div class="container">
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
            <tbody>
                <tr>
                	<td id="h1" rowspan="2"><strong>혜택정보</strong></td>
                    <td><strong>손동훈</strong> 님은 [일반] 회원입니다.</td>
                </tr>
                <tr>
                    <td>가용적립금:<strong>1000원</strong></td>
                </tr>
            </tbody>
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
                    <th><input class="form-check-input" type="radio" name="checkAll" id="radio"></th>
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
                <tr>
                    <td><input class="form-check-input" type="radio" name="check" id="radio"></td>
                    <td><img src="images/catogory-flower/Sample2_JanaRoseBunch.jpg" alt="자나장미"></td>
                    <td>자나장미 꽃다발 100송이장미, 50송이 150송이 생화</td>
                    <td><strong>100000원</strong></td>
                    <td id="content-height">
                        <p><input type="number" name="quantity" maxlength="5"></p>
                        <p><button type="button" class="btn btn-light btn-sm">변경</button></p>
                    </td>
                    <td>300원</td>
                    <td>개별배송</td>
                    <td>3000원</td>
                    <td><strong>103000원</strong></td>
                    <td>
                    	<p><button type="button" class="btn btn-dark btn-sm">주문하기</button></p>
                    	<p><button type="button" class="btn btn-light btn-sm">관심상품등록</button></p>
                    	<p><button type="button" class="btn btn-light btn-sm">삭제</button></p>
                    </td>
                </tr>
                <tr>
                    <td><input class="form-check-input" type="radio" name="check" id="radio"></td>
                    <td><img src="images/catogory-flower/Sample2_JanaRoseBunch.jpg" alt="자나장미"></td>
                    <td>자나장미 꽃다발 100송이장미, 50송이 150송이 생화</td>
                    <td><strong>100000원</strong></td>
                    <td id="content-height">
                        <p><input type="number" name="quantity" maxlength="5"></p>
                        <p><button type="button" class="btn btn-light btn-sm">변경</button></p>
                    </td>
                    <td>300원</td>
                    <td>개별배송</td>
                    <td>3000원</td>
                    <td><strong>103000원</strong></td>
                    <td>
                    	<p><button type="button" class="btn btn-dark btn-sm">주문하기</button></p>
                    	<p><button type="button" class="btn btn-light btn-sm">관심상품등록</button></p>
                    	<p><button type="button" class="btn btn-light btn-sm">삭제</button></p>
                    </td>
                </tr>
                <tr>
                    <td><input class="form-check-input" type="radio" name="check" id="radio">
                    <td><img src="images/catogory-flower/Sample2_JanaRoseBunch.jpg" alt="자나장미"></td>
                    <td>자나장미 꽃다발 100송이장미, 50송이 150송이 생화</td>
                    <td><strong>100000원</strong></td>
                    <td id="content-height">
                        <p><input type="number" name="quantity" maxlength="5"></p>
                        <p><button type="button" class="btn btn-light btn-sm">변경</button></p>
                    </td>
                    <td>300원</td>
                    <td>개별배송</td>
                    <td>3000원</td>
                    <td><strong>103000원</strong></td>
                    <td>
                    	<p><button type="button" class="btn btn-dark btn-sm">주문하기</button></p>
                    	<p><button type="button" class="btn btn-light btn-sm">관심상품등록</button></p>
                    	<p><button type="button" class="btn btn-light btn-sm">삭제</button></p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div>
        <table class="table">
            <tr class="table-secondary">
                <td>[개별배송]</td>
                <td style="text-align: right;">상품구매금액 <strong>300000</strong> + 배송비 9,000 = 합계: <strong><span style="font-size: x-large;">1314142</span>원</strong></td>
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
                    <button type="button" class="btn btn-light btn-sm" style="float: right;">장바구니비우기</button>
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
    <div style="padding-top: 10px; padding-bottom: 70px; text-align: center;">
        <button type="button" class="btn btn-dark">전체상품주문</button>
        <button type="button" class="btn btn-secondary">선택상품주문</button>
        <button type="button" class="btn btn-outline-dark" style="float: right;">쇼핑계속하기</button>
    </div>
</div>

<!-- footer -->
<jsp:include page="common/footer.jsp">
	<jsp:param name="footer" value="cartform.jsp"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>