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
				<p class="errorCode"><b>403</b></p>
				<p class="errorInfo"> 접근 권한이 없는 페이지입니다. </p>
				<button class="homeBtn" type="button">Home</button>
			</div>
		</div>
	</div>
</body>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</html>