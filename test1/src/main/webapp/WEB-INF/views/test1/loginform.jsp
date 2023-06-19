<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/loginform.css" rel="stylesheet"/>	
<script src="resources/js/jquery-3.6.4.min.js"></script>
<style>
input::placeholder{ color: #BDBDBD; }
</style>
<script>
$(document).ready(function(){
	const loginForm = document.getElementById("login_form");	
	const loginBtn = document.getElementById("login_submit_btn");
	const loginId = document.getElementById("login_form_id");
	const loginPassword= document.getElementById("login_form_password");
	//const loginErrorMsg ="아이디 또는 비밀번호를 잘못입력했습니다. 다시확인해주세요. ";
	/* const loginLink= "http://localhost:8081/team_running/team1.html"; */
	
	$("#login_submit_btn").on('click', function(event){
		    //서브밋 우선 막기.
		 	event.preventDefault();

			//아이디, 비번에 빈칸 입력시 경고창. + 둘 다 입력시 submit
		    if (loginId.value.trim() === "" || loginPassword.value.trim() === "") {
		      alert("빈칸을 입력해주세요"); 
		    } else {
		      loginForm.submit(); 
		    }
		});//loginBtn click

	  //엔터로 다음칸 가기 : (순서) 아이디-> pw-> 로그인버튼
	  loginId.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      loginPassword.focus();
	    }
	  });//keydown

	  loginPassword.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      loginBtn.click(); 
	    }
	    });//keydown
	
	//회원가입 버튼
    $("#join_btn").on('click', function(){
    	location.replace("/rollroll/memberjoin");
    });
	    
  //비밀번호찾기
    $("#findpw").on('click', function(event){
        location.replace("/rollroll/findpwform");
    });//find 

});//ready end
</script>

</head>
<body>
<div id="login_Box">
    <h1 id="login_message">Login</h1>
    <form id="login_form" action="memberlogin" method="post">
    <!-- 로그인 아이디&패스워드 입력칸  -->
    <div id = "login_form_group_box">
      <input type="text" name="memberid" id="login_form_id" class="login_form_group" placeholder="아이디" autofocus><br/>
      <input type="password" name="pw" id="login_form_password" class="login_form_group" placeholder="비밀번호">
    </div>
      <!-- 회원정보찾기, 로그인버튼 -->
      <input type="button" value="비밀번호 찾기"  id="findpw" class="login_find_Info">|
      <input type="button" value="회원가입" id="join_btn" class="login_find_Info" >|
      <input type="submit" value="로그인" id="login_submit_btn" >
    </form>
</div>

<%
String sessionid = (String) session.getAttribute("sessionid");
if (sessionid != null && (sessionid.equals("비번다름") || sessionid.equals("미가입자"))) {
%>
<script>
window.alert("Warning: ${sessionid}");
</script>
<% session.setAttribute("sessionid", null);} %>

</body>
</html>