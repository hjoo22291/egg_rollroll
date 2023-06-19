package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.MemberDTO;
import service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	//로그인
	@GetMapping("/memberlogin")
	public String loginform() {
		return "test1/loginform";
	}
	
	@PostMapping("/memberlogin")
    public String memberlogin(String memberid, String pw, HttpSession session) {
        MemberDTO dto = service.oneMember(memberid); 
        if(dto != null) {
            //DB pw== 입력pw
            if( (dto.getPw()).equals(pw)) { 
                 session.setAttribute("sessionid", memberid);
                    return "/test1/loginresult";
            }
            else {
                 session.setAttribute("sessionid","비번다름");
                    return "/test1/loginform";
            }
        }//if-end
        else {//아이디가 DB에 없을때.
             session.setAttribute("sessionid", "미가입자");
            return "/test1/loginform";
        }
	}//로그인
	
	//로그아웃
	@RequestMapping("/memberlogout")
	public String memberlogout(HttpSession session) {
		if(session.getAttribute("sessionid") != null) { //로그인한 세션 정보가 있으면
			session.removeAttribute("sessionid"); //세션정보 없애라 = 로그아웃해라
		}//if
		//return "test1/main";
		return "redirect:/";
	}
	
    // 회원가입
    @GetMapping("/memberjoin")
    public String joinForm() {
        return "test1/joinform";
    }

    @PostMapping("/memberjoin")
    public String memberjoin(MemberDTO member) {
        service.addMember(member);
        return "redirect:/memberlogin";
    }
    
    //id중복여부
//    @RequestMapping(value="/ismemberexist", produces = {"application/json;charset=utf-8"})
//    public @ResponseBody int isMemberexist(String inputId) {
//    	int result = service.isMemberexist(inputId);
//    	return result;
//    }
    
    //id, email 중복여부
    @RequestMapping(value="/ismemberexist", produces = {"application/json;charset=utf-8"})
    public @ResponseBody String isMemberexist(String inputId, String inputEmail) {
    	int idresult = service.isMemberIdExist(inputId);
    	int emailresult = service.isMemberEmailExist(inputEmail);
    	String result = "";
    	if( idresult == 0 && emailresult == 0) {
    		result = "ok";
    	}
    	else if(idresult == 1 && emailresult == 0) {
    		result = "one_id";
    	}
    	else if(idresult == 0 && emailresult == 1) {
    		result = "one_email";
    	}
    	else {
    		result = "both";
    	}
    	return "{\"result\" : \"" + result+ " \" }";
    }

    
  //비밀번호찾기1(폼)
    @GetMapping("/findpwform")
    public String findpwform() {
        return "test1/findpwform";
    }

    //비밀번호찾기2(비밀번호찾기처리)
      @PostMapping("/findpwform")
      public String findpw(String memberid, String email,HttpSession session) {
          MemberDTO dto = service.findpw(memberid);
          //id입력했을때.
          if(dto != null) {
            //DB email== 입력email
            if( (dto.getEmail()).equals(email)) { 
                session.setAttribute("sessionmsg","임시 비밀번호를 등록하신 이메일로 전송하였습니다.");
                return "/test1/findpwresult";
            }//if end(아이디,email같음)
            else {
                session.setAttribute("sessionmsg","입력하신 이메일이 올바르지 않습니다.");
                return "/test1/findpwresult";
            }//else end(아이디와 email이다름)

          }//if end(아이디있을때)
          else {//아이디가 DB에 없을때.
        session.setAttribute("sessionmsg", "가입된 아이디가 없습니다.");
        return "/test1/findpwresult";
          }//else end
      }//비밀번호찾기end
	
    //myinfo 비번수정-----------------------
      @GetMapping("/myinfoform")
      public String myinfoform(HttpSession session) {
          String session_id = (String) session.getAttribute("sessionid");
          MemberDTO dto = service.myinfo(session_id);
          String dtoId = dto.getMemberid();
          String dtoEmail= dto.getEmail();

          //sessionid와 dto의 id가 같을 때(혹시몰라서)
          if(session_id.equals(dtoId)) {
          session.setAttribute("myinfoid", dtoId);
          session.setAttribute("myinfoemail", dtoEmail);
          session.setAttribute("originalpw", dto.getPw());
          }
          else {System.out.println("세션id, dto아이디 다름");}

          return "test1/myinfoform";
      }

      //myinfo 기존비번 받고->뉴 비번 번경.
      @PostMapping("/myinfoform")
      public String myinfo(@RequestParam(value="pw") String pw, HttpSession session) {
          String sessionid = (String) session.getAttribute("sessionid");
          MemberDTO dto = service.oneMember(sessionid); 
          dto.setPw(pw);
          service.updateMember(dto);
          return "test1/myinforesult";
      }//myinfo비밀번호찾기end 
      
    //myinfo -이메일 거쳐가기.
      @RequestMapping("/myinfocheck")
      public String myinfocheck(HttpSession session) {
          String session_id = (String) session.getAttribute("sessionid");
          MemberDTO dto = service.myinfo(session_id);
          String dtoId = dto.getMemberid();
          String dtoEmail= dto.getEmail();


        //sessionid와 dto의 id가 같을 때(혹시몰라서)
          if(session_id.equals(dtoId)) {
          session.setAttribute("myinfoid", dtoId);
          session.setAttribute("myinfoemail", dtoEmail);
          session.setAttribute("originalpw", dto.getPw());
          }
          else {System.out.println("세션id, dto아이디 다름");}

          return "test1/myinfocheck";
      }     
 
      //회원탈퇴
      @RequestMapping(value="/deleteme", produces = {"application/json;charset=utf-8"})
      public @ResponseBody String deleteme(String memberid, HttpSession session ){
          service.deleteMember(memberid);
          session.removeAttribute("sessionid");
          String result = "ok";
          return "{\"result\" : \"" + result+ " \" }";
      }
      
}
