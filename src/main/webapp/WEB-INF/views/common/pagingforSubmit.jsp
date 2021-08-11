<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${searchVO.totPage>1}">
	<div class="row justify-content-center">
					    <div class="col-lg-3">
							<div class="mb-1">
		<nav aria-label="Blog page navigation">
		<ul class="pagination justify-content-center">
		<c:if test="${searchVO.page>1}">
<!-- 			<a href="javascript:fnSubmitForm(1);" class="page-link">[처음]</a> -->
			<li class="page-item">
			<a href="javascript:fnSubmitForm(1);" class="page-link"><span class="fas fa-angle-double-left"></span></a>
			</li>
			<li class="page-item">
<%-- 			<a href="javascript:fnSubmitForm(${searchVO.page-1});" class="page-link">[이전]</a> --%>
			<a href="javascript:fnSubmitForm(${searchVO.page-1});" class="page-link" aria-label="first link"><span class="fas fa-chevron-left"></span></a>
			</li>
		</c:if>
		<c:forEach var="i" begin="${searchVO.pageStart}" end="${searchVO.pageEnd}" step="1">
            <c:choose>
                <c:when test="${i eq searchVO.page}">
                	<li class="page-item active">
<%--                 	<c:out value="${i}"/> --%>
						<a href="#" class="page-link"><c:out value="${i}"></c:out></a>
                	</li>
                </c:when>
                <c:otherwise>
                	<li class="page-item">
                		<a href="javascript:fnSubmitForm(${i});" class="page-link"><c:out value="${i}"/></a>
                	</li>
                </c:otherwise>
            </c:choose>
<%--             <c:if test="${not status.last}">/</c:if> --%>
        </c:forEach>
		<c:if test="${searchVO.totPage > searchVO.page}">
<%-- 			<a href="javascript:fnSubmitForm(${searchVO.page+1});">[다음]</a> --%>
			<li class="page-item">
			<a href="javascript:fnSubmitForm(${searchVO.page+1});" class="page-link" aria-label="first link"><span class="fas fa-chevron-right"></span></a>
			</li>
			<li class="page-item">
			<a href="javascript:fnSubmitForm(${searchVO.totPage});" class="page-link"><span class="fas fa-angle-double-right"></span></a>
			</li>
		</c:if>
		</ul>
		</nav>
	</div>
	</div>
	</div>
	<br/>
	<input type="hidden" name="page" id="page" value="" />
		
	<script type="text/javascript">
	function fnSubmitForm(page){ 
		document.form1.page.value=page;
		document.form1.submit();
	}
	</script>
</c:if>
