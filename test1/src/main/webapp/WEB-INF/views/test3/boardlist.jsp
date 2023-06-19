<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.4.min.js"></script>
</head>
<body>
<%
int myBoard = (Integer)request.getAttribute("myBoard");
int totalPage = 0;
if(myBoard % 30 == 0){
	totalPage = myBoard / 30;
}
else {
	totalPage = myBoard / 30 + 1;
}
for(int i = 1; i <= totalPage; i++){
	%>
	<a href="boardlist?page=<%=i %>"> <%=i %>페이지 </a>
<%
}
%>
<h2>게시물 리스트입니다.</h2>
<table border=2>
<tr><th>번호</th><th>작성자</th><th>내용</th><th>작성시간</th></tr>
<c:forEach items="${getSearchMyBoard }" var="dto">
	<tr><td>${dto.seq}</td><td><a href="boarddetail?seq=${dto.seq}">${dto.nickname}</a></td><td>${dto.contents}</td><td>${dto.writingtime}</td></tr>
</c:forEach>
</table>
</body>
</html>

