package controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.DongHoService;
import service.K_BoardService;
import 동호서비스.EventService;

@Controller
@RequestMapping("/board")
public class BoardController {
///////////////////////////동호////////////////////////////////////////////////////////
	@Autowired
	DongHoService dongHoService;
	
	
	@RequestMapping("/eventList")
	public String eventList(Model model) {
		model.addAttribute("eventList",dongHoService.getUserEventList());
		return "eventList";
	}
	
	@RequestMapping("/eventView")
	public String eventView(String eventNum) {
		
		dongHoService.addViewCount(eventNum);
		return "eventView";	
	}
	
	@RequestMapping("/thumbnailImg")
	@ResponseBody
	public byte[] thumbnailImg(String eventNum) {
		return dongHoService.getImegeAsByteArray("2", eventNum);
	}
	
	@RequestMapping("/detailImg")
	@ResponseBody
	public byte[] detailImg(String eventNum) {
			
		return dongHoService.getImegeAsByteArray("1", eventNum);
	}
	
///////////////////////////동호////////////////////////////////////////////////////////
	/////////////////////////////////////////////경아//////////////////////////////////////
	@Autowired
	K_BoardService Kservice;
	//(사용자)문의사항-"FAQ,1:1문의 내역, 문의작성" 화면 요청
	@RequestMapping("/question")
	public String question(Model model,@RequestParam Map<String,Object>params,@RequestParam(required=false)String pageNum, HttpSession session) {
		
		
		int num = 0;
		if(pageNum == null) {
			pageNum = "1";
		}else{
			num = 1;
		}
		
		String MemberNum1 = (String)session.getAttribute("SEQ");
		model.addAttribute("MemberNum",MemberNum1);
		params.put("MEMBERNUM", MemberNum1);
		params.put("PAGENUM",Integer.parseInt(pageNum));
		//회원 문의 내역 반환
		
		//faq리스트 반환
		Map<String,Object>totalMap = Kservice.selectAllUser(params);
		totalMap.put("faqList",  Kservice.selectAll());
		
		model.addAttribute("num",num);
		model.addAttribute("totalMap",totalMap);
		return "question";
	}
	
	
	
	//문의 작성 처리
	@RequestMapping("/questionWrite")
	
	public String questionWrite(@RequestParam Map<String,Object>params,Model model,HttpSession session) {
		
		
		String MemberNum1 = (String)session.getAttribute("SEQ");
		params.put("MEMBERNUM", MemberNum1);
		boolean result = Kservice.insertInquire(params);
		if(result) {
			
			return "redirect:question";
		}
		return "redirect:questionWrite";
	}
	
	//(사용자)공지사항 화면 요청
	@RequestMapping("/noticeList")
	public String noticeList(@RequestParam Map<String, Object>params, @RequestParam(defaultValue="1")int pageNum, 
			@RequestParam(required=false) String keyword, Model model) {
		
		params.put("PAGENUM", pageNum);
		model.addAttribute("totalMap", Kservice.selectAllNotice(params));
		
		return "noticeList";
	}
	
	//(사용자)공지사항 상세보기 화면 요청
	@RequestMapping("/noticeView")
	public String noticeView(@RequestParam Map<String, Object>params,Model model) {
		String NOTICENUM = (String)params.get("NOTICENUM");
		model.addAttribute("notice", Kservice.selectOneNotice(NOTICENUM));
		Map<String, Object>param = Kservice.selectOneNotice(NOTICENUM);
		Kservice.updateCount(param);
		String rnum =String.valueOf(param.get("RNUM2"));
		model.addAttribute("page",Kservice.userPage(rnum));
		return "noticeView";
	}
	
	//모든약관 화면 요청
	@RequestMapping("/termsView")
	public String termsView() {
		return "termsView";
	}
	@RequestMapping("/download")
	public void downloadFile(HttpServletRequest req,HttpServletResponse res,@RequestParam("fileName")String fileName) throws Exception{
		String path = "C:\\temp\\";
		String OriginfileName = fileName;
		int idx= fileName.indexOf("_");
		String downfileName= fileName.substring(idx+1);
		byte fileByte[] = FileUtils.readFileToByteArray(new File(path+OriginfileName));
		
		res.setContentType("application/octet-stream");
		res.setContentLength(fileByte.length);
		res.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(downfileName, "UTF-8")+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(fileByte);
		
		res.getOutputStream().flush();
		res.getOutputStream().close();
		File file = new File(path+fileName);
		
	}
	/////////////////////////////////////경아///////////////////////////////
}
