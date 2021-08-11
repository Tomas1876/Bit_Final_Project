$(function() {


   // 스킬 셀렉트
   //클릭하면 태그 선택
   $(document).on("click", ".tags", function() {

      $(this).addClass("clicked");

      var addSkill = $(this).addClass("clicked")[0].children[1];
      $(addSkill).attr("name", "skill_code");

      $(this).removeClass("tags");
      $("#selectedarea").append($(this));
   });

   //클릭하면 태그 선택 해제
   $(document).on("click", ".clicked", function() {

      var addSkill = $(this).addClass("clicked")[0].children[1];
      $(addSkill).attr("name", "");

      $(this).removeClass();
      $(this).addClass("tags");

      $("#tagarea").append($(this));
   });




   // 사진클릭시 파일 실행
   $('#target_img').click(function() {

      $('#file').click();
   });


   // 사진 변경시 이미지 태그 변경
   $('#file').change(function(event) {

      var file = $(event)[0].target.files;

      // 정규식으로 확장자 체크
      if (!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) {

         swal("이미지 파일만 업로드 가능합니다.", "", "error");


      } else {
         reader = new FileReader();

         reader.onload = function(event) {
            $('#target_img').attr("src", event.target.result);

         }

         reader.readAsDataURL(event.target.files[0]);
      }


   })

   // 상태 정보 바꿀시 변경 이벤트
   $('#status').change(function() {
      var status = $('#status').val();
      if (status == '모집중') {
         $('#status').attr("class", "statusOpenTag")
      } else {
         $('#status').attr("class", "statusGoingTag")
      }

   })


   // 버튼 클릭 이벤트
   $('.EditBtn').click(function() {
      var title = $('.ProjectTitle').val();
      var contents = $('.ProjectContents').val();
      var status = $('#status').val();
      var skillBox = $('#selectedarea').children().length;
      var formData = new FormData($('.Project_EditForm')[0]);
      var SkillList = [];

      $("#selectedarea > div > input[name='skill_code']").each(function(i) {
         SkillList.push($(this).val());
      })


      if (title == "") {
         swal("제목을 작성해주세요.", "", "error");
      } else if (contents == "") {
         swal("프로젝트 내용을 작성해주세요.", "", "error");
      } else if (skillBox == "0") {
         swal("1개이상의 기술 스텍을 선택해주세요.", "", "error");
      } else {

         if (status == "진행중") {

            swal({
               title: "안내",
               text: "프로젝트 상태를 진행 중으로 변경 시 더 이상 수정이 불가능합니다.",
               icon: "warning",
               buttons: true,
               dangerMode: true,
            })
               .then((willDelete) => {
                  if (willDelete) {

                     $.ajax({
                        type: "post",
                        enctype: 'multipart/form-data',
                        url: "/ajaxproject/editAjax",
                        data: formData,
                        processData: false,
                        contentType: false,
                        traditional: true,
                        success: function(data) {
                           if (data == "true"){
                                 
                              var alarm = {
                                 "alarm_CODE": "PR_UP",
                                 "url": project_id,
                                 "members":memberlist,
                                 "alarm_CONTENT": "참여중이신 프로젝트의 상태가 변경되었습니다"
                              }
                              
                              console.log(alarm);
                              //swal("수정 되었습니다.", "", "success")
                              makeAlarm(JSON.stringify(alarm)).then(function(){
                                    window.location.href = "/project/detail?project_id=" + project_id;
                                 });

                           } else {
                              swal("알수없는 에러가 발생하였습니다.", "잠시 후 다시 시도해주세요.", "error")
                                 .then((value) => {
                                    window.location.href = "/project/detail?project_id=" + project_id;
                                 });
                           }

                        }
                     });

                  } else {
                     return false;
                  }
               });

         } else {

            swal({
               title: "프로젝트를 수정하시겠습니까?",
               text: "",
               icon: "warning",
               buttons: true,
               dangerMode: true,
            })
               .then((willDelete) => {
                  if (willDelete) {

                     $.ajax({
                        type: "post",
                        enctype: 'multipart/form-data',
                        url: "/ajaxproject/editAjax",
                        data: formData,
                        processData: false,
                        contentType: false,
                        traditional: true,
                        success: function(data) {
                           if (data == "true") {
                              swal("수정 되었습니다.", "", "success")
                                 .then((value) => {
                                    window.location.href = "/project/detail?project_id=" + project_id;
                                 });

                           } else {
                              swal("알수없는 에러가 발생하였습니다.", "잠시 후 다시 시도해주세요.", "error")
                                 .then((value) => {
                                    window.location.href = "/project/detail?project_id=" + project_id;
                                 });
                           }

                        }
                     })

                  } else {
                     return false;
                  }
               });
         }

      }
   })




})



