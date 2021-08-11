<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이좋게 코딩하자 - 프로젝트 수정</title>

</head>
<jsp:include page="../include/header.jsp"></jsp:include>

<!-- project css -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/adminSite.css"
	rel="stylesheet">


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="positionList" value="${positionList}"></c:set>
<c:set var="fieldList" value="${fieldList}"></c:set>
<c:set var="skillList" value="${skillList}"></c:set>



<body>
<section class="min-vh-100 d-flex align-items-center border-top" style="background-color: #fdfcfc">
		<div class="Ad_container">
			<div class="row justify-content-center">
				<div class=subject>
					<span>사이트 관리</span>
					
				</div>
			</div>
			<!-- Skill List -->
			<div class="card_list">
			<div class="listname-head">
				<div class="listname">
				<span>기술 목록</span>
				</div>
			<div class="addbox">
			<span>추가 할 기술 이름 : </span>
			<input type="text" class="form-control" id="skill_input" placeholder="Enter로 추가">
			</div>
				
				</div>
				
				<hr>
				<div class="skill_wholearea">
				<p class="Project_p">
					<b style="color: red;">*</b> 활성화 될 목록
				</p>
						<div class = tagarea id="skill_tagarea">
							<c:forEach var="skill" items="${skillList}">
								<c:if test="${skill.skill_enabled eq 1}">
									<div class="tags skill_tags">
										<input type="text" name="skill_name" value="${skill.skill_name}" readonly="readonly">
										<input type="text" name="skill_enabled" value="${skill.skill_enabled}" hidden="">
										<input type="text" name="skill_code" value="${skill.skill_code}" hidden="">
										
									</div>
								</c:if>
							</c:forEach>
						</div>
						<hr>
						<p class="Project_p">
							<b style="color: red;">*</b> 비 활성화 될 목록
						</p>
						<div class=selectedarea id="skill_selectedarea">
							<c:forEach var="skill" items="${skillList}">
							<c:if test="${skill.skill_enabled eq 0}">
								<div class="clicked skill_clicked">
									<input type="text" name="skill_name" value="${skill.skill_name}" readonly="readonly">
										<input type="text" name="skill_enabled" value="${skill.skill_enabled}" hidden="">
										<input type="text" name="skill_code" value="${skill.skill_code}" hidden="">
								</div>
							</c:if>
							</c:forEach>
						</div>
				
				</div>
			</div>
			<div class="updateContainer">
				<div class="updateWrapper">
					<button class="updateBtn" id="skill_Btn">수정하기</button>
				</div>
			</div>
			<!-- Skill List -->
			
			<!-- Field List -->
			<div class="card_list">
			<div class="listname-head">
				<div class="listname">
				<span>분야 목록</span>
				</div>
			<div class="addbox">
			<span>추가 할 분야 이름 : </span>
			<input type="text" class="form-control" id="field_input" placeholder="Enter로 추가">
			</div>
				
				</div>
				
				<hr>
				<div class="field_wholearea">
				<p class="Project_p">
					<b style="color: red;">*</b> 활성화 될 목록
				</p>
						<div class = tagarea id="field_tagarea">
							<c:forEach var="field" items="${fieldList}">
								<c:if test="${field.field_enabled eq 1}">
									<div class="tags field_tags">
										<input type="text" name="field_name" value="${field.field_name}" readonly="readonly">
										<input type="text" name="field_enabled" value="${field.field_enabled}" hidden="">
										<input type="text" name="field_code" value="${field.field_code}" hidden="">
										
									</div>
								</c:if>
							</c:forEach>
						</div>
						<hr>
						<p class="Project_p">
							<b style="color: red;">*</b> 비 활성화 될 목록
						</p>
						<div class=selectedarea id="field_selectedarea">
							<c:forEach var="field" items="${fieldList}">
							<c:if test="${field.field_enabled eq 0}">
								<div class="clicked field_clicked">
									<input type="text" name="field_name" value="${field.field_name}" readonly="readonly">
										<input type="text" name="field_enabled" value="${field.field_enabled}" hidden="">
										<input type="text" name="field_code" value="${field.field_code}" hidden="">
								</div>
							</c:if>
							</c:forEach>
						</div>
				
				</div>
			</div>
			<div class="updateContainer">
				<div class="updateWrapper">
					<button class="updateBtn" id="field_Btn">수정하기</button>
				</div>
			</div>
			<!-- Field List -->
			
			<!-- Position List -->
			<div class="card_list">
			<div class="listname-head">
				<div class="listname">
				<span>포지션 목록</span>
				</div>
			<div class="addbox">
			<span>추가 할 포지션 이름 : </span>
			<input type="text" class="form-control" id="position_input" placeholder="Enter로 추가">
			</div>
				
				</div>
				
				<hr>
				<div class="position_wholearea">
				<p class="Project_p">
					<b style="color: red;">*</b> 활성화 될 목록
				</p>
						<div class = tagarea id="position_tagarea">
							<c:forEach var="position" items="${positionList}">
								<c:if test="${position.position_enabled eq 1}">
									<div class="tags position_tags">
										<input type="text" name="position_name" value="${position.position_name}" readonly="readonly">
										<input type="text" name="position_enabled" value="${position.position_enabled}" hidden="">
										<input type="text" name="position_code" value="${position.position_id}" hidden="">
										
									</div>
								</c:if>
							</c:forEach>
						</div>
						<hr>
						<p class="Project_p">
							<b style="color: red;">*</b> 비 활성화 될 목록
						</p>
						<div class=selectedarea id="position_selectedarea">
							<c:forEach var="position" items="${positionList}">
							<c:if test="${position.position_enabled eq 0}">
								<div class="clicked position_clicked">
									<input type="text" name="position_name" value="${position.position_name}" readonly="readonly">
										<input type="text" name="position_enabled" value="${position.position_enabled}" hidden="">
										<input type="text" name="position_code" value="${position.position_id}" hidden="">
								</div>
							</c:if>
							</c:forEach>
						</div>
				
				</div>
			</div>
			<div class="updateContainer">
				<div class="updateWrapper">
					<button class="updateBtn" id="position_Btn">수정하기</button>
				</div>
			</div>
			<!-- Position List -->
			
		</div>
		 </section>
</body>
<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>


<script
	src="${pageContext.request.contextPath}/assets/js/adminSite.js"></script>
</html>
