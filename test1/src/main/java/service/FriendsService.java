package service;

import java.util.List;

import dto.FriendsDTO;

public interface FriendsService {
	public List<FriendsDTO> friendsList(String myid);
	public int isBookmarkedFriends(FriendsDTO dto);
	public int addFriends(FriendsDTO dto);
	public int deleteFriends(FriendsDTO dto);
	public List<FriendsDTO> searchFriends(String myid, String author);
	
}//class
