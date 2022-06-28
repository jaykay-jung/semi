<%@page import="vo.User"%>
<%@page import="vo.Address"%>
<%@page import="dao.AddressDao"%>
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
<!-- 카카오 우편번호 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function popupZipSearch(){
	new daum.Postcode({
		oncomplete: function(data) {
		// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	 
		  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		  var fullAddr = ''; // 최종 주소 변수
		  var extraAddr = ''; // 조합형 주소 변수
		 
		  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		      fullAddr = data.roadAddress;
		  } else { // 사용자가 지번 주소를 선택했을 경우(J)
		      fullAddr = data.jibunAddress;
		  }
		 
		  // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		  if(data.userSelectedType === 'R'){
		      //법정동명이 있을 경우 추가한다.
		      if(data.bname !== ''){
		          extraAddr += data.bname;
		      }
		      // 건물명이 있을 경우 추가한다.
		      if(data.buildingName !== ''){
		          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		      }
		      // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		      fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		  }
	 
		  // 우편번호와 주소 정보를 해당 필드에 넣는다.
		  document.getElementById('zip').value = data.zonecode;
		  document.getElementById("addr1").value = fullAddr;
		  // 커서를 상세주소 필드로 이동한다.
		  document.getElementById("addr2").focus();
		}
	

}).open({
    popupKey: 'popup1' //팝업창 Key값 설정 (영문+숫자 추천)
});
}
 
</script>

<!-- 스타일 -->
<style type="text/css">
input {
border:1px solid #d5d5d5;
font-size:12px;
padding:5px;
}

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
  	
  	<%
		// 세션에서 로그인된 사용자 정보 조회하기
		User user = (User) session.getAttribute("LOGINED_USER");
		if (user == null) {
			response.sendRedirect("../loginform.jsp?fail=deny");
			return;
		}

  		// 요청파라미터값을 조회한다.
  		int addressNo = Integer.parseInt(request.getParameter("addressNo"));
  	
		// 주소록을 조회한다.
		AddressDao addressDao = AddressDao.getInstance();
		Address address = addressDao.getAddress(addressNo);
  	
		// 주소정보가 없으면 재요청 URL을 응답으로 보낸다.
		if (address == null) {
			throw new RuntimeException("존재하지 않는 주소입니다.");
		}
		if (address.getUser().getNo() != user.getNo()) {
			throw new RuntimeException("다른 사용자의 주소록은 수정할 수 없습니다.");
		}
		
  	%>
  	
  	
  	
  	
<!-- 주소록 입력 퐄 -->
	<form action="modify.jsp" method="post">
		<input type="hidden" name="addressNo" value="<%=address.getNo() %>" />		
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col" >
        			<div style="float:left; width:120px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px; margin-left: 7px;">배송지명</font>
        				<img src="../../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="text" name="nickname" style="width:190px; height:24px;" value="<%=address.getNickName() %>">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col">
        			<div style="float:left; width:120px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px;margin-left: 7px;">성명</font><img src="../../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="text" name="name" style="width:190px; height:24px;" value="<%=address.getName() %>">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
	    	
		</div>
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:98px;">
        		<div class="col">
        			<div style="float:left; width:120px; height:98px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height:10px;margin-left: 7px;">주소</font><img src="../../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:5px 10px;">
						<div style="height:29px;">
							<input type="text" id="zip" name="zip" style="width:70px; height:24px;" readonly="readonly" value="<%=address.getZip() %>">
							<a href="javascript:void(0);" onclick="popupZipSearch();return false;"><img src="../../images/mypage/address-zipcode.png" style="margin-left:5px; margin-bottom:6px;" ></a>

						</div>
						<div style="height:29px;">
							<input type="text" id="addr1" name="addr1" style="width:460px; height:24px;"><span style="height:15px; font-size:12px;" value="<%=address.getCity() %>"> 기본주소 </span>
						</div>
						<div style="height:29px;">
							<input type="text" id="addr2" name="addr2" style="width:460px; height:24px;"><span style="height:15px;font-size:12px;" value="<%=address.getStreet() %>">  나머지주소(선택입력가능)</span>
						</div>
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; border-bottom:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col">
        			<div style="float:left; width:120px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px;margin-left: 7px;">휴대전화</font><img src="../../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="text" name="phone" style="width:190px; height:24px;" value="<%=address.getTel() %>">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
<!-- 체크박스와 등록버튼 -->		
		<div>
			<div class="row" style="height:40px;">
        		<div class="col" >
        			<div style="float:right; width:170px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
						<input type="checkbox" name="basic" value="T" style="width:13px; height:13px;">
        				<font style="line-height: 10px; margin-left: 7px;">기본 배송지로 저장</font>
					</div>
				</div>
	    	</div>
		</div>	
	  	<div class="row">
			<div class="col">
		       	<div class="vertical-align-content2" style="float:right; background-color:#999; ">
		       		<a class="nolinelink" href="list.jsp" style="color:white;">
					<font>취소</font>
					</a>
				</div>
		       	<div class="vertical-align-content2" style="float:right; background-color:black; ">
					<button type="submit" style="border:0; padding: 4px 30px; background-color:black;"><font style="color:white;">수정</font></button>
				</div>
			</div>
		</div>
		
	</form>

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
<jsp:include page="/common/footer.jsp">
	<jsp:param name="footer" value="register"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 	
