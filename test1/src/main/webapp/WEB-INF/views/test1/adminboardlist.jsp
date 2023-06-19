<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/admin.css" rel="stylesheet"/>	
 <script src="resources/js/jquery-3.6.4.min.js"></script>
 <script>
	 
 
 $(document).ready(function(){

	//admin계정(eggking)이 아니면 메인페이지로 이동.
		if ("${sessionid}"!=('eggking')) {
			alert("잘못된 접근입니다.")
	        location.href = "/rollroll";  
	    }else{
	    	 //admin계정이 맞다면 :삭제버튼 클릭 : <해당글 삭제> + <삭제문구> + <adminboardlist 재실행>  
 			$('#adminpageboardlist').on('click', 'button' , function() {
 	            //var memberid = $(this).closest('tr').find('td:nth-child(2)').text();
 	            var seq = $(this).prop("id");
			    $.post('/rollroll/adminboarddelete', {"seq": seq}, function() { });
			    alert("게시글을 삭제했습니다.");
 	      		var form = document.createElement('form'); // 폼객체 생성
	    		form.setAttribute('method', 'post'); //get,post 가능
	    		form.setAttribute('action', "adminboardlist"); //보내는 url
	    		document.body.appendChild(form); 
	    		form.submit();
				});
	  	}//else end 

	  	
/* 		//페이지 링크 눌렀을때 해당페이지 보여주기 
	  	$(".adminpagelink_board").on('click',function(){
	 		$.ajax({
				url : 'adminboardpaging',
				type : 'post',
				data : {'page' : $(this).text() }, 
				dataType : 'json', 
				success : function(response){
					$("#adminpageboardlist").html("<table border='3' >");
						$("#adminpageboardlist").append("<thead><tr><th>번호</th><th>받은사람</th><th>작성자</th><th>닉네임</th><th>내용</th><th>작성시간</th><th>삭제</th></tr></thead>");					
						for(let i = 0; i < response.length; i++) {
							$("#adminpageboardlist").append("<tr><td>" +response[i].seq +"</td><td>" +response[i].receiver +"</td><td>" 
									+response[i].writer +"</td><td>" +response[i].nickname +"</td><td>" +response[i].contents +"</td><td>" 
									+response[i].writingtime +"</td><td><button class='deleteboard' id='"+response[i].seq+ "'>삭제</button></td></tr>");
						}//for
						$("#adminpageboardlist").append("</table>");
						
						  $("#adminpageboardlist table tr.new-row").addClass("table-row-styling");
		        
				}, 
				error : function(request, status, e) {
					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
				}
			});//ajax
		}); //페이지버튼 */
		
		
		//이부분부터추가==============================
		$(".adminpagelink_board").on('click', function () {
			  $.ajax({
			    url: 'adminboardpaging',
			    type: 'post',
			    data: { 'page': $(this).text() },
			    dataType: 'json',
			    success: function (response) {
			      var table = $("<table>").attr("border", "3").css("width", "100%");
			      var thead = $("<thead>").append("<tr><th>번호</th><th>받은사람</th><th>작성자</th><th>닉네임</th><th>내용</th><th>작성시간</th><th>삭제</th></tr>");
			      var tbody = $("<tbody>");

			      for (let i = 0; i < response.length; i++) {
			        var row = $("<tr>").append(
			          "<td>" + response[i].seq + "</td><td>" + response[i].receiver + "</td><td>" +
			          response[i].writer + "</td><td>" + response[i].nickname + "</td><td>" + response[i].contents + "</td><td>" +
			          response[i].writingtime + "</td><td><button class='deleteboard' id='" + response[i].seq + "'>삭제</button></td>"
			        );
			        tbody.append(row);
			      }

			      table.append(thead, tbody);
			      $("#adminpageboardlist").empty().append(table);
			    },
			    error: function (request, status, e) {
			      alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e);
			    }
			  });
			});
		//이부분까지 추가==============================
	  	
	  	
});//ready end

 
 </script>
 
 
</head>
<body>

<header>
	[ADMIN]  BoardList 
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
		[Admin] 이 페이지는 EggRollRoll 전체 게시물 관리자 메뉴입니다.
		<br>
		<br>
		
<!-- 기존테이블코드 -->	
<div id="adminpageboardlist">	
<table border="3">
<thead><tr><th>번호</th><th>받은사람</th><th>작성자</th><th>닉네임</th><th>내용</th><th>작성시간</th><th>삭제</th></tr></thead>
<c:forEach items="${boardList }" var="dto">
	<tr><td>${dto.seq }</td><td>${dto.receiver }</td><td>${dto.writer }</td><td>${dto.nickname }</td>
		<td>${dto.contents }</td><td>${dto.writingtime }</td>
		 <td><button class="deleteboard" id="${dto.seq}">삭제</button></td></tr>
</c:forEach>   
</table>
</div>
<br>
<!-- 페이지리스트 -->
<div id="div_page">
<%
  int totalBoard = (Integer)request.getAttribute("totalBoard"); 
//토탈페이지계산
  int totalPage = 0;
  if(totalBoard % 10 == 0){
	  totalPage = totalBoard / 10; 
  }
  else{
	  totalPage = totalBoard / 10 + 1;
  }
  for(int i = 1; i <= totalPage; i++){ 
	  %>
	  <button class='adminpagelink_board' id="<%=i %>page"><%=i %></button>
<%  }
%>
</div>
</div>

<!-- 기존테이블코드 // end -->

	

	 
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