<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="member" value="${aboutmember}" />
<c:set var="skills" value="${skills}" />
<c:set var="position" value="${position}" />
<c:set var="durations" value="${durations}" />
<c:set var="experiences" value="${experiences}" />
<c:set var="reviewList" value="${reviewList}" />

<c:set var="gradeAvg" value="${gradeAvg}" />


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>사이좋게 코딩하자</title>

<link type="text/css"
	href="${pageContext.request.contextPath}/css/memberdetail.css"
	rel="stylesheet">
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<body>
	<main>
	
	<!-- 로그인한 유저 -->
	<input type="hidden" id="current_id" value="${sessionScope.Member_id}">
	<!-- 이 페이지의 회원 -->
	<input type="hidden" id="m_id" name="m_id" value="${param.memberid}">

		<div id="wrap">
			<div id="profile_img">
				<!-- <img src="assets/img/member_detail/cycoding_img.png"> -->
				<img
					src="${pageContext.request.contextPath}/resources/upload/${member.MEMBER_IMAGE}">
			</div>
			<div id="cycoder">
				<p>${member.MEMBER_NICKNAME}</p>
				<a href="#invitation_modal" class="trigger-btn" data-toggle="modal"><button type="button" id="invitation">초대하기</button></a>
				<a href="#message_modal" class="trigger-btn" data-toggle="modal"><button type="button" id="send">쪽지보내기</button></a>
			</div>

			<!-- 			<div id="modals">
				<ul>
					<li>지원내역</li>
					<li>프로젝트</li>
				</ul>
			</div> -->

			<div id="detail_box">

				<div id="info" class="details">
					<p class="cycoder_title">
						ABOUT<br>CYCODER
						
					<p class="sub_title"></p>

					<div class="infolist">

						<div class="detail_section">

							<div class="detail_title">
								<span class="item">보유기술</span>
							</div>

							<div class="moerdetails skillarea" onclick="edit_modal('skill')">
								<c:choose>
									<c:when test="${empty skills}">
										<div class="none">미입력</div>
									</c:when>
									<c:otherwise>
										<c:forEach var="sarr" items="${skills}" varStatus="status">
											<c:choose>
												<c:when test="${status.index eq 0 }">
													<!-- <span id="star">★</span> -->
													<i class="fa fa-star" id=star></i>
													<div class="info_tags main_skill skill">
														<c:out value="${sarr.skill_name}" />
													</div>
												</c:when>
												<c:otherwise>
													<div class="info_tags skill">
														<c:out value="${sarr.skill_name}" />
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					<div class="detail_section">
							<div class="detail_title">
								<span class="item">선호 포지션</span>
							</div>
							<!-- 스탯 입력 안 했으면 -->
							<div class="moerdetails positionarea"
								onclick="edit_modal('position')">
								<c:choose>
									<c:when test="${empty position}">
										<div class="none">미입력</div>
									</c:when>
									<c:otherwise>

										<c:forEach var="position" items="${position}">

											<div class="info_tags position">
												<c:out value="${position.position_name}" />
											</div>

										</c:forEach>

									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="detail_section">
							<div class="detail_title">
								<span class="item">선호 프로젝트 기간</span>
							</div>

							<!-- 기간 입력 안 했으면 -->
							<div class="moerdetails durationarea"
								onclick="edit_modal('duration')">
								<c:choose>
									<c:when test="${empty durations}">

										<div class="none">미입력</div>

									</c:when>
									<c:otherwise>

										<c:forEach var="darr" items="${durations}">

											<div class="info_tags duration">
												<c:out value="${darr.du_date}" />
											</div>

										</c:forEach>

									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<div class="detail_section itmelist">
							<div class="detail_title">

								<span class="item">프로젝트 경험</span>

							</div>
							<!-- 스탯 입력 안 했으면 -->
							<div class="moerdetails experience"
								onclick="edit_modal('experience')">
								<c:choose>
									<c:when test="${empty experiences}">

										<div id="ex_btn"
											style="display: flex; align-items: center; width: 350px; margin: auto; justify-content: space-btween;">
											<div class="none experience" id="never">없음</div>

										</div>
									</c:when>
									<c:otherwise>

									<div id="exlist">
									
									<c:forEach var="experiences" items="${experiences}" varStatus="status">
									<form action="ajax/updateexperiences" class="ex_edit_form">
									<input type="hidden" class="member_id_input" name="member_id_input" value="${member.MEMBER_ID}" />
										<div class="ex_box" id="${experiences.ex_count}">
										<div class="ex ex_titlebox">
											<div id="exicons">
												<i class="fas fa-edit edit_exbox"></i>
												<i class="fas fa-eraser del_exbox"></i>
											</div>
										
											<span class="ex_count">#${status.count}</span><input type="text" class="exp_title exp_title_input" name="exp_title_input" value="${experiences.EXP_TITLE}" readonly/>
										</div>
										<div class="ex"><span class="name"> 담당 업무</span>
											<input type="text"  name="ex_position_input" class="ex_position_input" value="${experiences.EX_POSITION}" readonly/></div>
										<div class="ex"><span class="name">사용 기술</span>
											<input type="text"  name="ex_skill_input" class="ex_skill_input" value="${experiences.EX_SKILL}" readonly/></div>
										<div class="ex"><span class="name">소요 기간</span>
											<input type="text"  name="ex_duration_input" class="ex_duration_input" value="${experiences.EX_DURATION}" readonly/></div>
										<div class="ex"><span class="name">설명</span>
											<input type="text"  name="ex_content_input"  class="ex_content_input"value="${experiences.EX_CONTENT}" readonly/></div>
										
										</div>
										</form>
										</c:forEach>

									</div>

									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>

				<!-- 리뷰 div -->
				<div id="review" class="details">
					<p class="cycoder_title">REVIEW</p>
					<div class="reviewBox">
					
					<c:set var="last_flag" value="true"/>
					<!-- list_size : reviewList의 크기 -->
					<c:set var="list_size" value="${fn:length(reviewList)}"/>
					
					<!-- 리뷰가 1개도 없는 경우 문구 출력 -->
					<c:if test="${list_size eq 0}">
						<div class="review_nothing">
							<p> 아직 남겨진 리뷰가 없습니다. </p>
						</div>
					</c:if>
					
					<c:if test="${list_size ne 0}">
						<div class="review_avg">
							<p>${member.MEMBER_NICKNAME} 님의 평점</p>
							<div class="gradeAvg">
								${gradeAvg}
							</div>
						</div>
						<hr class="reviewAvgHr">
					</c:if>
					
					<!-- 리뷰 리스트 뿌리기 -->
						<c:forEach var="reviewList" items="${reviewList}" varStatus="status" begin="0" end="3">
							<c:set var="last_flag" value="false"/>
							<!-- if문을 통해 현재 index가 project_list의 끝인지 검사 -->
							<c:if test="${status.count eq list_size}">
								<c:set var="last_flag" value="true"/>
							</c:if>
							
							<!-- 리뷰 start -->
									<div class="col-12 reviews">
										<h5 class="reviewWriter"><c:out value="${reviewList.member_nickname}" /></h5>
										<div class="star-rate">
											<c:forEach begin="1" step="1" end="${reviewList.review_grade}">
												<i class="fas fa-star review-star"></i>
											</c:forEach>
											
										</div>
										<p class="review-content"><c:out value="${reviewList.review_content}" /></p>
									</div>
						</c:forEach>
						<!-- 리뷰 end -->
						
					</div>
						<div class="moreSec">
						<!-- 리뷰 끝나면 더보기 버튼 안보이게하기 -->
							<c:if test="${not last_flag}">
								<p class="moreLink" id="moreBtn"> + 더보기</p>
							</c:if>
						</div>
				</div>
				<!-- 리뷰 div end -->
				
				<!-- 탑버튼 -->
				<img id="topBtn" src="${pageContext.request.contextPath}/assets/img/ain_test/topBtn.png">
				<!-- 목록 돌아가기버튼 -->
				<div class="return_sec">
					<a href="/member/list"><button class="returnBtn" type="button">목록으로돌아가기</button></a>
				</div>
			</div>
		</div>
	</main>
	
	
	<div id="invitation_modal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<p id="modal-title">INVITATION</p>
				</div>
				<div id="modal-body">
					<div id="inv_img"></div>
					<div id="contentarea">
						<%-- <p>${member.MEMBER_NICKNAME}님을 프로젝트에 초대하시겠습니까?</p> --%>
					</div>
					<div id="inv_buttonarea">
						
						<!-- <a href="#invitation_modal" class="trigger-btn" data-toggle="modal">
							<button class="inv_btn" id="confirm_inv">초대</button>		
						</a> -->
					</div>

				</div>


			</div>
		</div>
	</div>
	
	<div id="message_modal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<p id="modal-title">SEND</p>
				</div>
				<div id="modal-body">
					<!-- <div id="msg_img"></div> -->
					<div id="messagearea">
						<span>메시지를 입력하세요</span>					
					</div>
					<input type="hidden" name="text" id="text">
					<div id="textcount"></div>
					<div id="msg_buttonarea">
						
						<a href="#message_modal" class="trigger-btn" data-toggle="modal">
							<button class="send_btn" id="msg_btn"><i class="far fa-paper-plane"></i></button>		
						</a> 
					</div>

				</div>
			</div>
		</div>
	</div>
	
</body>
<jsp:include page="../include/footer.jsp"></jsp:include>
<script type="text/javascript">
	/* js로 보내주기 */
	var reviewList = ${reviewList};
	
	console.log(${fn:length(reviewList)});

</script>
<script src="${pageContext.request.contextPath}/assets/js/memberdetail.js?ver=1"></script>
</html>