package service;

import java.util.ArrayList;
import java.util.List;

import dto.MemberDTO;

public interface MemberService {
	MemberDTO oneMember(String id);
    void addMember(MemberDTO member);
    //id중복여부
    public int isMemberIdExist(String inputId);
    //email중복여부
    public int isMemberEmailExist(String inputEmail);
    
    //[관리자]회원리스트 추가-----
    public int getTotalMember();
	public List<MemberDTO> memberPagingList(ArrayList<MemberDTO> limit);
	public int deleteMember(String memberid);
	//비밀번호찾기
	public MemberDTO findpw(String id);
	
	 //myinfo 비번수정1-내비번찾아오기.
    public MemberDTO myinfo(String id);

    //myinfo 비번수정-내비번바꾸기
    public int updateMember(MemberDTO member);
}//class
