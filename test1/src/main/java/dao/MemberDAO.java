package dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MemberDTO;

@Repository
public class MemberDAO { //메인이 아닌 DAO가 처리하도록 만들기

	@Autowired
	SqlSession session;
	
	//회원한명정보조회 - 로그인시 활용
	public MemberDTO oneMember(String id) {
		return session.selectOne("oneMember", id); 
	}
	
	//회원가입
    public void addMember(MemberDTO member) {
        session.insert("addMember", member);
    }
    
    //id중복여부
    public int isMemberIdExist(String inputId) {
    	return session.selectOne("isMemberIdExist", inputId);
    }
    
    //id중복여부
    public int isMemberEmailExist(String inputEmail) {
    	return session.selectOne("isMemberEmailExist", inputEmail);
    }
    
    
  //[관리자-회원리스트 추가용]--------------
    //[관리자 회원]-회원리스트(리스트-페이징용-총회원수)
  	public int getTotalMember() {
  		return session.selectOne("getTotalMember");
  	}
  	
  	//[관리자 회원]-회원리스트(페이징) 
  	public List<MemberDTO> memberPagingList(ArrayList<MemberDTO> limit){
  		return session.selectList("memberPagingList", limit);
  	}
    
  	//[관리자 회원]-회원리스트(회원 삭제);
  	public int deleteMember(String memberid) {
  		return session.update("deleteMember", memberid);
  	}
    
  //회원정보 - 비번수정1
    public int updateMember(MemberDTO member)  {
     return session.update("updateMember", member);
  }
    
    
}
