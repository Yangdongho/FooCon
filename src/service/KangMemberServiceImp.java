package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.KangMemberDao;

@Service
public class KangMemberServiceImp implements KangMemberService {
	
	
	@Autowired
	KangMemberDao memberDao;
	
	
	/***********************로그인 시작***********************/
	/*회원 탈퇴 유저인지 아닌지 조회 시작*/
	@Override
	public boolean CheckQuitMember(String memberEmail) {
		Map<String, Object>showQuitMember = memberDao.select_emailLogin(memberEmail);
		String check = (String) showQuitMember.get("QUITMEMBER");
		String quitMember = "Y";
		if(check.equals(quitMember)) {
			return false;
		}
		return true;
	}
	/*회원 탈퇴 유저인지 아닌지 조회 종료*/
	
	/*입력된 이메일 주소를 이용해 원래 비밀번호와 입력된 비밀번호가 같은지 조회 시작*/
	@Override
	public boolean login(String memberEmail, String memberPassword) {
		
		String email = memberEmail;
		String password = memberPassword;
		Map<String, Object> member = memberDao.select_emailLogin(email);
		if(member == null) {
			return false;
		}
		String originPass = (String) member.get("MEMBERPASSWORD");
		if (member != null) {
			if (originPass.equals(password)) {
				return true;
			}
		}
		return false;
	}
	/*입력된 이메일 주소를 이용해 원래 비밀번호와 입력된 비밀번호가 같은지 조회 종료*/
	
	
	/*세션값을 받아오기 위한 value값을 가져오기 시작*/
	@Override
	public Map<String, Object> getMember(String memberEmail) {
		String email = memberEmail;
		Map<String, Object> member = memberDao.select_emailLogin(email);
		
		return member;
	}
	/*세션값을 받아오기 위한 value값을 가져오기 종료*/
	/***********************로그인 종료***********************/
	
	
	@Override
	public List<Map<String, Object>> getAllMembers() {
		// TODO Auto-generated method stub
		return null;
	}

	

	@Override
	public boolean modifyMember(Map<String, Object> member) {
		if (memberDao.updateMember(member) > 0) {
			return true;
		}
		return false;
	}

	@Override
	public boolean removeMember(String memberEmail) {
		if (memberDao.deleteMember(memberEmail) > 0) {
			return true;
		}
		return false;
	}
	
	/***********************비밀번호 찾기 시작***********************/
	/*회원 탈퇴 유저인지 아닌지 조회 시작*/
	@Override
	public boolean CheckQuitMemberPwFind(String memberEmail) {
		Map<String, Object>showQuitMember = memberDao.select_emailFindPw(memberEmail);
		String check = (String) showQuitMember.get("QUITMEMBER");
		String quitMember = "Y";
		if(check.equals(quitMember)) {
			return false;
		}
		return true;
	}
	/*회원 탈퇴 유저인지 아닌지 조회 종료*/
	
	/*이메일 중복확인 시작*/
	@Override
	public boolean checkEmailPwFind(String memberEmail) {
		String email = memberEmail;
		
		// email을 이용해서 원래 정보 읽어옴
		Map<String, Object> member = memberDao.select_emailFindPw(email);
		
		// 원래 이메일과 입력받은 이메일 비교
		if (member != null) {
			return true;
		} else {
			return false;
		}
	}
	/*이메일 중복확인 종료*/
	
	/*이메일 값 가져오기 시작*/
	@Override
	public Map<String, Object> EmailPwFind(String memberEmail){
		Map<String, Object> member = memberDao.select_emailFindPw(memberEmail);
		return member;
	}
	/*이메일 값 가져오기 종료*/
	
	/*임시비밀번호 발급 시작*/
	@Override
	public String tempPassPwFind(String memberEmail) {
		String memberPassword = "";
		for (int i = 0; i < 12; i++) {
			memberPassword += (char) ((Math.random() * 26) + 97);
		}
		
		// 비밀번호 변경
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("MEMBERPASSWORD", memberPassword);
		param.put("MEMBEREMAIL", memberEmail);
		
		if(memberDao.update_pw(param)>0) {
		}else {
			return null;
		}
		return memberPassword;
	}
	/*임시비밀번호 발급 종료*/
	/***********************비밀번호 찾기 종료***********************/
	
	
	/***********************유저 회원가입 시작***********************/
	/*이메일 중복확인 시작*/
	@Override
	public boolean checkEmailJoin(String ownerEmail) {	
		Map<String, Object> param = memberDao.select_EmailJoin(ownerEmail);
		
		if(param == null) {
			return true;
		}else {
			return false;
		}
	}
	/*이메일 중복확인 종료*/
	
	/*닉네임 중복확인 시작*/
	@Override
	public boolean checkNickJoin(String memberNick) {	
		Map<String, Object> param = memberDao.select_NickJoin(memberNick);
		
		if(param == null) {
			return true;
		}else {
			return false;
		}
	}
	/*닉네임 중복확인 종료*/
	
	/*핸드폰번호 중복확인 시작*/
	@Override
	public boolean checkPhoneNumJoin(String memberPhone) {
		Map<String, Object> param = memberDao.select_PhoneNumJoin(memberPhone);
		
		if(param == null) {
			return true;
		}else {
			return false;
		}
	}
	/*핸드폰번호 중복확인 종료*/
	
	/*DB에 입력된 회원정보 넣기 시작*/
	@Override
	public boolean joinMember(Map<String, Object> member) {
		int result = memberDao.insertMember(member);
		
		if(result>0) {
			return true;
		}else {
			return false;
		}
	}
	/*DB에 입력된 회원정보 넣기 종료*/
	/***********************유저 회원가입 종료***********************/
	
	
	/***********************myPage 페이지 전환전 패스워드 확인 시작***********************/
	/*비밀번호 검사 시작*/
	@Override
	public boolean pwCheck(String memberEmail, String memberPassword) {
		
		String email = memberEmail;
		String password = memberPassword;
		Map<String, Object> member = memberDao.select_emailPwCheck(email);
		String originPass = (String) member.get("MEMBERPASSWORD");
		if (member != null) {
			if (originPass.equals(password)) {
				return true;
			}
		}
		return false;
	}
	/*비밀번호 검사 종료*/
	
	/*로그인 할 정보 가져오기 시작*/
	@Override
	public Map<String, Object> getMemberPwCheck(String memberEmail) {
		Map<String, Object> member =  memberDao.select_emailPwCheck(memberEmail);
		return member;
	}
	/*로그인 할 정보 가져오기 종료*/
	/***********************myPage 페이지 전환전 패스워드 확인 종료***********************/
	
	
	/***********************myPage 기능모음 시작***********************/
	/*myPage 로그인한 정보 가져오기 시작*/
	@Override
	public Map<String, Object> getMemberMyPage(String memberEmail) {
		Map<String, Object> member =  memberDao.select_emailPwCheck(memberEmail);
		return member;
	}
	/*myPage 로그인한 정보 가져오기 종료*/
	
	/*myPage 회원탈퇴 시작*/
	@Override
	public boolean quitPwCheck(String memberEmail,String memberPassword) {
		String email = memberEmail;
		String password = memberPassword;
		Map<String, Object> member = memberDao.select_emailQuitPwCheck(email);
		String originPass = (String) member.get("MEMBERPASSWORD");
		if (member != null) {
			if (originPass.equals(password)) {
				return true;
			}
		}
		return false;
	}
	@Override
	public String quitMember(String memberEmail) {
		String email = memberEmail;
		memberDao.deleteMember(email);
		return email;
	}
	/*myPage 회원탈퇴 종료*/

	
	/*닉네임 변경하기 시작*/ 
	/*닉네임 중복검사 시작*/
	@Override
	public boolean NickCheck(String nick) {
		// nick을 이용해서 원래 정보 읽어옴
		Map<String, Object> member = memberDao.selectNick(nick);
		
		if(member != null) {
		}else {
			return true;
		}
		return false;
	}
	/*닉네임 중복검사 종료*/
	
	/*닉네임 중복검사후 닉네임 변경 시작*/
	@Override
	public boolean updateNick(String nick,String memberEmail) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("NICK", nick);
		param.put("MEMBEREMAIL", memberEmail);
		
		int result = memberDao.updateNick(param);
		
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*닉네임 중복검사후 닉네임 변경 종료*/
	/*닉네임 변경하기 종료*/ 
	
	
	/*myPage 페이지에서 비밀번호 변경 시작*/
	/*현재 비밀번호가 맞는지 확인 시작*/
	@Override
	public boolean originpassCheck(String originPassword, String memberEmail ) {

		String email = memberEmail;
		String password = originPassword;
		Map<String, Object> member = memberDao.select_emailOriginpassCheck(email);
		String originPass = (String) member.get("MEMBERPASSWORD");
		if (member != null) {
			if (originPass.equals(password)) {
				return true;
			}
		}
		return false;
	}
	/*현재 비밀번호가 맞는지 확인 종료*/
	
	/*변경할 비밀번호 한번 더 확인 시작*/
	@Override
	public boolean doubleCheckPass(String wantingPass,String wantingPassCheck) {
		if (wantingPass.equals(wantingPassCheck)) {
			return true;
		}else {
			return false;
		}
	}
	
	/*변경할 비밀번호 한번 더 확인 종료*/
	
	/*비밀번호 변경 시작*/
	@Override
	public boolean updatePass(String memberPassword,String memberEmail) {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("MEMBERPASSWORD", memberPassword);
		param.put("MEMBEREMAIL", memberEmail);
		
		int result = memberDao.updatePass(param);
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*비밀번호 변경 종료*/
	/*myPage 페이지에서 비밀번호 변경 종료*/
	
	/*myPage 페이지에서 핸드폰번호 변경 시작*/
	/*작성된 폰번호의 더블체크 시작*/
	@Override
	public boolean doubleCheckPhoneNum(String memberPhone,String memberPhoneCheck) {
		if (memberPhone.equals(memberPhoneCheck)) {
			return true;
		}else {
			return false;
		}
	}
	/*작성된 폰번호의 더블체크 종료*/
	
	/*작성된 폰번호를 DB상에서 중복된 번호가 있는지 확인 시작*/
	public boolean phoneNumCheck(String memberPhone) {
		// phoneNum을 이용해서 원래 정보 읽어옴
		Map<String, Object> member = memberDao.selectPhone(memberPhone);
		
		if(member != null) {	
		}else {
			return true;
		}
		return false;
	}
	/*작성된 폰번호를 DB상에서 중복된 번호가 있는지 확인 종료*/
	
	/*폰번호 변경 시작*/
	@Override
	public boolean updatePhoneNum(String memberPhone,String memberEmail) {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("MEMBERPHONE", memberPhone);
		param.put("MEMBEREMAIL", memberEmail);
		
		int result = memberDao.updatePhoneNum(param);
		if (result > 0) {
			return true;
		}
		return false;
	}
	/*폰번호 변경 종료*/
	/*myPage 페이지에서 핸드폰번호 변경 종료*/
	/***********************myPage 기능모음 종료***********************/
	/***********************admin 로그인 페이지 기능모음 종료***********************/
}
