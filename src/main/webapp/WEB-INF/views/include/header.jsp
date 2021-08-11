<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">



<!-- Primary Meta Tags -->
<title>사이좋게 코딩하자</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 반응형 토글 -->
<script
	src="${pageContext.request.contextPath}/vendor/bootstrap/dist/js/bootstrap.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<!-- Fontawesome -->
<link type="text/css"
	href="${pageContext.request.contextPath}/vendor/@fortawesome/fontawesome-free/css/all.min.css"
	rel="stylesheet">

<!-- Pixel CSS -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/pixel.css"
	rel="stylesheet">
<!-- main CSS -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">

<!-- favicon -->
<link type="image/x-icon"
	href="${pageContext.request.contextPath}/assets/img/favicon/cycoding-favicon.ico"
	rel="icon">

</head>
<!-- 반응형 토글 -->
<script
	src="${pageContext.request.contextPath}/vendor/bootstrap/dist/js/bootstrap.min.js"></script>

<!-- JQuesy -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


<link type="text/css"
	href="${pageContext.request.contextPath}/css/pixel.css"
	rel="stylesheet">
<!-- main CSS -->
<link type="text/css"
	href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 스프링 시큐리티 설정 -->
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<body>
	<header class="header-global">
		<div class="header_">
			<nav id="navbar-main" aria-label="Primary navigation"
				class="navbar navbar-main navbar-expand-lg navbar-theme-primary headroom navbar-dark">
				<div class="container position-relaive">
					<a class="navbar-brand me-lg-5"
						href="${pageContext.request.contextPath}/main"> <img
						class="navbar-brand-dark"
						src="${pageContext.request.contextPath}/assets/img/brand/LOGO.svg"
						alt="Logo light">
					</a>
					<div class="navbar-collapse collapse me-auto" id="navbar_global">

						<div class="navbar-collapse-header">
							<div class="row">
								<div class="col-6 collapse-brand">
									<a href="/main"> <img
										src="${pageContext.request.contextPath}/assets/img/brand/LOGO.svg"
										alt="Themesberg logo">
									</a>
								</div>
								<div class="col-6 collapse-close">
									<a href="#navbar_global" class="fas fa-times" id="HeaderCancle"
										data-bs-toggle="collapse" data-bs-target="#navbar_global"
										aria-controls="navbar_global" aria-expanded="false"
										title="close" aria-label="Toggle navigation"></a>
								</div>
							</div>
						</div>


						<!-- Header Left -->
						<ul class="navbar-nav navbar-nav-hover align-items-lg-center">

							<li class="nav-item dropdown"><a
								href="${pageContext.request.contextPath}/main" class="nav-link">
									HOME </a></li>

							<li class="nav-item dropdown"><a
								href="${pageContext.request.contextPath}/project/list"
								class="nav-link"> PROJECT </a></li>


							<li class="nav-item dropdown"><a
								href="${pageContext.request.contextPath}/member/list"
								class="nav-link"> MEMBER </a></li>

							<li class="nav-item dropdown"><a
								href="${pageContext.request.contextPath}/board/list"
								class="nav-link"> COMMUNITY </a></li>
						</ul>

						<!-- Header Right -->
						<div class="right_nav">
							<ul
								class="navbar-nav navbar-nav-hover align-items-lg-center plex_right" id="MenuToggle">

								<!-- 로그인 안하면 -->
								<se:authorize
									access="!hasAnyRole('ROLE_PREMEMBER','ROLE_MEMBER','ROLE_ADMIN', 'ROLE_TEAMMANGER', 'ROLE_PENALTY', 'ROLE_BAN')">
									<li class="nav-item dropdown"><a
										href="${pageContext.request.contextPath}/login"
										class="nav-link"> 로그인 </a></li>
								</se:authorize>
								<!-- 영정 회원 -->

								<!-- 어드민  -->
								<se:authorize access="hasRole('ROLE_ADMIN')">

									<li class="nav-item dropdown mydropdow 
										panel-group"
										id="accordion" role="tablist" aria-multiselectable="true">
										<div class="panel panel-default">
											<div class="panel-heading" role="tab">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#my_sub_admin"
													aria-expanded="false">관리자 페이지 <i
													class="fas fa-caret-down"></i></a>
											</div>
											<!-- 1차 메뉴 -->
											<div class="sub panel-collapse collapse" role="tabpanel"
												id="my_sub_admin">
												<ul class="panel-body" id="headerMenu">
													<li><a
														href="${pageContext.request.contextPath}/admin/chart">통계</a></li>
													<li><a
														href="${pageContext.request.contextPath}/admin/member">회원관리</a></li>
													<li><a
														href="${pageContext.request.contextPath}/admin/site">사이트관리</a></li>
													<li><a
														href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
												</ul>
											</div>
										</div>
									</li>
								</se:authorize>

								<!-- 기본 회원들 헤더 -->
								<se:authentication property="name" var="LoginUser" />

								<se:authorize
									access="hasAnyRole('ROLE_MEMBER','ROLE_PREMEMBER','ROLE_TEAMMANGER','ROLE_PENALTY','ROLE_BAN')">

									<!-- 로그인 id에 스타일 줬는데 id가 안 잡혀서 인라인으로 스타일 줌-->
									<li class="nav-item dropdown panel-group" id="accordion"
										role="tablist" aria-multiselectable="true" id="alarmbell_li"
										style="margin-right: 30px;">
										<div class="panel panel-default" id="alarm_panel">
											<div class="panel-heading" role="tab">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#a_sub"
													aria-expanded="false"><img class="alarmbell"
													src="${pageContext.request.contextPath}/assets/img/brand/ALARM.svg"></a>
													<!-- <div id="alarmdiv">새 알림이 도착했습니다</div> -->
													
											</div>
											<!-- 1차 메뉴 알림 -->
											<div class="sub panel-collapse collapse" role="tabpanel"
												id="a_sub">
												<ul class="panel-body" id="headerMenu">
													<li><a
														href="${pageContext.request.contextPath}/messages/">내
															쪽지</a></li>

													<li class="subdrop"><a role="button"
														data-toggle="collapse" data-parent="#accordion"
														href="#a_sub_down" aria-expanded="false">알림
														</a>
														<div id="a_sub_down" class="panel-collapse collapse"
															role="tabpanel">
															<ul class="susub panel-body" id="alarmsub">

															</ul>
														</div></li>
												</ul>
											</div>
										</div>
									</li>

									<!-- 1차 메뉴 개인-->
									<!-- 그룹 태그로 role과 aria-multiselectable를 설정한다. -->
									<li class="panel-group" id="accordion" role="tablist"
										aria-multiselectable="true">
										<!-- 하나의 item입니다. data-parent 설청과 href 설정만 제대로 하면 문제없이 작동합니다. -->
										<div class="panel panel-default" id="member_panel">
											<div class="panel-heading" role="tab">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#my_sub_member"
													aria-expanded="false"> ${sessionScope.nickname}님 <i
													class="fas fa-caret-down"></i>
												</a>
											</div>
											<div class="panel-collapse collapse sub" id="my_sub_member" role="tabpanel">
												<ul class="panel-body" id="headerMenu">
													<li><a
														href="${pageContext.request.contextPath}/mypage/mypageCheck">마이페이지</a></li>
													<li><a
														href="${pageContext.request.contextPath}/mypage/wishProject">북마크/지원내역</a></li>

													<li class="subdrop"><a role="button"
														data-toggle="collapse" data-parent="#accordion"
														href="#p_coll_sub" aria-expanded="false">프로젝트</a> <se:authorize
															access="hasAnyRole('ROLE_MEMBER', 'ROLE_TEAMMANGER', 'ROLE_PENALTY')">
															<input type="hidden" id="ismember" value="1" />
														</se:authorize> <se:authorize access="hasRole('ROLE_PREMEMBER')">
															<input type="hidden" id="ismember" value="0" />
														</se:authorize>
														<div id="p_coll_sub" class="panel-collapse collapse"
															role="tabpanel">
															<ul class="susub panel-body" id="project_sub">
																<!-- 현재 참여중인 프로젝트 있는지 확인 -->

															</ul>
														</div></li>

													<li><a
														href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
												</ul>
											</div>
										</div>
									</li>
									<!-- 이 빈 li가 있어야 마이페이지 메뉴 위치를 잡을 수 있음 -->
									<li></li>
								</se:authorize>
								<!-- 영정회원 -->
								<se:authorize access="hasRole('ROLE_BAN')">
									<input type="hidden" id="getout" value="1">
								</se:authorize>
								<se:authorize access="!hasRole('ROLE_BAN')">
									<input type="hidden" id="getout" value="0">
								</se:authorize>
							</ul>
						</div>
					</div>
					<button class="navbar-toggler ms-2" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbar_global"
						aria-controls="navbar_global" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
				</div>
			</nav>
		</div>
	</header>

	<main>

		<!-- LOADER -->
		<div id="preloader">
			<div class="loader-container">
				<div class="progress-br float shadow">
					<div class="progress__item"></div>

				</div>
			</div>
			<!-- END LOADER -->

			<!-- 새 메시지 알림 창 -->
			<div id="new_note_modal" class="modal fade">
				<div class="modal-dialog modal-login">
					<div class="modal-content">
						<div class="modal-header">
							<p id="modal-title">새 쪽지가 도착했습니다</p>
						</div>
						<div id="modal-body">

							<div class="alert_messagearea">
								<!-- <div class="msg_content"></div> -->
							</div>
							<div class="msg_buttonarea">

								<a href="#new_note_modal" class="trigger-btn"
									data-toggle="modal">
									<button class="msg_btn" id="msg_btn">닫기</button>
								</a>
							</div>

						</div>
					</div>
				</div>
			</div>
		
	</main>
<div id="alarmdiv">새 알림이 도착했습니다</div>
	<!-- 반응형 토글 -->
	<script
		src="${pageContext.request.contextPath}/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendor/headroom.js/dist/headroom.min.js"></script>

	<!-- Pixel JS -->
	<script src="${pageContext.request.contextPath}/assets/js/pixel.js"></script>

	<script
		src="${pageContext.request.contextPath}/vendor/vivus/dist/vivus.min.js"></script>

	<!-- sweetalert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<!-- 	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script> -->
	<!-- header.js -->
	<script
		src="${pageContext.request.contextPath}/assets/js/header.js?ver=2"></script>
	<script type="text/javascript">	
/* ==============================================
Loader -->
=============================================== */
$(function() {
    $("#preloader").on(500).fadeOut();
    $(".preloader").on(600).fadeOut("slow");
	$('.loader-container').addClass('done');
	$('.progress-br').addClass('done');	 
});
/* ==============================================
Loader -->
=============================================== */

var hideMenu;
var thisShow;
var checkLi;

$('#MenuToggle > li > div').click(function(){

	if($(this).attr("id") == "alarm_panel"){
		if(hideMenu < 0 && checkLi != "alarm_panel"){
			$(thisShow).removeClass('show');
		}
		
		var attr = $(this).children()[1];
		hideMenu = $(attr).attr("class").indexOf('show');
		thisShow = $(attr);
		checkLi = $(this).attr("id");
		
	}else if($(this).attr("id") == "member_panel"){
		if(hideMenu < 0 && checkLi != "member_panel"){
			$(thisShow).removeClass('show');
		}
		
		var attr = $(this).children()[1];
		hideMenu = $(attr).attr("class").indexOf('show');
		thisShow = $(attr);
		checkLi = $(this).attr("id");
		
	}
	
})


// 회원 정보
$('#info').click(function() {
	var toggle = $('.user_info').attr('style');
	var Alramtoggle = $('.Alram_box').attr('style');
	
	if(toggle == "display:none"){
		$('.user_info').attr('style','');
		if(Alramtoggle == ""){
			$('.Alram_box').attr('style','display:none');
		}
	}else {
		$('.user_info').attr('style','display:none');
		
	}
})


$('#alram').click(function() {
	var toggle = $('.Alram_box').attr('style');
	var infotoggle = $('.user_info').attr('style');
	
	if(toggle == "display:none"){
		$('.Alram_box').attr('style','');
		if(infotoggle == ""){
			$('.user_info').attr('style','display:none');
		}
	}else {
		$('.Alram_box').attr('style','display:none');
	}
})
	//웹소켓
	var ws;
	var logineduser = "${sessionScope.member_id}";
	var loginednickname = "${sessionScope.nickname}"
	var wsurl = "ws://localhost:8090/websocket/${sessionScope.member_id}"	
	
	
	function openSocket() {
	//var ws = new WebSocket("wss://localhost:8090/alarm/{code, sender, receiver}");
	ws = new WebSocket(wsurl);
	console.log("웹소켓 파라미터로 넘기는 회원번호 ",${sessionScope.member_id});
	let logineduser = "${sessionScope.member_id}";
	function open(){
		//서버와 연결할 때 호출됨
		ws.onopen = function(event) {
			if (event.data === undefined) {
				return;
			}	
		};
	}
	
	ws.onmessage = function(event) {
		
		let data = event.data;
		console.log("서버에서 받은 메시지 ",JSON.parse(data));
		updatealarmlist(logineduser).then(function(){
			
			//종 바꾸기
			changeBell_New();

			//알림 왔다고 띄워주기
			 $( '#alarmdiv' ).fadeIn( 2000, function() {
				$( '#alarmdiv' ).fadeOut(2000, function() {});
          		
        	});

			
			//알림페이지에 알림 하나 추가하는 함수
			addNewAlarm(JSON.parse(data));
			
		});	
		
	
	}		
	 	ws.onclose = function(event){
		    console.log("연결 해제");
		    
		    openSocket();
	}
}
	
	//insertAlarm 파라미터로 받을 기본 data 형식
	/* var data = {
			code: "PR_IN",
			url: res.project_id,
			//기타 추가 정보
			member_id: 받는 사람,
			sender: logineduser,
			content: 알림 띄울 내용
		} */
		//알림 보내기(트랜잭션)
		function insertAlarm(data){
			return new Promise(function(resolve, reject) {
			//서버로 알림 보내기(웹소켓)
			ws.send(data);
			resolve(data);
			});
			
		}
	
	//알림 보내고 알림 테이블에 인서트(다른 동작과 트랜잭션X)
	//프로젝트 초대, 상태 변경
	function makeAlarm(data){
		
		return new Promise(function(resolve, reject) {
		
			$.ajax({
			
			url:"/alarm/makealarm",
			type:"post",
			dataType:"json",
			data:data,
			dataType:"text",
			contentType: "application/json; charset=utf-8;",
			success:function(res){
				console.log(res)
				//서버로 알림 보내기(웹소켓)
				console.log(data);
				ws.send(data);
				
			},
			error:function(xhr){
				console.log(xhr)
			}			
		});
			
			resolve(data);
		});
		
	}
	
//////////////////////////////////////////
	$(document).ready(function(){
		
		
		if(logineduser != ""){
			
			openSocket();
			chekcBell(logineduser);
			updatealarmlist(logineduser);
			
		}

		
/* 		//드롭다운 메뉴
		$("#my_sub").hide();
		$("#my_dropdown").click(function(){
			
			$(this).find("#my_sub").slideDown();
			$(this).parent().click(function(){
			}, function(){
				let _this = $(this)
				setTimeout(function(){_this.find("#my_sub").slideUp(600)},3000)
			});
			
		});
				
		
		//알림 드롭다운
		$("#a_sub").hide();
		$("#alarmbell_li").click(function(){
			
			$(this).find("#a_sub").slideDown();
			$(this).parent().click(function(){
			}, function(){
				let _this = $(this)
				setTimeout(function(){_this.find("#a_sub").slideUp(600)},3000)
				//_this.find("#a_sub").slideUp(600)
			});
			
		});
		
		//서브메뉴 다운
 		$(".susub").hide();
		$(".subdrop").click(function(){
			
			$(this).find(".susub").slideDown();
			$(this).click(function(){
			}, function(){
				 let _this = $(this)
				setTimeout(function(){_this.find(".sub").slideUp(600)},3000)
			})
		});
		 */
		//헤더에 있는 새 알림 클릭해서 이동하면 상태 확인으로 업데이트 하기
		$(document).on("click", ".alarm_content", function() {
		//$(".alarm_content").on("click",function(){
			var id=  $(this).attr("id");
			console.log(id, " 이벤트");
			$.ajax({
				url: "/alarm/checkalarm",
				data: { alarm_id:id},
				dataType: "text",
				type: "post",
				success: function(res) {
					console.log("헤더 알림 리스트에서 상태 업데이트 ", res);
				},
				error: function(xhr) {
					console.log(xhr);
				}
			});
			
			
		});
				
			$("main").off('click');
		
	//ROLE_MEMBER이거나 TEAMMANAGER일 경우 프로젝트 참여 여부 페이지 이동시마다 반영되게 처리
	if($("#ismember").val() == '1'){
		
		$.ajax({
			
			url:"/mypage/ajax/checkhasproject",
			data:{id : logineduser},
			dataType:"text",
			success:function(res){

				$("#project_sub").empty();
				
				if(res == "none"){
					$("#project_sub").append(
							'<li id="myproject_title"><a href="/project/create">프로젝트 생성하기</a></li>'
							+'<li><a href="/mypage/myProject">나의 프로젝트/후기</a></li>');
					
				} else{
					$("#project_sub").append(
							'<li id="myproject_title"><a href="/project/detail?project_id='+res+'">진행중 프로젝트</a></li>'
							+'<li><a href="/mypage/myProject">나의 프로젝트/후기</a></li>');
				}
				
			},
			error:function(xhr){
				console.log(xhr)
				
			}
		});
	}	
	
	//추가 정보 미입력 회원이 프로젝트 상세나 회원상세 누르면 경고창 띄우고 마이페이지로 보내기
	$(".deny_premember").on("click", function() {

		swal({
			title: "PLEASE FILL YOUR PROFILE",
			text: "추가정보를 입력하셔야 상세보기가 가능합니다",
			icon: "info",
			buttons: true,
			dangerMode: true,
		})
			.then((willDelete) => {
				if (willDelete) {

					location.href="/mypage/mypageCheck";
					
				} else {
					return false;
				}
			});

	})
		
	});
///////////////////////////////////////////
</script>

</body>
</html>