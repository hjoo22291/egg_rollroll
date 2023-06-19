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
	if ("${sessionid}"=='eggking') {
		var form = document.createElement('form'); // 폼객체 생성
		form.setAttribute('method', 'post'); //get,post 가능
		form.setAttribute('action', "adminmain"); //보내는 url
		opener.document.body.appendChild(form); //부모창에 생성한 폼 붙이기 - 부모창이 이동해야하니까
		form.submit();
	    window.close();//새창끄기 
	}
	else {
		opener.location.reload(); //main새로고침
	    window.close();//새창끄기 
	}
	

});//ready
</script>
<body>
</body>
</html>

<%-- <%
String sessionid = (String) session.getAttribute("sessionid");
if ( sessionid == "eggking") {
%>
	<script>	
	
	document.g
	form.setAttribute('action', "/adminmain"); //보내는 url
	document.body.appendChild(form);
	form.submit();
    window.close();//새창끄기

    
<%	
}
else {
%>
	<script>	
     opener.location.reload(); //main새로고침
    //opener.location.href= "/rollroll/boardlist";
    window.close();//새창끄기 
    
/* 	var form = document.createElement('form'); // 폼객체 생성
	var objs;
	objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
	objs.setAttribute('type', 'text'); // 값이 들어있는 녀석의 type
	objs.setAttribute('name', 'memberid'); // 객체이름
	objs.setAttribute('value', $('#uId').val()); //객체값
	form.appendChild(objs);
	form.setAttribute('method', 'post'); //get,post 가능
	form.setAttribute('action', "/adminmain"); //보내는 url
	document.body.appendChild(form);
	form.submit(); */
    </script>
<%	
}
%> --%>