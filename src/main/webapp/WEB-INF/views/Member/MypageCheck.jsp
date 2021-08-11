<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" href="${pageContext.request.contextPath}/css/mypageCheck.css" rel="stylesheet">
</head>
<!-- 스프링 시큐리티 설정 -->
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<body>

	<se:authentication property="name" var="LoginUser" />

	<div class="check-container">
		<div class="check-box">
			<div class="check-text">
				<div class="check-form">
					<i class="fas fa-user-lock checkIcon"></i>
					<p> 고객님의 소중한 정보를 위해 </p>
					<p style="margin-bottom: 50px;"> 비밀번호를 한번 더 입력해주세요 </p>
						<input id="useremail" name="useremail" value="${LoginUser}" type="hidden"> 
						<input class="check-input" id="userPwd" placeholder="비밀번호" name="userPwd" type="password">
						<button type="button" class="checkBtn" id="pwdCheck">입력</button>
				</div>
			</div>
		</div>
	</div>

</body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		
		function PwdCheck(useremail, userPwd) {
			$.ajax({
	             url:'/mypage/ajax/mypageCheck',
	             type: 'post',
	             dataType:"text",
	             data: { 
	            	 	useremail : useremail,
	            	 	userPwd : userPwd 
	             },
	             success:function(result){
	                 console.log("result: "+ result);
	                 
	                 if(result != "false") {
	                	 let url = "${pageContext.request.contextPath}/mypage/mypage?useremail=${LoginUser}";
	                	 location.replace(url);
	                 } else {
	                	 swal("비밀번호를 다시 확인해주세요." , "" ,"error");
	                	 $('#userPwd').val("");
	                 }
	             }
			})
		}
		
		$("#userPwd").keyup(function(e){
			if(e.keyCode == 13)  {
				let useremail = $('#useremail').val();
				let userPwd = $('#userPwd').val();
				
				PwdCheck(useremail, userPwd);
			}
			
		});
		
		$("#pwdCheck").click(function() { 
			let useremail = $('#useremail').val();
			let userPwd = $('#userPwd').val();
			
			PwdCheck(useremail, userPwd);
		});
		
	})
	
</script>

</html>