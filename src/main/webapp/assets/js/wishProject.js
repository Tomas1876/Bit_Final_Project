let card;
/* 북마크 */
function BookMarking(projectid) {
		swal({
			  title: "북마크를 해제하시겠습니까?",
			  text: "해제하시면 북마크 목록에서 확인하실 수 없습니다.",
			  icon: "warning",
			  dangerMode: true,
			  buttons: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
				
				/* 확인버튼 클릭시 지원내역 delete 후 html 재로딩(비동기) */
				$.ajax({
		            url:'ajax/markCancle?project_id='+projectid,
		            type: 'get',
		            dataType:"text",
		            success:function(result){
		                bookmark_list = JSON.parse(result);
		                console.log("result" + result);
		                
		                $('.bookmark_table').empty();
		                
		                
		                card =	"	<tbody>	"
		                $.each(bookmark_list, function(index, obj){
							card +=	"	<tr>	"
							card +=	"	<td><i class='fas fa-heart bookmark marking'	"
							card +=	"	id='"+obj.project_id+"' onclick='BookMarking("+obj.project_id+")'></i></td>	"
							card +=	"	<td><a href='/project/detail?project_id="+obj.project_id+"'>"+obj.p_title+"</a></td>	"
							if(obj.p_state == '모집중') {
								card +=	"	<td><p class='state_ing'> 모집중 </p></td>	"
							}else if (obj.p_state != '모집중') {
								card +=	"	<td><p class='state_end'> 모집완료 </p></td>	"
							}
							card +=	"	</tr>	"
						})
						card +=	"	</tbody>	"

		                 $('.bookmark_table').append(card);
		            }
				})
				
			    swal("북마크가 해제되었습니다.", {
			      icon: "success",
			    });
			  } else {
			    swal("취소하셨습니다.");
			  }
			});
	}
	
function applyCancle(applyid) {
		swal({
			  title: "지원을 취소하시겠습니까?",
			  text: "취소하시면 지원 목록에서 확인하실 수 없습니다.",
			  icon: "warning",
			  dangerMode: true,
			  buttons: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
				
				/* 확인버튼 클릭시 북마크 delete 후 html 재로딩(비동기) */
				applyListReload(applyid);
				
			    swal("지원이 취소되었습니다.", {
			      icon: "success",
			    });
			  } else {
			    swal("지원상태를 유지합니다.");
			  }
			});
	}
	
function applyListReload(applyid) {
	/* 확인버튼 클릭시 북마크 delete 후 html 재로딩(비동기) */
				$.ajax({
		            url:'ajax/applyCancle?apply_id='+applyid,
		            type: 'get',
		            dataType:"text",
		            success:function(result){
		                apply_list = JSON.parse(result);
		                
		                $('.apply_table_sec').empty();
		                
		                $.each(apply_list, function(index, obj){
							if(obj.p_state=='모집중' && obj.apply_ok==0) {
								card =	"	<tr>	"
								card +=	"	<td><i class='fas fa-cut applyCancle' id='"+obj.apply_id+"'	"
								card +=	"	onclick='applyCancle("+obj.apply_id+")'></i></td>	"
								card +=	"	<td><a href='/project/detail?project_id="+obj.project_id+"'>"+obj.p_title+"</a></td>	"
								card +=	"	<td>"+obj.apply_date.substring(2,10)+"</td>	"
								card +=	"	<td><p class='state_ing'> 모집중 </p></td>	"
								card +=	"	</tr>	"
		                 		$('.apply_table_sec').append(card);
							}
						})

		            }
				});
}