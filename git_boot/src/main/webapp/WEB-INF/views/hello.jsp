<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	$("#ajaxbtn").on('click', function(){
		$.ajax({
			url : "helloajax",
			type : "get",
			dataType : "JSON",
			success : function(server){
				$("#result").html(server.model);
			},
			error : function(error){
				alert(error);
			}
		});
		alert("포크 테스트!); 
	});//ajaxbtn
	
});//ready

</script>
</head>
<body>
<h1>hello.jsp파일입니다.</h1>
<h1>${model }</h1>

<img src="/images/html5.jpg"><br>

<input type=button value="ajax요청버튼" id="ajaxbtn"> <br>
ajax결과출력 <h1 id="result"></h1>
</body>
</html>
