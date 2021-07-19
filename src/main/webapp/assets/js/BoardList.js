// 페이징
function fn_formSubmit(){
	if(!$(':input:checkbox[name=searchType]:checked').val()) {   
   	swal("검색 타입을 선택해 주세요.", "", "warning");
   	return;
	}

	document.form1.submit();	
}
// 검색 체크박스 하나만 선택되게
function checkOnlyOne(element) {
	  const checkboxes 
	      = document.getElementsByName("searchType");
	  
	  checkboxes.forEach((cb) => {
	    cb.checked = false;
	  })
	  
	  element.checked = true;
}
