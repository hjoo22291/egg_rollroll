package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.BoardDTO;
import service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService service;

	@GetMapping("/boardwrite")
	public String writeform() {
		return "test1/writeform";
	}
	
	@PostMapping("/boardwrite")
    public ModelAndView writeprocess(BoardDTO dto){
        service.insertBoard(dto);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("test1/writeresult");
        return mv;
    }
	
	//로그인했을때 & page번호 눌렀을때 (매개변수 int page)
	@RequestMapping("/mainafterlogin")
	public ModelAndView boardlist(HttpSession session, @RequestParam(value="page", required=false, defaultValue="0" ) int page) {
		//전체 게시물 갯수 가져와서 몇페이지까지 가져올수있는지 (1페이지당 30개씩 보여주도록 할때)
		String receiver = (String)session.getAttribute("sessionid");
		int myBoard = service.getCountMyBoard(receiver);
		
		//처음 로드될때 최신글이 있는 마지막 페이지로 & page값 있을땐 그 page가 로드되도록
		int returnPage = 0;
		if(myBoard > 0) {
			if(page==0) {
				if(myBoard % 30 == 0){
					returnPage = myBoard / 30;
				}
				else {
					returnPage = myBoard / 30 + 1;
				}
			}else {
				returnPage = page;
			}
		}
		else {
			returnPage = 1;
		}

		//page번호 해당 게시물 30개 리스트 조회
		int limitnum = (returnPage-1)*30;
		String limitcount = String.valueOf(30);
		String limitindex = String.valueOf( limitnum );
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", "receiver");
		map.put("colvalue", receiver);
		map.put("limitindex", limitindex);
		map.put("limitcount", limitcount);

		List<BoardDTO> list = service.getSearchMyBoard(map);

		ModelAndView mv = new ModelAndView();
		mv.addObject("myBoard", myBoard );
		mv.addObject("getSearchMyBoard", list );
		mv.setViewName("test1/mainafterlogin"); 
		//mv.setViewName("test3/mainafterlogin");
		return mv;	
	}	

	//클릭한 게시물 상세조회
	@RequestMapping(value="/ajaxboarddetail", produces = {"application/json;charset=utf-8"})
	public @ResponseBody BoardDTO ajaxboarddetail (int seq) {
		BoardDTO dto = service.getBoardDetail(seq);
		return dto;	
	}
	

	//게시물 삭제
	//@RequestMapping("/boarddelete")
	@RequestMapping(value="/boarddelete", produces = {"application/json;charset=utf-8"})
	public String boarddelete(int seq){
		service.deleteBoard(seq);
		return "redirect:/mainafterlogin"; //redirect : 컨트롤러에서 해당 url에 매핑된 곳으로 가라.
	}
	
	
	//게시물 수정
	//게시물 상세조회해서 객체 수정폼으로 넘겨주기(Non ajax)
	@GetMapping("/boardupdateform")
	public ModelAndView boardupdateform(int seq) {
		BoardDTO dto = service.getBoardDetail(seq);
		ModelAndView mv = new ModelAndView();
		mv.addObject("detaildto", dto);
		mv.setViewName("test1/boardupdateform");
		return mv;
	}
	
	@RequestMapping("/boardupdate")
	public ModelAndView boardupdate(BoardDTO dto){
		//System.out.println("보드컨트롤러 : boardupdate(BoardDTO dto)출력");
		service.updateBoard(dto);
		ModelAndView mv = new ModelAndView();
        mv.setViewName("test1/writeresult");
        return mv;
	}
	
///////////////////////////친구페이지방문시 - url에 id정보넣어서 그 id = receiver인 글 목록 불러온 화면 보여주기/////////////////////////////////
	//참고파일 : AjaxController -> url에 변수를 넣는 방식 - 1) url에 {변수}로 추가
	@RequestMapping(value="/{id}")
	public ModelAndView friendboard(
			@PathVariable("id") String receiver, 
			@RequestParam(value="page", required=false, defaultValue="0" ) int page) {
		//전체 게시물 갯수 가져와서 몇페이지까지 가져올수있는지 (1페이지당 30개씩 보여주도록 할때)
		int myBoard = service.getCountMyBoard(receiver);
		
		//처음 로드될때 최신글이 있는 마지막 페이지로 & page값 있을땐 그 page가 로드되도록
		int returnPage = 0;
		if(myBoard > 0) {
			if(page==0) {
				if(myBoard % 30 == 0){
					returnPage = myBoard / 30;
				}
				else {
					returnPage = myBoard / 30 + 1;
				}
			}else {
				returnPage = page;
			}
		}
		else {
			returnPage = 1;
		}

		//page번호 해당 게시물 30개 리스트 조회
		int limitnum = (returnPage-1)*30;
		String limitcount = String.valueOf(30);
		String limitindex = String.valueOf( limitnum );
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", "receiver");
		map.put("colvalue", receiver);
		map.put("limitindex", limitindex);
		map.put("limitcount", limitcount);

		List<BoardDTO> list = service.getSearchMyBoard(map);

		ModelAndView mv = new ModelAndView();
		mv.addObject("myBoard", myBoard );
		mv.addObject("getSearchMyBoard", list );
		//mv.setViewName("test1/mainafterlogin");
		mv.setViewName("test2/friendboard");
		return mv;	
	}	

	//친구페이지 페이징처리
	  @RequestMapping("/{id}/{page}") 
	  public ModelAndView yourPaging(@PathVariable("id") String receiver, @PathVariable("page") int page) {
		  int myBoard = service.getCountMyBoard(receiver);
			
		  //처음 로드될때 최신글이 있는 마지막 페이지로 & page값 있을땐 그 page가 로드되도록
			int returnPage = 0;
			if(myBoard > 0) {
				if(page==0) {
					if(myBoard % 30 == 0){
						returnPage = myBoard / 30;
					}
					else {
						returnPage = myBoard / 30 + 1;
					}
				}else {
					returnPage = page;
				}
			}
			else {
				returnPage = 1;
			}

			//page번호 해당 게시물 30개 리스트 조회
			int limitnum = (returnPage-1)*30;
			String limitcount = String.valueOf(30);
			String limitindex = String.valueOf( limitnum );
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("colname", "receiver");
			map.put("colvalue", receiver);
			map.put("limitindex", limitindex);
			map.put("limitcount", limitcount);

			List<BoardDTO> list = service.getSearchMyBoard(map);

			ModelAndView mv = new ModelAndView();
			mv.addObject("myBoard", myBoard );
			mv.addObject("getSearchMyBoard", list );
			//mv.setViewName("test1/mainafterlogin");
			mv.setViewName("test2/friendboard");
			return mv;	
	   }

	//친구한테 편지보내기(writeform to friend)
	@GetMapping("/writeformtofriend")
	public String writeformtofriend() {
		return "test2/writeformtofriend";
	}
	

}//class




