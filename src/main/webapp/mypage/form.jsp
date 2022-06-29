<%@page import="vo.OrderSummary"%>
<%@page import="dao.OrderSummaryDao"%>
<%@page import="vo.Point"%>
<%@page import="dao.PointDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("마이페이지는 로그인 후 사용가능한 서비스 입니다.");
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
    height: 18px;
    line-height: 15px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
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
font {font-size:13px;}
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
				<h6><strong>마이페이지</strong></h6>
			</div>
			<div style="float: right; width:300px; height:auto; text-align:right; color:gray;">	
				<font><a class="nolinelink" href="../home.jsp" style="color:gray;">홈</a></font>
				<font><strong>》</strong></font>
				<font><a class="nolinelink" href="mypage.jsp" style="color:gray;">마이페이지</a></font>
				<font><strong>》</strong></font>
				<font><strong>회원정보수정</strong></font>
			</div><div style="clear:both:"></div>
    	</div>
		<hr style="border: gray 0.7px dotted;">	
  	</div>
  	

<%
	// 포인트를 조회한다.
	int userNo = user.getNo();
	PointDao pointDao = PointDao.getInstance();
	Point point = pointDao.getPointByUserNo(userNo);

	// 주문내역을 조회한다.
	OrderSummaryDao orderSummaryDao = OrderSummaryDao.getInstance();
	OrderSummary orderSummary = orderSummaryDao.getOrderSummaryByUserNo(userNo);
	
%>  	
<!-- 회원이름과 등급 -->				
	<div style="margin:20px 5px; border:1px solid gainsboro; ">
		<div class="row" style="margin:10px; height:auto;">
        	<div class="col">
        		<div style="float:left; width:90px; height:80px; line-height:30px; border-right:1px solid gainsboro;">
        			<img src="../images/mypage/login-icon.png" width="73">
				</div>
				<div style="float:left; width:80%; margin:30px 10px; color:gray;">	
					<font> 저희 쇼핑몰을 이용해주셔서 감사합니다.</font>
					<font><strong> <%=user.getName() %> </strong></font>
					<font>님은</font>
					<font><strong>[<%=user.getGrade() %>]</strong></font>
					<font>이십니다.</font>
				</div><div style="clear:both:"></div>
			</div>
    	</div>
	</div>

 	
<!-- 회원정보 입력 퐄 -->

<!-- 
<form>태그에서 onsubmit 이벤트가 발생하면 submitRegisterForm() 함수가 실행된다.
submitRegisterForm()함수가 true를 반환하면 <form>태그내의 폼 입력값이 서버(register.jsp)로 제출된다.
submitRegisterForm()함수가 false를 반환하면 <form>태그내의 폼 입력값이 서버(register.jsp)로 제출되지 않는다.
-->

	<form id="user-form" method="post" action="modifyinfo.jsp" onsubmit="return submitModifyForm()">
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col" >
        			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px; margin-left: 7px;">아이디</font>
        				<img src="../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="text" name="id" style="width:136px; height:24px;" readonly="readonly"  value="<%=user.getId() %>"><span style="height:15px; font-size:12px;"> (영문소문자/숫자, 4~16자) </span>
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col" >
        			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px; margin-left: 7px;">비밀번호</font>
        				<img src="../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="password" name="password" style="width:136px; height:24px;" ><span style="height:15px; font-size:12px;"> (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자) </span>
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col" >
        			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px; margin-left: 7px;">비밀번호 확인</font>
        				<img src="../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="password" name="password2" style="width:136px; height:24px;">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col">
        			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px;margin-left: 7px;" >이름</font><img src="../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="text" name="name" style="width:136px; height:24px;" readonly="readonly"  value="<%=user.getName() %>">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:98px;">
        		<div class="col">
        			<div style="float:left; width:150px; height:98px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height:10px;margin-left: 7px;">주소</font>
					</div>
					<div style="float:left; margin:5px 10px;">
						<div style="height:29px;">
							<input type="text" id="zip" name="zip" style="width:50px; height:24px;" readonly="readonly">
							<a href="javascript:void(0);" onclick="popupZipSearch();return false;"><img src="../images/mypage/modify-zipcode.png" style="margin-left:5px; margin-bottom:6px;" ></a>
						</div>
						<div style="height:29px;">
							<input type="text" id="addr1" name="addr1" style="width:290px; height:24px;"><span style="height:15px; font-size:12px;"> 기본주소 </span>
						</div>
						<div style="height:29px;">
							<input type="text" id="addr2" name="addr2" style="width:290px; height:24px;"><span style="height:15px;font-size:12px;">  나머지주소(선택입력가능)</span>
						</div>
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col">
        			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px;margin-left: 7px;">휴대전화</font><img src="../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="text" name="phone" style="width:190px; height:24px;" value="<%=user.getPhone() %>">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		<div style="border-top:1px solid #dfdfdf; border-bottom:1px solid #dfdfdf; color:#353535;">
			<div class="row" style="height:40px;">
        		<div class="col">
        			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
        				<font style="line-height: 10px;margin-left: 7px;" >이메일</font><img src="../images/mypage/address-add.png" style="width:7px; margin-left:5px;">
					</div>
					<div style="float:left; margin:10px 10px;">
						<input type="email" name="email" style="width:190px; height:24px;" value="<%=user.getEmail() %>">
					</div><div style="clear:both:"></div>
				</div>
	    	</div>
		</div>
		
<!-- 추가정보 -->
	<div class="row" style="margin-top:30px; height:auto; line-height:30px;">
		<div class="col">
        	<div style="float:left; width:300px; height:30px; line-height:30px;">
				<h6><strong>추가정보</strong></h6>
			</div>
    	</div>
  	</div>
  	
	<div style="border-top:1px solid #dfdfdf; color:#353535;">
		<div class="row" style="height:40px;">
       		<div class="col">
       			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
       				<font style="line-height: 10px;margin-left: 7px;">성별</font>
				</div>
				<div style="float:left; margin:10px 10px;">
					<input type="radio" id="male" name="gender" value="M"><label for="male" style="width:30px; font-size:13px; ">남자</label>
					<input type="radio" id="female" name="gender" value="F"><label for="female" style="width:30px; font-size:13px;">여자</label>
				</div><div style="clear:both:"></div>
			</div>
    	</div>
    	
	</div>
	<div style="border-top:1px solid #dfdfdf; color:#353535; border-bottom:1px solid #dfdfdf;">
		<div class="row" style="height:40px;">
       		<div class="col">
       			<div style="float:left; width:150px; height:40px; border-right:1px solid #dfdfdf; background-color: #fbfafa; padding:7px;">
       				<font style="line-height: 10px;margin-left: 7px;">생년월일</font>
				</div>
				<div style="float:left; margin:10px 3px 10px 10px;">
					<input type="text" name="birth_yr" style="width:70px; height:24px;"><span style="height:15px; font-size:12px;">년</span>
				</div>
				<div style="float:left; margin:10px 3px 10px 5px;">
					<input type="text" name="birth_month" style="width:40px; height:24px;"><span style="height:15px; font-size:12px;">월</span>
				</div>
				<div style="float:left; margin:10px 10px 10px 5px;">
					<input type="text" name="birth_day" style="width:40px; height:24px;"><span style="height:15px; font-size:12px;">일</span>
				</div>
				<div style="float:left; margin:10px 20px;">
					<input type="radio" id="solar" name="calender_type" value="S" checked="checked"><label for="solar" style="width:30px; font-size:13px; ">양력</label>
					<input type="radio" id="lunar" name="calender_type" value="L"><label for="lunar" style="width:30px; font-size:13px;">음력</label>
				</div><div style="clear:both:"></div>				

			</div>
    	</div>
	</div>

		
<!-- 체크박스와 등록버튼 -->		
	  	<div class="row" style="margin-top:30px; height:120px; line-height:30px;">
			<div class="col">
		       	<div style="float:left; border=1px solid red; width:40%">
		       		<font style="color:white">빈화면출력</font>
		       	</div>
		       	<div class="vertical-align-content" style="float:left;">
					<button type="submit" style="background-color:black; padding: 3px 33px;"><font style="color:white;">회원정보수정</font></button>
				</div>
		       	<div class="vertical-align-content" style="float:right; border:1px solid black;">
		       		<a class="nolinelink" href="javascript:deleteInfo()">
						<font>회원탈퇴</font>
					</a>
				</div>
		       	<div class="vertical-align-content" style="float:center; background-color:#999; ">
		       		<a class="nolinelink" href="mypage.jsp" style="color:white;">
						<font>취소</font>
					</a>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- footer -->
<jsp:include page="/common/footer.jsp">
	<jsp:param name="footer" value="mypage"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">



	// 회원정보 수정시 필수입력값 팝업 띄우기
	function submitModifyForm() {
		
		let passwordField = document.querySelector("input[name=password]");
		if (passwordField.value === '') {
			alert("비밀번호는 필수입력값입니다.");
			passwordField.focus();
			return false;
		}
		
		let passwordField = document.querySelector("input[name=password2]");
		if (passwordField.value === '') {
			alert("비밀번호 확인은 필수입력값입니다.");
			passwordField.focus();
			return false;
		}
		return true;
	}
	

	// 회원탈퇴 버튼 클릭시, action이 달라지는 함수
	function deleteInfo() {
		let form = document.getElementById("user-form");
		form.setAttribute("action", "deleteinfo.jsp");
		
		form.submit();
	}
</script>
</body>
</html>