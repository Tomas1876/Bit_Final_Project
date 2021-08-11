<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" href="${pageContext.request.contextPath}/css/findAccount.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

	<div class="check-container">
		<div class="check-box">
			<div class="check-text">
				<div class="check-form">
					<div class="findEmailBox">
					<i class="fas fa-lock checkIcon"></i>
						<p> 이메일 찾기 </p>
					</div>
					<div class="findEmailBox">
							<input class="check-input" id="userName" placeholder="이름" name="userName" type="text">
							<input class="check-input" id="userPhone" placeholder="핸드폰번호" name="userPhone" type="text">
					</div>
					<button type="button" class="checkBtn" id="findEmailBtn">찾기</button>
				</div>
			</div>
		</div>
		<div class="check-box">
			<div class="check-text">
				<div class="check-form">
					<div class="findEmailBox">
					<i class="fas fa-key checkIcon"></i>
					<p> 비밀번호 찾기 </p>
					</div>
					<div class="findEmailBox">
						<input class="check-input" id="userPwdName" placeholder="이름" name="userName" type="text">
						<input class="check-input" id="userEmail" placeholder="이메일" name="userEmail" type="text">
						<input class="check-input" id="userConfirm" placeholder="인증번호" name="userConfirm" type="text">
						<p class="checkBtn" id="confirmEnd">인증완료</p>
					</div>
					<button type="button" class="checkBtn" id="findPwdBtn">찾기</button>
					<button type="button" class="checkBtn" id="userConfirmBtn">인증</button>
				</div>
			</div>
		</div>
		
		<!-- 모달 -->
       	<div id="emailModal" class="findEmailModal">
	       	<div class="emailBox">
				<div class="emailModalDiv">
					<div class="modal_XBtn">
						<i class="fas fa-times"></i>
					</div>
					<div class="emailIcon">
						📨
					</div>
					<div class="emailInfo">
						<p>고객님이 가입하신 이메일의 일부 정보입니다.</p>
						<p class="userCutEmail"></p>
						<div class="modalLinkSec">
							<a href="login">로그인하러가기</a>
						</div>
					</div>
				</div>		
			</div>
		</div>	
		
		<!-- 비밀번호 변경 모달 -->
       	<div id="editPwdModal" class="editPwdModal">
	       	<div class="emailBox">
				<div class="emailModalDiv">
					<div class="modal_XBtn">
						<i class="fas fa-times"></i>
					</div>
					<div class="modalPwdIcon">
						<i class="fas fa-user-lock"></i>
					</div>
					<div class="pwdModalInfo">
						<p>변경하실 비밀번호를 입력해주세요.</p>
						<input class="check-input" id="newPwd" placeholder="비밀번호" name="newPwd" type="password">
						<input class="check-input" id="newPwdCheck" placeholder="비밀번호체크" name="newPwdCheck" type="password">
						<button type="button" class="checkBtn" id="newPwdBtn">변경</button>
					</div>
					<div class="modalLinkSecPwd">
							<a href="login">로그인하러가기</a>
					</div>
				</div>		
			</div>
		</div>	
		
	</div><!-- container end -->
	
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script src="${pageContext.request.contextPath}/assets/js/findAccount.js"></script>
</html>