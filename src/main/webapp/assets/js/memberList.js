let card;
let step=8;
let start = 8;
let count;

$(document).ready(function() {
	
   /* 회원카드 공간 */
   var card_section = $('#card_section');

   /* 포지션select */
   $(".m_sel").change(function() {
      //console.log('셀렉트')

      card_section.empty();

      var position = $(".m_sel").val()

      $.ajax({
         url: "memberPosition/" + position,
         type: 'get',
         dataType:"text",
         success: function(filtered_list) {
	
			  memberList = JSON.parse(filtered_list);
             /* 카드모은 div 비우고 moreBtn함수를 이용해 카드 달기 */
              $('#card_section').empty();
              start=0;
              moreBtn(memberList, start);
			 
		}//sucess end

      })

   })
   
   /* 엔터키로 검색 */
   $("#memberNickname").keydown(function(key){
          if (key.keyCode == 13) {// keyCode 13 : Enter키
             $('#memberSearch').click()
         }
     })

   /* 닉네임검색 */
   $("#memberSearch").click(function() {
      //console.log('닉네임검색')

      var memberNickname = $("#memberNickname").val()
      //console.log("검색할닉네임: " + memberNickname);

      if (memberNickname == "") {
         alert('검색어를 입력해주세요 😥')
         return;
      }

      card_section.empty();

      var searchurl = "memberSearch/" + memberNickname;

      $.ajax({
         url: searchurl,
         type: 'get',
         dataType:"text",
         success: function(searchMemberList) {
	
			memberList = JSON.parse(searchMemberList);
            /* 카드모은 div 비우고 moreBtn함수를 이용해 카드 달기 */
            //$('.form-select').val('').prop('selected', true);
            $('#card_section').empty();
            start=0;
            moreBtn(memberList, start);
	
         }//success end

      })

      $("#memberNickname").val('');

   })

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

	
	//더보기 클릭
   $(".moreBtn").click(function() {
     console.log("memberList: " + memberList)
	moreBtn(memberList,start);
   });
   
   
   	//필터링 후 더보기버튼 작동되게 수정완료
   	
    /*더보기버튼 - 카드달아주는 함수 project_list : 프로젝트 리스트   current : 뿌려줄 시작 인덱스*/
     function moreBtn(memberList, current){
         /* 프로젝트 리스트가 존재 할 때만 함수 실행*/
         if(!memberList.length>0){
             //리스트는 없는데 더보기버튼이 있으면 안되기때문에 none
             $('#moreBtn').css('display', 'none');
			 $('.zerocontainer').css('display', 'block');
             
         }
         else{
             //리스트가 존재한다면 더보기버튼 보여주기.
             $('#moreBtn').css('display', 'inline-block');
			 $('.zerocontainer').css('display', 'none');
             /*
                 memberList 뿌리기
                 
                 end : 이번 for문의 끝
             */
             for(start =current+step; current<start; current++){
					console.log("current" + current);
                     console.log(memberList[current].m_nick);
     				 card = '<div class="cardNum">'
					 card += '<div class="card shadow">'
					 card += '<div class="m_img">'
					 card += '<img class="m_img_size"'
<<<<<<< HEAD
					 card += 'src="/resources/upload/' + memberList[current].m_image + '">'
=======
					 card += 'src="${pageContext.request.contextPath}/images/' + memberList[current].m_image + '">'
>>>>>>> master
					 card += '</div>'
					 card += '<div class="card-body">'
					 card += '<h3 class="h5 mt-3 card-title">' + memberList[current].m_nick + '</h3>'
					 card += '<p class="card-text">' + memberList[current].position + '</p>'
					 card += '<p class="tags"># '+ memberList[current].skill +'</p>'
					 if($("#ismember").val() == 0 ){ 
						//premember인 경우 멤버 상세 못 보게 경고
						card += '<a href="#" class="card_link deny_premember">VIEW MORE</a>'
					} else{
						card += '<a href="memberdetailpage?memberid='+memberList[current].m_id+'" class="card_link">VIEW MORE</a>'
					}
					 
					 
					 card += '</div> </div> </div>'
     
                 /* card_section에 for문을 돌면서 card 추가 */
                 $('#card_section').append(card)
                 
                 /* 
                     리스트의 마지막이라면 현재 index를 start변수에 넣고 
                     더보기버튼 display : none
                 */
                     
                     if(current<memberList.length){
                         
                     }
                     if(current == memberList.length-1){
                         start=current;
                         $('#moreBtn').css('display', 'none');
                         break;
                     }
                 }
                 }
     }
     
})