<<<<<<< HEAD
/* 북마크 */
function BookMarking(projectid) {
		var id = "#"+projectid;
		$.ajax({
            url:'/ajaxproject/bookmark?project_id='+projectid,
            type: 'get',
            dataType:"text",
            success:function(result){
	
                
                if(result == "insert") {
					swal("" , "북마크 내역은 북마크페이지에서도 확인하실 수 있습니다." ,"success");
					$(id).removeClass("no_marking");
					$(id).addClass("marking");
                } else {
               	 	swal("" , "북마크를 해제하셨습니다." ,"success");
               	 	
               	 	$(id).removeClass("marking");
					$(id).addClass("no_marking");
                }
            }
		})
=======
/* 북마크 */
function BookMarking(projectid) {
		var id = "#"+projectid;
		$.ajax({
            url:'/ajaxproject/bookmark?project_id='+projectid,
            type: 'get',
            dataType:"text",
            success:function(result){
	
                
                if(result == "insert") {
					swal("" , "북마크 내역은 북마크페이지에서도 확인하실 수 있습니다." ,"success");
					$(id).removeClass("no_marking");
					$(id).addClass("marking");
                } else {
               	 	swal("" , "북마크를 해제하셨습니다." ,"success");
               	 	
               	 	$(id).removeClass("marking");
					$(id).addClass("no_marking");
                }
            }
		})
>>>>>>> master
	}