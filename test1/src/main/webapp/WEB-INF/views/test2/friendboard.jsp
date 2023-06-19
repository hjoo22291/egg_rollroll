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
<link href="resources/css/modal.css" rel="stylesheet"/>
<style>
.eggpaper {
width: 146px; height: 146px;
margin:0px;
cursor: pointer;
}

.outerdiv{
margin : 0px 22px;
width: 152px; height: 146px;
display: flex;
justify-content: center;
align-items: center;
}
</style>
</head>
<script>
$(document).ready(function(){
	
	updateButtons();
	
	//친구 id url에서 가져오기
	var friendId = location.href.split('/')[(location.href.split('/').length-1)];
	let welcomemsg = "< "+friendId + "님의 달걀판 >";
	$("#whosepage").html(welcomemsg);
	
	//myhome클릭	
	$("#myhome").on('click', function(){ location.href="/rollroll/mainafterlogin"; });
	
	//eggrollroll글씨 클릭
	$("#head").on('click', function(){ location.reload(); });
	
	//글쓰기클릭 - 새창띄우기
 	$("#write").on('click', function(){ 
		open("/rollroll/writeformtofriend", "글쓰기", "width=700px, height=500px, top=150, left=300");
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
    
    
    //모달창 
    //const closeBtn = modal.querySelector("#closeBtn");
    const openModal = () =>{ modal.classList.remove("hidden");}
    const closeModal = () =>{modal.classList.add("hidden");}
    const modal = document.querySelector(".modal");
    const overlay = modal.querySelector(".modal_overlay");
    
    //달걀 눌렀을때 modal 오픈 - boarddetail
    $('#letter').on('click', 'img', function(){ 
    	$.ajax({
			url : 'ajaxboarddetail',
			type : 'get',
			data : {'seq' : $(this).attr("id") }, //클릭한 img의 id값
			dataType : 'json', 
			success : function(response){ 				
				$('#contents').text(response.contents);
				$('#nickname').val(response.nickname);
				$('#seq').val(response.seq);
				$('#boardpw').val(response.boardpw);
				//alert(response.eggcolor);
 				if(response.eggcolor === "brown") {
					$('.modal_content').css({
						"background":"url(http://localhost:8031/rollroll/resources/eggs/4754.png)",
						"background-size" : "cover"
					}); 		
				}else{
					$('.modal_content').css({
						"background":"url(http://localhost:8031/rollroll/resources/eggs/4753.png)",
						"background-size" : "cover"
					});
				}
			}, 
			error : function(request, status, e) {
				alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
			}
		});//ajax
    	openModal();
    });//달걀누르기
    
    //모달 끄기
	overlay.addEventListener("click", function(){ closeModal();	}); //주변부 누르면 종료되는코드
    $('#closeBtn').on('click', function(){ closeModal(); });
    
	
	//친구페이지의경우 보드 불러오기
	//var friendId = location.href.split('/')[(location.href.split('/').length-1)]; //맨위에추가
	$(".pagelink").on('click',function(){
	    $('#letter').load('/rollroll/'+friendId+'/'+$(this).html()+' #letter');
	});
	
  	
	//삭제하기 눌렀을때 비밀번호 입력후 글 삭제 
	$("#boarddeletebtn").on('click', function(){
 		const inputboardpw = prompt("글 작성시 입력한 비밀번호를 입력하세요");
		const boardpw = $('#boardpw').val();
		//글 비밀번호랑 맞으면 삭제
  		if(inputboardpw == boardpw) {
 			$.ajax({
 				url : 'boarddelete',
 				type : 'post',
 				data : {'seq' : $('#seq').val() }, //클릭한 글의 seq값
 				success : function(response){ 
 					let divid = $('#seq').val(); //삭제할 div id값이 글 seq값이니까 변수로 저장해서사용
 					$("#"+divid).remove();
 					alert("삭제되었습니다.");
 					closeModal();
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
		}else {
			alert("비밀번호가 맞지 않습니다.");
		}
		
	});//delete
	
	//수정하기
	$("#boardupdatebtn").on('click', function(e){
 		const inputboardpw = prompt("글 작성시 입력한 비밀번호를 입력하세요");
		const boardpw = $('#boardpw').val();
	
 		//글 비밀번호랑 맞으면 수정폼 열리기 & 정보 넘겨주기
	 	if(inputboardpw == boardpw) {
	 		let divid = $('#seq').val();
	 		open("/rollroll/boardupdateform?seq="+divid, "글쓰기", "width=700px, height=500px, top=150, left=300");
	 	}else {
			alert("비밀번호가 맞지 않습니다.");	 		
	 	}
	}); //click boardupdatebtn
   	
	
	//친구 북마크하기/빼기
	var friendsid = location.href.split('/')[(location.href.split('/').length-1)];
	
	$('#buttonsContainer').on('click', function(){
		$.ajax({
				url : 'bookmark',
				type : 'post',
				data : {'myid' : "${sessionid}", 'friendsid' : friendsid }, 
				dataType : 'json',
				success : function(response){ 
					if($.trim(response.result) ==="add") {
						//alert("친구가 추가되었습니다.");
						$('#bookmark').text("BookMarked!");
					} else if($.trim(response.result) ==="delete"){
						//alert("친구 목록에서 삭제되었습니다.");
						$('#bookmark').text("Bookmark");
					}
				}, 
				error : function(request, status, e) {
					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
				}
			});//ajax
	});//친구즐겨찾기
	


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
		<br>
		<h3 id="whosepage"></h3>
		<div id="menu">
		<nav>
			<ul>
				<li id="buttonsContainer"></li>
				<li><button id="myhome" class="anbtn">My Home</button></li>
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
		<div id="imogi_box">
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
		<c:forEach items="${getSearchMyBoard }" var="dto" varStatus="status">
			<c:if test="${dto.eggcolor == 'white'}">
			<div id="${dto.seq}" class="outerdiv"><img id="${dto.seq}" class="eggpaper" src="resources/eggs/144202.png"></div>			
			</c:if>
			<c:if test="${dto.eggcolor == 'brown'}">
			<div id="${dto.seq}" class="outerdiv"><img id="${dto.seq}" class="eggpaper" src="resources/eggs/144201.png"></div>			
			</c:if>
		</c:forEach>
		</div>
		<div id="deco">
		</div>
	</div>
	<div id="pageinfobox">
		<div id="pagenum">
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
					<button class='pagelink' id="<%=i %>page"><%=i %></button>
			<%		
				}
			%>
		</div>		
	</div>

<!-- modal -->
	<div class="modal hidden">
      <div class="modal_overlay"></div>
      <div class="modal_content">
      	<div style="display:flex; justify-content: flex-end; padding-right: 10px">
        <button id="closeBtn" style="font-size:20px">X</button>
        </div>
        <div id="writeBox">
			<form method=post>
				<input type=hidden name="seq" id="seq" value=""> 
				<textarea cols="20" rows="8" name="contents" id="contents" readonly>
				</textarea><br>
				from : <input type=text name="nickname" id="nickname" readonly><br>
<!-- 				<input type="radio" name="eggcolor" id="white" value="white" checked />white
	            <input type="radio" name="eggcolor" id="brown" value="brown" />brown -->
				<input type=hidden name="boardpw" id="boardpw" value=""><br>
			</form>
			<div id= below>
				<input type=button id="boardupdatebtn" value="수정하기">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type=button id="boarddeletebtn" value="삭제하기">
			</div>
          </div>
      </div>
    </div><!-- modal hidden end -->


</div>
 <!-- test -->
<script>
	//추가된 친구인지 아닌지에따라 버튼 변경하기
	function updateButtons() {
		var friendsid = location.href.split('/')[(location.href.split('/').length-1)];
    	$.ajax({
            url: 'isbookmarked',
            type : 'post',
			data : {'myid' : "${sessionid}", 'friendsid' : friendsid }, 
			dataType : 'json',
			success : function(response){ 
				if(response == 1 ) {
					$('#buttonsContainer').html('<button id="bookmark" class="anbtn">Bookmarked!</button>');
				} else if(response == 0){
					$('#buttonsContainer').html('<button id="bookmark" class="anbtn">Bookmark</button>');
				}
			}, 
			error : function(request, status, e) {
				alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
			}
		});//ajax

    } // updatebuttons end

</script>
</body>
</html>