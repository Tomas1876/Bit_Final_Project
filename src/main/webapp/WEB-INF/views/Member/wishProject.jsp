<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>Insert title here</title> -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/wishProject.css"
	rel="stylesheet">
<!-- 북마크 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/wishProject.js?ver=2"></script>
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
	<c:set var="bookmark_list" value="${bookmark_list}" />
	<c:set var="apply_list" value="${apply_list}" />
	
	<div class="wish_container">
		<div class="wish_section apply_sec">
			<p class="wish_title">지원한 프로젝트</p>
			<div class="wish_project_list">
					<div class="table_sec">
					<!-- 프로젝트목록 -->
					<!-- 지원목록 영역 -->
					
					<!-- 지원한 프로젝트(모집중)가 한개도 없는 경우 문구 출력용 -->
					<c:set var="wish_project_nothing" value="true"/>
					
					<div class="info_text_sec">
						<p class="table_name_text">모집중인 프로젝트</p>
					</div>
					<table class="table wish_table apply_table">
						<thead>
							<tr class="table_head">
								<th> </th>
								<th>프로젝트명</th>
								<th>지원 날짜</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody class="apply_table_sec">
							<c:forEach var = "apply" items="${apply_list}">
								<c:if test="${apply.p_state eq '모집중' && apply.apply_ok eq 0}">
									<tr>
										<td><i class="fas fa-cut applyCancle" id="${apply.project_id}"
											onclick='applyCancle(${apply.apply_id})'></i></td>
										<td><a href="/project/detail?project_id=${apply.project_id}">${apply.p_title}</a></td>
										<td>${fn:substring(apply.apply_date, 2,10)}</td>
										<td><p class="state_ing"> 모집중 </p></td>
									</tr>
									<c:set var="wish_project_nothing" value="false"/>
								</c:if>
							</c:forEach>
						</tbody>
						
						<!-- 모집중인 프로젝트 없는 경우 목록 출력 -->
						<c:if test="${wish_project_nothing eq true}">
							<tr><td colspan="4">
								<p class="not_project">지원한 프로젝트가 없습니다.</p>
							</td></tr>
							<c:set var="wish_project_nothing" value="false"/>
						</c:if>
						
					</table>
					<div class="info_text_sec">
						<p class="info_text">
							<i class="fas fa-cut"></i> 버튼을 누르면 해당 지원을 취소할 수 있어요!
						</p>
					</div>
					<div class="marginBox"></div>
					
					<!-- 지원한 프로젝트(마감)가 한개도 없는 경우 문구 출력용 -->
					<c:set var="wish_end_project_nothing" value="true"/>
					
					<!-- 마감된 플젝 -->
					<div class="info_text_sec">
						<p class="table_name_text">마감된 프로젝트</p>
					</div>
					<table class="table wish_table apply_table">
						<thead>
							<tr class="table_head">
								<th>프로젝트명</th>
								<th>지원 날짜</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var = "apply" items="${apply_list}">
							<c:choose>
								<c:when test="${apply.p_state ne '모집중' && apply.apply_ok ne 2}">
									<tr>
										<td><a href="/project/detail?project_id=${apply.project_id}">${apply.p_title}</a></td>
										<td>${fn:substring(apply.apply_date, 2,10)}</td>
										<td><p class="state_end"> 모집완료 </p></td>
									</tr>
									<!-- 지원한 프로젝트(마감)가 한개도 없는 경우 문구 출력용 -->
									<c:set var="wish_end_project_nothing" value="false"/>
								</c:when>
								<c:when test="${apply.apply_ok eq 2}">
									<tr>
										<td><a href="/project/detail?project_id=${apply.project_id}">${apply.p_title}</a></td>
										<td>${fn:substring(apply.apply_date, 2,10)}</td>
										<td><p class="state_ban"> 승인거절 </p></td>
										<c:set var="wish_end_project_nothing" value="false"/>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
						</tbody>
						<!-- 마감된 프로젝트 없는 경우 목록 출력 -->
						<c:if test="${wish_end_project_nothing eq true}">
							<tr><td colspan="3">
								<p class="not_project">지원한 프로젝트가 없습니다.</p>
							</td></tr>
							<c:set var="wish_end_project_nothing" value="false"/>
						</c:if>
					</table>
				</div>
			</div>
		</div>
		
		<div class="wish_section bookmark_sec">
			<p class="wish_title">북마크한 프로젝트</p>
			<div class="wish_project_list">
				<div class="info_text_sec">
					<p class="info_text">
						<i class="fas fa-heart"></i> 버튼을 누르면 북마크를 취소할 수 있어요!
					</p>
				</div>
				<div class="table_sec">
					<!-- 프로젝트목록 -->
					<table class="table wish_table bookmark_table">
						<tbody>
							<c:forEach var = "bookmark" items="${bookmark_list}">
								<tr>
									<td><i class="fas fa-heart bookmark marking"
										id="${bookmark.project_id}" onclick='BookMarking(${bookmark.project_id})'></i></td>
									<td><a href="/project/detail?project_id=${bookmark.project_id}">${bookmark.p_title}</a></td>
										<c:if test="${bookmark.p_state eq '모집중'}">
											<td><p class="state_ing"> ${bookmark.p_state} </p></td>
										</c:if>
										<c:if test="${bookmark.p_state ne '모집중'}">
											<td><p class="state_end"> 모집완료 </p></td>
										</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>

<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</html>