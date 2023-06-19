package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.BoardDTO;
import dto.FriendsDTO;
import dto.MemberDTO;
import service.BoardService;
import service.MemberService;

@Controller
public class AdminController {
	@Autowired
	BoardService service;
	
	@Autowired
	MemberService service2;

//	@RequestMapping("/adminmain")
//    public String adminmain() {
//        return "test1/adminmain";
//    }
	
	@PostMapping("/adminmain")
	public String adminmain() {
		return "test1/adminmain";
	}

    @PostMapping("/adminboardlist")
    public ModelAndView boardlist(@RequestParam(value="page", required=false, defaultValue="1" ) int page) {
        //전체 게시물 갯수 가져와서 몇페이지까지 가져올수있는지 (1페이지당 4개씩 보여주도록 할때)
        int totalBoard = service.getTotalBoard();

        //page번호 해당 게시물 10개 리스트 조회
        int limitcount = 10;
        int limitindex = (page-1)*limitcount;

        ArrayList mypage = new ArrayList();
        mypage.add(limitindex);
        mypage.add(limitcount);
        List<BoardDTO> list = service.boardPagingList(mypage);

        ModelAndView mv = new ModelAndView();
        mv.addObject("totalBoard", totalBoard );
        mv.addObject("boardList", list );
        mv.setViewName("test1/adminboardlist");
        return mv;
    }

    //게시물 삭제
    @PostMapping("/adminboarddelete")
    public String boarddelete(int seq){
        service.deleteBoard(seq);
        return "test1/adminmain";
    }
    
	
    //[관리자] 멤버 메뉴 추가***--------------------------------------------------------------------
    //관리자 - 회원리스트 페이징처리.
    @PostMapping("/adminmemberlist")
    public ModelAndView memberlist(@RequestParam(value="page", required=false, defaultValue="1" ) int page) {
        //전체 게시물 갯수 가져와서 몇페이지까지 가져올수있는지 (1페이지당 4개씩 보여주도록 할때)
        int totalMember = service2.getTotalMember();

        //page번호 해당 게시물 10개 리스트 조회
        int limitcount = 10;
        int limitindex = (page-1)*limitcount;

        ArrayList mypage = new ArrayList();
        mypage.add(limitindex);
        mypage.add(limitcount);
        List<MemberDTO> list = service2.memberPagingList(mypage);

        ModelAndView mv = new ModelAndView();
        mv.addObject("totalMember", totalMember );
        mv.addObject("memberList", list );
        mv.setViewName("test1/adminmemberlist");
        return mv;
    }
    
    //관리자 - 회원 삭제
    @PostMapping("/adminmemberdelete")
    public String memberdelete(String memberid){
        service2.deleteMember(memberid);
        return "test1/admingettopost";
    }
    
    
    //[관리자 메인] /adminmain서 작동하는 버튼***----------------------------------------------------------
	//관리자 - 로그아웃.
	 @PostMapping("/adminlogout") 
	 public String adminlogout(){
		 return "test1/adminlogout"; 
	 }
	 
	//관리자 멤버 페이지 번호 받는 url
		@PostMapping(value="/adminmemberpaging", produces = {"application/json;charset=utf-8"})
		public @ResponseBody List<MemberDTO> adminmemberpaginglist(int page) {
	        int totalMember = service2.getTotalMember();

	        //page번호 해당 게시물 10개 리스트 조회
	        int limitcount = 10;
	        int limitindex = (page-1)*limitcount;

	        ArrayList mypage = new ArrayList();
	        mypage.add(limitindex);
	        mypage.add(limitcount);
	        List<MemberDTO> list = service2.memberPagingList(mypage);

			return list;	
		}
		
		//관리자 보드페이지 번호 받는 url
		@PostMapping(value="/adminboardpaging", produces = {"application/json;charset=utf-8"})
		public @ResponseBody List<BoardDTO> adminboardpaginglist(int page) {
			int totalBoard = service.getTotalBoard();
			
			//page번호 해당 게시물 10개 리스트 조회
			int limitcount = 10;
			int limitindex = (page-1)*limitcount;
			
			ArrayList mypage = new ArrayList();
			mypage.add(limitindex);
			mypage.add(limitcount);
			List<BoardDTO> list = service.boardPagingList(mypage);
			
			return list;	
		}
	 
	 
	 
	 
}//class
