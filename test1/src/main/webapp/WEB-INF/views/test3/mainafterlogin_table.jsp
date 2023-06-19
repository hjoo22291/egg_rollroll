<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.4.min.js" ></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link href="resources/css/main.css" rel="stylesheet"/>
<style>
.eggpaper {
width: 145px; height: 140px;
margin:0px;
}
table {
padding-left:22px;
padding-top:3px;
margin:0px;
border-collapse : collapse;
border-spacing : 0;
table-layout: fixed;
}
table * {
border: solid 0.5px black;
margin:0px;
border-collapse : collapse;
border-spacing : 0;
}
td {
border-spacing : 0;
border-collapse : collapse;
height: 140px;
}
</style>
</head>
<script>
$(document).ready(function(){
	
	//home클릭	
	$("#home").on('click', function(){ location.replace("/rollroll"); });
	
	//로그인클릭 - 새창띄우기
	$("#login").on('click', function(){ 
		open("/rollroll/memberlogin", "로그인", "width=700px, height=500px, top=150, left=300");
	});//login click
	
	//글쓰기클릭 - 새창띄우기
	$("#write").on('click', function(){ 
		open("/rollroll/boardwrite", "글쓰기", "width=700px, height=500px, top=150, left=300");
	});//write click
			
	// 스티커클릭
    $("#sticker").click(function() {
        $("#sticker_list").show(300);
    }); 

    $("#sticker_list_out").click(function() {
        $("#sticker_list").hide(300);
    }); 

    // 스티커붙이기
    var stickerCount = 0; // 스티커 카운트 변수 추가
    $('img.imojis').click(function(event) {
        event.stopPropagation(); // 이벤트 전파 중지
        var offsetX = event.clientX - $(this).offset().left; // 클릭한 위치의 X 좌표
        var offsetY = event.clientY - $(this).offset().top; // 클릭한 위치의 Y 좌표
        var clonedImage = $(this).clone().appendTo('#deco');
        clonedImage.attr('id', 'cloned-image-' + Date.now() + '-' + stickerCount); // 스티커마다 고유한 id 생성
        clonedImage.css({
            'z-index': stickerCount + 1,
            'position': 'absolute',
            'left': offsetX,
            'top': offsetY
        });
        stickerCount++; // 스티커 카운트 증가
        clonedImage.draggable({ containment: 'none' }); // 위치 제한 없이 드래그 가능
    });

    // 스티커 더블 클릭으로 삭제
    $('#deco').on('dblclick', '.imojis', function(event) {
        event.stopPropagation(); // 이벤트 전파 중지
        var clonedImage = $(this);
        clonedImage.remove(); // 스티커 삭제
    });

    // 스티커 클릭 시 다른 스티커의 위치 제한 제거
    $('#deco').on('click', '.imojis', function(event) {
        event.stopPropagation(); // 이벤트 전파 중지
        var clonedImage = $(this);
        $('.imojis').not(clonedImage).draggable({ containment: 'none' }); // 다른 스티커의 위치 제한 제거
    });
    
});//ready
</script>
<body>
<div id="one">
	<div id="left">
		<hr style = "width: 80%; border : 2px solid black" >
		<p id="head">
			Egg<br>RollRoll
		</p>
		<hr style = "width: 80%; border-width:1px 0 0 0; border-color:black">
		<br><br>
		<div id="menu">
		<nav>
			<ul>
				<li><button id="home" class="anbtn">Home</button></li>
				<li><button id="login" class="anbtn">Login</button></li>			
				<li><button id="write" class="anbtn">Write</button></li>
				<li><button id="sticker" class="anbtn">Sticker</button></li>
			</ul>
		</nav>
		</div><!-- menu end -->
	</div><!-- left end -->

    
<!-- sticker --> 
   	<div id="sticker_list">
		<div style="display:flex; justify-content: flex-end; padding-right: 15px">
		<button id="sticker_list_out" class="anbtn">X</button><br>
		</div>
		<div>
		<img class="imojis" src="resources/imojis/glgl.png">
		<img class="imojis" src="resources/imojis/pngegg.png">
		<img class="imojis" src="resources/imojis/pngegg (1).png">
		<img class="imojis" src="resources/imojis/pngegg (2).png">
		<img class="imojis" src="resources/imojis/pngegg (3).png">
		<img class="imojis" src="resources/imojis/pngegg (4).png">
		<img class="imojis" src="resources/imojis/pngegg (5).png">
		<img class="imojis" src="resources/imojis/pngegg (6).png">
		<img class="imojis" src="resources/imojis/pngegg (7).png">
		<img class="imojis" src="resources/imojis/pngegg (8).png">
		<img class="imojis" src="resources/imojis/pngegg (9).png">
		<img class="imojis" src="resources/imojis/pngegg (10).png">
		<img class="imojis" src="resources/imojis/pngegg (11).png">
		<img class="imojis" src="resources/imojis/pngegg (12).png">
		<img class="imojis" src="resources/imojis/pngegg (13).png">
		<img class="imojis" src="resources/imojis/pngegg (14).png">
		<img class="imojis" src="resources/imojis/pngegg (15).png">
		<img class="imojis" src="resources/imojis/pngegg (16).png">
		<img class="imojis" src="resources/imojis/pngegg (17).png">
		<img class="imojis" src="resources/imojis/pngegg (18).png">
		<img class="imojis" src="resources/imojis/pngegg (19).png">
		<img class="imojis" src="resources/imojis/pngegg (20).png">
		<img class="imojis" src="resources/imojis/pngegg (21).png">
		<img class="imojis" src="resources/imojis/pngegg (22).png">
		<img class="imojis" src="resources/imojis/pngegg (23).png">
		<img class="imojis" src="resources/imojis/pngegg (24).png">
		<img class="imojis" src="resources/imojis/pngegg (25).png">
		<img class="imojis" src="resources/imojis/pngegg (26).png">
		<img class="imojis" src="resources/imojis/pngegg (27).png">
		<img class="imojis" src="resources/imojis/pngegg (28).png">
		<img class="imojis" src="resources/imojis/pngegg (29).png">
		<img class="imojis" src="resources/imojis/pngegg (30).png">
		<img class="imojis" src="resources/imojis/pngegg (31).png">
		<img class="imojis" src="resources/imojis/pngegg (32).png">
		<img class="imojis" src="resources/imojis/pngegg (33).png">
		<img class="imojis" src="resources/imojis/pngegg (34).png">
		
		</div>
	</div><!-- stickerlist end -->
	
<!-- main --> 
	<div id="main" class="paper">
		<div id="letter">
		<table>
		<tr>
		<c:forEach items="${getSearchMyBoard }" var="dto" varStatus="status">
			<td><img class="eggpaper" src="resources/eggs/144202.png"></td>
			<c:if test="${status.count%6==0}">
			</tr><tr>
			</c:if>
		</c:forEach>
		</tr>
		</table>
		</div>
		<div id="deco">
		</div>
	</div>

</div>

</body>
</html>