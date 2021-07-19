if (login_memberid == "") {
   swal("로그인을 하여야 확인 가능합니다.", "", "error").then((willDelete) => {
      location.href = "../login";
   })
}

if (project_id == "") {
   swal("잘못된 접근입니다.", "", "error").then((willDelete) => {
      location.href = "../main";
   })
}

$(document).ready(function() {

   // 모달 숨기기
   $('.Project_Apply_modal').hide();
   $('.Project_Detail_modal').hide();

   if(check == "true"){
      $('.Project_Apply_modal').empty();
          
         var table = "<div class='ProjectApplyMemberListDiv'>";
         table += "<div>";
         table += "<input type='button' class='ApplyMemberListCancleBtn' value='✕'>"
         table += "</div>";
         table += "<p class='FullMemberTitle'>🎉</p>"
         table += "<p class='FullMember_p1'>모집인원이 가득 찼습니다.</p>"
         table += "<div class='FullMember_pBox'>"
         table += "<p class='FullMember_p2'>멤버를 더 늘리거나, </p>"
         table += "<p class='FullMember_p2'>프로젝트를 진행 중 으로 표시해주세요! </p>"
         table += "</div>"
         table += "<div class='ApplyBtn_Box'>"
         table += "<input type='button' value='추가모집하기' class='Withdrawal_Ok'><input type='button' value='진행중 변경하기' class='Withdrawal_No'>"
         table += "</div>"
         table += "<div class='ApplyPbox'>"
         table += "<p class='Apply_p'><b>유의사항</b></p>"   
         table += "<p class='Project_p Apply_p'>- 프로젝트를 진행 중으로 변경시 더는 프로젝트 수정이 불가능합니다.</p>"
         table += "<p class='Project_p Apply_p'>- 프로젝트를 진행 중으로 변경시 더는 멤버모집이 불가능합니다.</p>"   
         table += "</div>";
         table += "</div>";
         
         $('.Project_Apply_modal').append(table);
         $('.Project_Apply_modal').show();
         
         // 추가 모집가기
         $('.Withdrawal_Ok').unbind("click").bind("click", function() {
               $('.Project_Apply_modal').empty();
               $('.Project_Apply_modal').hide();
               $('#memberEdit').trigger('click');   
         })
         
         // 진행중 변경하기
         $('.Withdrawal_No').unbind("click").bind("click", function() {
               $('.Project_Apply_modal').empty();
               $('.Project_Apply_modal').hide();
               location.href = "/project/edit?project_id=" + project_id;
         })
         // 모달 창 닫기
           $('.ApplyMemberListCancleBtn').unbind('click').bind('click',function(){
              $('.Project_Apply_modal').empty();
              $('.Project_Apply_modal').hide();
              $('#project_info').trigger('click');
              
           });
   }


   if ($('.member_list').children().length < 1) {
      $('.member_list').append("<tr><td class='ProjectDetail_p'>아직 프로젝트 멤버가 없습니다.</td></tr>");
   }

   // 탭 시작
   $('.Project_menuBar > li ').unbind("click").bind("click", function() {

      $('.Project_menuBar > li ').attr('class', 'menuli');

      // 프로젝트 info
      if ($(this).attr('id') == "project_info") {
         $('html').scrollTop(0);
         $('.ChangeContentBox').empty();

         $.ajax({

            url: "/ajaxproject/projectinfo",
            dataType: "html",
            data: { project_id: project_id },
            success: function(responsedata) {

               responsedata = JSON.parse(responsedata);

               var pmcountlist = responsedata.pmcountlist;
               var project = responsedata.project;
               var checkapply = responsedata.checkapply;

               var project_info = "<div class='Project_info'>"
               project_info += "<div class='ProjectMember'>"
               project_info += "<p>모집현황</p>"
               project_info += "<p class='Project_p'><b style='color: red;'>*</b> 원하는 분야에 지원해보세요!</p>"
               project_info += "<hr>"
               project_info += "<div id='PositionBox'>"
               project_info += "<table class='project_boxdiv'>"
               for (var i = 0; i < pmcountlist.length; i++) {
                  project_info += "<tr class='Project_memberList'>"
                  project_info += "<td width='50%'>" + pmcountlist[i].position_name + "</td>"
                  if (pmcountlist[i].curr == pmcountlist[i].max) {
                     project_info += "<td class='memberListcurrFull' width='15%'>" + pmcountlist[i].curr + " / " + pmcountlist[i].max + "</td>"
                     project_info += "<td width='30%' class='FullBtnWarp'>"
                     project_info += "<input type='button' value='마감'>"
                     project_info += "</td>"
                  } else {
                     project_info += "<td class='memberListcurr' width='15%'>" + pmcountlist[i].curr + " / " + pmcountlist[i].max + "</td>"
                     project_info += "<td width='30%' class='BtnWarp'>"
                     if (login_memberid != project.member_id) {
                        if(checkapply > 0){
                           project_info += "<input type='button' class='ApplyComple' value='지원완료'>"
                        }else{
                        project_info += "<input class='ProjectApplyBtn' type='button' value='지원'>"
                        project_info += "<label for='ProjectApplyBtn' hidden>" + pmcountlist[i].position_id + "</label>"
                        project_info += "<label for='ProjectApplyBtn' hidden>" + pmcountlist[i].position_name + "</label>"
                        }
                     }
                     project_info += "</td>"
                  }

                  project_info += "</tr>"
               }

               project_info += "</table>"
               project_info += "</div>"
               project_info += "</div>"

               project_info += "<div class='ProjectContent'>"
               project_info += "<p>프로젝트 소개</p>"
               project_info += "<hr>"
               project_info += "<p class='Project_content'>" + project.p_content + "</p>"
               project_info += "</div>"
               project_info += "</div>"

               $('.ChangeContentBox').append(project_info);

               // 모달 
               $('.ProjectApplyBtn').unbind("click").bind("click", function() {
                  var Applycode = this.nextElementSibling.textContent;
                  var Applyname = this.nextElementSibling.nextElementSibling.textContent;
                  var checkdata = {
                     "member_id": login_memberid,
                     "project_id": project_id
                  };

                  $.ajax({
                     url: "/ajaxproject/projectCheckApply",
                     dataType: "html",
                     data: checkdata,
                     success: function(responsedata) {
                        
                        if(project_state != "모집중"){
                           swal("프로젝트 지원이 마감되었습니다.", "", "warning");
                           return false;
                        }
                        if (responsedata == "is_project") {
                           swal("현재 진행 중인 프로젝트가 존재합니다.", "", "warning");
                           return false;
                        } else if (responsedata == "ProjectApply") {
                           swal("현재 프로젝트에 이미 지원 하였습니다.", "", "warning");
                           return false;
                        
                        } else {

                           var alarm = {
                              "alarm_CODE": "PR_A",
                              "url": logineduser,
                              "member_ID": $("#leader_id").val(),
                              "alarm_CONTENT": loginednickname + "님이 회원님의 프로젝트에 지원하셨습니다"
                           }

                           var Applydata = {
                              apply: {
                                 "project_id": project_id,
                                 "position_id": Applycode,
                                 "member_id": login_memberid,
                              },
                              alarm

                           };

                           $('.ApplyName').empty();
                           $('.ApplyName').append(Applyname);
                           $('.Project_Detail_modal').show();

                           $('.ApplyBtn_No').unbind('click').bind('click', function() {
                              $('.Project_Detail_modal').hide();
                           });

                           $('.ApplyBtn_Ok').unbind('click').bind('click', function() {

                              $.ajax({
                                 url: "/ajaxproject/projectapply",
                                 dataType: "html",
                                 type: "post",
                                 contentType: "application/json",
                                 data: JSON.stringify(Applydata),
                                 success: function(responsedata) {
                                    if (responsedata == "true") {
                                       swal("지원 되었습니다.", "", "success");

                                       //프로젝트 지원 알림 보내기
                                       insertAlarm(JSON.stringify(alarm)).then(function() {
                                          setTimeout(function() {
                                             document.location.reload(true);
                                          }, 1000)
                                       });
                                       setTimeout(function() {
                                             document.location.reload(true);
                                          }, 1000);
                                    } else if(responsedata == "isProject"){
                                       swal("이미 다른 프로젝트에 가입 하였습니다.", "", "error");
                                       setTimeout(function() {
                                          document.location.reload(true);
                                       }, 1000);

                                    } else {
                                       swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                       setTimeout(function() {
                                          document.location.reload(true);
                                       }, 1000);
                                    }

                                 }
                              });
                           });
                        }
                     }
                  });
               });
            }


         })
         // --------------------------------------------------------------------------------------------   
      // Qna 게시판    
      } else if ($(this).attr('id') == "Qna") {
         $('html').scrollTop(0);
         $('.ChangeContentBox').empty();

         var qnaData = { "project_id": project_id }

         $.ajax({
            url: "/ajaxproject/projectqna",
            method: "GET",
            dataType: "html",
            data: qnaData,
            success: function(responsedata) {

               responsedata = JSON.parse(responsedata);



               var QnaBox = "<div class='QnABox'>"
               QnaBox += "<p>Q&A</p>"
               QnaBox += "<p class='Project_p'><b style='color: red;'>*</b> 프로젝트에 대한 질문을 남겨보세요!</p>"
               QnaBox += "<hr>"
               QnaBox += "<textarea placeholder='프로젝트에 대한 질문을 남겨보세요.' class='QnaContents' maxlength='2000'></textarea>"
               QnaBox += "<div class='QnaBtnBox'>"
               QnaBox += "<input type='button' class='QnaBtn' value='등록'>"

               QnaBox += "</div>"
               QnaBox += "</div>"



               if (responsedata.length > 0) {
                  QnaBox += "<div class='QnaList'>"
                  for (var i = 0; i < responsedata.length; i++) {


                     QnaBox += "<div class='QnaBox_'>"
                     QnaBox += "<div class='QnaBoxTitle'>"
                     QnaBox += "<div class='QnaImgBox'>"
                     QnaBox += "<img src='/resources/upload/" + responsedata[i].member_image + "'>"
                     QnaBox += "</div>"
                     QnaBox += "<div class='QnaMember_nickname'>" + responsedata[i].member_nickname + "</div>"
                     QnaBox += "</div>"
                     QnaBox += "<div class='QnaDate'>"
                     QnaBox += "<p>" + responsedata[i].qna_date.substring(0, 16) + "</p>"
                     QnaBox += "</div>"
                     QnaBox += "<div class='QnaContent'>"
                     QnaBox += "<textarea class='EditQnaContent disabled' maxlength='2000'>"
                     QnaBox += responsedata[i].qna_content
                     QnaBox += "</textarea>"
                     QnaBox += "</div>"
                     QnaBox += "<div class='QnaBtnLeftBox'>"
                     QnaBox += "<p class='showReply'>댓글보기</p>"
                     QnaBox += "<input type='text' value='" + responsedata[i].ref + "' hidden>"
                     QnaBox += "</div>"
                     QnaBox += "<div class='QnaBtnRightBox'>"
                     if (responsedata[i].member_id == login_memberid) {
                        if (responsedata[i].enabled == 1) {
                           QnaBox += "<input type='button' class='EditQnaBtn' value='수정'><p>|</p>"
                           QnaBox += "<input type='button' class='DeleteQnaBtn' value='삭제'>"

                        }
                     }
                     QnaBox += "</div>"
                     QnaBox += "</div>"


                     QnaBox += "<div id='ReplyBox" + responsedata[i].ref + "' style='display:none'>"
                     QnaBox += "</div>"



                  }

                  QnaBox += "</div>"
               }


               $('.ChangeContentBox').append(QnaBox);

               // Qna 등록버튼
               $('.QnaBtn').unbind("click").bind("click", function() {
                  var content = $('.QnaContents').val();

                  if (content != "") {
                     $.ajax({
                        url: "/ajaxproject/projectqna",
                        method: "POST",
                        data: {
                           "project_id": project_id,
                           "member_id": login_memberid,
                           "qna_content": content
                        },
                        success: function(responsedata) {

                           if (responsedata == "true") {
                              $('#Qna').trigger('click');
                           }

                        }

                     })
                  }

               })


               // Qna 수정버튼
               $('.EditQnaBtn').unbind("click").bind("click", function() {

                  var Editcontent = $(this).parent().parent().children()[2].children;
                  var attr = $(this).parent().parent().children()[2].children[0];
                  var Editref = $(this).parent().parent().children()[3].children[1].value;
                  var at = $(attr).attr('class').indexOf('disabled');


                  if (at > 0) {
                     $(Editcontent).removeClass('disabled');
                  } else {

                     if ($(Editcontent).val() == "") {
                        swal('값을 입력해주세요.', '', 'error');
                        return false;
                     } else {

                        $.ajax({
                           url: "/ajaxproject/projectqna",
                           method: "PUT",
                           data: {
                              "project_id": project_id,
                              "member_id": login_memberid,
                              "qna_content": $(Editcontent).val(),
                              "ref": Editref
                           },
                           success: function(responsedata) {

                              if (responsedata != "true") {
                                 swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                 setTimeout(function() {
                                    document.location.reload(true);
                                 }, 1000);
                              }

                           }

                        })
                     }
                     $(Editcontent).addClass('disabled');
                  }

               })

               // Qna 삭제
               $('.DeleteQnaBtn').unbind("click").bind("click", function() {

                  var attr = $(this).parent().parent().children()[2].children[0];
                  var Deleteref = $(this).parent().parent().children()[3].children[1].value;


                  swal({
                     title: "작성하신 글을 삭제하시겠습니까?",
                     text: "",
                     icon: "warning",
                     buttons: true,
                     dangerMode: true,
                  })
                     .then((willDelete) => {
                        if (willDelete) {

                           $.ajax({
                              url: "/ajaxproject/projectqna",
                              method: "DELETE",
                              data: {
                                 "project_id": project_id,
                                 "member_id": login_memberid,
                                 "ref": Deleteref
                              },
                              success: function(responsedata) {

                                 if (responsedata != "true") {
                                    swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                    setTimeout(function() {
                                       document.location.reload(true);
                                    }, 1000);
                                 } else {
                                    $('#Qna').trigger('click');
                                 }

                              }

                           })

                        } else {
                           return false;
                        }
                     });


               })


               // 댓글보기 
               $('.showReply').unbind("click").bind("click", function() {
                  var ref = this.nextSibling.value
                  var attr = $("#ReplyBox" + ref).attr('style');


                  if (attr == "display:none") {



                     $("#ReplyBox" + ref).empty();

                     $.ajax({
                        url: "/ajaxproject/ProjectQnaReply",
                        method: "GET",
                        dataType: "html",
                        data: {
                           "project_id": project_id,
                           "REF": ref,
                           "member_id": login_memberid
                        },
                        success: function(responsedata) {


                           responsedata = JSON.parse(responsedata);

                           var ReplyBox = "<div class='colorBox'>"

                           if (responsedata.qna.length == 0) {
                              var ischeck = 0;
                              for (var i = 0; i < responsedata.pmlist.length; i++) {
                                 if (responsedata.pmlist[i].member_id == login_memberid) {
                                    ischeck++;
                                 }
                              }

                              if (ischeck > 0 || responsedata.Reader > 0) {
                                 ReplyBox += "<div class='QnaReplyInput'>"
                                 ReplyBox += "<input type='text' class='ReplyWrite' placeholder='댓글을 남겨주세요.'>"
                                 ReplyBox += "<input type='text' value='" + ref + "' hidden>"
                                 ReplyBox += "<div class='ReplyWriteBtnBox'>"
                                 ReplyBox += "<input type='button' class='ReplyWriteBtn'  value='등록'>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "</div>"

                              } else {
                                 ReplyBox += "<div class='QnaReplyInput'>"
                                 ReplyBox += "<input type='text' class='ReplyWrite Replydisabled' placeholder='프로젝트 멤버만 댓글 작성이 가능합니다.'>"
                                 ReplyBox += "<input type='text' value='" + ref + "' hidden>"
                                 ReplyBox += "<div class='ReplyWriteBtnBox Replydisabled'>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "</div>"

                              }

                           } else {
                              for (var i = 0; i < responsedata.qna.length; i++) {

                                 ReplyBox += "<div class='QnaReplyBox'>"
                                 ReplyBox += "<div class='QnaBoxTitle'>"
                                 ReplyBox += "<div class='QnaImgBox'>"
                                 ReplyBox += "<img src='/resources/upload/" + responsedata.qna[i].member_image + "'>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "<div class='QnaMember_nickname'>" + responsedata.qna[i].member_nickname + "</div>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "<div class='QnaDate'>"
                                 ReplyBox += "<p>" + responsedata.qna[i].qna_date.substring(0, 16) + "</p>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "<div class='QnaContent'>"
                                 ReplyBox += "<p>"
                                 ReplyBox += responsedata.qna[i].qna_content
                                 ReplyBox += "</p>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "<hr>"
                                 ReplyBox += "</div>"

                              }
                              var ischeck = 0;
                              for (var i = 0; i < responsedata.pmlist.length; i++) {
                                 if (responsedata.pmlist[i].member_id == login_memberid) {
                                    ischeck++;
                                 }
                              }

                              if (ischeck > 0 || responsedata.Reader > 0) {
                                 ReplyBox += "<div class='QnaReplyInput'>"
                                 ReplyBox += "<input type='text' class='ReplyWrite' placeholder='댓글을 남겨주세요.'>"
                                 ReplyBox += "<input type='text' value='" + ref + "' hidden>"
                                 ReplyBox += "<div class='ReplyWriteBtnBox'>"
                                 ReplyBox += "<input type='button' class='ReplyWriteBtn'  value='등록'>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "</div>"

                              } else {
                                 ReplyBox += "<div class='QnaReplyInput'>"
                                 ReplyBox += "<input type='text' class='ReplyWrite Replydisabled' placeholder='프로젝트 멤버만 댓글 작성이 가능합니다.'>"
                                 ReplyBox += "<input type='text' value='" + ref + "' hidden>"
                                 ReplyBox += "<div class='ReplyWriteBtnBox Replydisabled'>"
                                 ReplyBox += "</div>"
                                 ReplyBox += "</div>"

                              }
                           }

                           ReplyBox += "</div>";

                           $("#ReplyBox" + ref).append(ReplyBox);
                           $("#ReplyBox" + ref).show();

                           $('.ReplyWriteBtn').unbind("click").bind("click", function() {
                              var contents = $(this).parent().parent()[0].children[0].value;
                              var replyREF = $(this).parent().parent()[0].children[1].value;
                              var Btn = $(this).parent().parent().parent().parent().prev().children()[3].children[0];

                              if (contents != "") {
                                 $.ajax({
                                    url: "/ajaxproject/ProjectQnaReply",
                                    method: "POST",
                                    data: {
                                       "project_id": project_id,
                                       "member_id": login_memberid,
                                       "qna_content": contents,
                                       "ref": replyREF
                                    },

                                    success: function(responsedata) {

                                       if (responsedata == "true") {
                                          $(Btn).trigger('click');
                                          $(Btn).trigger('click');
                                       }
                                    }

                                 })
                              }

                           })

                        }


                     })

                  } else {
                     $("#ReplyBox" + ref).attr('style', 'display:none');
                  }
               })

            }
         });



         // --------------------------------------------------------------------------------------------
      // 멤버 피드   
      } else if ($(this).attr('id') == "memberfeed") {   
         
         $('html').scrollTop(0);
         $('.ChangeContentBox').empty();
         
         var FeedData = { "project_id": project_id,
                     "member_id":login_memberid }

         $.ajax({
            url: "/ajaxproject/projectfeed",
            dataType: "html",
            method: "GET",
            data: FeedData,
            success: function(responsedata) {
               
               responsedata = JSON.parse(responsedata);
               
               console.log(responsedata.Reader);
               
               var MemberFeedBox = "<div class='MemberFeedBox'>"
               MemberFeedBox += "<p>Feed</p>"
               MemberFeedBox += "<p class='Project_p'><b style='color: red;'>*</b> 프로젝트 리더가 남긴 프로젝트 추가 정보 사항입니다.</p>"
               MemberFeedBox += "<hr>"
               MemberFeedBox += "<div class='FeedBtnBox'>"
                  if(responsedata.Reader > 0){
                     MemberFeedBox += "<input type='button' class='FeedWriteBtn' value='글쓰기'>"
                  }
               MemberFeedBox += "</div>"
               MemberFeedBox += "</div>"

               if (responsedata.F_list.length > 0) {
                  MemberFeedBox += "<div class='QnaList'>"
                  for (var i = 0; i < responsedata.F_list.length; i++) {

                     MemberFeedBox += "<div class='QnaBox_'>"
                     MemberFeedBox += "<div class='QnaBoxTitle'>"
                     MemberFeedBox += "<div class='FeedTitle'><p>Q.</p><input class='disabled' maxlength='500' value='" + responsedata.F_list[i].feed_title + "'>"
                     MemberFeedBox += "<input value='" + responsedata.F_list[i].feed_id + "' hidden></div>"
                     MemberFeedBox += "</div>"
                     MemberFeedBox += "<div class='FeedContent'>"
                     MemberFeedBox += "<textarea class='disabled' maxlength='2000'>"
                     MemberFeedBox += responsedata.F_list[i].feed_content
                     MemberFeedBox += "</textarea>"
                     MemberFeedBox += "</div>"
                     if (responsedata.F_list[i].member_id == login_memberid || responsedata.Reader > 0) {
                        MemberFeedBox += "<div class='FeedBtnBox'>"
                        MemberFeedBox += "<input type='button' class='FeedEditBtn' value='수정'><p>|</p>"
                        MemberFeedBox += "<input type='button' class='FeedDeleteBtn' value='삭제'>"
                        MemberFeedBox += "</div>"
                     } 
                     MemberFeedBox += "</div>"


                  }

                  MemberFeedBox += "</div>"
               }

               $('.ChangeContentBox').append(MemberFeedBox);
            
               // 글쓰기 버튼
               $('.FeedWriteBtn').unbind("click").bind("click", function(){
                  $('.Project_Apply_modal').empty();
                          
                  var table = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";
                  
                  table += "<p class='ApplyMemberListTitle centerImpo'>멤버들에게 공유할 정보를 입력해주세요.</p>"
                  table += "<input type='text' class='feedTitle' placeholder='제목을 입력해주세요'>"
                  table += "<textarea type='text' class='feedcontent' placeholder='내용을 입력해주세요'></textarea>"
                  table += "<input type='button' value='글쓰기' class='FeedWrite'><input type='button' value='취소' class='Feedcancel'>"
                  table += "<div class='ApplyPbox'>"
                  table += "<p class='Apply_p'><b>작성 예시</b></p>"   
                  table += "<p class='Project_p Apply_p'>ex) 협업툴은 OO입니다~ </p>"
                  table += "<p class='Project_p Apply_p'>ex) 오픈채팅방 주소는 open.kakao.com/cyco 입니다. </p>"
                  table += "</div>";
                  table += "</div></form>";
                  
                  $('.Project_Apply_modal').append(table);
                  $('.Project_Apply_modal').show();
                  
                  
                  // 모달닫기
                  $('.Feedcancel').unbind('click').bind('click',function(){
                       $('.Project_Apply_modal').empty();
                       $('.Project_Apply_modal').hide();
                                                         
                    });
                  
                  // 글쓰기
                  $('.FeedWrite').unbind('click').bind('click',function(){
                     var FeedData = {"feed_title":$('.feedTitle').val(),
                                 "feed_content":$('.feedcontent').val(),
                                 "project_id":project_id,
                                 "member_id":login_memberid};
                     
                     $.ajax({
                        url: "/ajaxproject/projectfeed",
                        dataType: "html",
                        method: "POST",
                        data: FeedData,
                        success: function(responsedata) {
                           if(responsedata == "true"){
                              swal('피드가 등록되었습니다.','','success');
                               $('.Project_Apply_modal').empty();
                                $('.Project_Apply_modal').hide();
                                $('#memberfeed').trigger('click');
                           }
                           
                           
                        }
                     })
                                                         
                    });
                  
               })
            // Feed 수정버튼
            $('.FeedEditBtn').unbind("click").bind("click", function() {
   
               var Edittitle = $(this).parent().parent().children()[0].children[0].children[1].value;
               var EditFeedId = $(this).parent().parent().children()[0].children[0].children[2].value;
               var Editcontent = $(this).parent().parent().children()[1].children[0].innerHTML;
               
               
               $('.Project_Apply_modal').empty();
                          
                  var table = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";
                  
                  table += "<p class='ApplyMemberListTitle centerImpo'>멤버들에게 공유할 정보를 입력해주세요.</p>"
                  table += "<input type='text' class='feedTitle' placeholder='제목을 입력해주세요' value='"+ Edittitle +"'>"
                  table += "<textarea type='text' class='feedcontent' placeholder='내용을 입력해주세요'>"+ Editcontent +"</textarea>"
                  table += "<input type='button' value='수정' class='FeedWrite' id='EditFeed'><input type='button' value='취소' class='Feedcancel'>"
                  table += "<div class='ApplyPbox'>"
                  table += "<p class='Apply_p'><b>작성 예시</b></p>"   
                  table += "<p class='Project_p Apply_p'>ex) 협업툴은 OO입니다~ </p>"
                  table += "<p class='Project_p Apply_p'>ex) 오픈채팅방 주소는 open.kakao.com/cyco 입니다. </p>"
                  table += "</div>";
                  table += "</div></form>";
                  
                  $('.Project_Apply_modal').append(table);
                  $('.Project_Apply_modal').show();
               
               
                  // 모달닫기
                  $('.Feedcancel').unbind('click').bind('click',function(){
                       $('.Project_Apply_modal').empty();
                       $('.Project_Apply_modal').hide();
                                                         
                    });
                    
                    // 수정버튼
                  $('#EditFeed').unbind('click').bind('click',function(){
                     var FeedEdit = {"project_id":project_id,
                                 "feed_id":EditFeedId,
                                 "feed_title":$('.feedTitle').val(),
                                 "feed_content":$('.feedcontent').val()}
                       $.ajax({
                        url: "/ajaxproject/projectfeed",
                        dataType: "html",
                        method: "PUT",
                        data: FeedEdit,
                        success: function(responsedata) {
                           if(responsedata == "true"){
                              swal('피드가 수정되었습니다.','','success');
                               $('.Project_Apply_modal').empty();
                                $('.Project_Apply_modal').hide();
                                $('#memberfeed').trigger('click');
                           }
                           
                           
                           }
                        })                            
                       });
                       
            })   
            
             // 삭제 버튼
               $('.FeedDeleteBtn').unbind('click').bind('click',function(){
                  var DeleteFeedId = $(this).parent().parent().children()[0].children[0].children[2].value;
                  
                  swal({
                  title: "작성하신 글을 삭제하시겠습니까?",
                  text: "",
                  icon: "warning",
                  buttons: true,
                  dangerMode: true,
               })
                  .then((willDelete) => {
                     if (willDelete) {

                        $.ajax({
                           url: "/ajaxproject/projectfeed",
                           dataType: "html",
                           method: "DELETE",
                           data: {
                              "project_id": project_id,
                              "feed_id": DeleteFeedId,
                           },
                           success: function(responsedata) {

                              if (responsedata != "true") {
                                 swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                 setTimeout(function() {
                                    document.location.reload(true);
                                 }, 1000);
                              } else {
                                 swal('삭제 되었습니다.','','success');
                                 $('#memberfeed').trigger('click');
                              }

                           }

                        })

                     } else {
                        return false;
                     }
                  });
                  
               })
            
            
         }
      })   
      // 멤버관리 클릭   
      } else if ($(this).attr('id') == "memberEdit") {

         $('html').scrollTop(0);
         $('.ChangeContentBox').empty();

          // 멤버관리 리스트 뿌려주는 ajax
          $.ajax({
                 url:"/ajaxproject/getMemberEditBox",
                 dataType:"html",
                 data: {project_id:project_id},
                 success: function(responsedata){          
                    
                    responsedata = JSON.parse(responsedata);
                    
                    var pmcountlist = responsedata.pmcountlist;
                    var pmlist = responsedata.pmlist;
                    var memberCount = 0;
                    
                 
         
                     var Div =  "<div class='MemberEditBox'>"
                    Div +=   "<div class='ProjectMember'>"
                    Div +=   "<p>지원내역</p>"
                    if(project_state == '모집중'){
                    Div +=   "<p class='Project_p'><b style='color: red;'>*</b> 나의 프로젝트에 지원한 멤버 목록입니다.</p>"
                    Div +=   "<hr>"
                    Div +=   "<div id='PositionBox'>"
                    Div +=   "<table class='project_boxdiv'>"
                       for(var i = 0; i < pmcountlist.length; i++){
                          // 고용 멤버 확인
                          memberCount += Number(pmcountlist[i].max);
                          
                          Div +=   "<tr class='Project_memberList'>"
                          Div +=   "<td width='50%'>" + pmcountlist[i].position_name +"</td>"
                          Div +=   "<td class='memberListcurr' width='15%'>" + pmcountlist[i].curr + " / " + pmcountlist[i].max + "</td>"
                          Div +=   "<td width='30%' class='BtnWarp'>"
                          Div +=   "<input class='ProjectApplyMember_List' type='button' value='상세보기'>"
                          Div +=   "<label for='ProjectApplyBtn' hidden>" + pmcountlist[i].position_id +"</label>"
                         Div +=   "<label for='ProjectApplyBtn' hidden>" + pmcountlist[i].position_name + "</label>"
                         if(pmcountlist[i].count > 0){
                           Div +=   "<span class='Badge'️️</span>"
                        }
                         Div +=   "</td>"
                         Div +=   "</tr>"
                       }
                    Div +=   "</table>"
                    Div +=  "<div class='memberPlus'>"
                    Div +=  "<input type='button' value='+' class='MemberPlusBtn'>"
                    Div +=  "</div>"
                    Div +=   "</div>"
                    Div +=   "</div>"
                    Div +=  "</div>"
                    }else{
                     Div +=   "<p class='Project_p'><b style='color: red;'>*</b> 프로젝트 상태가 진행중으로 인해 모집이 마감되었습니다.</p>"
                       Div +=   "<hr>"
                       Div +=   "<div id='PositionBox'>"
                       Div +=   "<table class='project_boxdiv'>"
                       for(var i = 0; i < pmcountlist.length; i++){
                       
                          Div +=   "<tr class='Project_memberList'>"
                          Div +=   "<td width='50%'>" + pmcountlist[i].position_name +"</td>"
                          Div +=   "<td class='memberListcurr' width='15%'>" + pmcountlist[i].curr + " / " + pmcountlist[i].max + "</td>"
                          Div +=   "<td width='30%' class='BtnWarp'>"
                          Div +=   "<input class='ProjectApplyMember_List' type='button' value='마감'>"
                          Div +=   "<label for='ProjectApplyBtn' hidden>" + pmcountlist[i].position_id +"</label>"
                         Div +=   "<label for='ProjectApplyBtn' hidden>" + pmcountlist[i].position_name + "</label>"
                         Div +=   "</td>"
                         Div +=   "</tr>"
                       }
                          Div +=   "</table>"
                          Div +=   "</div>"
                          Div +=   "</div>"
                          Div +=  "</div>"
                  }            
                          Div += "<div class='MemberSuperintend'>"
                          Div += "<p>멤버목록</p>"
                          Div += "<p class='Project_p'><b style='color: red;'>*</b> 멤버들을 관리해보세요. </p>"
                          Div += "<hr>"
                          Div += "<div class='MemberSuperintend_list'>"
                          
                       for(var i = 0; i < pmlist.length; i ++){
                          if(pmlist[i].member_id != null){
                             Div +=      "<div class='memberListBox'>"
                             Div +=      "<div class='memberListInfo_data04042'>"
                             Div +=      "<div class='memberListImgBox'>"
                             Div +=      "<img src='/resources/upload/" + pmlist[i].member_image + "'>"
                             Div +=      "</div>"
                             Div +=      "<div class='memberinfoBox'>"
                             Div +=      "<div class='memberList_nickname'>" + pmlist[i].member_nickname + "</div> <br>"
                             Div +=      "<div class='memberList_skills'>_" + pmlist[i].position_name +" | 멤버</div>"
                             Div +=      "</div>"
                             Div +=       "</div>"
                             Div +=      "<div class='MemberSuperintend_list_Btn'>"
                             Div +=      "<div class='handoverAuthority_Btn'>"
                             Div +=      "<img src='/assets/img/project/handoverAuthority.png'>"
                             
                             Div +=      "<input type='text' value=" + pmlist[i].member_id + " hidden=''>"
                             Div +=      "<input type='text' value=" + pmlist[i].position_id + " hidden=''>"
                             Div +=      "</div>"
                                                  
                             Div +=      "<div class='Member_Expulsion_Btn'>"
                             Div +=      "<img src='/assets/img/project/ExpulsionBtn.png'>"
                             Div +=      "<input type='text' value=" + pmlist[i].member_id + " hidden=''>"
                             Div +=      "<input type='text' value=" + pmlist[i].position_id + " hidden=''>"
                             Div +=      "</div>"
                             Div +=      "</div>"
                             Div +=      "</div>"
                             Div +=      "<hr>"
                             }
                          }
                       
                    
                          Div +=      "</div>"
                          Div +=     "</div>"
                          
                          $('.ChangeContentBox').append(Div);
                          if($('.MemberSuperintend_list').children().length < 1){
                                $('.MemberSuperintend_list').append("<div class='ProjectDetail_p'>아직 프로젝트 멤버가 없습니다.</div>");
                          }
                          
                          // -------------------------------------------------------
                          // 멤버 추가
                          var NoDump = 0;
                          $('.MemberPlusBtn').unbind("click").bind("click", function(){
                             
                             NoDump ++;
                             if(NoDump > 1){
                                swal("현재 지정한 값을 반영 후 시도하시기 바랍니다.", "", "error");
                             }else{
                                
                             memberCount ++;   
                             $.ajax({
                                  url:"/ajaxproject/PositionList",
                                  dataType:"html",
                                  success: function(responsedata){    
                                     
                                   responsedata = JSON.parse(responsedata);
                                     
                                   var memberPlusBox = "<tr class='Project_memberList'>"
                                   memberPlusBox += "<td width='50%'>";
                                   memberPlusBox += "<select class='MemberPlus_SelectBox' name='position_code'>"
                                     for(var i = 0; i < responsedata.length; i++) {
                                        if(responsedata[i].position_enabled == 1 ){
                                              memberPlusBox += "<option value='"+ responsedata[i].position_id +"'>"+ responsedata[i].position_name +"</option>";
                                           }
                                        }
                                  memberPlusBox += "</select>"
                                  memberPlusBox += "</td>"
                                   memberPlusBox += "<td class='MemberPlusBtnWarp' width='15%'>";
                                   memberPlusBox += "<input type='button' class='Up_num' value='+' >"
                                   memberPlusBox += "<input type='text' class='number' name='field_selectCount' value='1' readonly='readonly'>"
                                   memberPlusBox += "<input type='button' class='Down_num' value='-'>"
                              memberPlusBox += "</td>"
                              memberPlusBox += "<td width='30%'>"         
                              memberPlusBox += "<input class='PlusMember_ListBtn' type='button' value='반영'>"
                              memberPlusBox += "</td>"
                                  memberPlusBox += "</tr>"   
                                  memberPlusBox += "<tr>"   
                                  memberPlusBox += "<td>"   
                                  memberPlusBox += "<p class='Project_p ma-l-10'><b style='color: red;'>*</b> 원하는 분야를 선택하고 +, - 를 통해서 모집인원을 추가하거나 삭제 후 반영하세요! </p>"
                                  memberPlusBox += "</td>"   
                                  memberPlusBox += "</tr>"   
                                  
                                   $('.project_boxdiv').append(memberPlusBox);
                     
                                   $('.MemberPlusBtnWarp').unbind("click").bind("click", function(){
                                      var UpBtn = $(this)[0].children[0];
                                     var DownBtn = $(this)[0].children[2];
                                     var Count = $(this)[0].children[1];
                                     
                                     
                                     // + 이벤트
                                     $(UpBtn).unbind("click").bind("click", function(){
      
                                        if (memberCount < 10) {
                                           var Count_ = parseInt($(Count).val());
                                           $(Count).val(Count_ + 1);
                                           memberCount++;
                                        } else {
                                           swal("맴버는 10명이상의 구인이 불가능합니다.", "", "error");
                                        }
                                        

                                     })

                                     // - 이벤트
                                     $(DownBtn).unbind("click").bind("click", function(){
                                        if(parseInt($(Count).val()) <= -9){
                                           swal("더 이상 값을 반영 할 수 없습니다.", "", "error");
                                           $(Count).val(-9);
                                           return false;
                                        }
                                        var Count_ = parseInt($(Count).val());
                                        $(Count).val(Count_ - 1);
                                        memberCount--;
                                        
                                     })
                                     
                                   })
                                   
                                   // 반영 버튼
                                   $('.PlusMember_ListBtn').unbind("click").bind("click", function(){
                                      var num = $('.MemberPlusBtnWarp > input')[1];   
                                      var selectPosition = $('.MemberPlus_SelectBox').val();
                                      
                                      if(memberCount > 10){
                                         swal("멤버는 10명 이상 모집이 불가능합니다.","","error");
                                         return null;
                                      }
                                      
                                      if(memberCount < 1){
                                         swal("멤버는 1명 이상 존재 하여야합니다.","","error");
                                         return null;
                                      }
                                         
                                      data = {"project_id":project_id,
                                            "select_num":$(num).val(),
                                            "position_id":selectPosition}
                                      
                                      
                                      $.ajax({
                                           url:"/ajaxproject/memberplus",
                                           dataType:"html",
                                           data:data,
                                           success: function(responsedata){    
                                        
                                               if(responsedata == "NumZero"){
                                                  swal("0이 아닌 값을 입력 후 반영해주세요.", "", "error");
                                               }else if(responsedata == "Update"){
                                                  swal("멤버가 추가 입력 되었습니다.", "", "success");
                                                  $('#memberEdit').trigger('click');
                                               }else if(responsedata == "Delete"){
                                                  swal("모집 멤버를 삭제 하였습니다.", "* 이미 모집된 멤버가 있을 경우 반영되지않습니다.", "warning");
                                                  $('#memberEdit').trigger('click');
                                               }
                                                  
                                           }
                                      
                                      })
                                   })
                                   
                                   
                                   
                                  }
                             });
                          }
                             
                       })
                          
                          // 프로젝트 멤버 상세보기
                          $('.ProjectApplyMember_List').unbind("click").bind("click", function(){
                             var Applycode = this.nextElementSibling.textContent;
                             
                             $.ajax({
                                     url:"/ajaxproject/applyList",
                                     dataType:"html",
                                     data: {"project_id":project_id,
                                           "Applycode":Applycode},
                                     success: function(responsedata){    
                                        
                                        responsedata = JSON.parse(responsedata);
                                        
                                        console.log(responsedata);
                                        $('.Project_Apply_modal').empty();
                                        
                                           var table = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";
                                           table += "<div>";
                                           table += "<input type='button' class='ApplyMemberListCancleBtn' value='✕'>"
                                           table += "</div>";
                                           
                                              if(responsedata.length < 1){
                                                 table += "<p class='ApplyMemberListTitle'>지원목록</p>"
                                                 table += "<div class='NomemberBox'>";
                                                 table += "<p>아직 지원한 회원이 없습니다.</p>"
                                                 table += "</div>";
                                              }else{
                                                 table += "<p class='ApplyMemberListTitle'>["+ responsedata[0].applypositionname + "] 지원목록</p>"
                                                  table += "<table class='ProjectApplyMemberListBox'>"
                                                    
                                                  table += "<tr class='ApplyMemberTr''><th colspan='2'>회원정보</th><th>상태</th><th>관리</th></tr>";
                                                 
                                                 $.each(responsedata, function(i, elt) {
                                                    
                                                 table += "<tr>";
                                                 table += "<td class='td_rigth'><div class='LeaderImg_Box'>"
                                                 table += "<img src='/resources/upload/" + elt.member_image + "'>"
                                                 table += "</div></td>";
                                                 table += "</td>";
                                                 table += "<td>";
                                                 table += "<a href='../member/memberdetailpage?memberid=" + elt.member_id +"' target='_blank' >" + elt.member_nickname + "</a>";                          
                                                 table += "</td>";
                                                 table += "<td>";
                                                    if(elt.apply_ok == "0"){
                                                       table += "<p class='applystate_0'>멤버 수락 대기중</p>"
                                                    }else if(elt.apply_ok == "1"){
                                                         table += "<p class='applystate_1'>승인</p>"
                                                    }else if(elt.apply_ok == "2"){
                                                       table += "<p class='applystate_2'>거절</p>"
                                                    }else if(elt.apply_ok == "3"){
                                                       table += "<p class='applystate_2'>추방</p>"
                                                    }
                                                 table += "</td>";
                                                 table += "<td>";
                                                 table += "<div class='ApplyMemberListBtn_Box'>";
                                                    
                                                    if(elt.apply_ok == "0"){
                                                   if(project_state == "모집중"){
                                                      table += "<input type='button' value='수락' class='ApplyMemberListBtn_Ok'><input type='button' value='거절' class='ApplyMemberListBtn_No'>"; 
                                                          table += "<input type='text' value='" + elt.member_id +"' hidden>";
                                                          table += "<input type='text' value='" + elt.apply_position_id +"' hidden>";
                                                   }else{
                                                      table += "<input type='button' value='모집마감' class='successBtn'>"
                                                   }
         
                                                    }else{
                                                         table += "<input type='button' value='처리완료' class='successBtn'>";
                                                    }
                                                 
                                                 table += "</div>";
                                                 table += "</td>";
                                                 table += "</tr>"
                                                 
                                              })  
                                            }
                                              
                                           table += "</table>"
                                           table += "<div class='ApplyPbox'>"
                                           table += "<p class='Apply_p'><b>유의사항</b></p>"   
                                           table += "<p class='Project_p Apply_p'>- 받은 요청에 거절 할 경우 해당 회원은 본 프로젝트에 더 이상 지원이 불가능 합니다.</p>"
                                           table += "<p class='Project_p Apply_p'>- 프로젝트내의 분쟁사항은 저희 사이코딩에서 절대 책임지지 않습니다.</p>"   
                                           table += "</div>";
                                           
                                           table += "</div></form>";
                                           
                                           $('.Project_Apply_modal').append(table);
                                           $('.Project_Apply_modal').show(); 
                                           
                                           /* ------------------------------------------------------------------------------ */
                                           
                                           // 모달 창 닫기
                                            $('.ApplyMemberListCancleBtn').unbind('click').bind('click',function(){
                                                $('.Project_Apply_modal').empty();
                                                $('.Project_Apply_modal').hide();
                                                $('#memberEdit').trigger('click');
                                                
                                             });
                                           
                                              // 승인 버튼
                                             $('.ApplyMemberListBtn_Ok').unbind('click').bind('click', function() {
                                                var Applymember_id = $(this).next().next().val();
                                                var ApplyPosition = $(this).next().next().next().val();
                                                var divBox = $(this).parent();
                                                var divBoxstate = $(this).parent().parent().prev();
                                                var alarm = {
                                                   "alarm_CODE": "PR_S",
                                                   "url": project_id,
                                                   "member_ID": Applymember_id,
                                                   "alarm_CONTENT": "지원하신 프로젝트의 참여가 승인되었습니다"
                                                }
                     
                                                var data = {
                                                   apply: {
                                                      "project_id": project_id,
                                                      "member_id": Applymember_id,
                                                      "position_id": ApplyPosition
                                                   },
                                                   alarm
                                                }
                     
                                                $.ajax({
                                                   url: "/ajaxproject/applyMemberOk",
                                                   dataType: "html",
                                                   type: "post",
                                                   contentType: "application/json",
                                                   data: JSON.stringify(data),
                                                   success: function(responsedata) {
                     
                     
                                                      if (responsedata == "checkd") {
                                                         swal("요구하는 멤버수가 가득찼습니다.", "추가로 모집 할 경우 멤버수를 늘려주세요.", "warning");
                                                         return false;
                                                         
                                                      } else if (responsedata == "isProject"){
                                                 swal("", "해당 멤버가 이미 다른 프로젝트에 가입되었습니다.", "error");
                                                          return false;
                                                      } else if (responsedata == "true") {
                     
                                                         divBox.empty();
                                                         divBoxstate.empty();
                     
                                                         divBoxstate.append("<p class='applystate_1'>승인</p>");
                                                         divBox.append("<input type='button' value='처리완료' class='successBtn'>");
                                                         insertAlarm(JSON.stringify(alarm)).then(function() {
                                                            swal("멤버로 승인 하셨습니다.", "", "success")
                                                         });
                                                         
                     
                                                      } else {
                                                         swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                                         setTimeout(function() {
                                                            document.location.reload(true);
                                                         }, 1000);
                                                      }
                     
                                                   }
                                                });
                     
                     
                                             });
                     
                                             // 거절 버튼
                                             $('.ApplyMemberListBtn_No').unbind('click').bind('click', function() {
                                                var Applymember_id = $(this).next().val();
                                                var ApplyPosition = $(this).next().next().val();
                                                var divBox = $(this).parent();
                                                var divBoxstate = $(this).parent().parent().prev();
                                                
                                                var alarm = {
                                                   "alarm_CODE": "PR_F",
                                                   "url": project_id,
                                                   "member_ID": Applymember_id,
                                                   "alarm_CONTENT": "지원하신 프로젝트의 참여가 거절되었습니다"
                                                }
                     
                                                var data = {
                                                   apply:{
                                                   "project_id": project_id,
                                                   "member_id": Applymember_id,
                                                   "position_id": ApplyPosition},
                                                   alarm
                                                }
                     
                                                $.ajax({
                                                   url: "/ajaxproject/applyMemberNo",
                                                   dataType: "html",
                                                   type: "post",
                                                   contentType: "application/json",
                                                   data: JSON.stringify(data),
                                                   success: function(responsedata) {
                     
                                                      if (responsedata == "true") {
                     
                                                         divBox.empty();
                                                         divBoxstate.empty();
                     
                                                         divBoxstate.append("<p class='applystate_2'>거절</p>");
                                                         divBox.append("<input type='button' value='처리완료' class='successBtn'>");
                                                         
                                                         insertAlarm(JSON.stringify(alarm)).then(function() {
                                                            swal("요청이 거절 되었습니다", "해당 회원은 더 이상 본 프로젝트에 지원이 불가능합니다.", "error")
                                                         });
                     
                                                      } else {
                                                         swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                                         setTimeout(function() {
                                                            document.location.reload(true);
                                                         }, 1000);
                                                      }
                     
                                                   }
                                                });
                                             });
                                          }
                                       });
                                    })
                          
                          // 맴버 강퇴버튼
               $('.Member_Expulsion_Btn').unbind('click').bind('click', function() {
                  var getOutMember_id = $(this).children()[1].value;
                  var getOutMember_position = $(this).children()[2].value;
            
                  var alarm = {
                     "alarm_CODE": "PR_EX",
                     "url": project_id,
                     "member_ID": getOutMember_id,
                     "alarm_CONTENT": "프로젝트에서 추방당했습니다"
                  }

                  var data = {
                     alarm,
                     expel: {
                        "member_id": getOutMember_id,
                        "position_id": getOutMember_position,
                        "project_id": project_id
                     }
                       }         

                             swal({
                        title: "해당 멤버를 추방하시겠습니까?",
                        text: "추방된 회원은 본 프로젝트에 더 이상 지원 및 참여가 불가능합니다.",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                     })
                                .then((willDelete) => {
                        if (willDelete) {

                           $.ajax({
                              url: "/ajaxproject/getOutmember",
                              dataType: "html",
                              type: "post",
                              contentType: "application/json",
                              data: JSON.stringify(data),
                              success: function(responsedata) {

                                 if (responsedata == "true") {

                                    insertAlarm(JSON.stringify(alarm)).then(function() {
                                       swal("추방 되었습니다.", "", "success").then((value) => {
                                       $('#memberEdit').trigger('click');
                                    });
                                    });
                                    

                                 } else {
                                    swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                    setTimeout(function() {
                                       document.location.reload(true);
                                    }, 1000);
                                 }

                              }
                           });

                        } else {
                           return false;
                        }
                     });



                  })
                          
                          // 멤버 위임버튼
                          $('.handoverAuthority_Btn').unbind('click').bind('click', function(){
                             var HandOverMember_id = $(this).children()[1].value;
                             var HandOverMember_NickName = $(this).parent().parent().children()[0].children[1].children[0].innerHTML;
                             
                             
                             $('.Project_Apply_modal').empty();
                             
                             var table = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";

                             table += "<p class='ApplyMemberListTitle centerImpo'>"+ HandOverMember_NickName  +" 님에게 프로젝트 리더를 위임하시겠습니까?</p>"
                             
                             table += "<div class='ApplyBtn_Box'>"
                             table += "<input type='button' value='다음' class='HandOverMember_Next'><input type='button' value='취소' class='HandOverMember_No'>"
                             table += "</div>"
                             table += "<div class='ApplyPbox'>"
                             table += "<p class='Apply_p'><b>유의사항</b></p>"   
                             table += "<p class='Project_p Apply_p'>- 프로젝트를 위임 시 해당 회원에게 프로젝트가 귀속되며, 철회가 불가능하오니 신중히 <br> 선택하시기 바랍니다.</p>"
                             table += "<p class='Project_p Apply_p'>- 프로젝트를 위임 시 해당 프로젝트에서 진행 할 분야를 선택하여 하여야합니다.</p>"   
                             table += "<p class='Project_p Apply_p'>- 프로젝트를 탈퇴를 원할 경우 패널티가 발생하므로 유의하시기 바랍니다.</p>"   
                             table += "</div>";
                             
                             table += "</div></form>";
                             
                             $('.Project_Apply_modal').append(table);
                             $('.Project_Apply_modal').show(); 
                             /* ------------------------------------------------------------------------------ */
                             
                             // 모달 창 닫기
                               $('.HandOverMember_No').unbind('click').bind('click',function(){
                                     $('.Project_Apply_modal').empty();
                                     $('.Project_Apply_modal').hide();
                                  });
                             
                               $('.HandOverMember_Next').unbind('click').bind('click',function(){
                                  $('.Project_Apply_modal').empty();
                                  
                                  $.ajax({
                                        url:"/ajaxproject/PositionList",
                                        dataType:"html",
                                        success: function(responsedata){    
                                           
                                           responsedata = JSON.parse(responsedata);
                                           
                                           var HandOverMember_PositionBox = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";
                                 
                                           HandOverMember_PositionBox += "<p class='ApplyMemberListTitle centerImpo'>리더 해임 후 진행할 분야를 선택해주세요.</p>"
                                           HandOverMember_PositionBox += "<div>"
                                           HandOverMember_PositionBox += "<select class='HandOverMember_SelectBox' name='position_code'>"
                                           $.each(responsedata, function(i, position) {
                                              if(position.position_enabled == 1 ){
                                                 HandOverMember_PositionBox += "<option value='"+ position.position_id +"'>"+ position.position_name +"</option>";
                                              }
                                              
                                           })
                                           
                                          HandOverMember_PositionBox += "</select>"
                                           HandOverMember_PositionBox += "</div>"
                                           HandOverMember_PositionBox += "<div class='HandOverMemberBtn_Box'>"
                                            HandOverMember_PositionBox += "<input type='button' value='확인' class='HandOverMember_Ok'><input type='button' value='취소' class='HandOverMember_No'>"
                                           HandOverMember_PositionBox += "</div>"
                                           HandOverMember_PositionBox += "<div class='ApplyPbox'>"
                                           HandOverMember_PositionBox += "<p class='Apply_p'><b>유의사항</b></p>"   
                                           HandOverMember_PositionBox += "<p class='Project_p Apply_p'>- 프로젝트를 위임 시 해당 회원에게 프로젝트가 귀속되며, 철회가 불가능하오니 신중히 <br> 선택하시기 바랍니다.</p>"
                                           HandOverMember_PositionBox += "<p class='Project_p Apply_p'>- 프로젝트를 위임 시 해당 프로젝트에서 진행 할 분야를 선택하여 하여야합니다.</p>"   
                                           HandOverMember_PositionBox += "<p class='Project_p Apply_p'>- 프로젝트를 탈퇴를 원할 경우 패널티가 발생하므로 유의하시기 바랍니다.</p>"   
                                           HandOverMember_PositionBox += "</div>";
                                           HandOverMember_PositionBox += "</div></form>";
                                              
                                           $('.Project_Apply_modal').append(HandOverMember_PositionBox);
                                           
                                           $('.HandOverMember_No').unbind('click').bind('click',function(){
                                              $('.Project_Apply_modal').empty();
                                              $('.Project_Apply_modal').hide();
                                       
                                               });
                                           
                                           $('.HandOverMember_Ok').unbind('click').bind('click', function() {
                              
                              var alarm = {
                                       "alarm_CODE": "TM_CH",
                                       "url": project_id,
                                       "member_ID": HandOverMember_id,
                                       "alarm_CONTENT": "프로젝트의 팀장이 되었습니다"
                                    }
                              
                              var data = {
                                 alarm,
                                 handover:{
                                 "member_id": HandOverMember_id,
                                 "project_id": project_id,                                 
                                 "position_id": $('.HandOverMember_SelectBox').val()
                                 },
                                 "NewMember_id": login_memberid,
                              };

                              swal({
                                 title: "정말로 위임하시겠습니까?",
                                 text: "* 철회가 불가능 하오니 신중히 선택바랍니다.",
                                 icon: "warning",
                                 buttons: true,
                                 dangerMode: true,
                              })
                                 .then((willDelete) => {
                                    if (willDelete) {

                                       $.ajax({
                                          url: "/ajaxproject/toHandauth",
                                          dataType: "html",
                                          type: "post",
                                          contentType: "application/json",
                                          data: JSON.stringify(data),
                                          success: function(responsedata) {

                                             if (responsedata == "true") {
                                                
                                                insertAlarm(JSON.stringify(alarm)).then(function() {
                                                   swal("리더가 변경 되었습니다.", "", "success").then((value) => {
                                                   document.location.reload(true);
                                                });
                                                });
                                                
                                                

                                             } else {
                                                swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error");
                                                setTimeout(function() {
                                                   document.location.reload(true);
                                                }, 1000);
                                             }

                                          }
                                       });

                                    } else {
                                       return false;
                                    }
                                 });

                           });
                           // ----------
                        }
                     });
                  });
                  // -------------------

               })
               // -----------------

            }
         });
      }
      // -----------------------------------------------------------------------------

      $(this).attr('class', 'menuliClick');

   })

   // 페이지 시작 시 포르젝트 인포 보여주기
   $('#project_info').trigger('click');

   // 프로젝트 탈퇴
   $('.ProjectDeleteBtn').unbind('click').bind('click', function() {

      if (project_state == '완료') {
         return false;
      }

      $('.Project_Apply_modal').empty();

      var table = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";

      table += "<p class='ApplyMemberListTitle centerImpo'>프로젝트를 탈퇴 하시겠습니까?</p>"

      table += "<div class='ApplyBtn_Box'>"
      table += "<input type='button' value='예' class='Withdrawal_Ok'><input type='button' value='아니요' class='Withdrawal_No'>"
      table += "</div>"
      table += "<p class=''Project_p Apply_p'><b style='color: red;'>*</b> 예를 누를 시 유의사항에 동의한 것으로 간주됩니다.</p>"
      table += "<div class='ApplyPbox'>"
      table += "<p class='Apply_p'><b>유의사항</b></p>"
      table += "<p class='Project_p Apply_p'>- 프로젝트 리더가 프로젝트를 탈퇴할 시 프로젝트가 삭제가 됩니다.</p>"
      table += "<p class='Project_p Apply_p'>- 프로젝트 리더는 프로젝트에 멤버가 존재 할 경우 프로젝트를 탈퇴할 수 없습니다.</p>"
      table += "<p class='Project_p Apply_p'>- 진행중인 프로젝트를 탈퇴 시 패널티가 발생하오니 신중히 선택하시기 바랍니다.</p>"
      table += "<p class='Project_p Apply_p'>- 프로젝트를 탈퇴 시 해당 프로젝트에 지원 및 참여가 불가능합니다.</p>"
      table += "<p class='Project_p Apply_p'><b style='color: red;'>*</b> 패널티 : 30일 간 프로젝트 참여 및 지원이 불가능합니다.</p>"
      table += "</div>";

      table += "</div></form>";

      $('.Project_Apply_modal').append(table);
      $('.Project_Apply_modal').show();

      // 모달닫기
      $('.Withdrawal_No').unbind('click').bind('click',function(){
           $('.Project_Apply_modal').empty();
           $('.Project_Apply_modal').hide();
                                             
        });
      
      // 예 버튼   
      $('.Withdrawal_Ok').unbind('click').bind('click',function(){
          
           $.ajax({
              url:"/ajaxproject/projectWithdrawal",
              method:"DELETE",
              dataType:"html",
              data: {"project_id":project_id,
                    "state":project_state},
              success: function(responsedata){    
                 
                 
            if(responsedata == "isMember"){
            swal("현재 프로젝트에 멤버가 존재합니다.","","error").then((value) => {
                       document.location.reload(true);
                  });

               } else if (responsedata == "DeleteProjecet") {
                  swal("프로젝트가 삭제되었습니다", "", "success").then((value) => {
                     location.href = "../main";
                  });
               } else if (responsedata == "OutProjecet") {
                  swal("프로젝트에서 탈퇴하였습니다", "", "success").then((value) => {
                     location.href = "/project/list";
                  });
               } else {
                  swal("오류가 발생하였습니다.", "잠시후 다시 시도해주세요.", "error").then((value) => {
                     document.location.reload(true);
                  });
               }                 
                 
              }
           });  
                                             
        });
         
      
   })
   
   // 프로젝트 완료버튼
   $('.ProjectCompleteBtn').unbind('click').bind('click',function(){
      
      $('.Project_Apply_modal').empty();
                          
      var table = "<form class='ProjectApply'><div class='ProjectApplyMemberListDiv'>";

      table += "<p class='ApplyMemberListTitle centerImpo'>프로젝트가 종료되었나요?</p>"
      
      table += "<div class='ApplyBtn_Box'>"
      table += "<input type='button' value='예' class='complete_Ok'><input type='button' value='아니요' class='complete_No'>"
      table += "</div>"
      table += "<p class=''Project_p Apply_p'><b style='color: red;'>*</b> 예를 누를 시 프로젝트가 완료됨으로 변경됩니다.</p>"
      table += "<div class='ApplyPbox'>"
      table += "<p class='Apply_p'><b>참고 사항</b></p>"   
      table += "<p class='Project_p Apply_p'>- 프로젝트가 종료 후 함께 진행한 동료들에게 후기를 남겨주세요!</p>"
      table += "<p class='Project_p Apply_p'>- 후기를 작성시 10포인트가 적립됩니다.</p>"
      table += "</div>";
      
      table += "</div></form>";
      
      $('.Project_Apply_modal').append(table);
      $('.Project_Apply_modal').show();
      
      // 모달닫기
      $('.complete_No').unbind('click').bind('click',function(){
           $('.Project_Apply_modal').empty();
           $('.Project_Apply_modal').hide();
                                             
        });
      
      // 완료   
      $('.complete_Ok').unbind('click').bind('click',function(){   
         
          $.ajax({
              url:"/ajaxproject/projectcomplete",
              method: "POST",
              dataType:"html",
              data: {"project_id":project_id,
                    "p_state":project_state},
              success: function(responsedata){    
                 if(responsedata == "true"){
                    swal("프로젝트가 종료되었습니다.","수고하셨습니다.","success").then((value) => {
                       document.location.reload(true);
                  });
                  
               }else{
                  swal("오류가 발생하였습니다.","잠시후 다시 시도해주세요.","error").then((value) => {
                       document.location.reload(true);
                  });
               }
                 
              }
           });  
        });
   })
      
})