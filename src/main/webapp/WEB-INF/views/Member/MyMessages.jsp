<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:set var="tolist" value="${tolist}" />
<c:set var="fromlist" value="${fromlist}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>사이좋게 코딩하자</title>

<link type="text/css"
	href="${pageContext.request.contextPath}/css/mymessages.css"
	rel="stylesheet">


</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<body>
	<main>

		<div class="wish_container">
			<div class="wish_section apply_sec">
				<p class="wish_title">MESSAGES</p>
				<div class="wish_project_list">
					<div class="table_sec">
						<div class="info_text_sec" id="msg_filter">
							<p class="table_name_text checked_title" id="all_note">받은 쪽지</p>
							<p class="table_name_text" id="read_note">읽은 쪽지</p>
							<p class="table_name_text" id="never_read_note">안 읽은 쪽지</p>
						</div>

						<table class="table wish_table apply_table" id="to">
							<thead>

								<tr class="table_head">
									<th>READ</th>
									<th>FROM</th>
									<th>MESSAGE</th>
									<th>DATE</th>
									<th class="check_th"><input type="checkbox" class="all"
										id="all_to"></th>
								</tr>

							</thead>
							<c:forEach var="tolist" items="${tolist}">
								<c:choose>
									<c:when test="${not empty tolist}">
										<c:choose>

											<c:when test="${tolist.NOTE_OK eq '0'}">
												<tbody class="apply_table_sec new">
													<tr id="to${tolist.NOTE_ID}">
														<td class="isread"><i class="far fa-envelope"></i></td>
														<td class="sender" id="from${tolist.MEMBER_FROM}"><a
															href="/member/memberdetailpage?memberid=${tolist.MEMBER_FROM}">${tolist.MEMBER_NICKNAME}</a></td>
														<td class="content"><a href="#to_note_modal"
															class="trigger-btn msg-trigger" data-toggle="modal">${tolist.NOTE_CONTENT}</a>
															<input type="hidden" value="${tolist.NOTE_CONTENT}">
														</td>
														<td class="date">${tolist.NOTE_DATE}</td>
														<td class="del_check"><input type="checkbox"
															class="del_received" name="NOTE_ID"
															value="${tolist.NOTE_ID}"> <%-- <label for="check_to_${tolist.NOTE_ID}"><i class="far fa-trash-alt"></label> --%></td>
													</tr>
												</tbody>
											</c:when>

											<c:when test="${tolist.NOTE_OK eq '1'}">
												<tbody class="apply_table_sec read">
													<tr id="to${tolist.NOTE_ID}">
														<td class="isread"><i
															class="fas fa-envelope-open-text"></i></td>
														<td class="sender" id="from${tolist.MEMBER_FROM}"><a
															href="/member/memberdetailpage?memberid=${tolist.MEMBER_FROM}">${tolist.MEMBER_NICKNAME}</a></td>
														<td class="content"><a href="#to_note_modal"
															class="trigger-btn msg-trigger" data-toggle="modal">${tolist.NOTE_CONTENT}</a>
															<input type="hidden" value="${tolist.NOTE_CONTENT}">
														</td>
														<td class="date">${tolist.NOTE_DATE}</td>
														<td class="del_check"><input type="checkbox"
															class="del_received" name="NOTE_ID"
															value="${tolist.NOTE_ID}"></td>
													</tr>
												</tbody>
											</c:when>

										</c:choose>
									</c:when>
									<c:otherwise>
										<tbody class="apply_table_sec">
											<tr>
												<td>받은 쪽지가 없습니다</td>
											</tr>

										</tbody>

									</c:otherwise>

								</c:choose>
							</c:forEach>
						</table>

						<div class="info_text_sec">
							<p class="info_text">
								삭제하고 싶은 쪽지를 선택하세요 <i class="far fa-trash-alt trash"
									id="to_trash"></i>
							</p>
						</div>
						<div class="marginBox"></div>

						<div class="info_text_sec">
							<p class="table_name_text">보낸 쪽지</p>
						</div>
						<table class="table wish_table apply_table" id="from">

							<thead>

								<tr class="table_head">
									<th>SEND</th>
									<th>TO</th>
									<th>MESSAGE</th>
									<th>DATE</th>
									<th><input type="checkbox" class="all" id="all_from"></th>
								</tr>

							</thead>
							<c:forEach var="fromlist" items="${fromlist}">
								<c:choose>

									<c:when test="${not empty fromlist}">

										<tbody class="apply_table_sec">
											<tr class="sended" id="from${fromlist.NOTE_ID}">
												<td class="isread"><i class="fas fa-paper-plane"></i></td>
												<td class="receiver"><a
													href="/member/memberdetailpage?memberid=${fromlist.MEMBER_TO}">${fromlist.MEMBER_NICKNAME}</a></td>
												<td class="content"><a href="#from_note_modal"
													class="trigger-btn msg-trigger" data-toggle="modal">${fromlist.NOTE_CONTENT}</a>
													<input type="hidden" value="${fromlist.NOTE_CONTENT}">
												</td>
												<td class="date">${fromlist.NOTE_DATE}</td>
												<td class="del_check"><input type="checkbox"
													class="del_send" name="NOTE_ID" value="${fromlist.NOTE_ID}"></td>
											</tr>
										</tbody>
									</c:when>

									<c:otherwise>

										<tbody class="apply_table_sec">
											<tr>
												<td>보낸 쪽지가 없습니다</td>
											</tr>

										</tbody>

									</c:otherwise>

								</c:choose>
							</c:forEach>
						</table>
						<div class="info_text_sec">
							<p class="info_text">
								삭제하고 싶은 쪽지를 선택하세요 <i class="far fa-trash-alt trash"
									id="from_trash"></i>
							</p>

						</div>
					</div>
				</div>
			</div>
		</div>

	</main>

	<!-- 수신 창 -->
	<div id="to_note_modal" class="modal fade">
		<div class="modal-dialog modal-login">
			<!-- 수신 메시지 보이는 영역 답장하기 클릭시 비활성화 -->
			<div class="modal-content" id="message_content">
				<div class="modal-header">
					<p id="modal-title">쪽지 읽기</p>
				</div>
				<div id="modal-body">
					<!-- <div id="msg_img"></div> -->
					<div class="messagearea">
						<div class="msg_content"></div>
					</div>
					<input type="hidden" id="reply_to">
					<div class="msg_buttonarea">

						<button class="msg_btn" id="reply_btn">답장하기</button>
						<a href="#to_note_modal" class="trigger-btn" data-toggle="modal">
							<button class="close_modal">닫기</button>
						</a>
					</div>

				</div>
			</div>

			<!-- 답장하기 클릭시 활성화 -->
			<div class="modal-content" id="reply_content">
				<div class="modal-header">
					<p id="modal-title">답장쓰기</p>
				</div>
				<div id="modal-body">
					<!-- <div id="msg_img"></div> -->
					<div id="messagearea"></div>
					<input type="hidden" name="text" id="text">
					<div id="textcount"></div>
					<div id="msg_buttonarea">

						<a href="#to_note_modal" class="trigger-btn" data-toggle="modal">
							<button class="send_btn" id="msg_btn">
								<i class="far fa-paper-plane"></i>
							</button>
						</a>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 발신 창 -->
	<div id="from_note_modal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<p id="modal-title">쪽지 쓰기</p>
				</div>
				<div id="modal-body">
					<!-- <div id="msg_img"></div> -->
					<div class="messagearea clickedarea">
						<div class="msg_content"></div>
					</div>
					<div class="msg_buttonarea">

						<a href="#from_note_modal" class="trigger-btn" data-toggle="modal">
							<button class="close_modal">닫기</button>
						</a>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 쪽지 보내기 -->
	<div id="reply_modal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content" id="reply_content">
				<div class="modal-header">
					<p id="modal-title">SEND</p>
				</div>
				<div id="modal-body">
					<!-- <div id="msg_img"></div> -->
					<div id="messagearea">
						<span>쪽지가 전송되었습니다</span>
					</div>
					<input type="hidden" name="text" id="text">
					<div id="textcount"></div>
					<div id="msg_buttonarea">

						<a href="#message_modal" class="trigger-btn" data-toggle="modal">
							<button class="send_btn" id="msg_btn">
								<i class="far fa-paper-plane"></i>
							</button>
						</a>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/assets/js/mymessages.js"></script>
<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
</html>