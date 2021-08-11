<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
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
		
		//영정회원일 경우
		if($("#getout").val() == "1"){
			
			swal({
				title: "BAN",
				text: "더 이상 사이트를 이용하실 수 없습니다",
				icon: "error",
				button: true,
				dangerMode: true,
			})
			.then(function(){location.href="logout"});
			
		} else{
			
			var alarm = "<c:out value="${alarm}" />";

			console.log(alarm);

			if(alarm != ""){
				swal("NEWS",alarm,"info");
			}
			
		}
<<<<<<< HEAD

		
		
=======
	
>>>>>>> master
	});
	

</script>
</html>