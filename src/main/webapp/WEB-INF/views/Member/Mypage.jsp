<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:set var="member" value="${aboutmember}"/>
<c:set var="skills" value="${skills}"/>
<c:set var="position" value="${position}"/>
<c:set var="durations" value="${durations}"/>

<!-- 배열에서 값 뽑아내기 -->





<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>사이좋게 코딩하자</title>


	<link type="text/css" href="css/mypage.css?ver=1" rel="stylesheet">
</head>
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
<main>

	<div id="wrap">
		<div id="profile_img">
			<img src="assets/img/member_detail/cycoding_img.png">
		</div>
		<div id="cycoder">
			<p>${member.MEMBER_NICKNAME}</p>
		</div>
		
		<div id="modals">
			<ul>
				<li>지원내역</li>
				<li>프로젝트</li>
			</ul>
		</div>

		<div id="detail_box">

			<div id="persnal" class="details">
				<p class="cycoder_title">ABOUT<br>CYCODER</p>
				<input type="hidden" id="m_id" name="m_id" value="${member.MEMBER_ID}">
				<ul>
					
					<li class="itemlist"><span class="item">이메일</span><input type="text" class="info" value="${member.MEMBER_EMAIL}" readonly><button type="button" class="modify_items m-btn hid" disabled>NONE</button></li>
					<li class="itemlist"><span class="item">비밀번호</span><input type="password" class="info" value="${member.MEMBER_PWD}" readonly><button type="button" class="modify_items m-btn">수정</button></li>
					<li class="itemlist"><span class="item">닉네임</span><input type="text" class="info" id="nick" value="${member.MEMBER_NICKNAME}" readonly><button type="button" class="modify_items m-btn">수정</button></li>
					<li class="itemlist"><span class="item">이름</span><input type="text" class="info" value="${member.MEMBER_NAME}" readonly><button type="button" class="modify_items m-btn hid" disabled>NONE</button></li>
					<li class="itemlist"><span class="item">휴대폰</span><input type="text" class="info" value="${member.MEMBER_PHONE}" readonly><button type="button" class="modify_items m-btn">수정</button></li>
					<li class="itemlist"><span class="item">포인트</span><input type="text" class="info" value="${member.HAVE_POINT}점" readonly><button type="button" class="modify_items point-btn">충전</button></li>
				
				</ul>
				
			</div>

			
			<div id="info" class="details">
			<p class="cycoder_title">DETAIL</p>
			<!--  <p class="sub_title">버튼을 누르면 수정할 수 있어요</p> -->

			<div class="infolist">
			
				<div class="detail_section">
				
					<div class="detail_title">
						<span class="item">보유기술</span>
					</div>
					<div class="moerdetails" onclick="edit_modal('skill')">
							<c:forEach var="sarr" items="${skills}" varStatus="status">
								<c:choose>
									<c:when test="${status.index eq 0 }">
										<a href="#m_stat" class="trigger-btn" data-toggle="modal">
											<div class="info_tags main_skill"><c:out value="${sarr.skill_name}"/><span id="star">★</span></div>
										</a>
									</c:when>
									<c:otherwise>
										<a href="#m_stat" class="trigger-btn" data-toggle="modal">
											<div class="info_tags"><c:out value="${sarr.skill_name}"/></div>
										</a>
									</c:otherwise>
								</c:choose>
								
							</c:forEach>
						
					</div>
				</div>
				
				<div class="detail_section itmelist">
				
					<div class="detail_title">
					
						<span class="item">프로젝트 경험여부</span>
					
					</div>
					
					<div class="moerdetails" onclick="edit_modal('experience')">

						
					</div>
					
				</div>
				
				<div class="detail_section">				
					<div class="detail_title">
					
						<span class="item">선호 포지션</span>
					
					</div>
					
					<div class="moerdetails" onclick="edit_modal('position')">
						<c:forEach var="position" items="${position}">
							<a href="#m_stat" class="trigger-btn" data-toggle="modal">
								<div class="info_tags"><c:out value="${position.position_name}"/></div>
							</a>
						</c:forEach>
					</div>
					
				</div>
				
				<div class="detail_section">
				
					<div class="detail_title">
					
						<span class="item">선호 프로젝트 기간</span>						
					
					</div>
					<div class="moerdetails" onclick="edit_modal('duration')">
						
							<c:forEach var="darr" items="${durations}">
								<a href="#m_stat" class="trigger-btn" data-toggle="modal"><div class="info_tags"><c:out value="${darr.du_date}"/></div></a>
							</c:forEach>
						
					</div>
					
				</div>
			
						
			</div> 
			
			
<%-- 			<div class="infolist">
			
				<div class="detail_section">
				
					<div class="detail_title">
						<span class="item">보유기술</span>
						<a href="#m_stat" class="trigger-btn" data-toggle="modal">
							<button type="button" class="modify_p_info right-btn" onclick="edit_modal('skill')">수정</button>
						</a>
					</div>
					<div class="moerdetails">
							<c:forEach var="sarr" items="${skills}">
								<div class="info_tags"><c:out value="${sarr.skill_name}"/></div>
							</c:forEach>
						
						</div>
				</div>
				
				<div class="detail_section itmelist">
				
					<div class="detail_title">
					
						<span class="item">프로젝트 경험여부</span><button type="button" class="modify_p_info right-btn">수정</button>
					
					</div>
				</div>
				
				<div class="detail_section">				
					<div class="detail_title">
					
						<span class="item">선호 포지션</span><button type="button" class="modify_p_info">수정</button>
					
					</div>
				</div>
				
				<div class="detail_section">
				
					<div class="detail_title">
					
						<span class="item">선호 프로젝트 기간</span>
						<a href="#m_stat" class="trigger-btn" data-toggle="modal">
							<button type="button" class="modify_p_info right-btn" onclick="edit_modal('duration')">수정</button>
						</a>
					
					</div>
					<div class="moerdetails">
							<c:forEach var="darr" items="${durations}">
								<div class="info_tags"><c:out value="${darr.du_date}"/></div>
							</c:forEach>
						</div>
				</div>
			
						
			</div>  --%>
			
			

			
			</div>
			
		</div>
	</div>
	
	


</main>


<!-- 기술 스택 모달창 -->
    <div id="m_stat" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">				
				<p id="modal-title"></p>
			</div>
			<div id="modal-body">
			
				<div id="tagarea"></div>
				<div id="selectedarea"></div>
				
				<div id="buttonarea">
					<button id="edit">수정</button>
					<a href="#m_stat" class="trigger-btn" data-toggle="modal"><button id="cancel">닫기</button></a>
				</div>
			
			</div>
			
			
		</div>
	</div>
</div> 


<!-- 선호 기간 모달창 
    <div id="m_duration" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">				
				<p id="modal-title">선호하시는 프로젝트 기간을 골라주세요</p>
			</div>
			<div id="modal-body">
			<div class="tagarea"></div>
			</div>
		</div>
	</div>
</div> 
-->

<script src="${pageContext.request.contextPath}/assets/js/mypage.js?ver=1"></script>
</body>
</html>