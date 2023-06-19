package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDAO;
import dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO dao;

	//회원정보조회
	public MemberDTO oneMember(String id) {
		return dao.oneMember(id);
	}
	
	//회원가입
    public void addMember(MemberDTO member) {
        dao.addMember(member);
    }
    
    //id중복여부
    public int isMemberIdExist(String inputId) {
    	return dao.isMemberIdExist(inputId);
    }
    
    //email중복여부
    public int isMemberEmailExist(String inputEmail) {
    	return dao.isMemberEmailExist(inputEmail);
    }
    
    
    //[관리자]회원리스트용 추가-----
    //[관리자]회원리스트용(전체 회원수)
    public int getTotalMember() {
    	return dao.getTotalMember();
	}

    //[관리자]회원리스트용(회원리스트 페이징처리)
	public List<MemberDTO> memberPagingList(ArrayList<MemberDTO> limit) {
		return dao.memberPagingList(limit);
	}

	//[관리자]회원리스트용(회원삭제)
	public int deleteMember(String memberid) {
		return dao.deleteMember(memberid);
	}
    
	//회원 비밀번호찾기
    public MemberDTO findpw(String id) {
        return dao.oneMember(id);
    }
    
  //myinfo- 내정보 조회.(비번원래값db서찾아오기)
    public MemberDTO myinfo(String id) {
        return dao.oneMember(id);
    }

    //myinfo-비번수정(변경)
    public int updateMember(MemberDTO member) {
        return dao.updateMember(member);
    }
	
}//class

