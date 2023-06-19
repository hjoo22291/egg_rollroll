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
#checkemailmsg{
font-size: 13px;
}
</style>
<script>
 
$(document).ready(function(){
	const checkForm = document.getElementById("myinfo_form");	
	const okbtn = document.getElementById("okbtn");
	const checkemail = document.getElementById("checkemail");


	    //엔터로 다음칸 가기1 :원래 비밀번호 → 새 비밀번호 →새 비밀번호확인→비밀번호변경
	 	checkemail.addEventListener("keydown", function(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); 
	      okbtn.click()
	    }
	    });//keydown
	    //빈칸허용x, 엔터키로 다음칸설정. end
	    
	    
	   
	    //[비밀번호 변경버튼 : 클릭이벤트 ] -빈칸이면 빈칸입력/ 기존pw와다를경우 경고/ 새비번=새비번체크 다를경우 경고.
	    //전부 맞을 경우 submit
	    $("#okbtn").on('click', function(event){
	    	console.log("버튼누름");
	    	 if (checkemail.value.trim() === "") {
	    		 event.preventDefault();
	    		alert("빈칸을 입력해주세요.")
	    	 }//ifend
	    	 else{ 
	    		 //실제db의 email과 =입력한 email이 같은경우.
	    		 if("${myinfoemail }"==checkemail.value){
	    			 checkForm.submit()
	    		 }//겉 if문
	    		 else{
	    			 alert("입력하신 정보를 다시 확인해주세요.");
	    		 }//겉 if -else //end
	    	}//빈칸 없는 경우 if-else//end
		});//change_pw_btn click end  
		  
		
		//['창닫기'버튼 누르면 회원정보변경 창 닫기]
		$("#backbtn").on('click', function(event){
			window.close();//새창끄기 
		});//backbtn click end 
	    

});//ready end
</script>





</head>
<body>




 <div id="myinfo_Box">
    <h1 id="check_message">My Info</h1>
    <form id="myinfo_form" action="myinfoform" method="get">
    
    <p>
    내 아이디  [  ${sessionid} ]<br>
    </p>
   	<p id="checkemailmsg">
   	회원가입시 입력하신 이메일을 입력해주세요.
   	</p>
    
    <!-- 로그인 아이디&패스워드 입력칸  -->
    <div id = "myinfo_group_box">
        <input type="email" name="email" id="checkemail" placeholder="이메일을 입력해주세요." class="myinfo_group" autofocus><br>
    </div>
      <!-- 회원정보찾기, 로그인버튼 -->
      <input type="button" value="확   인" id="okbtn" class="myinfo_btn">|
      <input type="button" value="창 닫기" id="backbtn" class="myinfo_btn">
     
    </form>
</div>



</body>
</html>