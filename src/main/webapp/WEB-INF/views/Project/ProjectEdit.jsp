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
<link type="text/css" href="${pageContext.request.contextPath}/css/Project_Css.css" rel="stylesheet">


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="adrvo" value="${AdrList}"></c:set>
<c:set var="fieldvo" value="${FieldList}"></c:set>
<c:set var="skillvo" value="${SkillList}"></c:set>
<c:set var="durationvo" value="${DurationList}"></c:set>
<c:set var="membervo" value="${MemberVo}"></c:set>
<c:set var="project" value="${Project}"></c:set>
<c:set var="createSkillList" value="${CreateSkillList}"></c:set>
<c:set var="createNotInSkillList" value="${CreateNotInSkillList}"></c:set>
<c:set var="members" value="${Members}"></c:set>

<body>
		<section class="min-vh-100 d-flex align-items-center border-top" style="background-color: #fdfcfc"> 
            <div class="container">
                <div class="row justify-content-center">
                    	<div class="ProjectPage">
                    	
            			<form action="" method="post" enctype="multipart/form-data" class="Project_EditForm">
            			
    					<div class="projectEditPageHeaderWrap">
							<div class="projectPurposeWrap">
								<div class="rightTxt">${project.field_name} 개발</div>
							</div>

								<div class="ProjectPageHeaderContent">
									<table class="statusTagWrap">
										<tr>
										<td width="33%" class="statusTagBox">
										<select class="statusOpenTag" name="p_state" id="status">
											<option class="statusOpenTag" value="${project.p_state}" selected="selected" hidden="">${project.p_state}</option>
											<option class="statusOpenTag" value="모집중">모집중</option>
											<option class="statusGoingTag" value="진행중">진행중</option>
										</select>
										</td>
										<td class="projectTit">
										<input class="ProjectTitle form-control" type="text" placeholder="제목을 입력해주세요." name="p_title" value="${project.p_title}" maxlength="30">
										</td>
										<td width="33%"></td>
										</tr>
									</table>
									<div class="EditBtnBox"><input class="EditBtn" type="button" value="수정"></div>
								</div>
							</div>
                    		<div class="NavBox"> 
                   			<div class="ProjectEdit_imgBox">
                   			<p class="p_bold">대표 이미지</p>
							<p class="Project_p"><b style="color:red;">*</b> 프로젝트 썸네일에 사용될 이미지를 선택해주세요.</p>
							<hr>
								<div class="Project_Create_img_box">
	                   			<img id ="target_img" src="${pageContext.request.contextPath}/resources/upload/${project.p_image}">
								    <input type="file" id="file" name="uploadFile" style="display:none;" >
								    <input type="hidden" name = "target_url">
								</div>    
                   			</div>
                    		  <div class="ProjectNav">
                    			<div class="Leader_Detail">  
                    				
                    				<p class="p_bold"><i class="fas fa-crown leaderIcon"></i> 리더 정보</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 리더 정보는 마이페이지를 통해서 수정하시기 바랍니다.</p>
                    				<input type="text" value="${membervo.MEMBER_ID}" name="member_id" hidden>
                    				<input type="text" value="${project.project_id}" name="project_id" hidden id="project_id">
                    				<div class="Leader_DetailBox">
                    				<div class="LeaderImg_Box">
                    				<img src="${pageContext.request.contextPath}/resources/upload/${membervo.MEMBER_IMAGE}">
                    				</div>
                    				<p><b>${membervo.MEMBER_NICKNAME}</b></p>
                    				</div>
                    				
                    			</div>
                    			<div class="Nav_Detail">
                    				<hr>
                    				<p class="p_bold">프로젝트 분야</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 어떤 분야의 프로젝트를 진행할 것인지 선택해주세요.</p>
                    				<select class="Project_SelectBox" name="field_code">
                    					<option value="${project.field_code}" hidden selected>${project.field_name} 개발</option>
	                    				<c:forEach items="${fieldvo}" var="field">
	                    				  <c:if test="${field.field_enabled eq 1}">
										 	 <option value="${field.field_code}">${field.field_name} 개발</option>
										  </c:if>
										</c:forEach>	
									</select>
                    				<hr>
                    				<p class="p_bold">프로젝트 지역</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 프로젝트를 진행하는 지역은 어디인가요?</p>
    								<select class="Project_SelectBox" name="adr_code">
    									<option value="${project.adr_code}" hidden selected>${project.adr_name}</option>
								    	<c:forEach items="${adrvo}" var="adr">
										 	 <option value="${adr.adr_code}">${adr.adr_name}</option>
										</c:forEach>
									</select> 
                    				<hr>
                    				<p class="p_bold">프로젝트 기간</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 프로젝트의 예상 기간을 선택해주세요.</p>
    								<select class="Project_SelectBox" name="duration_id">
    									<option value="${project.duration_id}" hidden selected>${project.duration_date}</option>
								    	<c:forEach items="${durationvo}" var="duration">
										 	 <option value="${duration.duration_id}">${duration.duration_date}</option>
										</c:forEach>
									</select>                				
                    				
                    			</div>
                    			
                    		  </div>
                    		   
                    		</div>
                    		
                    		<div class="ProjectContent margin_delete">
                    			<p class="p_bold">프로젝트 내용</p>
                    			<p class="Project_p"><b style="color:red;">*</b> 설명이 풍부한 프로젝트는, 아닌 프로젝트에 비해 지원율이 50% 높습니다.</p>
                    			<hr>
                    			<textarea rows="" cols="" placeholder="내용을 입력해주세요.(2000자 까지 작성 가능합니다)" maxlength="2000" name="p_content" class="ProjectContents">${project.p_content}</textarea>
                    		</div>
                    		
                    		<div class="ProjectSkill">
                    			<p class="p_bold">기술 스텍</p>
                    			<p class="Project_p"><b style="color:red;">*</b> 프로젝트를 진행하는데 필요한 기술 스텍을 선택하세요.</p>
                   				<hr>
								<div id="m_skill">
									<div>
										<div id="tagarea">
											<c:forEach items="${createNotInSkillList}" var="createNotInSkillList">
										 	 	<c:if test="${createNotInSkillList.skill_enabled eq 1}">
										 	 		<div class="tags">
									 				<input type="text" value="${createNotInSkillList.skill_name}" readonly="readonly">
									 				<input type="text" value="${createNotInSkillList.skill_code}" hidden="">
									 				</div>
												</c:if>
											</c:forEach>
										</div>
										<hr>
										<p class="Project_p"><b style="color:red;">*</b> 추후 수정이 가능합니다.</p>
										<div id="selectedarea">
											<c:forEach items="${createSkillList}" var="createSkillList">
										 	 		<div class="clicked">
									 				<input type="text" value="${createSkillList.skill_name}" readonly="readonly">
									 				<input type="text" value="${createSkillList.skill_code}" hidden="" name="skill_code">
									 				</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</form>
                   	</div>
             </div>
         </div>
       </section> 
</body>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
			
			var errMsg = "${error}";		
			var state = "${state}";
			var project_id = "${project.project_id}";
			
			
			if(errMsg != "" || state == "진행중"){
				swal("잘못 된 접근입니다.","","error")
				.then((value) => {
				  location.href = "${pageContext.request.contextPath}/main";
				});
			}
			
	//js로 프로젝트 멤버들 보내기
	var memberlist = ${Members}
			
	</script>
	
	<script src="${pageContext.request.contextPath}/assets/js/ProjectEdit.js" ></script>
</html>	