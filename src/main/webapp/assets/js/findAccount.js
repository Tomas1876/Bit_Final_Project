<<<<<<< HEAD
//이메일찾기
    $('#findEmailBtn').click(function() {
        let userName = $('#userName').val();
        let userPhone = $('#userPhone').val();
        userPhone = userPhone.replace("-", "")

        if (userName == '') {
            swal("이름을 입력해주세요." , "" ,"error");
            $("#userName").focus();
            return;
        }else if (userPhone == '') {
			swal("핸드폰번호를 입력해주세요." , "" ,"error");
            $("#userPhone").focus();
            return;
		}

        $.ajax({
            url: "register/ajax/findEmail",
            data: {
                userName: userName,
                userPhone: userPhone
            },
            type: "get",
            dataType: "text",
            success: function(data) {
				console.log(data);
				if (data == 'noExist') {
					 swal("존재하지 않는 사용자입니다." , "이름과 핸드폰번호를 다시 확인해주세요" ,"error");
				} else {
					
					$(".userCutEmail").text("[ " + data + "]");
					$(".findEmailModal").css("display", "flex");
					
					$('#userName').val("");
					$('#userPhone').val("");
					
				}
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
    
    $('.modal_XBtn').click(function() {
		$(".findEmailModal").css("display", "none");
	});
	
	
   //비밀번호
    $('#findPwdBtn').click(function() {
        let userName = $('#userPwdName').val().trim();
        let userEmail = $('#userEmail').val().trim();

        if (userName == '') {
            swal("이름을 입력해주세요." , "" ,"error");
            $("#userPwdName").focus();
            return;
        }else if (userEmail == '') {
			swal("이메일을 입력해주세요." , "" ,"error");
            $("#userEmail").focus();
            return;
		}

        $.ajax({
            url: "register/ajax/findPwd",
            data: {
                userName: userName,
                userEmail: userEmail
            },
            type: "get",
            dataType: "text",
            success: function(data) {
				console.log(data);
				if (data == 'noExist') {
					 swal("존재하지 않는 사용자입니다." , "이름과 이메일주소를 다시 확인해주세요" ,"error");
				} else {
					
					swal("📨" , "가입하신 이메일로 메일을 전송합니다.");
					
					$("#userPwdName").css("display", "none");
					$("#userEmail").css("display", "none");
					$("#findPwdBtn").css("display", "none");
					
					
					$("#userConfirm").css("display", "block");
					$("#userConfirmBtn").css("display", "inline-block");
					
					$.ajax({
                        url: "register/findPwdEmailSend.ajax",
                        data: {
                            userEmail: userEmail
                        },
                        type: "post",
                        dataType: "text",
                        success: function(data) {
                            console.log(data);
                            
                            let result = data.split("-");
                            if (result[0] == 'fail') {

                                swal("인증 메일 발송에 실패했습니다." , "" ,"error");
                                
                            } else {
                               
                                dice = result[1];
                                console.log("랜덤 숫자 : ",dice);
                                
                                //이메일 인증번호 확인
                                $("#userConfirmBtn").click(function(){
                                    
                                    $("#userConfirm").val();
                                    console.log("인증확인 클릭");
                                    console.log(dice);
                                    
                                    if(dice == $("#userConfirm").val()){
                                        swal("인증이 완료되었습니다." , "" ,"success");
                                        
                                        $("#userConfirm").css("display", "none");
										$("#userConfirmBtn").css("display", "none");
										
										$("#confirmEnd").css("display", "inline-block");
										$("#editPwdModal").css("display", "flex");
										
										
        								
        								$("#newPwdBtn").click(function(){
	
											let newPwd = $('#newPwd').val();
	        								let newPwdCheck = $('#newPwdCheck').val();
											
	        								if (newPwd == '') {
									            swal("비밀번호를 입력해주세요" , "" ,"error");
									            $("#newPwd").focus();
									            checking = false;
									            return;
									        }else if (newPwdCheck == '') {
												swal("비밀번호를 한번 더 입력해주세요." , "" ,"error");
									            $("#newPwdCheck").focus();
									            checking = false;
									            return;
											}
											
											//비밀번호 유효성 
								            let num = newPwd.search(/[0-9]/g);
								            let eng = newPwd.search(/[a-z]/ig);
								    
								            if (newPwd.length < 8 || newPwd.length > 13) {
								    
								                swal("비밀번호는 8-20자리 이내로 입력하세요." , "" ,"error");
								                $("#newPwd").focus();
								                checking = false;
								                return;
								    
								            } else if (newPwd.search(/\s/) != -1) {
								    
								                swal("비밀번호는 공백을 입력할 수 없습니다." , "" ,"error");
								                checking = false;
								                $("#newPwd").focus();
								                checking = false;
								                return;
								    
								            } else if (num < 0 || eng < 0 ) {
								    
								                swal("영문, 숫자를 포함하여 입력하세요." , "" ,"error");
								                $("#password").focus();
								                checking = false;
								                return;
								            }
								            
								            if(newPwd != newPwdCheck){
												swal({
								                    title: "비밀번호가 일치하지 않습니다",
								                    icon: "error"
								                });
								                $("#newPwdCheck").focus();
								                checking = false;
								                return;
											}
											
											
											
											$.ajax({
									                url:"register/editPwd.ajax",
									                data:{
									                   newPwd : newPwd,
									                   userEmail : userEmail
									                },
									                type:"get",
									                dataType:"text",
									                success:function(data){
														
														if(data == "success"){
															swal("수정되었습니다" , "변경한 비밀번호로 로그인해주세요!" ,"success");
															$(".pwdModalInfo").css("display", "none");
															$(".modalLinkSecPwd").css("display", "block");
						
														}
													}
													
												})
											
										});
                                        
                                    } else if( $("#userConfirm").val() == ""){
                                        swal("인증번호를 입력해주세요." , "" ,"error");
                                    } else if(dice != $("#userConfirm").val()){
                                        swal("다시 입력해주세요." , "" ,"error");
                                    }
                                    
                                    
                                });
                                
                            }
                        },
                        error: function(error) {
                            console.log(error);
                        }
                    });
					
				}
            },
            error: function(error) {
                console.log(error);
            }
        });
=======
//이메일찾기
    $('#findEmailBtn').click(function() {
        let userName = $('#userName').val();
        let userPhone = $('#userPhone').val();
        userPhone = userPhone.replace("-", "")

        if (userName == '') {
            swal("이름을 입력해주세요." , "" ,"error");
            $("#userName").focus();
            return;
        }else if (userPhone == '') {
			swal("핸드폰번호를 입력해주세요." , "" ,"error");
            $("#userPhone").focus();
            return;
		}

        $.ajax({
            url: "register/ajax/findEmail",
            data: {
                userName: userName,
                userPhone: userPhone
            },
            type: "get",
            dataType: "text",
            success: function(data) {
				console.log(data);
				if (data == 'noExist') {
					 swal("존재하지 않는 사용자입니다." , "이름과 핸드폰번호를 다시 확인해주세요" ,"error");
				} else {
					
					$(".userCutEmail").text("[ " + data + "]");
					$(".findEmailModal").css("display", "flex");
					
					$('#userName').val("");
					$('#userPhone').val("");
					
				}
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
    
    $('.modal_XBtn').click(function() {
		$(".findEmailModal").css("display", "none");
	});
	
	
   //비밀번호
    $('#findPwdBtn').click(function() {
        let userName = $('#userPwdName').val().trim();
        let userEmail = $('#userEmail').val().trim();

        if (userName == '') {
            swal("이름을 입력해주세요." , "" ,"error");
            $("#userPwdName").focus();
            return;
        }else if (userEmail == '') {
			swal("이메일을 입력해주세요." , "" ,"error");
            $("#userEmail").focus();
            return;
		}

        $.ajax({
            url: "register/ajax/findPwd",
            data: {
                userName: userName,
                userEmail: userEmail
            },
            type: "get",
            dataType: "text",
            success: function(data) {
				console.log(data);
				if (data == 'noExist') {
					 swal("존재하지 않는 사용자입니다." , "이름과 이메일주소를 다시 확인해주세요" ,"error");
				} else {
					
					swal("📨" , "가입하신 이메일로 메일을 전송합니다.");
					
					$("#userPwdName").css("display", "none");
					$("#userEmail").css("display", "none");
					$("#findPwdBtn").css("display", "none");
					
					
					$("#userConfirm").css("display", "block");
					$("#userConfirmBtn").css("display", "inline-block");
					
					$.ajax({
                        url: "register/findPwdEmailSend.ajax",
                        data: {
                            userEmail: userEmail
                        },
                        type: "post",
                        dataType: "text",
                        success: function(data) {
                            console.log(data);
                            
                            let result = data.split("-");
                            if (result[0] == 'fail') {

                                swal("인증 메일 발송에 실패했습니다." , "" ,"error");
                                
                            } else {
                               
                                dice = result[1];
                                console.log("랜덤 숫자 : ",dice);
                                
                                //이메일 인증번호 확인
                                $("#userConfirmBtn").click(function(){
                                    
                                    $("#userConfirm").val();
                                    console.log("인증확인 클릭");
                                    console.log(dice);
                                    
                                    if(dice == $("#userConfirm").val()){
                                        swal("인증이 완료되었습니다." , "" ,"success");
                                        
                                        $("#userConfirm").css("display", "none");
										$("#userConfirmBtn").css("display", "none");
										
										$("#confirmEnd").css("display", "inline-block");
										$("#editPwdModal").css("display", "flex");
										
										
        								
        								$("#newPwdBtn").click(function(){
	
											let newPwd = $('#newPwd').val();
	        								let newPwdCheck = $('#newPwdCheck').val();
											
	        								if (newPwd == '') {
									            swal("비밀번호를 입력해주세요" , "" ,"error");
									            $("#newPwd").focus();
									            checking = false;
									            return;
									        }else if (newPwdCheck == '') {
												swal("비밀번호를 한번 더 입력해주세요." , "" ,"error");
									            $("#newPwdCheck").focus();
									            checking = false;
									            return;
											}
											
											//비밀번호 유효성 
								            let num = newPwd.search(/[0-9]/g);
								            let eng = newPwd.search(/[a-z]/ig);
								    
								            if (newPwd.length < 8 || newPwd.length > 13) {
								    
								                swal("비밀번호는 8-20자리 이내로 입력하세요." , "" ,"error");
								                $("#newPwd").focus();
								                checking = false;
								                return;
								    
								            } else if (newPwd.search(/\s/) != -1) {
								    
								                swal("비밀번호는 공백을 입력할 수 없습니다." , "" ,"error");
								                checking = false;
								                $("#newPwd").focus();
								                checking = false;
								                return;
								    
								            } else if (num < 0 || eng < 0 ) {
								    
								                swal("영문, 숫자를 포함하여 입력하세요." , "" ,"error");
								                $("#password").focus();
								                checking = false;
								                return;
								            }
								            
								            if(newPwd != newPwdCheck){
												swal({
								                    title: "비밀번호가 일치하지 않습니다",
								                    icon: "error"
								                });
								                $("#newPwdCheck").focus();
								                checking = false;
								                return;
											}
											
											
											
											$.ajax({
									                url:"register/editPwd.ajax",
									                data:{
									                   newPwd : newPwd,
									                   userEmail : userEmail
									                },
									                type:"get",
									                dataType:"text",
									                success:function(data){
														
														if(data == "success"){
															swal("수정되었습니다" , "변경한 비밀번호로 로그인해주세요!" ,"success");
															$(".pwdModalInfo").css("display", "none");
															$(".modalLinkSecPwd").css("display", "block");
						
														}
													}
													
												})
											
										});
                                        
                                    } else if( $("#userConfirm").val() == ""){
                                        swal("인증번호를 입력해주세요." , "" ,"error");
                                    } else if(dice != $("#userConfirm").val()){
                                        swal("다시 입력해주세요." , "" ,"error");
                                    }
                                    
                                    
                                });
                                
                            }
                        },
                        error: function(error) {
                            console.log(error);
                        }
                    });
					
				}
            },
            error: function(error) {
                console.log(error);
            }
        });
>>>>>>> master
    });