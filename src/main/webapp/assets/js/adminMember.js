/**
 * 
 */
$(function() {
	
	//영정 회원, 정지 회원 필터링, 전헤체회원
$(".m_status").on("click", function() {
	
	var members = $(".members");
	//테이블에 display:block을 썼다간 다 깨진다
	
	//정상 회원 보기
	if($(this).attr("id") == "able"){
		
		$.each(members,function(index, item){
			
			if($(this).find(".isBan").children().hasClass("cancelBan")){
				
				$(this).css("display","none");
				
			} else{
				$(this).css("display","");
			}
			
		})
	
	// 정지 회원 보기	
	}else if($(this).attr("id") == "disable"){
		
		$.each(members,function(index, item){
			
			if(!$(this).find(".isBan").children().hasClass("cancelBan")){
				
				$(this).css("display","none");
				
			} else{
				$(this).css("display","");
			}
			
		})
	//전체 회원 보기	
	} else{
		
		$.each(members,function(index, item){
			
				$(this).css("display","");

		})
		
	}

});

	/*.applyBan인 클래스가 클릭되었을때 : 영구정지 적용*/
	$(document).on("click", ".applyBan", function() {
		console.log("applyBan");
		var m_id = $(this).attr('id');

		swal({
			title: "이 회원을 영구정지 시키시겠습니까?",
			text: "영구정지 시 회원은 재가입이 불가능합니다.",
			icon: "warning",
			dangerMode: true,
			buttons: true,
		})
			.then((willDelete) => {
				if (willDelete) {
					console.log("swal ok");
					/* member_id와 영구정지 상태(enabled)를 보낸다.*/
					var data  = {
						member_id: m_id,
						enabled: "0"
					};
					
					$.ajax({
						url: '/ajaxadmin/member',
						type:  'put',
						contentType: "application/json",
						data:  JSON.stringify(data),
						success: function(result)  {
							console.log(result);
							if ( result.result ==  "true") {
								console.log(result.list);
								//응답이 정상적으로 왔고
								//밴 당한 회웡이 팀장이라 응답으로 리스트가 넘어왔을 경우

								if (result.list != null ) {
									var list=[];
									result.list.forEach(function(item, index){
										console.log(item);
										console.log(item.member_id);
										list.push(item.member_id);
									})
									console.log("팀원이 있는 팀장이 밴 되었다.")
									var alarm = {
										"alarm_CODE": "PM_BAN",
										"url": "0",
										"members": list,
										"alarm_CONTENT": "지원하신 프로젝트의 팀장이 변경되었습니다"
									}

									makeAlarm(JSON.stringify(alarm)).then((value)  => {

									$('#' + m_id).removeClass("applyBan");
									$('#' + m_id).addClass("cancelBan");
									swal("회원이 영구정지 되었습니다.", {
										icon: "success",
									});

								});

							} else  {
								//팀장이 아니라 다른 회원일 경우 알림 없음
								$('#' + m_id).removeClass("applyBan");
								$('#' + m_id).addClass("cancelBan");
								swal("회원이 영구정지 되었습니다.", {
									icon: "success",
								});
							}
			
			
			
						}
						else if  (result.result == "false") {
						swal("오류가 발생했습니다.", {
							icon: "error",
						});
					}
				}
					})
				} 
				else {
					swal("취소되었습니다", "", "info");
				}
			});
	})

/*.cancelBan을 클릭했을때 : 영구정지 해제*/
$(document).on("click", ".cancelBan",   function() {
	console.log("cancleBan");
	var m_id = $(this).attr('id');

	swal({
		title: "이 회원의 영구정지를 해제하시겠습니까?",
		text: "영구정지가 해제되면 다시 로그인이 가능합니다.",
		icon: "warning",
		dangerMode: true,
		buttons: true,
	})
			.then((willDelete) => {
		if (willDelete) {
			var data = {
				member_id: m_id,
				enabled: "1"
			}
			$.ajax({
				url: '/ajaxadmin/member',
				type: 'put',
				contentType: "application/json",
				data: JSON.stringify(data),
				success: function(result) {
					console.log(result);
					if (result.result == "true") {
						$('#' + m_id).removeClass("cancelBan");
						$('#' + m_id).addClass("applyBan");
						swal("영구정지가 해제되었습니다.", {
							icon: "success",
						});
					}
					else if (result.result == "false") {
						swal("오류가 발생했습니다.", {
							icon: "error",
						});
					}
				}
			})
		} else {
			swal("취소하였습니다.");
		}
	});
})

/*검색 - Enter키가 눌렸을때*/
$("#MemberNameSearch").keydown(function(key) {
	if (key.keyCode == 13) {// keyCode 13 : Enter키
		$('#searchIcon').click()
	}
})

/* 검색 아이콘이 눌렸을때 이벤트 */
$('#searchIcon').click(function() {
	//input태그의 값을 변수에 담에주고 search()함수 호출
	let nickname = $('#MemberNameSearch').val();
	search(nickname);
})

/* 검색 함수 실행 */
function search(nickname) {
	$.ajax({
		url: '/ajaxadmin/member',
		type: 'get',
		dataType: "json",
		data: { nickname: nickname },
		success: function(member) {
			$('.apply_table_sec').empty();
			$.each(member, function(index, mem) {

				var status; // enabled를 가져와 영구정지 상태 판단
				if (mem.enabled == 1) {// 1이면 정상회원
					status = "applyBan";
				}						// 아니면 영구정지 회원
				else status = "cancelBan";

				var td = "<tr>"
					+ "<td><i class='fas fa-ban " + status + "' id='" + mem.member_id + "'></i></td>"
					+ "<td><a href='/member/memberdetailpage?memberid=" + mem.member_id + "'>" + mem.member_nickname + "</a></td>"
						+ "<td>" + mem.position_name + "</td>"
						+ "<td>"  + mem.skill_name + "</td>"
							+ "<td>" + mem.count + " 회</td>"
							+ "</tr>"

				$('.apply_table_sec').append(td);
			})

		}
	})
}
})