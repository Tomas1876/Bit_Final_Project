
 $(document).ready(function(){

//태그 추가하기
$(".form-control").keydown(function(key){
    var input_id = $(this).attr('id'); // 현재 key가 눌려진 input태그의 id가져오기
    var input_param
    if(input_id=="skill_input"){        //input태그 id가 skill_input일때 skill 목록에 추가예정
        input_param="skill";
    }
    else if(input_id=="field_input"){   //input태그 id가 field_input일때 field 목록에 추가예정
        input_param="field";
    }
    else if(input_id=="position_input"){ //input태그 id가 position_input일때 position 목록에 추가예정
        input_param="position";
    }
    
          if (key.keyCode == 13) {// keyCode 13 : Enter키
            var this_name = $(this).val(); // input태그의 값 가져오기
            
            // 위에서 결정된 input_param값에 따라서 skill / field / position 영역에 추가됨
            // input태그의 name이 input_param+_name인 모든 input태그 목록을 가져옴
            var tagslist = document.querySelectorAll('input[name='+input_param+'_name]');
            var check=false; 
            
            if(this_name.trim()==""){ //비어있는 input태그 걸러내기
                swal({
                    text:"기술 이름을 입력해주세요.",
                    icon:"warning"
                 })
                return false;
            }
            else{
                //모든 위에서 가져온 taglist를 반복문돌면서 중복이 있는지 체크
            $.each(tagslist, function(index,val){  
                console.log(val.value);
                console.log(this_name);
                if(val.value == this_name){
                    check=true; 
                    swal({
                            text:"중복되는 이름이 존재합니다.",
                            icon:"error"
                         })
                         .then(()=>{
                            $('#'+input_param+'_input').val('');
                         });
                }
            })
            }
                //위에서 중복되는 태그가 없을때 처리
            if(!check){
                $('#'+input_param+'_input').val('');
                 //새로만들어진 tag는 new라는 클래스를 붙여준다.
                 let tags="<div class='tags "+input_param+"_tags "+input_param+"_new'>"
                 tags +="<input type='text' name='"+input_param+"_name' value='"+this_name+"' readonly='readonly'>"
                 tags += "<input type='text' name='"+input_param+"_enabled' value='1' hidden=''>"
                 tags +="</div>"
                 $('#'+input_param+'_tagarea').append(tags);
                 //현재 클릭한 영역에만 붙일수 있음.
             } 
    }
})
    // tags라는 class를 클릭했을때 처리 : 활성화 -> 비활성화
 $(document).on("click",".tags",function(){
     // 마찬가지로 현재 클릭된 영역이 skill / field / position 인지 걸름.
    var tags_param
    if($(this).hasClass('skill_tags')){
        tags_param="skill";
    }
    else if($(this).hasClass('field_tags')){
        tags_param="field";
    }
    else if($(this).hasClass('position_tags')){
        tags_param="position";
    }
    //새로만들어진 태그가 아니라면
    if(!$(this).hasClass(tags_param+"_new")){
        //tags_param + updated class를 붙여줌
        $(this).addClass(tags_param+"_updated");
    }
    
    var update = $(this).addClass(tags_param+"_clicked")[0].children[1];
    $(update).attr("value","0"); // 비활성화라는 0을 value로 넣어줌
    
    //tags 관련 class 지우기
    $(this).removeClass("tags");
    $(this).removeClass(tags_param+"_tags");

    //clicked클래스 붙이기
     $(this).addClass("clicked");

     //해당 영역에 추가해준다.
    $("#"+tags_param+"_selectedarea").append($(this));
});

  //cliked라는 class를 클릭했을때 처리 : 비활성화 -> 활성화
  $(document).on("click",".clicked",function(){
      // 마찬가지로 현재 클릭된 영역이 skill / field / position 인지 걸름.
    var clicked_param
    if($(this).hasClass('skill_clicked')){
        clicked_param="skill";
    }
    else if($(this).hasClass('field_clicked')){
        clicked_param="field";
    }
    else if($(this).hasClass('position_clicked')){
        clicked_param="position";
    }

        //새로만들어진 태그가 아니라면
        if(!$(this).hasClass(clicked_param+"_new")){
            //clicked_param + _updated 라는 클래스 붙여줌
            $(this).addClass(clicked_param+"_updated");
        }

      var update = $(this).addClass(clicked_param+"_tags")[0].children[1];
      //활성화라는 "1"을 value로 넣어줌
      $(update).attr("value","1");
        
        //clicked관련 class를 지움
        $(this).removeClass("clicked");
        $(this).removeClass(clicked_param+"_clicked");

        //tags클래스 붙여주기
        $(this).addClass("tags");
      
        //해당 영역에 추가해준다.
        $("#"+clicked_param+"_tagarea").append($(this));
  });

  //수정버튼(updateBtn)이 눌렸을때 처리
$(document).on("click",".updateBtn",function(){
    // 현재 클릭된 영역이 skill / field / position 인지 걸름.
    var btn_id = $(this).attr('id');
    var btn_param
    if(btn_id=="skill_Btn"){
        btn_param="skill";
    }
    else if(btn_id=="field_Btn"){
        btn_param="field";
    }
    else if(btn_id=="position_Btn"){
        btn_param="position";
    }
    // btn_param + _new라는 class를 가지고있는 태그를 모두 가져옴
    // btn_param + _updated라는 class를 가지고있는 태그를 모두 가져옴
    var newtags = document.querySelectorAll('.'+btn_param+'_new');
    var updatedtags = document.querySelectorAll('.'+btn_param+'_updated');
    var new_arr=[];
    var update_arr=[];
    if(newtags.length>0 || updatedtags.length>0){
        
        // 새로 추가된 태그들 1개이상 들어있을때
        if(newtags.length>0){
            
            $.each(newtags, function(index, value){
                var insert_json={};
                // tags안의 input태그를 하나씩 돌면서 name과 value를 객체에 넣어준다.
                $.each(value.children, function(ind,atr){
                    //key : name   -   value : value
                    insert_json[atr.name]=atr.value;
                })
                // 완성된 객체를 배열에 push
                new_arr.push(insert_json)
            })
        }
    
        
        //활성화 여부가 업데이트된 태그들
        if(updatedtags.length>0){
            $.each(updatedtags, function(index, value){
                var update_json={};
                // tags안의 input태그를 하나씩 돌면서 name과 value를 객체에 넣어준다.
                $.each(value.children, function(ind,atr){
                    update_json[atr.name]=atr.value;
                })
                // 완성된 객체를 배열에 push
                update_arr.push(update_json);
            })
        }

        var data={}; // 서버에 보낼 객체
        data["new"]=new_arr; //key : "new"   -   value : new_arr
        data["update"]=update_arr;//key : "update"   -   value : update_arr
        data["code"]=btn_param;//key : "code"   -   value : btn_param(skill/field/position)
        $.ajax({
            type:"put",
            url:"/ajaxadmin/site",
            contentType: "application/json",
            data:JSON.stringify(data),//JSON string으로 서버에 보냄
            dataType:"json",
            success:function(result){
                //정상적으로 작동시 추가된 개수, 수정된 개수를 띄워주고 페이지 새로고침
                swal({
                        text:"추가 : "+result.add+"개\n"
                            +"수정 : "+result.update+"개\n"
                            +"완료 되었습니다.",
                        icon:"success"
                    })
                    .then(()=>{
                        window.location.reload();
                    });
            }
        })
    }
	else{
	      swal({
	            text:"수정할 내역이 없습니다.",
	            icon:"error"
	         })
	}
})
})