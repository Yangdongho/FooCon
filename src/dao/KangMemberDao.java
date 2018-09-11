package dao;

//import java.util.List;
import java.util.Map;


public interface KangMemberDao {
	
	/*로그인 시작*/
	public Map<String,Object> select_emailLogin(String memberEmail);
	/*로그인 종료*/
	
	/*member 비밀번호 찾기 시작*/
	public Map<String,Object> select_emailFindPw(String memberEmail);
	public int update_pw(Map<String, Object> param);
	/*member 비밀번호 찾기 종료*/
	
	
	/*member 회원가입 시작*/
	public Map<String,Object> select_EmailJoin(String memberEmail);
	public Map<String,Object> select_NickJoin(String memberNick);
	public Map<String,Object> select_PhoneNumJoin(String memberPhone);
	public int insertMember(Map<String, Object> member);
	/*member 회원가입 종료*/
	
	
	/*member myPage 가기전  패스확인 시작*/
	public Map<String,Object> select_emailPwCheck(String memberEmail);
	/*member myPage 가기전  패스확인 종료*/
	
	
	/*member myPage 기능 모음 시작*/
	public Map<String,Object> select_emailQuitPwCheck(String memberEmail);
	public int deleteMember(String memberEmail);
	public Map<String,Object> selectNick(String Nick);
	public int updateNick(Map<String, Object> param);
	public Map<String,Object> select_emailOriginpassCheck(String memberEmail);
	public int updatePass(Map<String, Object> param);
	public Map<String,Object> selectPhone(String memberPhone);
	public int updatePhoneNum(Map<String, Object> param);
	/*member myPage 기능 모음 종료*/
	
	public int updateMember(Map<String, Object> member);
	public Map<String,Object> selectPass(String memberPassword);
	
	
}
