<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이좋게 코딩하자 - 프로젝트 생성</title>

</head>
<jsp:include page="../include/header.jsp"></jsp:include>

<!-- project css -->
<link type="text/css" href="${pageContext.request.contextPath}/css/Project_Css.css" rel="stylesheet">


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="adrvo" value="${AdrList}"></c:set>
<c:set var="fieldvo" value="${FieldList}"></c:set>
<c:set var="skillvo" value="${SkillList}"></c:set>
<c:set var="positionvo" value="${PositionList}"></c:set>
<c:set var="durationvo" value="${DurationList}"></c:set>
<c:set var="membervo" value="${MemberVo}"></c:set>


<body>

	<div class="project_area">
	  <div class="area-img">
	  	 <p>프로젝트 생성</p>
      	 <p>당신의 상상을 현실로 반영해보세요!</p>
	  </div>	
   </div>
		<section class="min-vh-100 d-flex align-items-center" style="background-color:#F4F2F3">
            <div class="container">
                <div class="row justify-content-center">
                    	<div class="ProjectPage">
                    	
            			<form action="" method="post" enctype="multipart/form-data" class="Project_createForm">
                    		<div class="ProjectHeader">
                    			<div class="ProjectHeader_Left">
                    				<p></p>
									<p class="Project_title_p">프로젝트 명</p>
									<p class="Project_p ma-l"><b style="color:red;">*</b> 직관적인 프로젝트명을 사용하시면 클릭률이 올라갑니다.</p>
	                    			<input class="ProjectTitle form-control" type="text" placeholder="제목을 입력해주세요." name="p_title">  
	                    			<p></p>
                    			</div>
                    			
                    			
                    			<div class="ProjectHeader_Right">
                    			<p>대표 이미지</p>
								<p class="Project_p"><b style="color:red;">*</b> 프로젝트 썸네일에 사용될 이미지를 선택해주세요.</p>
								
                    			<img id ="target_img" src="${pageContext.request.contextPath}/assets/img/project/Project_defalutImg.png">
								    <input type="file" id="file" name="uploadFile" style="display:none;" onchange="changeValue(this)" >
								    <input type="hidden" name = "target_url">
                    			</div>
                    			
                    		</div>
                    		
                    		<div class="ProjectMember">
                    			<p>모집인원</p>
                    			
                    			<p class="Project_p"><b style="color:red;">*</b> 원하는 분야를 추가하여 모집해보세요. (추후 추가/수정 가능합니다.)</p>
                    			<hr>
                    			
                    			
                    			<div id="PositionBox">
                    			<div class="PositionBtn">
								<input type="button" value="추가" class="PositionAdd"> <input type="button" value="삭제" class="PositionDel">
								</div>	
                    				
                    			<div class="project_boxdiv">
                    			<select class="Project_SelectBox">
							    	<c:forEach items="${positionvo}" var="position">
							    		 <c:if test="${position.position_enabled eq 1}">
									 	 	<option value="${position.position_id}">${position.position_name}</option>
									 	 </c:if>	
									</c:forEach>
								</select>
									<div class="BtnWarp">
									<input type="button" class="Up_num" value="+" >
										<p class="number">1</p>
									<input type="button" class="Down_num" value="-">
									</div>
                    			</div>
                    			
                    			</div>
                    		</div>
                    		
                    		<div class="NavBox"> 
                    		  <div class="ProjectNav">
                    			<div class="Leader_Detail">  
                    				<p>✔️ 리더 정보</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 리더 정보는 마이페이지를 통해서 수정하시기 바랍니다.</p>
                    				<input type="text" value="${membervo.MEMBER_EMAIL}" name="member_id" hidden>
                    				<div class="Leader_DetailBox">
                    				<div class="LeaderImg_Box">
                    				<img src="${pageContext.request.contextPath}/assets/img/defalutimg.jpeg">
                    				</div>
                    				<p><b>${membervo.MEMBER_NICKNAME}</b></p>
                    				</div>
                    				
                    			</div>
                    			<div class="Nav_Detail">
                    				<hr>
                    				<p>프로젝트 지역</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 프로젝트를 진행하는 지역은 어디인가요?</p>
    								<select class="Project_SelectBox" name="adr_code">
								    	<c:forEach items="${adrvo}" var="adr">
										 	 <option value="${adr.adr_code}">${adr.adr_name}</option>
										</c:forEach>
									</select> 
                    				<hr>
                    				<p>프로젝트 기간</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 프로젝트의 예상 기간을 선택해주세요.</p>
    								<select class="Project_SelectBox" name="duration_id">
								    	<c:forEach items="${durationvo}" var="duration">
										 	 <option value="${duration.duration_id}">${duration.duration_date}</option>
										</c:forEach>
									</select>                				
                    				<hr>
                    				<p>프로젝트 분야</p>
                    				<p class="Project_p"><b style="color:red;">*</b> 어떤 분야의 프로젝트를 진행할 것인지 선택해주세요.</p>
                    				<select class="Project_SelectBox" name="field_code">
	                    				<c:forEach items="${fieldvo}" var="field">
	                    				  <c:if test="${field.field_enabled eq 1}">
										 	 <option value="${field.field_code}">${field.field_name} 개발</option>
										  </c:if>
										</c:forEach>	
									</select>
                    			</div>
                    		  </div>
                    		  
                    		</div>
                    		
                    		<div class="ProjectContent">
                    			<p>프로젝트 내용</p>
                    			<p class="Project_p"><b style="color:red;">*</b> 설명이 풍부한 프로젝트는, 아닌 프로젝트에 비해 지원율이 50% 높습니다.</p>
                    			<hr>
                    			<textarea rows="" cols="" placeholder="내용을 입력해주세요." name="p_content"></textarea>
                    		</div>
                    		
                    		<div class="ProjectSkill">
                    			<p>기술 스텍</p>
                    			<p class="Project_p"><b style="color:red;">*</b> 프로젝트를 진행하는데 필요한 기술 스텍을 선택하세요.</p>
                   				<hr>
								<div id="m_skill">
									<div>
										<div id="tagarea">
											<c:forEach items="${skillvo}" var="skill">
										 	 	<c:if test="${skill.skill_enabled eq 1}">
									 				<div class="tags">${skill.skill_name}</div>
												</c:if>
											</c:forEach>
										</div>
										<hr>
										<p class="Project_p"><b style="color:red;">*</b> 추후 수정이 가능합니다.</p>
										<div id="selectedarea" name="skill_code"></div>
									</div>
								</div>
							</div>
							
							<div class="CreateBtn_box">
								<input type="button" class="CreateBtn" value="프로젝트 생성하기">
								<p class="Project_p"><b style="color:red;">*</b> 프로젝트 생성시 50포인트가 소모됩니다.</p>
							</div>
							
						</form>
                   	</div>
             </div>
         </div>
       </section> 
</body>
	<script type="text/javascript">
		var selectBox = "<div class='project_boxdiv'><select class='Project_SelectBox'><c:forEach items='${positionvo}' var='position'><c:if test='${position.position_enabled eq 1}'><option value='${position.position_id}'>${position.position_name}</option>"
			+ "</c:if></c:forEach></select> <div class='BtnWarp'><input type='button' class='Up_num' value='+'><p class='number'>1</p><input type='button' class='Down_num' value='-'></div></div>";
	

			
			
		
		$('.CreateBtn').click(function(){
			swal({
				  title: "프로젝트를 생성하시겠습니까?",
				  text: "* 프로젝트 생성시 50포인트가 소모됩니다.",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
					  $('.Project_createForm').submit();
				  } else {
					  return false;
				  }
				});
		})
			
			
			
	</script>
	<script src="${pageContext.request.contextPath}/assets/js/ProjectCreate.js" ></script>
</html>	