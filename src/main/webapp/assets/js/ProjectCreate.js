$(function() {
			
			
			
			var memberNum = 1;

			// 포지션 추가 버튼
			$('.PositionAdd').click(function() {

				if (memberNum < 10) {
					$('#PositionBox').append(selectBox);
					memberNum++;
				}

				if (memberNum == 10) {
					swal("멤버는 10명이상 구인이 불가능합니다.", "", "error");
				}

			})

			// 포지션 삭제 버튼
			$('.PositionDel').click(function() {
				if (memberNum > 1) {
					var DelNum = $('.project_boxdiv').last()[0].children[1].children[1];
					
					
					
					memberNum -= $(DelNum)[0].value;
					
					
					$('.project_boxdiv').last().remove();
					
				}

			})

			// 맴버 + - 버튼 클릭 이벤트
			$(document).off("click").on('click', '.BtnWarp', function() {

				var UpBtn = $(this)[0].children[0];
				var DownBtn = $(this)[0].children[2];
				var Count = $(this)[0].children[1];

				// + 이벤트
				$(UpBtn).off("click").on("click", function() {

					if (memberNum < 10) {

						var Count_ = parseInt($(Count).val());
						
						$(Count).val(Count_ + 1);

						memberNum++;

					} else {
						swal("맴버는 10명이상의 구인이 불가능합니다.", "", "error");
					}

				})

				// - 이벤트
				$(DownBtn).off("click").on("click", function() {
				

					if (parseInt($(Count).val()) > 1) {
						
						
						var Count_ = parseInt($(Count).val());
						
						$(Count).val(Count_ - 1);

						memberNum--;
					}

				})

			})
			
			
			// 스킬 셀렉트
			//클릭하면 태그 선택
	        $(document).on("click",".tags",function(){
				
                $(this).addClass("clicked");
                
                var addSkill = $(this).addClass("clicked")[0].children[1];
                $(addSkill).attr("name","skil_code");
                
                $(this).removeClass("tags");
                $("#selectedarea").append($(this));
	        });

              //클릭하면 태그 선택 해제
              $(document).on("click",".clicked",function(){
                    
	              var addSkill = $(this).addClass("clicked")[0].children[1];
	              $(addSkill).attr("name","");
		            
                  $(this).removeClass();
                  $(this).addClass("tags");
                  
                  $("#tagarea").append($(this));
              });




			// 사진클릭시 파일 실행
             $('#target_img').click(function () {
               
                 $('#file').click();
             }); 
             
             
             // 사진 변경시 이미지 태그 변경
             $('#file').change(function(event) {
             
	            var file = $(event)[0].target.files;
	            
	            
				// 정규식으로 확장자 체크
				if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
				
				 swal("이미지 파일만 업로드 가능합니다.","", "error");
				
				
				}else{
				  	reader = new FileReader();

	         		reader.onload = function(event) {
	         			$('#target_img').attr("src", event.target.result);
						
	         		}
	
	         		reader.readAsDataURL(event.target.files[0]);
			 	}
         	
         		
         	})
			
			
			
			// 버튼 클릭 이벤트
			$('.CreateBtn').click(function(){
				var title = $('.ProjectTitle').val();
				var contents = $('.ProjectContents').val(); 
				var file = $('#file').val();
				var skillBox = $('#selectedarea').children().length;
				
				if(title == "" ){
					swal("제목을 작성해주세요." , "" ,"error");
				}else if(contents == ""){
					swal("프로젝트 내용을 작성해주세요." , "" ,"error");
				}else if(file == ""){
					swal("프로젝트에 사용될 이미지를 첨부해주세요." , "" ,"error");
				}else if(skillBox == "0"){
					swal("1개이상의 기술 스텍을 선택해주세요." , "" ,"error");
				}else{
						swal({
						  title: "프로젝트를 생성하시겠습니까?",
						  text: "* 프로젝트 생성시 50포인트가 소모됩니다.",
						  icon: "warning",
						  buttons: true,
						  dangerMode: true,
						})
						.then((willDelete) => {
						  if (willDelete) {
							  $('.Project_createForm').submit();
						  } else {
							  return false;
						  }
						});
				
				
				}
			})
			
			
			
			
})
			
			
			
			
		