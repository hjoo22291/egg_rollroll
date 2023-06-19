<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="resources/css/joinform.css">
<script src="resources/js/jquery-3.6.4.min.js"></script>
<style>
input::placeholder{ color: #BDBDBD; }
</style>
</head>
<script>
$(document).ready(function() {
    const joinBox = document.getElementById("join_Box");
    const joinBtn = document.getElementById("join_btn");
    const join_id = document.getElementById("memberid");
    const join_email = document.getElementById("email");
    const join_pw = document.getElementById("pw");

    join_id.addEventListener("keydown", function(event) {
        if (event.keyCode == 13) {
        	event.preventDefault(); 
            join_email.focus();
        }
    });
    join_email.addEventListener("keydown", function(event) {
        if (event.keyCode == 13) {
        	event.preventDefault(); 
            join_pw.focus();
        }
    });
    join_pw.addEventListener("keydown", function(event) {
        if (event.keyCode == 13) {
  	      event.preventDefault(); 
	      joinBtn.click(); 
        }
    });

/*  //id중복검사
	$("#join_btn").on('click', function(event){
	 	event.preventDefault();
		//아이디, 비번에 빈칸 입력시 경고창. + 둘 다 입력시 submit
	    if (join_id.value.trim() === "" || join_email.value.trim() === "" || join_pw.value.trim() === "") {
	      alert("빈칸을 입력해주세요"); 
	    } else {
	    	$.ajax({
 				url : 'ismemberexist',
 				type : 'post',
 				data : {'inputId' : $('#memberid').val()}, 
 				dataType : 'json',
 				success : function(response){ 
 					if(response == 0) {
				     	join_form.submit(); 
				      	alert("가입이 완료되었습니다."); 	
 					}else {
				      	alert("이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요."); 	 						
 					}
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
	    }//else
	});//joinBtn click */
	
	//아이디, 이메일 중복 검사	
	$("#join_btn").on('click', function(event){
	 	event.preventDefault();
		//아이디, 비번에 빈칸 입력시 경고창. + 둘 다 입력시 submit
	    if (join_id.value.trim() === "" || join_email.value.trim() === "" || join_pw.value.trim() === "") {
	      alert("빈칸을 입력해주세요"); 
	    } else {
	    	$.ajax({
 				url : 'ismemberexist',
 				type : 'post',
 				data : {'inputId' : $('#memberid').val(), 'inputEmail' : $('#email').val()}, 
 				dataType : 'json',
 				success : function(response){ 
 					if($.trim(response.result) ==="ok") {
				     	join_form.submit(); 
				      	alert("가입이 완료되었습니다."); 	
 					}
 					else if($.trim(response.result) ==="one_id"){
				      	alert("이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요."); 	 						
 					}
 					else if($.trim(response.result) ==="one_email"){
				      	alert("이미 존재하는 이메일입니다. 다른 이메일을 입력해주세요."); 	 						
 					}
 					else {
				      	alert("아이디, 이메일 모두 존재합니다."); 	 						 						
 					}
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
	    }//else
	});//joinBtn click
	
});

</script>
<body>
<div id="join_Box">
    <h2>Sign up</h2>
     <form id="join_form" action="memberjoin" method="post">
    <input type="text" name="memberid" id="memberid" placeholder="아이디" class="join_btn_group" autofocus><br>
    <input type="email" name="email" id="email" placeholder="이메일" class="join_btn_group"><br>
    <input type="password" name="pw" id="pw" placeholder="비밀번호" class="join_btn_group"><br>
    <input type="submit" id="join_btn" value="| 가입하기 |">
    </form>
</div>
</body>
</html>
