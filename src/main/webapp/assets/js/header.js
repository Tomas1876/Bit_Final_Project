
// 비동기로 종모양 바꾸기
function changeBell_New() {

	$(".alarmbell").attr("src", "/assets/img/brand/NEWALARM.svg")

}

function changeBell_Old() {

	$(".alarmbell").attr("src", "/assets/img/brand/ALARM.svg")

}

//페이지 이동할 때마다 알림 종모양 유지하기
function chekcBell(id) {
	console.log(id)

	$.ajax({

		url: "/alarm/checkbell",
		type: "post",
		data: { id: id },
		dataType: "text",
		success: function(res) {
			console.log(res)

			if (res == "true") {

				changeBell_New()

			} else {

				changeBell_Old()

			}

		},
		error: function(xhr) {
			console.log(xhr)
		}

	});

}

//알림 리스트 비동기로 바꿔주기
function updatealarmlist(id) {

	return new Promise(function(resolve, reject) {

		$.ajax({
			url: "/alarm/updatealarmlist",
			type: "post",
			data: { id: id },
			dataType: "json",
			success: function(res) {
				console.log(res)

				$("#alarmsub").empty();

				if (res.length != 0) {

					$.each(res, function(index, data) {

						// 프로젝트에 초대됨
						if (data.alarm_CODE == "PR_IN") {
							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/project/detail?project_id=" + data.url + "'><p id='" + data.alarm_ID + "' class='alarm_content'>프로젝트에 초대되었습니다</p></a></li>"

							);

							// 내 프로젝트에 누가 지원함
						} else if (data.alarm_CODE == "PR_A") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/member/memberdetailpage?memberid=" + data.url + "'><p id='" + data.alarm_ID + "' class='alarm_content'>내 프로젝트에 지원자가 있습니다</p></a></li>"

							);

							// 내가 지원 내역이 승인됨
						} else if (data.alarm_CODE == "PR_S") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/project/detail?project_id=" + data.url + "'><p id='" + data.alarm_ID + "' class='alarm_content'>내 지원내역이 승인되었습니다</p></a></li>"

							);

							// 내 지원 내역이 거절됨
						} else if (data.alarm_CODE == "PR_F") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/project/detail?project_id=" + data.url + "'><p id='" + data.alarm_ID + "' class='alarm_content'>내 지원내역이 거절되었습니다</p></a></li>"

							);

							// 내가 지원/참여한 프로젝트의 상태가 변경됨(모집/진행/종료)
						} else if (data.alarm_CODE == "PR_UP") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/project/detail?project_id=" + data.url + "'><p id='" + data.alarm_ID + "' class='alarm_content'>내 프로젝트의 상태가 바뀌었습니다</p></a></li>"

							);

							// 누군가 나에게 후기를남김
						} else if (data.alarm_CODE == "MY_RV") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/member/memberdetailpage?memberid=" + data.url + "'><p id='" + data.alarm_ID + "' class='alarm_content'>후기가 작성됐습니다</p></a></li>"
								//"<li class='header_alarm'><a href='#'><p id='" + data.alarm_ID + "' class='alarm_content'>후기가 작성됐습니다</p></a></li>"
							);

						} else if (data.alarm_CODE == "CHAT_O") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/messages/'><p id='" + data.alarm_ID + "' class='alarm_content'>새로운 쪽지가 도착했습니다</p></a></li>"
								//"<li class='header_alarm'><p id='" + data.alarm_ID + "' class='alarm_content'>새로운 쪽지가 도착했습니다</p></li>"
							);

						} else if (data.alarm_CODE == "PM_BAN") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/mypage/myProject'><p id='" + data.alarm_ID + "' class='alarm_content'>프로젝트의 팀장이 변경되었습니다</p></a></li>"

							);

						} else if (data.alarm_CODE == "PR_EX") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/project/detail?project_id=" + data.url + "' class='alarm_content'>프로젝트에서 추방당했습니다</p></a></li>"

							);

						} else if (data.alarm_CODE == "TM_CH") {

							$("#alarmsub").append(

								"<li class='header_alarm'><a href='/project/detail?project_id=" + data.url + "' class='alarm_content'>프로젝트의 팀장이 되셨습니다</p></a></li>"

							);

						}
						
					});

				} else {

					$("#alarmsub").append(
						"<li><p class='none_alarm_content'>새 알림이 없습니다</p></li>"
					);
				}

				$("#alarmsub").append(

					"<li class='last'><a href='/mypage/myalarm'><p class='none_alarm_content'>알림 더보기</p></a></li>"

				);

				resolve(res);
			},
			error: function(xhr) {
				console.log(xhr)
			}
		});

	})

}


