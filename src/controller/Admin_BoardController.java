package controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import service.BoardService;
import service.DongHoService;
import service.K_BoardService;
import service.OrderBrandService;

@Controller
@RequestMapping("/admin/board")
public class Admin_BoardController {
	
///////////////////////////동호////////////////////////////////////////////////////////
	
	@Autowired
	DongHoService dongHoService;
	/*@MessageMapping("/greeting/{memberid}/{targetid}")
	@SendTo("/topic/msg/{targetid}")*/
	/*@DestinationVariable(value = "memberid")String memberid,
	@DestinationVariable(value = "targetid")String targetid) {*/
	
	@CrossOrigin
	@MessageMapping("/greeting/{userid}")
	@SendTo("/topic/msg/{userid}")
	public String stompTest(String message,@DestinationVariable(value = "userid")String userid) {
		//client의 greeting client/greeting
	
		return message;
	}

	
	
	
	//제목 검색 + 전체리스트
	@RequestMapping("/eventList")
	public String eventList(Model model,@RequestParam(required = false)String keyword,
										@RequestParam(defaultValue="1")int pageNumber,HttpSession session) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("keyword", keyword);
		param.put("pageNumber", pageNumber);
		model.addAttribute("viewData",dongHoService.getEventList(param));
		return "admin_eventList";
		
	}

	
	@RequestMapping("/eventView")
	public String eventView(@RequestParam(required = false)String eventNum, Model model) {
		
		//조회수 증가는 사용자 화면에서 클릭시 증가하는걸로
		//type 1은 update 0은
		if(eventNum!=null) {
			model.addAttribute("event",dongHoService.getEvent(eventNum));
			model.addAttribute("type",1);
		}else {
			model.addAttribute("type",0);
		}
		
		return "admin_eventView";
		
		
	}
	
	@RequestMapping("/eventWrite")
	public String eventWrite(@RequestParam(required = false)String eventNum, Model model,
							@RequestParam Map<String,Object> event,
							@RequestParam("eventImg")MultipartFile eventImg,
							@RequestParam("thumnail")MultipartFile thumnail) {
	
		if(eventNum!=null && event.get("type").equals("1")) {
			dongHoService.modifyEvent(event,eventImg,thumnail);
		}else {	
			dongHoService.addEvent(event, eventImg, thumnail);
		}

		return "redirect:eventList";
	}
	
	@RequestMapping("/deleteEvent")
	public String deleteEvent(String eventNum) {
		dongHoService.removeEvent(eventNum);
		return "redirect:eventList";
		
	}
	
	@RequestMapping("/eventImg")
	@ResponseBody
	public byte[] eventImg(String type,String eventNum) {
		//이미지 요청
		if(eventNum.equals("")) {
			return null;
		}
		return dongHoService.getImegeAsByteArray(type,eventNum);
	}	
///////////////////////////동호////////////////////////////////////////////////////////
	
	/////////////////////////////////////////경아//////////////////////////////////////////
	@Autowired
	K_BoardService Kservice;
	// (본사) 문의사항 화면 요청
	@RequestMapping("/questionList")
	public String questionList(Model model,@RequestParam Map<String,Object>params, 
			@RequestParam (defaultValue="1")int pageNum,@RequestParam(required=false)String keyword,@RequestParam(required=false)String cate) {
		
		params.put("PAGENUM",pageNum);
		if(cate!=null) {
			if(cate.equals("답변완료")) {
				cate="Y";
				params.put("cate", cate);
			}else if(cate.equals("답변대기")){
				cate="N";
				params.put("cate", cate); 
			}
		}else {
			
		}
		
		Map<String, Object>inquireList = Kservice.selectAllAdmin(params);
		inquireList.put("keyword",keyword);
		inquireList.put("cate",cate);
		
		
		model.addAttribute("inquireList", inquireList);
		return "admin_questionList";
	}
	//모달에 넣어줄 정보 가져오기
	@RequestMapping("/showModal")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> showModal(String INQUIRENUM) {
		ResponseEntity<Map<String,Object>> entity = null;
		
		try{
			Map<String,Object> inquireMap = Kservice.selectOneAdmin(INQUIRENUM);
			entity = new ResponseEntity<>(inquireMap,HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//문의 사항 답글달기
	@RequestMapping("/inquireReply")
	@ResponseBody
	public boolean inquireReply(@RequestParam Map<String,Object>params,String replyContent,String INQUIRENUM) {
		
		boolean result=Kservice.insertInquireReply(params);
		if(result) {
			boolean result1=Kservice.updateInquire(INQUIRENUM);
			if(result1) {
				return true;
			}else {
				return false ;
			}
		}return true;
	}
	

	// (본사)공지사항 화면 요청
	@RequestMapping("/noticeList")
	public String noticeList(@RequestParam Map<String, Object>params, @RequestParam(defaultValue="1")int pageNum, 
			@RequestParam(required=false) String keyword, Model model) {
		
		params.put("PAGENUM", pageNum);
		Map<String, Object>totalMap = Kservice.selectAllNotice(params);
		totalMap.put("keyword",keyword);
		
		model.addAttribute("totalMap", totalMap);
		
		return "admin_noticeList";
	}

	//공지사항 작성
	@RequestMapping("/noticeWriteForm")
	public String noticeWrite() {
		return "admin_noticeWrite";
	}
	//공지사항 등록 처리
	@RequestMapping("/noticeWrite")
	public String noticeWrite(MultipartHttpServletRequest request) {
		Map<String, Object> params = new HashMap<String,Object>();
		try {
			//한글 깨짐 현상 잡아주는 친구
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		//화면에서 파라미터로 받아오고 싶은  친구들 받아주기
		params.put("noticecontent",request.getParameter("content"));
		params.put("noticetitle",request.getParameter("title") );
		params.put("noticetype",request.getParameter("category"));
		//보낸 파일들 리스트에 넣어주기
	    List<MultipartFile> fileList = request.getFiles("file");
		//파일 저장할 경로
		String path = "C:\\temp\\";
		//반복문으로 파일들 하나씩 저장해주기
		
		for(int i=0; i<fileList.size(); i++) {
			MultipartFile mf = fileList.get(i);
			if(mf.getOriginalFilename() != "") {
					String fileOriginName = mf.getOriginalFilename();
					
					UUID uuid = UUID.randomUUID();//랜덤으로 uuid생성
					//저장할 파일 이름
					String saveName = uuid.toString()+"_"+fileOriginName;
					params.put("uploadfile"+(i+1), saveName);
					try {
						mf.transferTo(new File(path+saveName));
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}else {
					params.put("uploadfile"+(i+1), "");
				}
		}
		if(!params.containsKey("uploadfile2")) {
			params.put("uploadfile2", "");
		}
		if(!params.containsKey("uploadfile3")) {
			params.put("uploadfile3", "");
		}
		
		boolean result=Kservice.insertNotice(params);
		if(result) {
			return "redirect:noticeList";
		}else {
			return "redirect:noticeWriteForm";
		}
	}
	//파일 다운로드
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
	// (본사)공지사항 수정 
	@RequestMapping("/noticeView")
	public String updateNotice(MultipartHttpServletRequest request) {
		Map<String, Object> params = new HashMap<String,Object>();
		try {
			//한글 깨짐 현상 잡아주는 친구
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//화면에서 파라미터로 받아오고 싶은  친구들 받아주기
		params.put("noticecontent",request.getParameter("content"));
		params.put("noticetitle",request.getParameter("title") );
		params.put("noticenum", request.getParameter("noticeNum"));
		//보낸 파일들 리스트에 넣어주기
	    List<MultipartFile> fileList = request.getFiles("file");
		//파일 저장할 경로
		String path = "C:\\temp\\";
		//반복문으로 파일들 하나씩 저장해주기
		if(fileList.get(0).getOriginalFilename() != "") {
			for(int i=0; i<fileList.size(); i++) {
				MultipartFile mf = fileList.get(i);
				if(mf.getOriginalFilename() != "") {
					String fileOriginName = mf.getOriginalFilename();
					
					UUID uuid = UUID.randomUUID();//랜덤으로 uuid생성
					//저장할 파일 이름
					String saveName = uuid.toString()+"_"+fileOriginName;
					params.put("uploadfile"+(i+1), saveName);
					try {
						mf.transferTo(new File(path+saveName));
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}else {
					params.put("uploadfile"+(i+1), "");
				}
			}
			if(!params.containsKey("uploadfile2")) {
				params.put("uploadfile2", "");
			}
			if(!params.containsKey("uploadfile3")) {
				params.put("uploadfile3", "");
			}
			boolean result=Kservice.updateNotice(params);
			if(result) {
				return "redirect:noticeList";
			}else {
				return "redirect:noticeViewForm";
			}
		}else {
			boolean result1=Kservice.updateNotice(params);
			if(result1) {
				return "redirect:noticeList";
			}else {
				return "redirect:noticeViewForm";
			}
		}
		
	}

	//공지사항 삭제하기
	@RequestMapping("/noticeDelete")
	@ResponseBody
	public boolean deleteNotice(@RequestParam Map<String, Object>params) {
		String noticeNum=(String)params.get("noticeNum");
		boolean result = Kservice.deleteNotice(noticeNum);
		if(result) {
			return true;
		}return false;
	}
	//공지사항 상세보기
	@RequestMapping("/noticeViewForm")
	public String noticeView(@RequestParam Map<String, Object>params,Model model) {
		String NOTICENUM = (String)params.get("NOTICENUM");
		
		Map<String,Object>param = Kservice.selectOneNotice(NOTICENUM);
		
		model.addAttribute("notice", Kservice.selectOneNotice(NOTICENUM));
		
		return "admin_noticeView";
	}
	// (본사)FAQ화면 요청
	@RequestMapping("/faqList")
	public String faqList(Model model) {
		model.addAttribute("faqList", Kservice.selectAll());
		return "admin_faqList";
	}
	//FAQ삭제하기
	@RequestMapping("/faqDelete")
	@ResponseBody
	public boolean faqDelete(@RequestParam Map<String, Object>params) {
		String faqNum = (String)params.get("faqNum");
		boolean result = Kservice.deleteFaq(faqNum);
		if(result) {
			return true;
		}else {
			return false;
		}
	}

	// (본사)FAQ수정 등록 화면 요청
	@RequestMapping("/faqViewForm")
	public String faqView(@RequestParam Map<String, Object>params,Model model) {
		String faqNum=(String)params.get("faqNum");
		model.addAttribute("faqOne", Kservice.selectOne(faqNum));
		return "admin_faqView";
	}
	//FAQ상세보기
	@RequestMapping("/faqView")
	public String faqModify(@RequestParam Map<String,Object>params,String faqNum,Model model) {
		
		boolean result = Kservice.updateFaq(params);
		if(result) {
			return "redirect:faqList";
		}else {
			return "admin_faqView";
		}
	}
	//FAQ작성 폼
	@RequestMapping("/faqWriteForm")
	public String faqWriteForm() {
		return "admin_faqWrite";
	}
	//FAQ작성 
	@RequestMapping("/faqWrite")
	public String faqWrite(@RequestParam Map<String,Object> params) {
		boolean result = Kservice.insertFaq(params);
		
		if(result) {
			return "redirect:faqList";
		}else {
			return "admin_faqWrite";
		}
	}
	/////////////////////////////////////경아///////////////////////////////
	
	/////////////////////////원용///////////////////////////////////////////
	@Autowired
	private OrderBrandService orderBrandService;
	@Autowired
	private BoardService boardSerivce;
	
	@RequestMapping("/adReferenceList")
	public String admin_adReferenceList(Model model,String keyword,@RequestParam(required=false)String type,@RequestParam(defaultValue="1")int page) {	
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("keyword", keyword);			
		param.put("type", type);
		
		Map<String,Object> viewData = boardSerivce.admin_adReferenceList(param,page);
		viewData.put("keyword", keyword);
		viewData.put("type", type);
		
		model.addAttribute("viewData",viewData);
		return "admin_adReferenceList";
	}
	
	@RequestMapping("/adReferenceView")
	public String admin_adReferenceView(Model model,String addInquireNUM) {
		model.addAttribute("adReferenceView",boardSerivce.admin_adReferenceView(addInquireNUM));
		return "admin_adReferenceView";
	}
//	///////////////////////원용///////////////////////////////////////////
}
