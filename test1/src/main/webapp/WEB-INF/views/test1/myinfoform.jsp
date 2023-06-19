<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/myinfoform.css" rel="stylesheet"/>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<style>
input::placeholder{ color: #BDBDBD; }
</style>
<script>
 
$(document).ready(function(){
	const myinfoForm = document.getElementById("myinfo_form");	
	const changePwBtn = document.getElementById("change_pw_btn");
	const originpw = document.getElementById("myinfo_origin_pw");
	const newpw = document.getElementById("myinfo_new_pw");
	const newpw_check = document.getElementById("myinfo_check_new_pw");
	
	//빈칸허용x, 엔터키로 다음칸설정.
/* 	$("#changePwBtn").on('click', function(event){
		if (originpw.value.trim() === "" || newpw.value.trim() === "" || newpw_check.value.trim() === "") {
		      alert("빈칸을 입력해주세요"); 
		    } else {
		    	myinfoForm.submit()
		    }
		});//changePwBtn click */

	    //엔터로 다음칸 가기1 :원래 비밀번호 → 새 비밀번호 →새 비밀번호확인→비밀번호변경
	  	originpw.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      newpw.focus();
	    }
	  	});//keydown
	  
		//엔터키 2
		newpw.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      newpw_check.focus();
	    }
	 	 });//keydown
	 	 
		//엔터키3
	 	newpw_check.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      changePwBtn.click()
	    }
	    });//keydown
	    //빈칸허용x, 엔터키로 다음칸설정. end
	    
	    
	   
	    //[비밀번호 변경버튼 : 클릭이벤트 ] -빈칸이면 빈칸입력/ 기존pw와다를경우 경고/ 새비번=새비번체크 다를경우 경고.
	    //전부 맞을 경우 submit
	    $("#change_pw_btn").on('click', function(event){
	    	console.log("버튼누름");
	    	 if (originpw.value.trim() === "" || newpw.value.trim() === "" || newpw_check.value.trim() === "") {
	    		 event.preventDefault();
	    		alert("빈칸을 입력해주세요.")
	    	 }//ifend
	    	 else{ 
	    		 //실제dbpw와 =입력한 pw가 같은경우.
	    		 if("${originalpw}"==originpw.value){
	    			 //입력한 새로운 pw와 새로운 pw체크용이 같은경우->OK
	    			 if(newpw.value==newpw_check.value){
	    				 myinfoForm.submit();
	    			 }else{
	    				 alert("새로운 비밀번호를 같은 값으로 입력해주시기바랍니다.");
	    			 }//안쪽 if-else end
	    		 }//겉 if문
	    		 else{
	    			 alert("기존 비밀번호가 맞지 않습니다.");
	    		 }//겉 if -else //end
	    	}//빈칸 없는 경우 if-else//end
		});//change_pw_btn click end  
		  
		
		//['창닫기'버튼 누르면 회원정보변경 창 닫기]
		$("#backbtn").on('click', function(event){
			window.close();//새창끄기 
		});//backbtn click end
		
		//탈퇴버튼
		$("#deleteMebtn").on('click', function(event){
			if(window.confirm("탈퇴하시면 지금까지 받은 편지는 모두 삭제됩니다. 정말로 탈퇴하시겠어요?")){
				$.ajax({
	 				url : 'deleteme',
	 				type : 'post',
	 				data : {'memberid' : "${sessionid}"}, 
	 				dataType : 'json',
	 				success : function(response){ 
	 					alert("탈퇴가 완료되었습니다.");
	 					opener.location.href="/rollroll";
	 					window.close();
	 				}, 
	 				error : function(request, status, e) {
	 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
	 				}
	 			});//ajax
			}else{
				
			}
		});//backbtn click end
	    

});//ready end
</script>





</head>
<body>

<div id="myinfo_Box">
    <h1 id="myinfo_message">My Info</h1>
    <form id="myinfo_form" action="myinfoform" method="post">

    <p>
    내 아이디  [  ${sessionid} ]<br>
    내 이메일  [  ${myinfoemail } ]<br>
    </p>

    <!-- 로그인 아이디&패스워드 입력칸  -->
    <div id = "myinfo_group_box">
       <input type="password" name="pw_old" id="myinfo_origin_pw" class="myinfo_group" placeholder="현재 비밀번호" autofocus><br>
       <input type="password" name="pw" id="myinfo_new_pw" class="myinfo_group" placeholder="새 비밀번호"><br>
       <input type="password" name="pw_check" id="myinfo_check_new_pw" class="myinfo_group" placeholder="새 비밀번호 확인"><br>
    </div>
      <!-- 회원정보찾기, 로그인버튼 -->
      <input type="button" value="탈퇴하기" id="deleteMebtn" class="myinfo_btn">|
      <input type="button" value="비밀번호 변경" id="change_pw_btn" class="myinfo_btn">|
      <input type="button" value="창 닫기" id="backbtn" class="myinfo_btn">
     
    </form>
</div>



</body>
</html>