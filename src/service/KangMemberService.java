package service;

import java.util.List;
import java.util.Map;

public interface KangMemberService {
	
	/*로그인 시작*/
	public boolean CheckQuitMember(String memberEmail);
	public boolean login(String memberEmail,String memberPassword);
	public Map<String, Object> getMember(String memberEmail);
	/*로그인 종료*/
	
	/*비밀번호 찾기 시작*/
	public boolean CheckQuitMemberPwFind(String memberEmail);
	public boolean checkEmailPwFind(String memberEmail);
	public String tempPassPwFind(String memberEmail);
	public Map<String, Object> EmailPwFind(String memberEmail);
	/*비밀번호 찾기 종료*/
	
	
	/*회원가입 시작*/
	public boolean checkEmailJoin(String memberEmail);
	public boolean checkNickJoin(String memberNick);
	public boolean checkPhoneNumJoin(String memberNick);
	public boolean joinMember(Map<String, Object> member);
	/*회원가입 종료*/
	
	
	/*myPage 페이지 진입 전 패스워드 확인 시작*/
	public boolean pwCheck(String memberEmail,String memberPassword);
	public Map<String, Object> getMemberPwCheck(String memberEmail);
	/*myPage 페이지 진입 전 패스워드 확인 종료*/
	
	
	/*myPage 기능 모음 시작*/
	public Map<String, Object> getMemberMyPage(String memberEmail);
	public boolean quitPwCheck(String memberEmail,String memberPassword);
	public String quitMember(String memberEmail);
	public boolean NickCheck(String nick);
	public boolean updateNick(String nick,String memberEmail);
	public boolean originpassCheck(String originPassword, String memberEmail);
	public boolean doubleCheckPass(String wantingPass,String wantingPassCheck);
	public boolean updatePass(String memberPassword,String memberEmail);
	public boolean doubleCheckPhoneNum(String memberPhone,String memberPhoneCheck);
	public boolean phoneNumCheck(String memberPhone);
	public boolean updatePhoneNum(String memberPhone,String memberEmail);
	/*myPage 기능 모음 종료*/
	
	
	public List<Map<String, Object>> getAllMembers();
	
	public boolean modifyMember(Map<String,Object> member);
	public boolean removeMember(String memberEmail);
	
	
	
	
	
	
	
	
	
	
}
