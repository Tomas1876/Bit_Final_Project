<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
// 	양식 다시 제출 방지
	response.setHeader("Cache-Control","no-store"); 
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1")){ 
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CYCO COMMUNITY</title>
<link rel="stylesheet" type="text/css" href = "../css/BoardRead.css">
</head>
<jsp:include page="../include/header.jsp"></jsp:include>
<body>
<div class="container">
	<div class="section-header"></div>
	<br/>
	<br/>
	<header>
		<div>
			<h2>
				<span><c:out value="${boardInfo.FREE_TITLE}"/><br/></span>
			</h2>
			<div>
					<span><c:out value="${boardInfo.MEMBER_NICKNAME}"/></span>&nbsp; | &nbsp;<span><fmt:formatDate value="${boardInfo.FREE_DATE }" pattern="yyyy.MM.dd hh:mm:ss" /></span>
			</div>
			<div class="text-right">
					<span>조회&nbsp;<c:out value="${boardInfo.FREE_VIEWS}"/></span><br/>
			</div>			
		</div>
	</header>
	<hr/>
	<div class="form-group">
		<textarea class="form-control boardContent" cols="120" rows="15" readonly="readonly" disabled><c:out value="${boardInfo.FREE_CONTENT}" escapeXml="false"/></textarea>
	</div>	
	<br/>
	<div class="form-group" style="margin-bottom:10px">
			<label for="fileno">첨부파일</label>
			<c:if test="${sessionScope.nickname ne null}">
						<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:if test="${!empty listview.filename }">	
            				<a class="form-control" href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
 							<c:out value="${listview.filename}"/>&nbsp;<i class="fas fa-download font-img"></i></a><%-- <c:out value="${listview.size2String()}"/> --%>
 						</c:if>
						</c:forEach><br/>
		</c:if>				
	</div>			
	<hr id="replyHr">
	<label>댓글</label>
        <c:if test="${sessionScope.nickname ne null}">
        <div>
			<form name="form1" action="replysave" method="post">
				<div class="form-group">
				<input type="hidden" name="FREE_ID" value="<c:out value="${boardInfo.FREE_ID}"/>">
				<input type="hidden" name="MEMBER_ID" value="${sessionScope.member_id }">
				<textarea name="REPLY_CONTENT" class="form-control" rows="3" cols="120" onKeyUp="javascript:fnChkByte(this,'60')" placeholder="댓글을 작성해주세요."></textarea>
				<span id="byteInfo">0</span>/ 60byte
				<div class="text-right">
					<button type="button" onclick="fn_formSubmit()" class="btn btn-outline-primary text-right boardBtn">저장</button>
				</div>
				</div>
			</form>
		</div>
		<hr/>
		</c:if>
		<c:forEach var="replylist" items="${replylist}" varStatus="status">
			<div class="form-group" style="margin-top: 5px; position: relative; background:transparent; clear:both; display:block;
					padding-left: <c:out value="${20*replylist.DEPT}"/>px;">
					<c:choose>
					<c:when test="${replylist.DEPT eq '0'}">
					<div style="float:left; width:132px; margin-left:10px; margin-right:20px; margin-top:3px;">
						<c:out value="${replylist.MEMBER_NICKNAME}"/> 
					</div>
					<div id="reply<c:out value="${replylist.REPLY_ID}"/>" style="float:left; margin-top:3px;">
						<c:out value="${replylist.REPLY_CONTENT}"/>
					</div>
					 </c:when>
					 <c:otherwise>
					<div style="float:left; width:132px; margin-left:10px; margin-right:20px; margin-top:3px;">
						<img alt="replyIcon" src="../assets/img/board/re.png" width="10" height="10">&nbsp;<c:out value="${replylist.MEMBER_NICKNAME}"/> 
					</div> 
					 <div id="reply<c:out value="${replylist.REPLY_ID}"/>" style="float:left; margin-top:3px;">
					<c:out value="${replylist.REPLY_CONTENT}"/>
					</div>
					 </c:otherwise>
					 </c:choose>
					 <c:if test="${sessionScope.nickname eq replylist.MEMBER_NICKNAME}">
					<div style="float:right; margin-top:3px;">
						<fmt:formatDate value="${replylist.REPLY_DATE }" pattern="MM.dd hh:mm:ss" />
						<button class="imgBtn" onclick="fn_replyReply('<c:out value="${replylist.REPLY_ID}"/>')">&nbsp;<i class="fas fa-plus"></i></button>&nbsp;<button class="imgBtn" onclick="fn_replyUpdate('<c:out value="${replylist.REPLY_ID}"/>')" >&nbsp;<i class="fas fa-pencil-alt"></i></button>&nbsp;<button class="imgBtn" onclick="fn_replyDelete('<c:out value="${replylist.REPLY_ID}"/>')">&nbsp;<i class="fas fa-trash-alt"></i></button>
					</div>	
					</c:if>
					<c:if test="${sessionScope.nickname ne replylist.MEMBER_NICKNAME}">
					<div style="float:right; margin-top:3px; margin-right: 83px">
						<fmt:formatDate value="${replylist.REPLY_DATE }" pattern="MM.dd hh:mm:ss" />
						<span style="padding-left:6px;"><button class="imgBtn" onclick="fn_replyReply('<c:out value="${replylist.REPLY_ID}"/>')"><i class="fas fa-plus"></i></button></span>
					</div>
					</c:if>
<%-- 				<a href="#" onclick="fn_replyDelete('<c:out value="${replylist.REPLY_ID}"/>')">삭제</a> --%>
<%-- 				<a href="#" onclick="fn_replyUpdate('<c:out value="${replylist.REPLY_ID}"/>')">수정</a> --%>
<%-- 				<a href="#" onclick="fn_replyReply('<c:out value="${replylist.REPLY_ID}"/>')">대댓글</a> --%>
			</div><br/>
		</c:forEach>
		<div id="replySpace"></div>
		<br/>
		<!-- 댓글 수정 -->
		<div id="replyDiv" style="width: 99%; display:none">
			<form name="form2" action="replysave" method="post">
				<input type="hidden" name="FREE_ID" value="<c:out value="${boardInfo.FREE_ID}"/>"> 
				<input type="hidden" name="REPLY_ID"> 
				<textarea name="REPLY_CONTENT" class="form-control" rows="3" cols="120" onKeyUp="javascript:fnChkByte1(this,'60')" placeholder="수정할 댓글을 작성해주세요."></textarea>
				<span id="byteInfo1">0</span>/ 60byte
				<button onclick="fn_replyUpdateSave()" class="btn btn-outline-primary text-right boardBtn">저장</button>
				<button type="button" onclick="fn_replyUpdateCancel()" class="btn btn-default text-right boardBtn">취소</button>
			</form>
				
		</div>
		<!-- 대댓글 -->
		<br/>
		<div id="replyDialog" style="width: 99%; display:none; padding-top:30px;">
			<form name="form3" action="replysave" method="post">
				<input type="hidden" name="FREE_ID" value="<c:out value="${boardInfo.FREE_ID}"/>"> 
				<input type="hidden" name="REPLY_ID">
				<input type="hidden" name="REPLY_REF">
				<input type="hidden" name="MEMBER_ID" value="${sessionScope.member_id}">
				<textarea name="REPLY_CONTENT" class="form-control" rows="3" cols="120" onKeyUp="javascript:fnChkByte2(this,'60')" placeholder="댓글을 작성해주세요."></textarea>
				<span id="byteInfo2">0</span>/ 60byte
				<button onclick="fn_replyReplySave()" class="btn btn-outline-primary text-right boardBtn">저장</button>
				<button type="button" onclick="fn_replyReplyCancel()" class="btn btn-default text-right boardBtn">취소</button>
			</form>
		</div>
		<br/>
</div>
<div class="container text-right" style="margin-bottom:30px">
	<c:if test="${sessionScope.nickname eq boardInfo.MEMBER_NICKNAME}">
			<a href="form?FREE_ID=<c:out value="${boardInfo.FREE_ID}"/>" class="btn btn-outline-primary boardBtn">수정</a>
	        <a href="delete?FREE_ID=<c:out value="${boardInfo.FREE_ID}"/>" class="btn btn-outline-black boardBtn">삭제</a>
	        <a href="list" class="btn btn-outline-black boardBtn">목록</a>
	 </c:if>
	 <c:if test="${sessionScope.nickname eq '관리자'}">
	 		<a href="delete?FREE_ID=<c:out value="${boardInfo.FREE_ID}"/>" class="btn btn-outline-black boardBtn">삭제</a>
	 </c:if>
	 <c:if test="${sessionScope.nickname ne boardInfo.MEMBER_NICKNAME}">
			<a href="list" class="btn btn-outline-black boardBtn">목록</a>
	</c:if>		
</div>
<script src="${pageContext.request.contextPath}/assets/js/BoardRead.js" type="text/javascript"></script>
</body>
</html>