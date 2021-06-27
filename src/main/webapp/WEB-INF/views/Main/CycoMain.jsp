<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<title>CYCO HOME</title>
<link rel="stylesheet" type="text/css" href = "../css/main.css">
</head>
<jsp:include page="../include/header.jsp"></jsp:include>
<body onload="InitializeStaticMenu();">
	<div class="main_">
		<!-- Project main -->
		<div class="main_area_l">
		
			<div class="container main_center">
				<p><spring:message code="main.project1"/><br><spring:message code="main.project2"/></p>

				<a href="/project/list"><img src="${pageContext.request.contextPath}/assets/img/main_page/Project_arrow.png"></a>

			</div>
		</div>
		<div id="STATICMENU">
			<div id="circle1" onclick="location.href='?lang=ko'; colorChange1();">
			</div>
			<div id="circle2" onclick="location.href='?lang=en'; colorChange2();">
			</div>
			<div id="circle3" onclick="location.href='?lang=ja'; colorChange3();">
			</div>
		</div>
		<!-- Member main -->
		<div class="main_area_r">
			
			<div class="container main_center">
				<p><spring:message code="main.member1"/><br> <spring:message code="main.member2"/></p>
				<a href="/member/list"><img src="${pageContext.request.contextPath}/assets/img/main_page/Member_arrow.png"></a>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/assets/js/main.js" type="text/javascript"></script>
</body>
<script>

	$(document).ready(function(){

		var alarm = "<c:out value="${alarm}" />";

		console.log(alarm);

		if(alarm == "success"){
			swal(alarm,"마이페이지에서 정보를 입력하셔야 프로젝트 참여가 가능합니다","info");
		}
		
	});
	

</script>
</html>