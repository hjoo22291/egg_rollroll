<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.4.min.js"></script>
</head>
<script>
$(document).ready(function(){
	if ("${sessionid}"=='eggking') { //admin계정이면
		var form = document.createElement('form'); // 폼객체 생성
		form.setAttribute('method', 'post'); //get,post 가능
		form.setAttribute('action', "adminmain"); //보내는 url
		opener.document.body.appendChild(form); //부모창에 생성한 폼 붙이기 - 부모창이 이동해야하니까
		form.submit();
	    window.close();//새창끄기 
	}
	else {
		opener.location.href="/rollroll/mainafterlogin"; //main새로고침
	    window.close();//새창끄기 
	}
	

});//ready
</script>
<body>
</body>
</html>