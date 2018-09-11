package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import commons.Constants;
import service.KangBrandService;
import service.MemberService;

@Controller
@RequestMapping("/admin/member")
public class Admin_MemberController {


	@Autowired
	MemberService service;
	
	@RequestMapping("/memberList")
	public String memberList(Model model,
							@RequestParam(required = false)String keyword,
							@RequestParam(defaultValue="1")int pageNumber) {
		//페이징
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("keyword", keyword);
		param.put("pageNumber", pageNumber);
		model.addAttribute("viewData",service.getMemberList(param));
		return "admin_memberList";
	}
	
	@RequestMapping("/memberInfo")
	public String memberInfo(String memberNum, Model model) {
		//멤버정보
		model.addAttribute("member",service.getMember(memberNum));
		return "admin_memberInfo";
	}
	

	
	@RequestMapping("/memberOrderList")
	public String memberOrderList(@RequestParam Map<String, Object>params,
									@RequestParam(defaultValue="1")int pageNum ,
									Model model) {
	
		params.put("PAGENUM", pageNum);
		Map<String, Object> totalMap = service.selectMemberOrderList(params);
		model.addAttribute("totalMap", totalMap);
		model.addAttribute("member",service.getMember((String)params.get("MEMBERNUM")));
		return "admin_memberOrderList";
	}
	
	
	@RequestMapping("/memberPointList")
	public String memberPointList(@RequestParam(defaultValue="1") int pageNum,@RequestParam Map<String,Object>params,Model model) {
		
		params.put("PAGENUM",pageNum);
		Map<String, Object> totalMap = service.selectAllMemberPoint(params);
		
		model.addAttribute("totalMap", totalMap);
		model.addAttribute("member",service.getMember((String)params.get("MEMBERNUM")));
		return "admin_memberPointList";
	}
	
	
	
	/*************************************강석 컨트롤러 시작************************************************************/
	@Autowired
	KangBrandService brandService;
	
	@Autowired
	JavaMailSender mailSender;
	
	/***********************관리자 비밀번호 찾기 시작***********************/
	@RequestMapping(value = "/pwFind", method = RequestMethod.GET)
	public String pwFindForm() {
		return "admin_pwFind";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwFind", method = RequestMethod.POST)
	public void pwFind(@RequestParam Map<String, Object> params, HttpServletResponse response) throws IOException, MessagingException {
		
		PrintWriter out = null;
		
		try {
			String ownerEmail = (String) params.get(Constants.Brand.OWNEREMAIL);
			out = response.getWriter();
			
			//DB 이메일 유무 확인
			boolean result = brandService.checkEmailpwFind(ownerEmail);
			if(result) {
			}else {
				out.write("{\"result\":false}");
				return;
			}
			
			//임시비밀번호 발급
			String tempPw = brandService.tempPassPwFind(ownerEmail); 
			if(tempPw != null) {
			}else {
				out.write("{\"result\":false}");
				return;
			}
			
			Map<String, Object> owner = brandService.EmailPwFind(ownerEmail);
			String originEmail = (String) owner.get(Constants.Brand.OWNEREMAIL);
			String ownerName = (String) owner.get(Constants.Brand.OWNERNAME);
			
			String setfrom = "FooconHelp@gmail.com";
			String tomail = originEmail;
			String title = "[푸콘] 요청하신 " + ownerName  + "님의 비밀번호 입니다.";
			String content = ownerName + "님의 비밀번호는 " + tempPw + " 입니다.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

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
		}finally{
			out.close();
		}
		out.write("{\"result\":true}");
		return;
	}
	/***********************관리자 비밀번호 찾기 종료***********************/
	/*************************************강석 컨트롤러 종료************************************************************/
	
	
	
}
