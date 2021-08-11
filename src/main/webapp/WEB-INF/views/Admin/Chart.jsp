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
<c:set var="mcount" value="${mcount}"/>
<c:set var="pcount" value="${pcount}"/>
<c:set var="PscountList" value="${PscountList}"/>
<c:set var="PpcountList" value="${PpcountList}"/>
<c:set var="PfcountList" value="${PfcountList}"/>
<c:set var="MscountList" value="${MscountList}"/>
<c:set var="MpcountList" value="${MpcountList}"/>
<c:set var="stateList" value="${stateList}"/>
				<!-- Chart.js -->
<script type="text/javascript"></script>
</head>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<link type="text/css"
	href="/css/adminChart.css"
	rel="stylesheet">

<body>

	<main>
		<div class="section">
			<div class="container card">
				<div class="mpcount mt-6 mb-5" >
					<div class="card pcount">
						<div class="card-body">
							<p>지금까지 생성된 프로젝트 수</p>
							<div class="pcountdiv"></div>
						</div>
					</div>
					<div class="card mcount ">
						<div class="card-body ">
							<p>활동중인 회원 수</p>
							<div class="mcountdiv"></div>
						</div>
					</div>
				</div>
				<div class=barchartWrap>
					<div class="bar mx-sm-5">
						<div class="card-body"><canvas id="SkillChart"></canvas></div>
					</div>
					
					<div class="bar mx-sm-5">
						<div class="card-body"><canvas id="PositionChart"></canvas></div>
					</div>
					
					<div class="bar mx-sm-5">
						<div class="card-body"><canvas id="FieldChart"></canvas></div>
					</div>
					<div class="pie">
						<div class="card-body"><canvas id="StateChart"></canvas></div>
					</div>
				</div>
				
				
				

				
			</div>
		</div>
	</main>

</body>

<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp"></jsp:include>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
var mcount= ${mcount};
var pcount= ${pcount};
const Slabels=[];
const PScountdata=[];
const MScountdata=[];

const Plabels=[];
const PPcountdata=[];
const MPcountdata=[];

const Flabels=[];
const PFcountdata=[];
const MFcountdata=[];

const STlabels=[];
const STcountdata=[];


//스킬
<c:forEach var="p" items="${PscountList }">
	Slabels.unshift("${p.name}");
	PScountdata.unshift("${p.count}")
</c:forEach>
<c:forEach var="m" items="${MscountList }">
	MScountdata.unshift("${m.count}")
</c:forEach>
//포지션
<c:forEach var="p" items="${PpcountList }">
	Plabels.unshift("${p.name}");
	PPcountdata.unshift("${p.count}")
</c:forEach>
<c:forEach var="m" items="${MpcountList }">
	MPcountdata.unshift("${m.count}")
</c:forEach>
//필드
<c:forEach var="p" items="${PfcountList }">
	Flabels.unshift("${p.name}");
	PFcountdata.unshift("${p.count}");
</c:forEach>

//상태
<c:forEach var="st" items="${stateList }">
	STlabels.unshift("${st.p_state}");
	STcountdata.unshift("${st.count}");
</c:forEach>


const Sdata = {
  labels: Slabels,
  datasets: [
	    {
      label: '프로젝트',
      data: PScountdata,
      borderColor: '#CA8FAB',
      backgroundColor: '#CA8FAB',
		type:'bar',
		 yAxisID: 'y1'
    },
    {
      label: '회원',
      data: MScountdata,
      borderColor: '#c28aeede',
      backgroundColor: '#c28aeede',
      type: 'bar',
 		yAxisID: 'y'
    }

  ]
};

const Pdata = {
  labels: Plabels,
  datasets: [
	    {
      label: '프로젝트',
      data: PPcountdata,
      borderColor: '#CA8FAB',
      backgroundColor: '#CA8FAB',
		type:'bar',
		 yAxisID: 'y1'
    },
    {
      label: '회원',
      data: MPcountdata,
      borderColor: '#c28aee',
      backgroundColor: '#c28aeede',
      type: 'bar',
 		yAxisID: 'y'
    }

  ]
};
		
const Fdata = {
		  labels: Flabels,
		  datasets: [
			    {
		      label: '프로젝트',
		      data: PFcountdata,
		      borderColor: '#CA8FAB',
		      backgroundColor: '#CA8FAB',
				type:'bar',
				 yAxisID: 'y1'
		    }

		  ]
		};
const Statedata = {
		  labels: STlabels,
		  datasets: [
		    {
		      label: '상태별 프로젝트 수',
		      data: STcountdata,
		      backgroundColor: ['#ffb0b2', '#3eaf3a8a', '#0d6efd66'],
		    }
		  ]
		};
</script>
<script type="text/javascript" src="/assets/js/adminChart.js"></script>
</html>