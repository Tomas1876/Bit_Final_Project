/* 리뷰 작성용 카드 */
let reviewCard;
/* 리뷰 작성 모달 테이블 */
var reviewWriteTable = $('.reviewWriteTable');
/* 리뷰 조회 모달 테이블 */
var myReviewTable = $('.myReviewTable');



/* 페이지 모두 로딩 후 실행 */
$(document).ready(function() {

	/* 별점 클릭시 인풋태그에 넣기 */
	$(".m_sel").change(function() {
		console.log('셀렉트')
	})

	/* 리뷰 작성 모달 */
	$(".reviewWrite").on("click", function() {

		var projectid = $(this).attr('id');
		console.log("프로젝트아이디" + projectid);


		$.ajax({
			url: "ajax/writeReviewMember?projectid=" + projectid,
			type: "get",
			dataType: "text",
			success: function(data) {
				console.log("팀원목록" + data);

				memberList = JSON.parse(data);

				reviewWriteTable.empty();

				/* 혼자 프로젝트를 진행한 경우 모달 띄워주기 위한 변수 */
				var soloProject = true;

				/*for(let i = 0; i < memberList.length; i++) {*/
				$.each(memberList, function(index, member) {
					if (member.position_name == '팀장' && member.member_nickname != 'dummy') {

						soloProject = false;

						reviewCard = "	<tr>	"
						reviewCard += "	<input type='hidden' class='teammember' name='review_member' value='" + member.teamleader + "'>	"
						reviewCard += "	<input type='hidden' name='project_id' value='" + member.project_id + "'>	"
						reviewCard += "	<td>" + member.member_nickname + "</td>	"
						reviewCard += "	<td>팀장 <i class='fas fa-crown leaderIcon'></i></td>	"
						reviewCard += "	<td><input type='text' name='review_content' maxlength='49' class='writeReviewContent form-control'></td>	"
						reviewCard += "	<td><div class='star-input'>	"
						reviewCard += "	<select class='starSelectBox' name='review_grade'>	"
						reviewCard += "	<option value=''> </option>	"
						reviewCard += "	<option value='1'>★</option>	"
						reviewCard += "	<option value='2'>★★</option>	"
						reviewCard += "	<option value='3'>★★★</option>	"
						reviewCard += "	<option value='4'>★★★★</option>	"
						reviewCard += "	<option value='5'>★★★★★</option>	"
						reviewCard += "	</select>	"
						reviewCard += "	</div>	"
						reviewCard += "	</td>	"
						reviewCard += "	</tr>	"

						reviewWriteTable.append(reviewCard);
					}

				})

				$.each(memberList, function(index, member) {
					if (member.position_name != '팀장') {

						soloProject = false;

						reviewCard = "	<tr>	"
						reviewCard += "	<input type='hidden' class='teammember' name='review_member' value='" + member.teammember + "'>	"
						reviewCard += "	<input type='hidden' name='project_id' value='" + member.project_id + "'>	"
						reviewCard += "	<td>" + member.member_nickname + "</td>	"
						reviewCard += "	<td>" + member.position_name + "</td>	"
						reviewCard += "	<td><input type='text' name='review_content' maxlength='49' class='writeReviewContent form-control'></td>	"
						reviewCard += "	<td><div class='star-input'>	"
						reviewCard += "	<select class='starSelectBox' name='review_grade'>	"
						reviewCard += "	<option value=''> </option>	"
						reviewCard += "	<option value='1'>★</option>	"
						reviewCard += "	<option value='2'>★★</option>	"
						reviewCard += "	<option value='3'>★★★</option>	"
						reviewCard += "	<option value='4'>★★★★</option>	"
						reviewCard += "	<option value='5'>★★★★★</option>	"
						reviewCard += "	</select>	"
						reviewCard += "	</div>	"
						reviewCard += "	</td>	"
						reviewCard += "	</tr>	"

						reviewWriteTable.append(reviewCard);
					}
				})

				if (soloProject == true) {
					swal("리뷰를 작성할 멤버가 없습니다.", "해당 프로젝트는 멤버가 없이 진행된 프로젝트입니다.", "warning");
				}
			},
			error: function(xhr) {
				console.log(xhr);
			}
	
		});

	})


	/*별점 : .star-input*/
	/*출처 : http://codepen.io/naradesign/pen/zxPbOw*/
	var starRating = function() {
		var $star = $(".star-input"),
			$result = $star.find("output>b");

		$(document)
			.on("focusin", ".star-input>.input",
				function() {
					$(this).addClass("focus");
				})

			.on("focusout", ".star-input>.input", function() {
				var $this = $(this);
				setTimeout(function() {
					if ($this.find(":focus").length === 0) {
						$this.removeClass("focus");
					}
				}, 100);
			})

			.on("change", ".star-input :radio", function() {
				$result.text($(this).next().text());

				var grade_code = $('.star-input>.input').find(":checked").val()

				$('.gradesubmit').val($('.star-input>.input').find(":checked").val());
			})
			.on("mouseover", ".star-input label", function() {
				$result.text($(this).text());
			})
			.on("mouseleave", ".star-input>.input", function() {
				var $checked = $star.find(":checked");
				if ($checked.length === 0) {
					$result.text("0");
				} else {
					$result.text($checked.next().text());
				}
			});
	};

	starRating();

	/* 리뷰 작성 버튼 클릭 */

	/* 모든 리뷰 작성헀는지 확인 후 리뷰 insert */
	$("#write_ok").on("click", function() {
		/* 리뷰 모두 작성해야 다음으로 이동 */
		var contents = document.getElementsByClassName('writeReviewContent');
		for (var i = 0; i < contents.length; i++) {
			console.log(contents[i].value);
			if (contents[i].value == '') {
				swal("모든 멤버의 후기를 작성해주세요! ", "", "warning");
				return;
			}
		};

		var stars = document.getElementsByClassName('starSelectBox');
		for (var i = 0; i < stars.length; i++) {
			console.log(stars[i].value);
			if (stars[i].value == '') {
				swal("모든 멤버의 별점을 입력해주세요!", "", "warning");
				return;
			}
		};
		
		//리뷰 남겼다는 알림 보내기
		var memberlist = [];
		$.each($(".teammember"),function(index, item){			
					memberlist.push($(this).val());				
				});
				console.log(memberlist);
		var alarm = {
			"alarm_CODE": "MY_RV",
			"url": logineduser,
			"members": memberlist,
			"alarm_CONTENT": loginednickname+"님이 회원님께 후기를 남겼습니다"
		}

		console.log(alarm);

		makeAlarm(JSON.stringify(alarm)).then(function() {
			swal("후기가 작성되었습니다", "10point가 지급되었습니다 🎉 잠시만 기다려주세요!", "success", {
			buttons: false,
			timer: 1500,
			});
		});
		

		giveReviewPoint();

		setTimeout(function() {
			$('.writeReview').submit();
		}, 1500);


	});

	//후기작성시 포인트지급
	function giveReviewPoint() {

		$.ajax({

			url: "ajax/giveReviewpoint",
			type: "post",
			success: function(data) {
				console.log("포인트지급완료");
			}

		});

	}

	//로그인한 회원이 해당 프로젝트에 작성한 리뷰 조회 - ajax/myProjectReview
	$(".reviewPrint").on("click", function() {

		var projectid = $(this).attr('id');
		console.log("노출할 프로젝트아이디" + projectid);


		$.ajax({
			url: "ajax/myProjectReview?projectid=" + projectid,
			type: "get",
			dataType: "text",
			success: function(data) {

				reviewList = JSON.parse(data);

				myReviewTable.empty();


				$.each(reviewList, function(index, review) {

					reviewCard = "	<tr>	"
					reviewCard += "	<td>" + review.member_nickname + "</td>	"

					if (review.position_name == null && review.member_nickname !== 'dummy') {
						reviewCard += "	<td>팀장 <i class='fas fa-crown leaderIcon'></i></td>	"
					} else if (review.position_name != null) {
						reviewCard += "	<td>" + review.position_name + "</td>	"
					}

					reviewCard += "	<td>" + review.review_content + "</td>	"

					reviewCard += " <td> "
					for (let i = 1; i <= reviewList[index].review_grade; i++) {
						reviewCard += "	<i class='fas fa-star review-star'></i>	"
					}
					reviewCard += " </td> "
					reviewCard += "	</tr>	"

					myReviewTable.append(reviewCard);

				})




			},
			error: function(xhr) {
				console.log(xhr);
			}

		});

	})


})