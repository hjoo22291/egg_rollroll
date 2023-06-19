package dto;

import org.springframework.stereotype.Component;

@Component
public class FriendsDTO {
	String myid, friendsid;

	public String getMyid() {
		return myid;
	}

	public void setMyid(String myid) {
		this.myid = myid;
	}

	public String getFriendsid() {
		return friendsid;
	}

	public void setFriendsid(String friendsid) {
		this.friendsid = friendsid;
	}
	
	
}
