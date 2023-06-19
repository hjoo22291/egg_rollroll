package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.BoardDTO;
import dto.FriendsDTO;
import service.FriendsService;

@Controller
public class FriendsController {
	
	@Autowired
	FriendsService service;
	
	//즐겨찾기한 친구 id list 가져오기
	@RequestMapping(value="/friendslist", produces = {"application/json;charset=utf-8"})
	public @ResponseBody List<FriendsDTO> friendslist(String myid) {
		List<FriendsDTO> friendslist = service.friendsList(myid);
		return friendslist;	
	}
	
	//즐겨찾기된 친구인지 아닌지 구분해서 친구 추가/삭제
	@RequestMapping(value="/bookmark", produces = {"application/json;charset=utf-8"})
	public @ResponseBody String bookmark(String myid, String friendsid) {
		FriendsDTO dto = new FriendsDTO();
		dto.setMyid(myid);
		dto.setFriendsid(friendsid);
		
		int isBookmarked = service.isBookmarkedFriends(dto);
		String result="";
		if(isBookmarked == 0) {
			service.addFriends(dto);
			result = "add";
		}
		else if(isBookmarked == 1) {
			service.deleteFriends(dto);
			result = "delete";
		}
		
		return "{\"result\" : \"" + result+ " \" }";
		
	}//친구 추가/삭제
	
	//즐겨찾기된 친구인지 아닌지 구분해서 친구 추가/삭제
	@RequestMapping(value="/isbookmarked", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int isbookmarked(String myid, String friendsid) {
		FriendsDTO dto = new FriendsDTO();
		dto.setMyid(myid);
		dto.setFriendsid(friendsid);
		
		int result = service.isBookmarkedFriends(dto);
		return result;
		
	}//친구 추가/삭제
	
	//친구 검색
		@RequestMapping(value="/searchfriends", produces = {"application/json;charset=utf-8"})
		public @ResponseBody List<FriendsDTO> searchFriends(String myid, String author) {
		  List<FriendsDTO> friendslist = service.searchFriends(myid, author);
		  return friendslist;
		}
	
	
	
	
}
