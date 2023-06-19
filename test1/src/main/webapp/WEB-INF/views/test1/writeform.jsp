<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/writeform.css" rel="stylesheet"/> 	
<script src="resources/js/jquery-3.6.4.min.js"></script>
<style>
input::placeholder, textarea::placeholder {color: #BDBDBD;}
</style>
</head>
<script>
$(document).ready(function(){
	const contents = document.getElementById("contents");
	const nickname = document.getElementById("nickname");
	const boardpw = document.getElementById("boardpw");	
	
	//글쓰기 버튼 누르기
	$("#writesubmitbtn").on('click', function(e){
 		e.preventDefault();
 		
  		if(contents.value.trim() !== ""){
 			if(boardpw.value.trim() !== ""){
 				if(nickname.value.trim() !== '') {
	 				$('form').submit();		
 				}
 				else {
 					nickname.value = "${sessionid}";
 					$('form').submit();		 					
 				}
 			}
 			else {
 				alert("비밀번호를 입력해주세요.");
 			}	
 		}
 		else {
 			alert("내용을 입력해주세요.");
 		} 
    });//글쓰기
	
    // delete버튼 - 쓴 글 전체 삭제 + 글자수 초기화 + 제목에 포커스
    $("#deleteAll").on('click', function(){
/*     	let temp = document.getElementsByClassName('contents');
		for (let i = 0; i < temp.length; i++) {
			temp[i].value = ''; }//for end */
		$('textarea').val('');
		$('#nickname').val('');
		$('#boardpw').val('');		
	    $('#remainNum').text('0');
	    $('#contents').focus(); 
 
    });
    
	//쓴글자수
	//let total_len = 500;
	$('textarea').on('keyup',function(){
		let str_len= $(this).val().length;
		$('#remainNum').text(str_len);
	});//글자수end
	
});//ready
</script>
<body>
<div id="writespace">
	<form action='boardwrite' method="post">
		<div id = "writebox">
		<h1>Letter to</h1>
		<input type="hidden" id="receiver" name="receiver" value="${sessionid}">
		<textarea maxlength="500" cols="70" rows="13" id="contents" name="contents" autofocus placeholder="내용을 입력해주세요.(필수)"></textarea>
		From <input type=text id="nickname" name="nickname" maxlength="30" placeholder="미입력시 id입력" >
		<input type="hidden" id="writer" name="writer" value="${sessionid}">
		<div id="remainNum">0</div>/ 500 <br>
		비밀번호 <input type="password" id="boardpw" name="boardpw" maxlength="30" placeholder="(필수)"><br>
		<input type="radio" name="eggcolor" value="white" checked />white
        <input type="radio" name="eggcolor" value="brown" />brown
		<div id= below> 
		<input type="button" value="다시쓰기" id="deleteAll">
		<input type="submit" value="등록하기" id="writesubmitbtn">
		</div>
		</div>
	</form>
</div>
</body>
</html>