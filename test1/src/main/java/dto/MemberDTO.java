package dto;

import org.springframework.stereotype.Component;

@Component
public class MemberDTO {
	String memberid, email, pw, regtime;
	int reported;
	
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	public int getReported() {
		return reported;
	}
	public void setReported(int reported) {
		this.reported = reported;
	}
	
	
}
