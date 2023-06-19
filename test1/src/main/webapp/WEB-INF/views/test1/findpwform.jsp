<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/findpwform.css" rel="stylesheet"/>	
<script src="resources/js/jquery-3.6.4.min.js"></script>
<style>
input::placeholder{ color: #BDBDBD; }
</style>
 <script>
 
$(document).ready(function(){
	const findForm = document.getElementById("findpw_form");	
	const findBtn = document.getElementById("findpw");
	const findId = document.getElementById("findpw_id");
	const findEmail= document.getElementById("findpw_email");
	//const loginErrorMsg ="아이디 또는 비밀번호를 잘못입력했습니다. 다시확인해주세요. ";
	/* const loginLink= "http://localhost:8081/team_running/team1.html"; */
	
	$("#findpw").on('click', function(event){
		    //서브밋 우선 막기.
		 	event.preventDefault();

			//아이디, 이메일에 빈칸 입력시 경고창. + 둘 다 입력시 submit
		    if (findId.value.trim() === "" || findEmail.value.trim() === "") {
		      alert("빈칸을 입력해주세요"); 
		    } else {
		    	findForm.submit()
		    }
		});//findBtn click

	  //엔터로 다음칸 가기 : (순서) 아이디-> email-> 로그인버튼
	  findId.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      findEmail.focus();
	    }
	  });//keydown

	  findEmail.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      findForm.submit();
	    }
	    });//keydown
	    
	    
	    //찾기버튼 누르면 submit(빈칸이면 submit막기)
	    $("#findpw").on('click', function(event){
	    	 if (findId.value.trim() === "" || findEmail.value.trim() === "") {
	    		 event.preventDefault();
	    	 }else{
	    	findForm.submit();}
		});//find   
		  
		
		//로그인창으로 돌아가기
		$("#backbtn").on('click', function(event){
			location.replace("/rollroll/memberlogin");
		});//find 

});//ready end
</script>





</head>
<body>
  
<div id="findpw_Box">
    <h1 id="findpw_message">Find Password</h1>
    <form id="findpw_form" action="findpwform" method="post">
    <!-- 로그인 아이디&패스워드 입력칸  -->
    <div id = "findpw_group_box">
      <input type="text" name="memberid" id="findpw_id" class="findpw_group" placeholder="아이디" autofocus><br/>
      <input type="email" name="email" id="findpw_email" placeholder="이메일" class="findpw_group">
    </div>
      <!-- 회원정보찾기, 로그인버튼 -->
      <input type="button" value="이전 페이지로" id="backbtn" class="find_Info">|
      <input type="submit" value="비밀번호 찾기" id="findpw" class="find_Info">
     
    </form>
</div>

</body>
</html>