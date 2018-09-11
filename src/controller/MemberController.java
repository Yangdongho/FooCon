package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import service.KangMemberService;
import service.naraeService;

@Controller
@RequestMapping("/member")
public class MemberController {

	
	@Autowired
	naraeService service;
	
	//원래는 세션에 담겨있는 회원의 고유PK를 가지고 검색을 가지고 들어와야한다. 
	@RequestMapping("/interest")
//	public String interest(@RequestParam(defaultValue = "noMember") String memberPK, @RequestParam Map<String, Object> param, Model model) {
	public String interest(@RequestParam(defaultValue = "noMember") String memberPK, Model model, HttpSession session) {	
		//일단 세션이 없어서 M6을 박아놓고 보냄				
//		String myLit = (String)param.get("lit");
//		String myLot = (String)param.get("lot");
		
		//로그인 정보 세션에 없으면 관심트럭눌러도 메인으로 넘어감
		if(session.getAttribute("SEQ") == null) {
			
			return "redirect:/";
			
		}
		
//		double myLit = (double)session.getAttribute("lit");
//		double myLot = (double)session.getAttribute("lot");
		
		
		
		double mLit= 0.0;
		double mLot= 0.0;
		
		//만약 사용자가 허용을 누르지 않으면, 세션에 위도,경도에 대한 값이 없으니니까 디폴트 위도, 경도를 넣어준다.
		if((Double)session.getAttribute("lit") == null) {
	
			//비트캠프 위도 경도
			//사용자가 본인 위치 허용 안눌렀으면 디폴트 위도 경도를 session에 넣고 그 값을 꺼내서 사용한다
			session.setAttribute("lit", 37.494796);
			session.setAttribute("lot", 127.027583);
			
			mLit = (double)session.getAttribute("lit");
			mLot = (double)session.getAttribute("lot");
			
		}else {
		
			//사용자가 본인 위치 허용했을 때 위도, 경도 찍는 곳
			mLit = (double)session.getAttribute("lit");
			mLot = (double)session.getAttribute("lot");
		}
		
		
		
		
		
		//일단 서비스에서 원하는 memberPK를 통해서 원하는 리스트를 가지고 온다.
		List<Map<String, Object>> interestList = service.memberFavorBrand(memberPK);	
		
		List<Map<String, Object>> sortingList = service.favorSorting(interestList, mLit, mLot);
		
		String gsonInterest = new Gson().toJson(sortingList);

		model.addAttribute("memberFavor", sortingList);//interest.jsp에 값을 뿌려줄 리스트
		model.addAttribute("gsonInterestList", gsonInterest); //interest.jsp에 hidden으로 숨겨놓을  json형태의 객체
		model.addAttribute("searchSize", sortingList.size());
		
		return "interest";
	}
	
	//썸네일 사진 바이트로 가져오기
	@RequestMapping("/imageDown")
	@ResponseBody
	public byte[] imageDown(@RequestParam String brandNUM){
		
		byte[] image = service.getImegeAsByteArray(brandNUM);
		
		return image;
		
	}
	
	
	
	/*************************************강석 컨트롤러 시작************************************************************/
	@Autowired
	KangMemberService memberService;

	@Autowired
	JavaMailSender mailSender;

	/* 로그아웃 시작 */
	public String logoutForm() {
		return null;
	}
	/* 로그아웃 종료 */

	/* 유저 로그인 시작 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm(HttpServletRequest request, HttpSession session, HttpServletResponse response) {

		Cookie[] cookies1 = request.getCookies();
		if (cookies1 != null) {
			for (Cookie c : cookies1) {
				if (c.getName().equals("loginCookieId") && c.getValue() != null && !c.getValue().equals("")) {
					//세션에 쿠키값을 저장
					session.setAttribute("USERID", c.getValue());
					session.setAttribute("SEQ", memberService.getMember(c.getValue()).get("MEMBERNUM"));
					session.setAttribute("AUTHORITY", "MEMBER");
					session.setAttribute("NICK", memberService.getMember(c.getValue()).get("NICK"));
			
					return "redirect:/";
				}
			}
		}
		return "login";
	}

	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public boolean login(@RequestParam Map<String, Object> params, HttpSession session, HttpServletResponse response) {
		
		String memberEmail = (String) params.get("MEMBEREMAIL");
		String memberPassword = (String) params.get("MEMBERPASSWORD");
		String AutoLogin = (String) params.get("AUTO");
		
		//입력된 아이디와 비밀번호의 일치 조회
		boolean result = memberService.login(memberEmail, memberPassword);
		if(result == false) {
			return false;
		}
		
		//회원탈퇴 유저 식별
				boolean CheckQuitMember = memberService.CheckQuitMember(memberEmail);
				if (CheckQuitMember == false) {
					return false;
				}

		if (result) {
			//세션에 아이디를 담고 메인으로 이동
			Map<String, Object> member = memberService.getMember(memberEmail);

			String memberEmailSession = (String) member.get("MEMBEREMAIL");
			String memberSeqSession = (String) member.get("MEMBERNUM");
			String memberAuthSession = (String) member.get("MEMBERAUTHORITY");
			String meberNickSession = (String) member.get("NICK");

			if (AutoLogin != null) {
				Cookie cookieId = new Cookie("loginCookieId", memberEmail);

				cookieId.setPath("/");
				int amount = 60 * 60 * 24 * 1;
				cookieId.setMaxAge(amount);
				//쿠키적용
				response.addCookie(cookieId);
			} else {
				session.setAttribute("USERID", memberEmailSession);
				session.setAttribute("SEQ", memberSeqSession);
				session.setAttribute("AUTHORITY", memberAuthSession);
				session.setAttribute("NICK", meberNickSession);
				return result;
			}
			session.setAttribute("USERID", memberEmailSession);
			session.setAttribute("SEQ", memberSeqSession);
			session.setAttribute("AUTHORITY", memberAuthSession);
			session.setAttribute("NICK", meberNickSession);
		}
		return result;
	}
	/*유저 로그인 종료 */

	/***********************유저 비밀번호 찾기 시작 ***********************/
	@RequestMapping(value = "/pwFind", method = RequestMethod.GET)
	public String pwFindForm() {
		return "pwFind";
	}

	@ResponseBody
	@RequestMapping(value = "/pwFind", method = RequestMethod.POST)
	public void pwFind(@RequestParam Map<String, Object> params, HttpServletResponse response)throws IOException, MessagingException {
		PrintWriter out = null;
		try {
			String memberEmail = (String) params.get("MEMBEREMAIL");
			out = response.getWriter();
			//회원탈퇴 유저 식별
			boolean CheckQuitMember = memberService.CheckQuitMemberPwFind(memberEmail);
			if (CheckQuitMember == false) {
				out.write("{\"result\":false}");
				return;
			}

			//DB 이메일 유무 확인
			boolean result = memberService.checkEmailPwFind(memberEmail);
			if (result) {
			} else {
				out.write("{\"result\":false}");
				return;
			}

			//임시비밀번호 발급
			String tempPw = memberService.tempPassPwFind(memberEmail);
			if (tempPw != null) {
			} else {
				out.write("{\"result\":false}");
				return;
			}
			
			//이메일로 회원정보 가져오기
			Map<String, Object> member = memberService.EmailPwFind(memberEmail);
			
			
			
			String originNick = (String) member.get("NICK");
			String setfrom = "FooconHelp@gmail.com";
			String tomail = (String) member.get("MEMBEREMAIL");
			String title = "[푸콘] 요청하신 " + originNick + "님의 비밀번호 입니다.";
			String content = originNick + "님의 임시 비밀번호는 " + tempPw + " 입니다.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");																		// 가능.

				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				mailSender.send(message);
				response.setContentType("text/html; charset=UTF-8");
				out.write("{\"result\":true}");
			} catch (Exception e) {
				System.out.println(e);
			}
		} finally {
			out.close();
		}
		out.write("{\"result\":true}");
		return;
	}

	/*********************** 유저 비밀번호 찾기 종료 ***********************/

	/*********************** 유저 회원가입 전 서비스 동의 시작 ***********************/
	@RequestMapping("/terms")
	public String terms() {
	    
		return "terms";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		
		//멤버 쿠키 삭제
		Cookie cookieId1 = new Cookie("loginCookieId", null);
		cookieId1.setPath("/");
		cookieId1.setMaxAge(0);
		response.addCookie(cookieId1);
		
		//멤버 쿠키 삭제
		Cookie cookieId2 = new Cookie("loginCookieIdAdmin", null);
		cookieId2.setPath("/");
		cookieId2.setMaxAge(0);
		response.addCookie(cookieId2);
		
		if(session.getAttribute("AUTHORITY").equals("BRAND") || session.getAttribute("AUTHORITY").equals("MASTER")) {
						
			//세션 삭제
			session.removeAttribute("USERID");
			session.removeAttribute("SEQ");
			session.removeAttribute("AUTHORITY");
			
			return "redirect:/admin";
			
		}
		
		else {
			
			//세션 삭제
			session.removeAttribute("USERID");
			session.removeAttribute("SEQ");
			session.removeAttribute("AUTHORITY");
			session.removeAttribute("NICK");
			
			
			return "redirect:/";			
		}
		

	}
	
	

	/*********************** 유저 회원가입 전 서비스 동의 종료 ***********************/

	/*********************** 유저 회원가입 시작 ***********************/
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinForm() {
		return "join";
	}

	@ResponseBody
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public boolean join(@RequestParam Map<String, Object> member) {

		String memberEmail = (String) member.get("MEMBEREMAIL");
		String memberNick = (String) member.get("NICK");
		String memberPhoneNum = (String) member.get("MEMBERPHONE");

		// 이메일 중복 확인
		boolean emailResult = memberService.checkEmailJoin(memberEmail);
		if (emailResult) {
		} else {
			return false;
		}
		// 이메일 중복 종료

		// 닉네임 중복 확인
		boolean nickResult = memberService.checkNickJoin(memberNick);
		if (nickResult) {
		} else {
			return false;
		}
		// 닉네임 중복 종료

		// 핸드폰번호 중복 확인
		boolean phoneResult = memberService.checkPhoneNumJoin(memberPhoneNum);
		if (phoneResult) {
		} else {
			return false;
		}
		// 핸드폰번호 중복 종료

		// DB에 입력된 정보 넣기
		if (memberService.joinMember(member)) {
		} else {
			return false;
		}
		return true;
	}

	/*********************** 유저 회원가입 종료 ***********************/

	/*********************** 유저 myPage 가기위한 패스워드 확인 시작 ***********************/
	@RequestMapping(value = "/pwCheck", method = RequestMethod.GET)
	public String pwCheckForm(HttpSession session) {
		String dd  = (String) session.getAttribute("USERID");
		
		if(dd != null) {
	         return "pwCheck";
	      }else {
	         return "redirect:/";
	      }
		
				
	}

	@ResponseBody
	@RequestMapping(value = "/pwCheck", method = RequestMethod.POST)
	public boolean pwCheck(@RequestParam Map<String, Object> params, HttpSession session, HttpServletRequest request) {

		String memberEmail = (String) session.getAttribute("USERID");
		String memberPassword = (String) params.get("MEMBERPASSWORD");
		
		//비밀번호 확인
		boolean result = memberService.pwCheck(memberEmail, memberPassword);

		return result;
	}
	/*********************** 유저 myPage 가기위한 패스워드 확인 종료 ***********************/

	/*********************** myPage 기능 모음 시작 ***********************/
	/* 유저 myPage 탈퇴를 위한 메서드 시작 */
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPageForm(Model model, HttpSession session) {
		String memberEmail = (String) session.getAttribute("USERID");
		//회원정보 가져오기
		Map<String, Object> member = memberService.getMemberMyPage(memberEmail);

		model.addAttribute("member", member);
		return "myPage";
	}

	@ResponseBody
	@RequestMapping(value = "/myPage", method = RequestMethod.POST)
	public boolean myPage(@RequestParam Map<String, Object> params, HttpSession session, HttpServletResponse response) {

		String memberEmail = (String) session.getAttribute("USERID");
		String memberPassword = (String) params.get("MEMBERPASSWORD");
		
		//회원탈퇴 유저 식별
		boolean result = memberService.quitPwCheck(memberEmail, memberPassword);

		if (result) {
			//회원탈퇴
			memberService.quitMember(memberEmail);

			Cookie cookieId1 = new Cookie("loginCookieId", null);
			cookieId1.setPath("/");
			cookieId1.setMaxAge(0);
			response.addCookie(cookieId1);

			session.removeAttribute("USERID");
			session.removeAttribute("SEQ");
			session.removeAttribute("AUTHORITY");
		}
		return result;
	}
	/* 유저 myPage 탈퇴를 위한 메서드 종료 */

	/* 유저 myPage 닉네임 변경 시작 */
	@RequestMapping(value = "/memberChangeNick", method = RequestMethod.GET)
	public String memberChangeNickForm() {
		return "memberChangeNick";
	}

	@ResponseBody
	@RequestMapping(value = "/memberChangeNick", method = RequestMethod.POST)
	public boolean memberChangeNick(@RequestParam Map<String, Object> params, HttpSession session) {

		String NICK = (String) params.get("WANTINGNICK");
		String EMAIL = (String) session.getAttribute("USERID");
		
		//닉네임 중복검사
		boolean result = memberService.NickCheck(NICK);

		if (result) {
			//닉네임 변경
			memberService.updateNick(NICK, EMAIL);
		} else {
			return false;
		}
		return true;
	}
	/* 유저 myPage 닉네임 변경 종료 */

	/* 유저 myPage 비밀번호 변경 시작 */
	@RequestMapping(value = "/memberChangePw", method = RequestMethod.GET)
	public String memberChangePwForm() {
		return "memberChangePw";
	}

	@ResponseBody
	@RequestMapping(value = "/memberChangePw", method = RequestMethod.POST)
	public boolean memberChangePw(@RequestParam Map<String, Object> params, HttpSession session) {

		String EMAIL = (String) session.getAttribute("USERID");
		String ORIGINPASSWORD = (String) params.get("ORIGINPASSWORD");
		String WANTINGPASS = (String) params.get("WANTINGPASSWORD");
		String WANTINGPASSCHECK = (String) params.get("WANTINGPASSWORDCHECK");
		
		//비밀번호 확인
		boolean result = memberService.originpassCheck(ORIGINPASSWORD, EMAIL);
		//변경하고자 하는 비밀번호 중복확인
		boolean doubleCheck = memberService.doubleCheckPass(WANTINGPASS, WANTINGPASSCHECK);

		if (doubleCheck) {
			if (result) {
				//비밀번호 변경
				memberService.updatePass(WANTINGPASS, EMAIL);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	/* 유저 myPage 비밀번호 변경 종료 */

	/* 유저 myPage 핸드폰번호 변경 시작 */
	@RequestMapping(value = "/memberChangePhoneNum", method = RequestMethod.GET)
	public String memberChangePhoneNumForm() {
		return "memberChangePhoneNum";
	}

	@ResponseBody
	@RequestMapping(value = "/memberChangePhoneNum", method = RequestMethod.POST)
	public boolean memberChangePhoneNum(@RequestParam Map<String, Object> params, HttpSession session) {
		String MEMBERPHONE = (String) params.get("WANTINGPHONENUM");
		String MEMBERPHONECHECK = (String) params.get("WANTINGPHONENUMCHECK");
		String EMAIL = (String) session.getAttribute("USERID");
		
		//변경하고자 하는 핸드폰번호 중복확인
		boolean doubleCheck = memberService.doubleCheckPhoneNum(MEMBERPHONE, MEMBERPHONECHECK);
		//DB상에 입력된 핸드폰번호 유무확인
		boolean result = memberService.phoneNumCheck(MEMBERPHONE);

		if (doubleCheck) {
			if (result) {
				//핸드폰번호 변경
				memberService.updatePhoneNum(MEMBERPHONE, EMAIL);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	/* 유저 myPage 핸드폰번호 변경 종료 */
	/*********************** myPage 기능 모음 종료 ***********************/
	/*************************************강석 컨트롤러 종료************************************************************/


}
