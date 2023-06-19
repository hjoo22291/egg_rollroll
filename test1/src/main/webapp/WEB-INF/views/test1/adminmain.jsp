<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/admin.css" rel="stylesheet"/>	
 <script src="resources/js/jquery-3.6.4.min.js"></script>
<script>

$(document).ready(function(){
	
	//관리자 아이디(eggking)이 아니면 메인페이지로 돌아가기.
	if ("${sessionid}"!=('eggking')) {
		alert("관리자만 접근 가능합니다.")
        location.href = "/rollroll";  
   	}

});//ready end

</script>
</head>
<body>

<header>
		EggRollRoll
</header>


<nav>
</nav>

<!-- 좌측 aside -->
<aside>
	<div id="div_aside">
		<div id="div_odd">
			 <form id="admin_member" action="adminmemberlist" method="post">
				 <input type="submit" value="관리자 회원정보조회 " id="admin_memberlist_btn" class="admin_group" >
			 </form>
		</div>
		
		<div id="div_even">
			 <form id="admin_board" action="adminboardlist" method="post">
			 	<input type="submit" value="관리자 게시글조회" id="admin_boardlist_btn" class="admin_group" >
			 </form>
		</div>
		
		<div id="div_odd">
		 	<form id="admin_logout" action="adminlogout" method="post">
		 		<input type="submit" value="로그아웃(main)" id="logout_return_home_btn" class="admin_group" >
		 	</form>
		</div>
	</div>	
</aside>
	
	
	
<!-- 가운데 본문 -->
<section>
	<div id="section_text">
		[Admin] 이 페이지는 Egg RollRoll 관리자 메뉴입니다.
		<br>
		<br>
		원하시는 메뉴를 클릭해주세요.
		<br>
		<br>
		<Br>
		[관리자 회원정보 관리]  :  전체 회원 정보를 관리합니다.
		<br>
		<br>
		[관리자 게시글 관리]  :  전체 게시글을 관리합니다.
		<br>
		<br>
		[관리자 로그아웃]  :  admin관리페이지를 벗어나 메인 메뉴로 되돌아갑니다. 
	</div>
	
	<!--  <form id="admin_member" action="adminmemberlist" method="post">
	 <input type="submit" value="관리자 회원정보조회 " id="admin_memberlist_btn" class="admin_group" >|
	 </form>
	 <form id="admin_board" action="adminboardlist" method="post">
	 <input type="submit" value="관리자 게시글조회" id="admin_boardlist_btn" class="admin_group" >|
	 </form>
	 <form id="admin_logout" action="adminlogout" method="post">
	 <input type="submit" value="로그아웃-메인으로돌아가기" id="logout_return_home_btn" class="admin_group" >
	 </form> -->
	 
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

<!--  
그 adminmain.jsp 하나 해서
버튼 하나 누르면 adminmemberlist.jsp
나머지 하나 누르면 adminboardlist.jsp
해서 각 페이지에서 테이블로 나오게
css다 빼고 기본 구조만 저렇게 해두시고 진행해주시면 될거같아요~!
뭐 버튼이나 페이지는 나중에 추가하면되니까요

1.adminmain.jsp - <body>에 버튼1개 -  누르면 이동
2.컨트롤러 통해서 뭐 불러오고 등등
3.adminmemberlist.jsp - 전체회원출력

-->