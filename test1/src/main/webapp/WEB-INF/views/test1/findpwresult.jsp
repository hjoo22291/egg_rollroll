<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	if("${sessionmsg}"=='임시 비밀번호를 등록하신 이메일로 전송하였습니다.'){
		alert("${sessionmsg }");
	 	window.location.href = "/rollroll/memberlogin";
	}else{
		alert("${sessionmsg }");
		window.location.href = "/rollroll/findpwform";
	}
	 
});//ready end
</script>

</head>
<body>
<p></p>




</body>
</html>