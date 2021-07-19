<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이좋게 코딩하자</title>

</head>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp"></jsp:include>

<!-- project css -->
<link type="text/css" href="${pageContext.request.contextPath}/css/Project_Css.css" rel="stylesheet">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<c:set var="msg" value="${msg}"></c:set>
<c:set var="memberList" value="${memberList}" />
<c:set var="session" value="${auth}" />
<se:authentication property="name" var="authSession" />

<body>
	
	<div class="projectok_area">
	<c:if test="${msg eq true }">
	  <div class="projectok_area_icon"><img src="${pageContext.request.contextPath}/assets/img/project/ProjectCreateOk.png"></div>
	  	 <p class="projectok_area_title">프로젝트가 생성되었습니다.</p>
      	 <p>프로젝트를 함께 할 멤버를 모집하여 프로젝트를 진행해보세요!</p>
      	 
      	 <div class="MyProjectPage"><a href="${pageContext.request.contextPath}/project/detail?project_id=${id}">내 프로젝트로 이동하기</a></div>
     </c:if> 	
     
     <c:if test="${msg eq false }">
	  <div class="projectok_area_icon"><img src="${pageContext.request.contextPath}/assets/img/project/ProjectCreateFalse.png"></div>
	  	 <p class="projectok_area_title">작업을 처리하는 중 오류가 발생하였습니다. <br>잠시후 다시 시도해주세요.</p>
     </c:if> 
   </div>
		<div class="m_container">
			<div class="row mb-7" id="card_section">
				<div class="member_chois">
				<p class="member_chois_title">프로젝트를 함께할 멤버를 찾아보세요!</p>
				<div class="member_allList">
					<a href="${pageContext.request.contextPath}/member/list">전체보기 ></a>
				</div>
				</div>
				<!-- 카드-->
				<c:forEach var="member" items="${memberList}">
					<c:if test="${member.rownum <= 4}">
						<div class="cardNum">
								<div class="m_img">
									<img class="m_img_size"
										src="${pageContext.request.contextPath}/resources/upload/${member.m_image}">
								</div>
								<div class="Project_card-body">
									<h3 class="card-title">${member.m_nick}</h3>
									<p class="card-text">${member.position}</p>
									<p class="card-tags"># ${member.skill}</p>
									<a href="${pageContext.request.contextPath}/member/memberdetailpage?memberid=${member.m_id}" class="card_link" target="_blank">
									VIEW MORE</a>
			
								</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
</body>

<script type="text/javascript">
	
	if("${msg}" != "true" ){
		swal({
			  title: "잠시 후 다시 시도해주세요.",
			  text: "",
			  icon: "error",
			})
			.then((valse) => {
			  location.href = "/main"
			  
			});
	}
	
	
</script>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</html>	