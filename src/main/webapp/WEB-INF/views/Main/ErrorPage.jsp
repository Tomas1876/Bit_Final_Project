<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>사이좋게 코딩하자</title>

<link type="text/css" href="${pageContext.request.contextPath}/css/ErrorPage.css" rel="stylesheet">
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
	<div class="error-container">
		<div class="error-box">
			<div class="error-text">
				<i class="fas fa-exclamation-triangle errorIcon"></i>
				<p class="errorCode"><b>문제가 발생했습니다.</b></p>
				<p class="errorInfo"> 서비스 이용에 불편을 드려 죄송합니다. </p>
				<p class="errorInfo"> 빠른 시일내에 해결하겠습니다. 감사합니다. </p>
				<button class="homeBtn" type="button">Home</button>
			</div>
		</div>
	</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</html>