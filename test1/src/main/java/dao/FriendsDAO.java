package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.FriendsDTO;
import dto.MemberDTO;

@Repository
public class FriendsDAO {
	
	@Autowired
	SqlSession session;
	
	//즐겨찾기 친구 목록 가져오기
  	public List<FriendsDTO> friendsList(String myid){
  		return session.selectList("friendsList", myid);
  	}
  	
  	//즐겨찾기 되어있는지 count로 확인
  	public int isBookmarkedFriends(FriendsDTO dto) {
  		return session.selectOne("isBookmarkedFriends", dto);
  	}
  	
  	//친구추가
  	public int addFriends(FriendsDTO dto) {
        return session.insert("addFriends", dto);
    }
	
  	//친구삭제
  	public int deleteFriends(FriendsDTO dto) {
  		return session.update("deleteFriends", dto);
  	}
  	
    // 작성자로 친구 검색
    public List<FriendsDTO> searchFriends(String myid, String author) {
        HashMap<String, String> map = new HashMap<>();
        map.put("myid", myid);
        map.put("author", author);
        return session.selectList("searchFriends", map);
    }
  	
  	
}
