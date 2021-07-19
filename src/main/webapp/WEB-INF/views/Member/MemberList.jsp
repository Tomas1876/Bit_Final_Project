<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 스프링 시큐리티 설정 -->
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<head>
<!-- member CSS -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/member.css?ver=1"
	rel="stylesheet">
</head>
<jsp:include page="../include/header.jsp"></jsp:include>
<body>
	<!-- http://localhost:8090/memberlist.cy -->

	<!-- 탑버튼 -->
	<img id="topBtn"
		src="${pageContext.request.contextPath}/assets/img/ain_test/topBtn.png">

	<div class="top_area">
		<div class="area-img">
			<p>
				함께 할 <br> 팀원을 찾아보세요
			</p>
		</div>
	</div>

	<c:set var="memberList" value="${memberList}" />
	<c:set var="positionList" value="${positionList}" />

	<div class="section section-md">

		<div class="m_container">

			<div class="select_section">
				<!-- select 필터링 -->
				<select class="form-select m_sel" id="inlineFormCustomSelectPref"
					aria-label="Default select example">
					<option value="전체">선호포지션: 전체</option>
					<c:forEach var="position" items="${positionList}">
						<c:if test="${position.position_enabled eq '1'}">
							<option value="${position.position_name}">${position.position_name}</option>
						</c:if>
					</c:forEach>
				</select>
				<!-- 닉네임검색 -->
				<div class="input-group m_search">
					<input type="text" class="form-control" id="memberNickname"
						placeholder="회원 닉네임" aria-label="Search"
						aria-describedby="basic-addon2"> <span
						class="input-group-text" id="memberSearch"> <span
						class="fas fa-search"></span>
					</span>
				</div>
			</div>

			<!-- last_flag : forEach문이 project_list의 끝까지 돌았는지 검사해준다. -->
			<!-- last_flage >>  true : project_list 끝까지 반복문 완료. -->
			<c:set var="last_flag" value="false" />

			<div class="row mb-5" id="card_section">
				<!-- 카드-->
				<c:forEach var="member" items="${memberList}" varStatus="status"
					begin="0" end="7">

					<!-- if문을 통해 현재 index가 project_list의 끝인지 검사 -->
					<c:if test="${status.count eq list_size}">
						<c:set var="last_flag" value="true" />
					</c:if>

					<c:if test="${member.rownum <= 8}">
						<div class="cardNum">
							<div class="card shadow">
								<div class="m_img">
									<img class="m_img_size"
										src="${pageContext.request.contextPath}/resources/upload/${member.m_image}">
								</div>
								<div class="card-body">
									<h3 class="h5 mt-3 card-title">${member.m_nick}</h3>
									<p class="card-text">${member.position}</p>
									<p class="tags"># ${member.skill}</p>

									<se:authorize access="hasRole('ROLE_PREMEMBER')">
										<a href="#" class="card_link deny_premember">VIEW MORE</a>
									</se:authorize>
									<se:authorize access="!hasRole('ROLE_PREMEMBER')">
										<a href="memberdetailpage?memberid=${member.m_id}"
											class="card_link">VIEW MORE</a>
									</se:authorize>

								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>

			</div>
			<div class="zerocontainer">
				<div class="row ">
					<div class="col-md-8 zerowrapper">
						<blockquote class="blockquote text-center shadow" id=zerolist>
							<p>찾으시는 회원이 없네요...😥</p>
						</blockquote>
					</div>
				</div>
			</div>
			<!-- 더보기버튼 -->
			<!-- 더보기버튼 -->
			<!-- last_flag가  true면 버튼은 감춘다.-->
			<div class="more_sec">
				<c:if test="${not last_flag}">
					<button class="moreBtn" id="moreBtn" type="button">더보기</button>
				</c:if>
			</div>
		</div>
	</div>
</body>
<jsp:include page="../include/footer.jsp"></jsp:include>

<script type="text/javascript">
	var memberList = ${memberList};
</script>
<!-- MemberList Javascript -->
<script
	src="${pageContext.request.contextPath}/assets/js/memberList.js?ver=2"></script>
</html>