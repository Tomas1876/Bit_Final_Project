
var card;
let step=4;
let start=4;

let count;

/**
 *  yyyyMMdd 포맷으로 반환
 */
function getFormatDate(date) {
	var year = date.getFullYear();              //yyyy
	var month = (1 + date.getMonth());          //M
	month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	var day = date.getDate();                   //d
	day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	return year + '.' + month + '.' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

$(document).ready(function() {


    /* 탑버튼 */
   $(function() {
      $(window).scroll(function() {
         if ($(this).scrollTop() > 280) {
            $('#topBtn').fadeIn();
         } else {
            $('#topBtn').fadeOut();
         }
      });
      $("#topBtn").click(function() {
         $('html, body').animate({
            scrollTop: 0
         }, 10);
         return false;
      });
   });
       
       
     /* 더보기버튼 */
     /* 리뷰 리스트 reviewList 
     	current : 뿌려줄 시작 인덱스*/
     function moreBtn(reviewList, current){
         console.log("moreBtn clicked!!");
         console.log(current)
         console.log("reviewList: " + reviewList[0].member_nickname);
         /* 프로젝트 리스트가 존재 할 때만 함수 실행*/
         if(!reviewList.length>0){
             //리스트는 없는데 더보기버튼이 있으면 안되기때문에 none
             $('#moreBtn').css('display', 'none');
             
         }
         else{
             //리스트가 존재한다면 더보기버튼 보여주기.
             $('#moreBtn').css('display', 'inline-block');
             /*
                 reviewList 뿌리기
                 
                 end : 이번 for문의 끝
             */
             for(start=current+step; current<start; current++){
                     
                     console.log(current+": " + reviewList[current]);
                     console.log("이번 엔드포인트 : " + start);
                     
                     console.log("리뷰날짜:" + reviewList[current].review_date);
                    // console.log("리뷰날짜 형식: " + typeof reviewList[current].review_date);
                     
				    card=	"	<div class='col-12 reviews'>	"
					card+=	"	<h5 class='reviewWriter'>"+reviewList[current].member_nickname+"</h5>	"
					card+=	"	<div class='star-rate'>	"
					for(let i = 1; i<=reviewList[current].review_grade; i++) {
						card+=	"	<i class='fas fa-star review-star'></i>	"
					}
					/*card+=	"	<div class='review-date'><fmt:formatDate value='"+reviewList[current].review_date+"' pattern='yy.MM.dd' /></div>	"*/
					//card+=	"	<div class='review-date'>"+getFormatDate(reviewList[current].review_date)+"</div>	"
					
					card+=	"	</div>	"
					card+=	"	<p class='review-content'>"+reviewList[current].review_content+"</p>	"
					card+=	"	</div>	"
		     
		                 /* card_section에 for문을 돌면서 card 추가 */
		                 $('.reviewBox').append(card)
                 
                 /* 
                     리스트의 마지막이라면 현재 index를 start변수에 넣고 
                     더보기버튼 display : none
                 */
                     if(current == reviewList.length-1){
                         console.log("마지막입니다.")
                         console.log("current : " + current);
                         start=current;
                         console.log("start : " + start);
                         $('#moreBtn').css('display', 'none');
                         break;
                     }
                 }
                 }
     }
     /* 더보기버튼 */
     $('#moreBtn').click(function(){
		console.log("더보기..하게해주세여..제발..")
		moreBtn(reviewList, start)
	})

	//프로젝트 초대 모달창 띄우기 전에 로그인 유저가 초대할 프로젝트가 있는지 확인
	$("#invitation").on("click", function() {

		$.ajax({

			url: "ajax/checkprojectbeforeinvite",
			data: { member_id: logineduser },
			dataType: "json",
			type: "post",
			success: function(res) {
				console.log(res)

				if (res.p_title == undefined) {

					$("#contentarea").empty();
					$("#contentarea").append("<p>현재 초대할 수 있는 프로젝트가 없습니다</br>" + "</p>");

					$("#inv_buttonarea").empty();
					$("#inv_buttonarea").append("<a href='/mypage/myProject'><button class='inv_btn' id='create_p'>나의 프로젝트 확인하기</button></a>");

				} else {
					$("#contentarea").empty();
					$("#contentarea").append(
						"<p>" + $("#cycoder p").text() + "님을<br/>" + res.p_title + " 프로젝트에 초대하시겠습니까?</p>");

					$("#inv_buttonarea").empty();
					$("#inv_buttonarea").append(
						'<a href="#invitation_modal" class="trigger-btn" data-toggle="modal">'
						+ '<button class="inv_btn" id="confirm_inv">초대</button></a>');


					//프로젝트 초대 보내기
					$("#confirm_inv").on("click", function() {

						var data = {
							alarm_CODE: "PR_IN",
							url: res.project_id,
							//p_title:res.project_title,
							member_ID: $("#m_id").val(),
							sender: logineduser,
							alarm_CONTENT: loginednickname + "님이 회원님을 " + res.p_title + " 프로젝트에 초대하셨습니다"
						}

						console.log(data);
						//서버로 메시지 보내기
						//ws.send(JSON.stringify(data));
						

						//디비에 반영
						makeAlarm(JSON.stringify(data));
						swal($("#cycoder p").text() + "님을 초대했습니다","","success");

					});
				}
			},
			error: function(xhr) {
				console.log(xhr);
			}

		});

	});

	//div를 textarea처럼 사용
	$('#messagearea').attr('contentEditable', 'true');
	$('#messagearea').on("click",function(){
		$(this).empty();
	})
	//글자수 제한
	$('#messagearea').on('input', function() {
		$('#textcount').html($(this).text().length + " / 100");		

		if ($(this).text().length > 100) {
			$(this).text($(this).val().substring(0, 100));
			swal("쪽지는 100자 이상 쓸 수 없습니다", "", "warning");
			$('#textcount').html("100 / 100");
		}
	});
	

}); //document.ready 끝

//메시지 전송함수
//DB 알람 테이블, 수신, 발신 테이블에 각각 insert 되어야 한다
$(document).on("click","#msg_btn", function() {

	//우선 div의 텍스트를 다루기 용이하도록 input태그의 값으로 만든다
	$("#text").val($("#messagearea").text());
	
	if($("#text").val() == ""){
		swal("보낼 내용을 입력해주세요","","warning");
		
	} else{
		console.log("쪽지 보내기")
		
		var alarm = {
			alarm_CODE: "CHAT_O",
			url: logineduser,
			member_ID: $("#m_id").val(),
			//sender: logineduser,
			alarm_CONTENT: loginednickname + "님이 회원님에게 쪽지를 보냈습니다"
			}
			
			
		var data = {
			alarm,
			note:{
				member_FROM:logineduser,
				member_TO:$("#m_id").val(),
				note_CONTENT:$("#text").val()
			}
		};

		console.log(data);
		//쪽지 테이블에 반영
		console.log("쪽지 테이블에 반영")
		$.ajax({
			url:"/alarm/insertnote",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			contentType: "application/json",
			success:function(res){
				if(res == "true"){
					swal("쪽지를 발송했습니다","","success")
					$("#messagearea").empty();
				} else{
					swal("쪽지 발송하지 못했습니다","잠시 후 시도해주세요","error")
				}
			}
			
		});
		//알림 보내기
		insertAlarm(JSON.stringify(alarm));

	}
	
	
});



