<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="resources/js/jquery-3.6.4.min.js"></script>
 <head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/admin.css" rel="stylesheet"/>	
<script src="resources/js/jquery-3.6.4.min.js"></script>

<script>   
$(document).ready(function() {
	
	//admin계정(eggking)이 아니면 메인페이지로 이동.
	if ("${sessionid}"!=('eggking')) {
			alert("잘못된 접근입니다.")
	        location.href = "/rollroll";  
    }else{
        //admin계정이 맞다면 :  삭제버튼 클릭 : <해당회원 삭제> + <삭제성공문구> + <adminmemberlist 재실행>  
        $('#adminpagememberlist').on('click', 'button' , function() {
            //var memberid = $(this).closest('tr').find('td:nth-child(2)').text();
            var memberid = $(this).prop("id");
            $.post('/rollroll/adminmemberdelete', {"memberid": memberid}, function() { });
            alert("회원을 삭제했습니다.");
      		var form = document.createElement('form'); // 폼객체 생성
    		form.setAttribute('method', 'post'); //get,post 가능
    		form.setAttribute('action', "adminmemberlist"); //보내는 url
    		document.body.appendChild(form); 
    		form.submit();
        });
    }//else end 
    
	//페이지 링크 눌렀을때 해당페이지 보여주기 
  	$(".adminpagelink_member").on('click',function(){
 		$.ajax({
			url : 'adminmemberpaging',
			type : 'post',
			data : {'page' : $(this).text() }, 
			dataType : 'json', 
			success : function(response){
					$("#adminpagememberlist").html("<table border='3'>");
					$("#adminpagememberlist").append("<thead><tr><th>아이디</th><th>이메일</th><th>가입일</th><th>누적신고</th><th>회원삭제</th></tr></thead>");					
					for(let i = 0; i < response.length; i++) {
						$("#adminpagememberlist").append("<tr><td>" +response[i].memberid +"</td><td>" +response[i].email +"</td><td>" +response[i].regtime +"</td><td>" +response[i].reported +"</td><td><button class='deletemember' id='" +response[i].memberid+ "'>회원삭제</button></td></tr>");
					}//for
					$("#adminpagememberlist").append("</table>");
			}, 
			error : function(request, status, e) {
				alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
			}
		});//ajax
	}); //페이지버튼
  
         
});//ready end
    
    
    </script>
</head>


<body>

<header>
	[ADMIN]  MemberList 
</header>

<nav>
</nav>

<!-- 좌측 aside -->
<aside>
	<div id="div_aside">
		<div id="div_odd">
			<form action="adminmain" method="post">
				<input type="submit" value="관리자 홈으로 이동" id="adminmain_btn">
			</form>
		</div>
	</div>	
</aside>
	
	
	
<!-- 가운데 본문 -->
<section>
	<div id="section_text">
		[Admin] 이 페이지는 EggRollRoll 전체 회원 관리자 메뉴입니다.
		<br>
		<br>
		
		
<!-- 기존테이블코드 -->		
<div id="adminpagememberlist">	
<table border="3">
<thead><tr><th>아이디</th><th>이메일</th><th>가입일</th><th>누적신고</th><th>회원삭제</th></tr></thead>
        <c:forEach items="${memberList}" var="dto" varStatus="loop">
            <tr>
            	<td>${dto.memberid}</td>
                <td>${dto.email}</td>
                <td>${dto.regtime}</td><td>${dto.reported}</td>
                <td><button class="deletemember" id="${dto.memberid}">회원삭제</button></td>
            </tr>
        </c:forEach>
    </table>
</div>
<br>
<!-- 페이지리스트 -->
<div id="div_page">
    <%
  int totalMember = (Integer)request.getAttribute("totalMember"); 
//토탈페이지계산
  int totalPage = 0;
  if(totalMember % 10 == 0){
     totalPage = totalMember / 10; 
  }
  else{
     totalPage = totalMember / 10 + 1;
  }
  for(int i = 1; i <= totalPage; i++){ 
     %>
    <button class='adminpagelink_member' id="<%=i %>page"><%=i %></button>
<%  }
%>

<br>
</div>
<!-- 기존테이블코드 // end -->

</div>
	 
</section>
	
	
	
<!-- 우측aside -->
<aside>
</aside>



<footer>
	<hr>
	 ⓒEgg RollRoll Corp.
</footer>


</body>
</html>