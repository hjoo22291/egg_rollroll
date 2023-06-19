<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>글 상세조회</h2>
<form action="boardupdate" method=post><!-- textarea가 글이 길기때문에 post로 보내야함 -->
번호 : <input type=text name="seq" value="${detaildto.seq}" readonly><br>
제목 : <input type=text name="title" value="${detaildto.title}" id="title"><br>
내용 : <br><textarea rows="5" cols="50" name="contents" id="contents" >
${detaildto.contents}
</textarea><br>
작성자 : <input type=text name="writer" value="${detaildto.writer}" readonly><br>
조회수 : <input type=text name="viewcount" value="${detaildto.viewcount}" readonly><br>
작성시간 : <input type=text name="writingtime" value="${detaildto.writingtime}" readonly><br>
<input type=hidden name="pw" value="${detaildto.pw}"><br> 
<input type=button id="updatebtn" value="수정하기">
<input type=button id="deletebtn" value="삭제하기">
</form>
</body>
</html>