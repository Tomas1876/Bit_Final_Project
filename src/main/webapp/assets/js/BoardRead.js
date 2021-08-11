//댓글 Byte 수 체크 제한
function fnChkByte(obj, maxByte)
{
    var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4)
        {
            rbyte += 2;                                         //한글2Byte
        }
        else
        {
            rbyte++;                                            //영문 등 나머지 1Byte
        }


        if(rbyte <= maxByte)
        {
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }


     if(rbyte > maxByte)
     {
  // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
  swal("댓글은 최대 " + maxByte + "byte를 초과할 수 없습니다.", "", "warning");
  
  str2 = str.substr(0,rlen);                                  //문자열 자르기
  obj.value = str2;
  fnChkByte(obj, maxByte);
     }
     else
     {
        document.getElementById('byteInfo').innerText = rbyte;
     }
}

//수정 댓글 Byte 수 체크 제한
function fnChkByte1(obj, maxByte)
{
    var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4)
        {
            rbyte += 2;                                         //한글2Byte
        }
        else
        {
            rbyte++;                                            //영문 등 나머지 1Byte
        }


        if(rbyte <= maxByte)
        {
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }


     if(rbyte > maxByte)
     {
  // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
  swal("댓글은 최대 " + maxByte + "byte를 초과할 수 없습니다.", "", "warning");
  str2 = str.substr(0,rlen);                                  //문자열 자르기
  obj.value = str2;
  fnChkByte(obj, maxByte);
     }
     else
     {
        document.getElementById('byteInfo1').innerText = rbyte;
     }
}
//대댓글 Byte 수 체크 제한
function fnChkByte2(obj, maxByte)
{
    var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4)
        {
            rbyte += 2;                                         //한글2Byte
        }
        else
        {
            rbyte++;                                            //영문 등 나머지 1Byte
        }


        if(rbyte <= maxByte)
        {
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }


     if(rbyte > maxByte)
     {
  // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
  swal("댓글은 최대 " + maxByte + "byte를 초과할 수 없습니다.", "", "warning");
  str2 = str.substr(0,rlen);                                  //문자열 자르기
  obj.value = str2;
  fnChkByte(obj, maxByte);
     }
     else
     {
        document.getElementById('byteInfo2').innerText = rbyte;
     }
}
// 댓글유효성검사
function fn_formSubmit(){
// 	var validateMEMBER_ID = document.form1.MEMBER_ID.value.replace(/\s|　/gi, '');
	var validateREPLY_CONTENT = document.form1.REPLY_CONTENT.value.replace(/\s|　/gi, '');
	var form1 = document.form1;
	
// 	if (validateMEMBER_ID == "") {
// 		swal("작성자를 입력해주세요.", "", "warning");
// 		form1.MEMBER_ID.focus();
// 		return;
// 	}
	if (validateREPLY_CONTENT == "") {
		swal("글 내용을 입력해주세요." , "", "warning");
		form1.REPLY_CONTENT.focus();
		return;
	}
	form1.submit();	
}
// 댓글 삭제
function fn_replyDelete(REPLY_ID){
	if (!confirm("삭제하시겠습니까?")) {
		return;
	}
	var form = document.form2;

	form.action="replydelete";
	form.REPLY_ID.value=REPLY_ID;
	form.submit();
} 
// 댓글 수정 + 취소
var updateReno = updateRememo = null;
function fn_replyUpdate(REPLY_ID){
	hideDiv("replyDialog");
	
	var form = document.form2;
	var reply = document.getElementById("reply"+REPLY_ID);
	var replyDiv = document.getElementById("replyDiv");
	replyDiv.style.display = "";
	
	if (updateReno) {
		document.body.appendChild(replyDiv);
		var oldReno = document.getElementById("reply"+updateReno);
		oldReno.innerText = updateRememo;
	} 
	
	form.REPLY_ID.value=REPLY_ID;
	form.REPLY_CONTENT.value = reply.innerText;
	reply.innerText ="";
	reply.appendChild(replyDiv);
	updateReno   = REPLY_ID;
	updateRememo = form.REPLY_CONTENT.value;
	form.REPLY_CONTENT.focus();
} 

// 댓글 수정 유효성검사
function fn_replyUpdateSave(){
	var validateREPLY_CONTENT = document.form2.REPLY_CONTENT.value.replace(/\s|　/gi, '');
	var form = document.form2;
	if (validateREPLY_CONTENT == "") {
		swal("글 내용을 입력해주세요.", "", "warning");
		form.REPLY_CONTENT.focus();
		return;
	}
	
	form.action="replysave";
	form.submit();	
} 

function fn_replyUpdateCancel(){
	var form = document.form2;
	hideDiv("replyDiv");
	
	var oldReno = document.getElementById("reply"+updateReno);
	oldReno.innerText = updateRememo;
	updateReno = updateRememo = null;
} 
// (빈공간에 div 만들기)
function hideDiv(id){
	var div = document.getElementById(id);
	div.style.display = "none";
	document.getElementById("replySpace").appendChild(div);
}

function fn_replyReply(REPLY_ID){
	hideDiv("replyDiv");
	
	var form = document.form3;
	var reply = document.getElementById("reply"+REPLY_ID);
	var replyDia = document.getElementById("replyDialog");
	replyDia.style.display = "";
	
	if (updateReno) {
		fn_replyUpdateCancel();
	} 
	
	form.REPLY_CONTENT.value = "";
	form.REPLY_REF.value=REPLY_ID;
	reply.appendChild(replyDia);
	form.MEMBER_ID.focus();
} 
function fn_replyReplyCancel(){
	hideDiv("replyDialog");
} 

function fn_replyReplySave(){
	var validateREPLY_CONTENT = document.form3.REPLY_CONTENT.value.replace(/\s|　/gi, '');
	var form = document.form3;
	
// 	if (form.MEMBER_ID.value=="") {
// 		alert("작성자를 입력해주세요.");
// 		form.MEMBER_ID.focus();
// 		return;
// 	}
	if (validateREPLY_CONTENT =="") {
		swal("글 내용을 입력해주세요.", "", "warning");
		form.REPLY_CONTENT.focus();
		return;
	}
	
	form.action="replysave";
	form.submit();	
}
