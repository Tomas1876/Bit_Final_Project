<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:set var="newlist" value="${newalarmlist}" />
<c:set var="oldlist" value="${oldalarmlist}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>사이좋게 코딩하자</title>

<link type="text/css"
	href="${pageContext.request.contextPath}/css/myalarm.css"
	rel="stylesheet">


</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<body>
	<main>

		<div class="wish_container">
			<div class="wish_section apply_sec">
				<p class="wish_title">MYNEWS</p>
				<div class="wish_project_list">
					<div class="table_sec">
						<!-- 프로젝트목록 -->
						<!-- 지원목록 영역 -->
						<div class="info_text_sec">
							<p class="table_name_text">새 알림내역</p>
						</div>

						<table class="table wish_table apply_table" id="newalarms">

							<c:forEach var="newlist" items="${newlist}">
								<c:choose>
									<c:when test="${not empty newlist}">
										<thead>

											<tr class="table_head">
												<th>${newlist.ALARM_DATE}</th>
											</tr>

										</thead>
										<tbody class="apply_table_sec">
											<tr id="${newlist.ALARM_ID}">
											
												<c:choose>
												
													<c:when test="${newlist.ALARM_CODE eq 'PR_IN' || newlist.ALARM_CODE eq 'PR_S' || newlist.ALARM_CODE eq 'PR_F' || newlist.ALARM_CODE eq 'PR_UP'
														|| newlist.ALARM_CODE eq 'PR_EX' || newlist.ALARM_CODE eq 'TM_CH'}">
														<td class="${newlist.ALARM_CODE}" id="${newlist.URL}"><a href="/project/detail?project_id=${newlist.URL}">${newlist.ALARM_CONTENT}</a></td>
													</c:when>
													
													<c:when test="${newlist.ALARM_CODE eq 'PR_A'}">
														<td class="${newlist.ALARM_CODE}" id="${newlist.URL}"><a href="/member/memberdetailpage?memberid=${newlist.URL}">${newlist.ALARM_CONTENT}</a></td>
													</c:when>
													
													<c:when test="${newlist.ALARM_CODE eq 'MY_RV'}">
														<td class="${newlist.ALARM_CODE}" id="${newlist.URL}"><a href="/member/memberdetailpage?memberid=${newlist.URL}">${newlist.ALARM_CONTENT}</a></td>
													</c:when>
													
													<c:when test="${newlist.ALARM_CODE eq 'PM_BAN'}">
														<td class="${newlist.ALARM_CODE}" id="${newlist.URL}"><a href="/mypage/myProject">${newlist.ALARM_CONTENT}</a></td>
													</c:when>
													
												</c:choose>

											</tr>

										</tbody>
									</c:when>
									<c:otherwise>
										
										<thead>

											<tr class="table_head">
												<th>CLEAR</th>
											</tr>

										</thead>
										<tbody class="apply_table_sec">
											<tr>
												<td>아직 새 알림이 없어요</td>
											</tr>

										</tbody>
									
									</c:otherwise>

								</c:choose>
							</c:forEach>
						</table>

						<div class="info_text_sec">
							<p class="info_text">
								<i class="fas fa-mouse"></i> 클릭하면 해당 페이지로 이동할 수 있어요!
							</p>
						</div>
						<div class="marginBox"></div>


						<div class="info_text_sec">
							<p class="table_name_text">지난 알림내역</p>
						</div>
						<table class="table wish_table apply_table" id="oldalarms">

							<c:forEach var="oldlist" items="${oldlist}">
								<c:choose>
									<c:when test="${not empty oldlist}">
										<thead>

											<tr class="table_head">
												<th>${oldlist.ALARM_DATE}</th>
											</tr>

										</thead>
										<tbody class="apply_table_sec">
											<tr id="${oldlist.ALARM_ID}">
												<td class="${oldlist.ALARM_CODE}" id="${oldlist.URL}">${oldlist.ALARM_CONTENT}
												</td>
											</tr>

										</tbody>
									</c:when>
									<c:otherwise>
										
										<thead>

											<tr class="table_head">
												<th>CLEAR</th>
											</tr>

										</thead>
										<tbody class="apply_table_sec">
											<tr>
												<td>지난 알림이 없어요</td>
											</tr>

										</tbody>
									
									</c:otherwise>

								</c:choose>
							</c:forEach>
						</table>
						<div class="info_text_sec">
						<p class="info_text">
							<i class="fas fa-cut"></i> 클릭하면 해당 알림을 삭제할 수 있어요!
						</p>
					</div>
					</div>
				</div>
			</div>
		</div>

	</main>
</body>
<script src="${pageContext.request.contextPath}/assets/js/myalarm.js?ver=1"></script>
<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</html>