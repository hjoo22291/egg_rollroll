<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
$(document).ready(function(){
 	if ("${sessionid}"=='eggking') { //admin계정이면
		var form = document.createElement('form'); // 폼객체 생성
		form.setAttribute('method', 'post'); //get,post 가능
		form.setAttribute('action', "adminmemberlist"); //보내는 url
		document.body.appendChild(form); //만든 form붙이기
		form.submit();
	} 
	
});//ready
</script>
<body>
</body>
</html>