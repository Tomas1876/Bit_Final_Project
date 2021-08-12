<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<!-- 스프링 시큐리티 설정 -->
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<head>
<!-- member CSS -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/ProjectList.css"
	rel="stylesheet">
<!-- Swiper Css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<!-- Swiper js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<!-- 북마크 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/bookmark.js?ver=1"></script>
</head>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
	<c:set var="project_list" value="${project_list}" />
	<c:set var="adr_list" value="${adr_list}" />
	<c:set var="field_list" value="${field_list}" />
	<c:set var="skill_list" value="${skill_list}" />
	<c:set var="pjsk_list" value="${pjsk_list}" />
	<c:set var="membercount_list" value="${membercount_list}" />
	<c:set var="bookmark_list" value="${bookmark_list}" />
	
	
	<!-- 탑버튼 -->
	<img id="topBtn"
		src="${pageContext.request.contextPath}/assets/img/ain_test/topBtn.png">

	<div class="top_area">
		<div class="area-img">
		<p>나와 맞는 <br> 프로젝트를 찾아보세요.</p>
      	</div>
	</div>
	
	

	
	<div class="section section-md">

		<div class="p_container">

			<div class="select_section">
				<!-- select 필터링 -->
				<!-- 지역 -->
				<select class="form-select p_sel" id="adrSelect"
					aria-label="Default select example">
					<option value="">지역: 전체</option>
					<c:forEach var="adr" items="${adr_list}">
	                     <option value="${adr.adr_code}">${adr.adr_name}</option>
	               </c:forEach>
				</select>
				<!-- 분야 -->
				<select class="form-select p_sel" id="fieldSelect"
					aria-label="Default select example">
					<option value="">분야: 전체</option>
					<c:forEach var="field" items="${field_list}">
	                  <c:if test="${field.field_enabled eq '1'}">
	                     <option value="${field.field_code}">${field.field_name}</option>
	                  </c:if>
	               </c:forEach>
				</select>
				<!-- 주언어 -->
				<select class="form-select p_sel" id="skillSelect"
					aria-label="Default select example">
					<option value="">주언어: 전체</option>
					<c:forEach var="skill" items="${skill_list}">
	                  <c:if test="${skill.skill_enabled eq '1'}">
	                     <option value="${skill.skill_code}">${skill.skill_name}</option>
	                  </c:if>
	               </c:forEach>
				</select>
				<!-- 상태 -->
				<select class="form-select p_sel" id="stateSelect"
					aria-label="Default select example">
					<option value="">상태: 전체</option>
					<option value="모집중">모집중</option>
					<option value="진행중">진행중</option>
					<option value="완료">완료</option>
				</select>

				<!-- 프로젝트이름검색 -->
				<div class="input-group p_search">
					<input type="text" class="form-control" id="ProjectNameSearch" placeholder="프로젝트이름" name="projectname"
						aria-label="Search" aria-describedby="basic-addon2">
					<span class="input-group-text" id="searchIcon">
						<span class="fas fa-search"></span>
					</span>
				</div>
			</div>
			
	<p id="wouldyoulike">이런 프로젝트는 어떠세요?</p>
	<!-- 추천 리스트 박스 -->
	<div id="slidewrapper">
	<!-- 클래스명은 변경하면 안 됨 -->
	<div class="swiper-container mySwiper">

		<div class="swiper-wrapper">
			<c:forEach var="rcm" items="${rcm_list}">
			<div class="swiper-slide" >
			<!-- 프로젝트카트 start -->

				<div class="col-12 col-md-6 col-lg-4 mb-5 cardNum" id="rcmcard" >
					<div class="card shadow" >
						<!-- 카드헤더: 모집상태,분야,조회수 -->
						
						<!-- 프로젝트이미지 -->

                       
                        <!-- 프로젝트이름, 주언어 -->


						<div class="card-body" id="backimg" style="background-image:url(${pageContext.request.contextPath}/images/${rcm.p_image})">		
						<!-- 추가정보 미입력 회원이면 상세 보기 경고 -->
						<se:authorize access="hasRole('ROLE_PREMEMBER')">
							<a href="#"><h3 class="h5 card-title deny_premember">${rcm.p_title}</h3></a>
						</se:authorize>
						<se:authorize access="!hasRole('ROLE_PREMEMBER')">
							<a href="/project/detail?project_id=${rcm.project_id}"><h3 class="h5 card-title">${rcm.p_title}</h3></a>
						</se:authorize>
							<p class="card-text recommend_skill" >
								<c:forEach var = "pjsk" items="${pjsk_list}" varStatus="status" > 
									<c:if test="${pjsk.project_id eq rcm.project_id}">
										#${pjsk.skill_name}
									</c:if>
								</c:forEach>
								</p>
							
						</div>

					</div>
				</div>

				<!-- 프로젝트카드end -->
			</div>
			</c:forEach>
		</div>
		

		
	</div>
	<!-- 페이징 -->
			<!-- 네비게이션 -->
		 <div class="swiper-button-next">
		 <svg 
 xmlns="http://www.w3.org/2000/svg"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 width="27px" height="44px">
<image  x="0px" y="0px" width="27px" height="44px"  xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGUAAAC4CAMAAADNAtIMAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABJlBMVEXFtLrBrLzAqb3BrbzCrbzCrrvDrrvDr7vDsLvEsbvEsrvEsrrEs7rFs7rAqr3Bqr3Bq7zCrrzFtLrCrbzBrLzDr7vDsLvEsbvEsrvFs7rFs7rFtLrFtLrBrLzAqb3Bq7zBrLzFtLrBrbzCrbzCrbzCrbzCrbzCrrvDrrvDrrvDrrvDr7vDr7vDr7vDr7vDr7vDsLvEsbvEsbvEsbvEsbvEsrvEsrvEsrvEsrvEsrrEsrrEs7rEs7rFs7rFs7rFs7rFs7rFtLrFtLrFtLrFtLrBrbzAqr3Bqr3Bq7zAqb3BrLzAqb3CrrzAqr3DsLvBq7zEs7rBrLzAqb3Aqr3Bq7zBrbzBrLzCrrvDr7vDsLvEsLvEsbvEsrvEsrrEs7rFs7rFtLr///9XjYPhAAAAUnRSTlMAAAAAAAAAAAAAAAAAAAAAAAAQ69vk3dvX09LQz+Cfw9lg19XSz83KycbDwb+9vLq4tbSysLCvrKuqqaimpaSjoqGgn4/tkW5N/jb9JfsY9xLx/bnpaQAAAAFiS0dEYbKwTIYAAAAHdElNRQflBhYQEylPFKf8AAADM0lEQVR42r3Nh2JSQRBG4UvEEAhYsGvsvfdeosbeXSD28v5PYRKCkDt7d6f8w3mA8xXFsO6OnTW/RsiuEByZdWR3CJ7MENkTgiuzhuwNwZdZRfb1gjOzguwfI15M0T0wiTgxxUI/BHemOBiCP1McClNgiplpMMXMNJgVZQrMquLPrCnuzFDxZtYVZ2ak+DL/FVdmrHgyE4ojM6n4MRsUN2aj4sWUFCemrPgwRHFhqOLBRBQHJqbgmagCZ+IKmqlQwEyVgmUqFShTrSCZhAJkUgqOSSowJq2gmIwCYnIKhskqECavIBiGAmA4ip1hKWaGp1gZpmJkuIqNYSsmhq9YGIFiYCSKnhEpakamaBmhomSkio4RKypGrmgYhaJgNIqcUSliRqdIGaUiZLSKjFErIkavSBiDImAsCp8xKWzGpnAZo8JkrAqPMSssxq5wGIDCYBBKnoEoWQaj5BiQkmFQSpqBKUkGp6QYoJJgkEo1A1UqGaxSxYCVCgatxBm4EmXwysxhohwp4B0dlJFjNfs1ixzfBFcocqIOVyhysg5XKHKqDlcocroOVyhyZjNcocjZWbhCkXOzcIUi52fhCkUuNOAKRS424ApFLjXgCkUuN+AKRa404ApFrs7BFYpca8IVilxvwhWK3GjCFYrcbMIVitxqwRWK3G7BFYrcacEVgvTutuAKRe7Nw5UYAlcocn8erlDkQRuuUORhG65EkA5cocijDlyhyGIHrsQRsEKRxx24QpD+kw5ciSAFXIkhcIUiTwu4EkfACkGWlwq4UoVAlUoEqRBkMEKASgLBKQT5MkZgShJBKWkEpGQQjJJDIApBvpYQhJJHAAoDsSscxKywEKtCkG8xxKgQ5HsUsSlcxKSwEYtCkB9ViEERIHqFID+rEbUiQrSKDFEqQkSnEORXGlEpYkSjPCsjv3OIQlmSI3KljPQYiFhRIVKFIH84iFBRIjJFi4gUNSJR9IhAMSB8hSB/+QhbMSFcxYYwlTLSlyE8xYqwFDPCUp5bEZbywoqwlC0vJ5BlBcJTtr56bUKYyrY3by0IV6m9e29A2Mr2Dx9DGCgRvjL36bMaESjt7oIW4Sj/AKYmitKQcugzAAAAAElFTkSuQmCC" />
</svg>
		 </div> <!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		 <div class="swiper-button-prev">
		<svg 
 xmlns="http://www.w3.org/2000/svg"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 width="27px" height="44px">
<image  x="0px" y="0px" width="27px" height="44px"  xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGYAAAC4CAYAAAAR65k9AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH5QYWECEwxg9bTQAADVdJREFUeNrtnVmQJEUZgL/MrO6enQU55FgCMEBXETwiWG7kXi6572uRhRCvUMMjvEJDQ3hQ0dAHDUNAUZb7vm+5VlgEgUWuZVnWQA0lCBEEZGa6pyszfciecVnm6O76u7O6u7636en+K//8oqqrszL/VPdfeQ8F3aE01/7OjuuDXarOxXPWTO/VsRs7KDSknO7qah6e76P41EzvL8R0gTWk/P9Fz3lKc8R0nynEdJgppQSU91yntF841ecKMR1kBikBj/Fe3aGMX7D2vwoxHaI0115oazNImcCT4NRDuuTnr/lyIaYDNKQsdqlq6v3eU/GWJ03ZbTnxWiFGmFalTOCdGnapWpEMuU2gECNKaa5d0o6UCbxT67i6WgmoJHYy/UJprl1iq/o0Z9uTMoGzagPgB4UYAUpz7ZK0qk/zGaWswWghJiOlYXtRWtWfEJTyLeCcQkwGSsP24rSmTxWS4oGvAT8DKMS0SQekfBH45cQLhZg2KA3bS9KaXiQo5bPA+Wu+WIhpkdKwvTSt6lO8E5FigTOBC9f+RyGmBRJ5KYuBS6c8Vuxke4Vk2F5mq/pkISl14FTgqmmPFzvhXiAZtpfbqj5JSMo4cBJw/YzHjJ103knm2Cts1ZzonUi4GnAccMusx42deJ5J5tgrbc2cICRlDDgauLOpY8dOPq8kc9xVtmaOF5IyChwBND3zpRAzBckcd7Wt6uO8Fwn3FnAI8EArHyqG/dcimeOuEZTyBnAwLUqB4ox5G8kcd62t6mOEpLwOHAg82lZbYndGXkiG3HW2qo8WkvIqQcryttsTu0PyQDLkrk9r+ihkpLwC7A88lalNsTslNsmQuzGt6SOEpLwMLARWZG5X5H6JSjLkbkpr+nAhKf8kSHlepG0R+yUqyZC7Oa3pw4Sk/J0gZbVY+yL1S1RMxd2a1vQhQlJeBPYD/irZxoH7HWMq7jY7LiZlNbAPwlJgwM4YU3G325o+WCjcSsLl66VOtHVgxJiKu9PW9IFC4VYQpLzcqfYOxKXMVNxdglL+TLh8dUwKDMAZYyrublvTC7NHAsIv+QOA1zrd7r4+Y0zZ3Sso5RHC5avjUqCPxZiyu8+O632Fwi0jjH293q3296UYU3ZL7bjeRyjcUsLQ/ZvdzKHvxJiye8CO672Ewt1NeMj1Vrfz6CsxuuSX2XG9h1C4OwiPg0ej5BLjoB1JpOT/6Opqd6FwNwNHEiZQxMkn1oFFkyj5h11d7SoU7jrCFKPxqDnFPLhIAiX/qKurXYTCXQmcSGQp0ONidOIfd3W1o1C4S4BFQBo7L+hhMTrxy12qFmSPBMBvgdMJE71zQU+K0Yl/0qVqe6Fw5xGWQuRGCvSgGJ34p12qPioU7hfA50Do6YxknrEb0AJKJ/5Zl6oPC8X7KfAlcigFekeM0savcKnaTijeDwkLUXMpBXpDjFLGr3RWfVAo3tnAt2MnNRt5fx5jlPHPeaveLxTv24SzJffkWYxRxj/vrXqfULxvAD+JnVSz5FVMooxf5a3aWiCWJ3zJ/yJ2Ui11QOwGTEG5caZsJRDLA58HfhU7qVbJm5iy0n61t2rL7KFwwKeBC2In1Q55EjOktH/BO7WFQCwHnAFcFDupdsmLmGGl/Srv1OYCsRxhMPKK2EllIQ9ihpX2q71TmwnESoGTgWtiJ5WV2GLWUZrV3qlNBWKlwLHATZFzEiGmmPWUZpV3bCIQq054FHx7xHxEiSVm/YaUjQVijQOHAb+PlEtHiCFmw4aUdwvEqhHmfN0fIY+O0m0xGynF896xoUCsMcLsyAe7nENX6KaYTZXiOe/ZQCDWGGEV18NdbH9X6ZaYzRpS1hOINQLsDTzepbZHoRtiNkexwnveJRDrLWBPwhqVvqbTD8reg+I5ZKS8CezGAEiBzorZGsWzeNYViPU6sAvwTFd6JQd0Ssx8FE/jWSdzJMVrBCkru9kxsenEd8w2KJbjGc4cSfEqnp0Ia+kHCukzZlsUTwhJeQXPDgygFJAV85HGmTIncyTFy3i2B/4WrWciIyVmexR/wjOUOZLiJTwLCEVzBhaJ75gdgIfwlDNHUvyjcfn6V+yOiU3WM2ZX4CEQkfK3xuVr4KVANjF7AH9ARsqLDSn/jt0heaFdMXsD9wKlzC1QrG5I+U/szsgT7YhZSFhmnVmKUqxqfNG/Ebsj8karYg4ilEDPfNPQGG3eHvhv7E7II62IORS4FTBZD6oUz3jPjkRaQ98LNCvmKMLsEwkpTxVSZqcZMccB1zb53hlRmuU+jH3VYieed2br7JMJuwJJSHnMO3YlB2voe4GZOvw0wv5ZmbcZUto/3JBSj51wrzCdmE8SdpqTkLLMO7UHOVuunXemEvMZ4DfISFnqndqLQkrLrC3mC8C5EoGV9vd6p/YlzL4vaJE1xXwVoeVwyvi7vFP7k+Pl2nlnQsw3CQUJMqOMv81bdRCFlExo4DvAjySCKeNv9lYdGjupfkDrxB8vFcxb1da2TwXvRJuKe0KXxK46ZwNfj51UP6DrI+YMU3YXCsr5MfDl2In1OhqgA3J+RlhfX9Amk7fLwnIU4db7zNgJ9ipv+4HZATnnEUoaFrTIO4ZkhOVowvDOKbET7TWmHMQUlmMIFSrEbssHgWmH/Tsg5xLCtukFTTDjA7BJOYmInDKhjEgxMtAEsz6ZrI+YM0xFVM61hNk2BTPQ1CNjYTkVQv38/WInn2eafpbfkLNESM4wYccJqX1e+o6WJlnUR8zpwnJuAaS2FukrWp79IixnXeA2YKfYHZE32pqWJCxnPeAuQGoDhb6g7fliwnLWJ8yJlqrZ3/NkmsjXkHORkJyNCKsIpMrE9zSZZ1jWR8xiQTkbA/cA28TumNiILI6dlGNE5MwjnDnzY3ZMbMSWk9dHzGIz5C5SMnK2IKxY2ypSv0RHtABDfcQsTuTkbEmQI1Ecu+cQryUjLGdrghyJesw9RUeK/NRHzOKk4i4WkjOfcEMgUQK4Z+hYWaz6qDlNUM42BDkSVWd7go4WkmvIuURIzocId2sS1WdzT8e3wqqPmk8IyvkoYfhGorZmrunKHmXCchYwAHK6tnmcsJydCaPS2SsI5pSu7urXkHOpkJzdCXUHshetyyFd326xPmpOFZSzF3AjfSgnyj6YDTmXKS0iZ3/CHILsVaByRLQNSuujZlEyJCbnIPpMTtSdY4XlHApcjkSprhwQfUvf+qhZZOTkHEMoGpG55k1soosBSIOcy4XkHA8socfl5EIMQDpqTjFD7gohOYuAXyNQRCIWuREDkI6akwXlnAGcT4/KyZUYEJdzJvBzelBO7sTAmnJEwn0BoeIS3SSXYqAhp2KvFJLzFeCc2Dm1Qm7FAKRj5iRBOd8AzoqdU7PkWgxMyrlKSM73gO/GzqkZci8GIB0zJ5qKvVpIztmEsyfX9IQYgHTMnGAq7molc391Djmv3tEzYgDSMX2CGRKTk+vqHT0lBiblXCMgJ9fVO3pODEA6po8XlHM+Oaze0ZNiYFLOtUJyLiBn1Tt6VgxAOqaPM0PuOgE5GriYHFXv6GkxAOmYPlZQzuXkpHpHz4uBSTnXCwxVGkLJ/OjVO/pCDEA6po9JKiJyEuAGIlfv6BsxAGlVH5NU3A1Ccm4i7C4Vhb4SA5BW9dFCcsqE2Z5Rqnf0nRiYlHOjkJw7iVC9oy/FAKRVfVRScTcJyBkiLP/YuZvt71sxAGlVHykkZw5wH12s3tHXYmBSzs0CcoaBpXSpekffiwFIq/qIpOJuEZCzDvAgYXVbRxkIMQBpVR8uJGddYBkdrt4xMGIgyDEVd6uAnPVQ/JEOVu8YKDEAtqoPM2V3W2Y5ng1QPEKoRSDOwIkBsDV9qJCcDRtyxKt3DKQYmJRze+ZAno1RPIZw9Y6BFQNga/oQUxGRs0lDzjyptg20GJiUc0fmQJ55DTki1TsGXgyAremPm4q7M3Mgz+YoHkegekchpoGt6YNNxd2VOZBnS6V4mlDns20KMWtga/ogU3G/zxrHezZTmhfIUL2jELMWtqYPFJHj2EhpVtFm9Y5CzBQ05NydNY53bKK0X00bBSIKMdNga/oAU3H3ZI3jndq0HTmFmBmwNb2/Kbt7s8bxTm2mtF9FCwUiCjGzYMf1QlN292WN453aXGn/F5qUU4hpAjuu9zNld3/WON6pLZTxL9BE9Y5CTJPYcb2viByr3qOMX8UsBSIKMS3QkLM0axxv1VazySnEtIgd1/uYsvtD1jjeqvcq41cyTQ2CQkwb2HG9tym7B7LG8VbNn05OIaZN7Ljey5Tdg1njeKs+oI1/lrXkFGIyYMf1nrrkl2WN46zaVif+mTVfK8RkxNXVHiJyUrWdTvzTE38XYgRoyHkoc5xUfVgn/s9QiBHD1dXHdMk/nDmQCptLFGIEcXW1my75R9r9vC75l03ZbQuFGHFcXe2qS/5PrX5uQkp9xLwOhZiO4OpqF13yjzb7/rWlQCGmY7i62rkZOVNJgUJMR2nIeWy6/08nBQoxHcfV1U468cvXfn0mKVCI6QouVTvoxD8x8fdsUiAsmy7oAi5VC3Tin0AxbzYpAP8D16uSvOoyOG4AAAAASUVORK5CYII=" />
</svg>
		 </div> <!-- 이전 버튼 -->
	<div class="swiper-pagination"></div>
	</div>
			<div class="row mb-5" id="card_section">
				<!-- 프로젝트카드  -->
				<!-- cardNum은 마지막 더보기버튼 사라지게 하기 위해 넣은 class -->
				
				<!-- last_flag : forEach문이 project_list의 끝까지 돌았는지 검사해준다. -->
				<!-- last_flage >>  true : project_list 끝까지 반복문 완료. -->
				<c:set var="last_flag" value="false"/>
				
				<!-- list_size : project_list의 크기 -->
				<c:set var="list_size" value="${fn:length(project_list)}"/>
				
				<!-- ## project_list반복문 시작 >> card만들기 시작 ## -->
				<c:forEach var = "project" items="${project_list}" varStatus="status" begin="0" end="5"> 
				
				<!-- if문을 통해 현재 index가 project_list의 끝인지 검사 -->
				<c:if test="${status.count eq list_size}">
					<c:set var="last_flag" value="true"/>
				</c:if>
				
				<!-- 북마크 for each문 break용 -->
				<c:set var="bookmarking" value="false" />
				
				<!-- 프로젝트카트 start -->
				
				<div class="col-12 col-md-6 col-lg-4 mb-5 cardNum">
					<div class="card shadow">
						<!-- 카드헤더: 모집상태,분야,조회수 -->
						<div class="card-header">
							<div class="p_state">${project.p_state} - ${project.field_name}</div>
							<div class="p_views"><i class="fas fa-eye"> ${project.p_views} </i></div>
						</div>
						<!-- 프로젝트이미지 -->
						
						<div class="m_img" >
						   <div class="m_img_top">
						   <!-- 해당 회원이 마킹했던 프로젝트면 표시해주기 -->
						   <se:authorize access="hasAnyRole('ROLE_PREMEMBER','ROLE_MEMBER','ROLE_ADMIN', 'ROLE_TEAMMANGER', 'ROLE_PENALTY')">
							   <c:forEach var = "bookmark" items="${bookmark_list}" varStatus="mark_status">
									<c:if test="${bookmarking eq false}">
										 <c:choose>
											<c:when test="${bookmark.project_id eq project.project_id}">
											  	<i class="fas fa-heart bookmark marking" id="${project.project_id}" onclick='BookMarking(${project.project_id})'></i>
											  	<c:set var="bookmarking" value="true" />
											</c:when>
										  	<c:when test="${mark_status.last}">
											  	<i class="fas fa-heart bookmark no_marking" id="${project.project_id}" onclick='BookMarking(${project.project_id})'></i>
											</c:when> 
										</c:choose>
									</c:if>
							   </c:forEach>
						   </se:authorize>
						   </div>
<<<<<<< HEAD
                           <a href="/project/detail?project_id=${project.project_id}"><img class="m_img_size" src="${pageContext.request.contextPath}/resources/upload/${project.p_image}"></a>
=======
                           <a href="/project/detail?project_id=${project.project_id}"><img class="m_img_size" src="${pageContext.request.contextPath}/images/${project.p_image}"></a>
>>>>>>> master
                        </div>
                        <!-- 프로젝트이름, 주언어 -->
						<div class="card-body">
						<se:authorize access="hasRole('ROLE_PREMEMBER')">
							<h3 class="h5 card-title mt-3 deny_premember">${project.p_title}</h3>
							</se:authorize>
							<se:authorize access="!hasRole('ROLE_PREMEMBER')">
							<a href="/project/detail?project_id=${project.project_id}"><h3 class="h5 card-title mt-3">
							<c:choose>
								<c:when test="${fn:length(project.p_title) >18 }">
									${fn:substring(project.p_title,0,15)} ...
								</c:when>
								<c:when test="${fn:length(project.p_title) <=18 }">
									${project.p_title }
								</c:when>
							</c:choose>
							</h3></a>
						</se:authorize>
							<div class="p_footer">
							<p class="card-text p_skill">
							<c:set var="sk" value=""/>
								<c:forEach var = "pjsk" items="${pjsk_list}" varStatus="status" > 
									<c:if test="${pjsk.project_id eq project.project_id}">
									 <c:set var="sk" value="${sk} #${pjsk.skill_name}"/>
									</c:if>
								</c:forEach>
								<c:choose>
									<c:when test="${fn:length(sk)>25}">
										${fn:substring(sk,0,23)} ...
									</c:when>
									<c:when test="${fn:length(sk)<=25}">
										${sk }
									</c:when>
									
								</c:choose>
								</p>
								<p class="card-text p_team_memNum">모집인원: 
								<c:forEach var = "membercount" items="${membercount_list}" varStatus="status" > 
									<c:if test="${membercount.project_id eq project.project_id}">
										${membercount.m_count} / ${membercount.total_count}
									</c:if>
								</c:forEach> 
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- 프로젝트카드end -->
				</c:forEach>


		</div>
		<div class="zerocontainer">
			<div class="row " >
			<div class="col-md-8 zerowrapper">
			<blockquote class="blockquote text-center shadow" id=zerolist>
				<p>원하시는 프로젝트를 찾을수 없네요...😥</p>
			</blockquote>
			</div>
			</div>
		</div>
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
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
<script type="text/javascript">
/* projectList.js에서 필요한 데이터들을 미리 선언 */
 	var membercount_list = ${membercount_list};
 	var pjsk_list = ${pjsk_list};
 	var project_list = ${project_list};
 	
 	<se:authorize access="hasAnyRole('ROLE_PREMEMBER','ROLE_MEMBER','ROLE_ADMIN', 'ROLE_TEAMMANGER', 'ROLE_PENALTY')">
 		var bookmark_list = ${bookmark_list};
 		var loginuser = '${sessionScope.nickname}';
 	</se:authorize>
 	
 	<se:authorize access="!hasAnyRole('ROLE_PREMEMBER','ROLE_MEMBER','ROLE_ADMIN', 'ROLE_TEAMMANGER', 'ROLE_PENALTY')">
 		var loginuser = null;
 	</se:authorize>
 
</script>
<script type="text/javascript" src="/assets/js/projectList.js?ver=2"></script>
</html>