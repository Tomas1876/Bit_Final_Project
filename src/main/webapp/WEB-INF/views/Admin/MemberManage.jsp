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
	href="${pageContext.request.contextPath}/css/adminMember.css"
	rel="stylesheet">
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
	<c:set var="memberList" value="${memberList}" />
	<c:set var="finishList" value="${finishList}" />

	
	<div class="wish_container">
		<div class="wish_section apply_sec">
			<p class="wish_title">회원 관리</p>
			<div class="wish_project_list">
					<div class="table_sec">
					<!-- 프로젝트목록 -->
					<!-- 지원목록 영역 -->
					<p class="mem_info_text"><b style="color:red;">* </b>회원 영구정지를 원하면 <i class="fas fa-ban" style="color:red;"></i> 버튼을 누르세요.</p>
					<div class="mem_info_text_sec">
					<p><span class="m_status">전체 회원</span><span class="m_status" id="able">정상 회원</span> <span class="m_status" id="disable">정지 회원</span></p>
						<div class="input-group m_search">
							<input type="text" class="form-control" id="MemberNameSearch" placeholder="회원 닉네임" name="projectname" aria-label="Search" aria-describedby="basic-addon2">
							<span class="input-group-text" id="searchIcon">
								<span class="fas fa-search" style="cursor: pointer;"></span>
							</span>
						</div>
					</div>
					<table class="table wish_table apply_table">
						<thead>
							<tr class="table_head">
								<th> </th>
								<th>회원 닉네임</th>
								<th>선호 포지션</th>
								<th>주 기술</th>
								<th>완료한 프로젝트 횟수</th>
							</tr>
						</thead>
						<tbody class="apply_table_sec">
							<c:forEach var="member" items="${memberList}">
							<c:set var="check" value="0"/>
									<tr class="members">
										<td class="isBan">
										<i 
										<c:if test='${member.enabled == "1"}'>
											class="fas fa-ban applyBan"
										</c:if>
										<c:if test='${member.enabled == 0}'>
											class="fas fa-ban cancelBan"
										</c:if>
										
										 id="${member.member_id}" ></i></td>
										<td><a href="/member/memberdetailpage?memberid=${member.member_id}">${member.member_nickname}</a></td>
										<td>${member.position_name }</td>
										<td>${member.skill_name }</td>
										<td>${member.count} 회</td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="marginBox"></div>
 
				</div>
			</div>
		</div>
		
		
	</div>
</body>

<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
<script type="text/javascript" src="/assets/js/adminMember.js"></script>

</html>