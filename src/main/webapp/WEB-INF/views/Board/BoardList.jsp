<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="width=device-width; initial-scale=1; text/html; charset=utf-8" />
<title>CYCO COMMUNITY</title>
<link rel="stylesheet" type="text/css" href = "../css/BoardList.css">
</head>
<jsp:include page="../include/header.jsp"></jsp:include>
<body>
<br/>
<div class="container">
<div class="section-header"></div>
<form id="form1" name="form1"  method="post">
<div class="form-group" id="searchDiv">
			<input type="checkbox" name="searchType" onclick="checkOnlyOne(this)" value="FREE_TITLE" <c:if test="${fn:indexOf(searchVO.searchType, 'FREE_TITLE')!=-1}">checked="checked"</c:if>/>
			<label class="chkselect" for="searchType1">제목</label>
			<input type="checkbox" name="searchType" onclick="checkOnlyOne(this)" value="FREE_CONTENT" <c:if test="${fn:indexOf(searchVO.searchType, 'FREE_CONTENT')!=-1}">checked="checked"</c:if>/>
			<label class="chkselect" for="searchType2">내용</label>
			<input type="text" name="searchKeyword" id="searchInput" maxlength=50; placeholder="검색" value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}"><button  name="btn_search" id="searchBtn" class="btn_sch input-group-addon" type="button" onclick="fn_formSubmit()"><span class="fas fa-search"></span></button>
		</div>
<div class="table-responsive-sm" id="boardTableRes">
	<table class="table table-hover" id="boardTable">
		<thead>
			<tr>
				<th scope="col" class="text-center">번호</th> 
				<th scope="col" class="text-center">제목</th>
				<th scope="col" class="text-center">글쓴이</th>
				<th scope="col" class="text-center">작성일</th>
				<th scope="col" class="text-center">조회</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="listview" items="${listview}" varStatus="status">	
				<c:url var="link" value="read">
					<c:param name="FREE_ID" value="${listview.FREE_ID}" />
				</c:url>		
				<tr>
					<td scope="row" align="center">
						<c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/>
					</td>
					<td scope="row">
						<a href="${link}"><c:out value="${listview.getShortTitle(50)}"/></a>
					</td>
					<td  scope="row"align="center">
						<c:out value="${listview.MEMBER_NICKNAME}"/>
					</td>
					<td scope="row" align="center">
						<fmt:formatDate value="${listview.FREE_DATE }" pattern="MM.dd" />
					 </td>
					<td scope="row" align="center">
						<c:out value="${listview.FREE_VIEWS}"/>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
		<c:if test="${sessionScope.nickname ne null}">
		<div class="text-right">
			<a href="form" id="writeBtn" class="btn btn-outline-primary boardBtn">글쓰기</a>
		</div>
		</c:if>
	<div class="text-center">
		<!-- 페이징 호출2 -->
	    	<jsp:include page="/WEB-INF/views/common/pagingforSubmit.jsp" />
		</div>
	</form>
	</div>
	
<!-- 	<script src="../assets/js/BoardList.js" type="text/javascript"></script> -->
	<script src="${pageContext.request.contextPath}/assets/js/BoardList.js" type="text/javascript"></script>
</body>
</html>
