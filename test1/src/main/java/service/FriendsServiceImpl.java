package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.FriendsDAO;
import dto.FriendsDTO;

@Service
public class FriendsServiceImpl implements FriendsService {
	
	@Autowired
	FriendsDAO dao;

	public List<FriendsDTO> friendsList(String myid){
		return dao.friendsList(myid);
	}

	@Override
	public int isBookmarkedFriends(FriendsDTO dto) {
		return dao.isBookmarkedFriends(dto);
	}

	@Override
	public int addFriends(FriendsDTO dto) {
		return dao.addFriends(dto);
	}

	@Override
	public int deleteFriends(FriendsDTO dto) {
		return dao.deleteFriends(dto);
	}
	
	@Override
	public List<FriendsDTO> searchFriends(String myid, String author) {
	  return dao.searchFriends(myid, author);
	}
	
}//class

