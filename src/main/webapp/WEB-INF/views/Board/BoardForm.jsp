<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" type="text/css" href = "../css/BoardForm.css">
</head>
<jsp:include page="../include/header.jsp"></jsp:include>
<body>
<div class="container">
	<div class="section-header"></div>
	<br/><br/>
	<form name="form" action="save" method="post" enctype="multipart/form-data" autocomplete="off">
		<input type="hidden" name="MEMBER_ID" value="${sessionScope.member_id }">
		<input type="hidden" name="FREE_ID" value="<c:out value="${boardInfo.FREE_ID}"/>">
		<div class="form-group">
			<label for="FREE_TITLE">제목</label>
			<input type="text" id="FREE_TITLE" name="FREE_TITLE" class="form-control" placeholder="제목을 입력해 주세요." pattern=".{1,150}" maxlength="150" onKeyUp="javascript:fnChkByte(this,'80')" value="<c:out value="${boardInfo.FREE_TITLE}"/>">
			<span id="byteInfo">0</span>/ 80byte
		</div>
		<br/>
		<div class="form-group">
			<label for="FREE_CONTENT">내용</label>
			<textarea id="FREE_CONTENT" name="FREE_CONTENT"  onKeyUp="javascript:fnChkByte1(this,'2500')" class="form-control" placeholder="내용을 입력해 주세요." rows="15" cols="120"><c:out value="${boardInfo.FREE_CONTENT}"/></textarea>
			<span id="byteInfo1">0</span>/ 2500byte
		</div>
		<br/>	
		<div class="form-group">
			<label for="fileno">첨부파일</label>
			<c:forEach var="listview" items="${listview}" varStatus="status">
				<input type="checkbox" name="fileno" value="<c:out value="${listview.fileno}"/>">	
            	<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
				<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
			</c:forEach>		
			<input type="file" id="uploadfile" name="uploadfile" class="form-control" multiple="multiple" onchange="previewImage(this,'View_area')"/>
			<div id='View_area' style='position:relative; color: black; border: 0px solid black; dispaly: inline; '></div>
		</div>
		<br/>
		<div class="text-right" style="margin-bottom:30px">			 
			<a href="#" onclick="fn_formSubmit()" class="btn btn-outline-primary boardBtn">등록</a>
			<a href="list" class="btn btn-outline-black boardBtn">취소</a>
		</div>
	</form>	
</div>
<!-- <script src="../assets/js/BoardForm.js" type="text/javascript"></script> -->
<script src="${pageContext.request.contextPath}/assets/js/BoardForm.js" type="text/javascript"></script>
</body>
</html>