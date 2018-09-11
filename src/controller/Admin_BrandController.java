package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import service.KangBrandService;
import service.OrderBrandService;
import service.naraeService;

@Controller
@RequestMapping("/admin/brand")
public class Admin_BrandController {
	///////////////////////원용///////////////////////////////////////////
	@Autowired
	private OrderBrandService orderBrandService;
	
	@RequestMapping(value="/brandView",method=RequestMethod.GET)
	public String admin_brandView(Model model,HttpSession session,String brandNUM) {
		String userid = (String)session.getAttribute("USERID");
		
		String seq = (String)session.getAttribute("SEQ");
		
		String authority = (String)session.getAttribute("AUTHORITY");

		
		//로그인 안한상태
		if(userid == null) {
			return "redirect:/";
		}
		if(brandNUM == null && seq.equals("MASTER")) {
			return "redirect:/admin/brand/brandList";
		}
		
		//로그인한 상태
		model.addAttribute("brandInfoCounting",orderBrandService.admin_brandInfoCounting(seq,brandNUM));
		if(authority.equals("BRAND")) {
			
			model.addAttribute("brandView",orderBrandService.admin_brandView(seq));
		}else if(authority.equals("MASTER")){
			
			model.addAttribute("brandView",orderBrandService.admin_brandViewSeconds(brandNUM));
			model.addAttribute("authority",authority);
		}
		
		return "admin_brandView";
	}
	
	@ResponseBody
	@RequestMapping(value="/brandOwnerPasswordChange",method=RequestMethod.POST)
	public boolean admin_brandOwnerPasswordChange(HttpSession session,@RequestParam Map<String,Object> param) {
		param.put("BRANDOWNERNUM",(String)session.getAttribute("SEQ"));
		return orderBrandService.admin_brandOwnerPasswordChange(param);
	}

	
	@ResponseBody
	@RequestMapping(value="/brandSave",method=RequestMethod.POST)
	public boolean admin_brandSave(HttpSession session,MultipartHttpServletRequest multi, @RequestParam Map<String,Object> param) {
		MultipartFile thumnailImage = multi.getFile("THUMNAILIMAGE");
		List<MultipartFile> imagesList = new ArrayList<MultipartFile>();
		
		int detailImageCount = (Integer.parseInt(multi.getParameter("DETAILIMAGECOUNT")));
		int thumnailImageCount = (Integer.parseInt(multi.getParameter("THUMNAILIMAGECOUNT")));
		
		for(int i=0;i<detailImageCount;i++) {
			imagesList.add((MultipartFile)multi.getFile("IMAGE"+i));
		}
		
		param.put("DETAILIMAGECOUNT", detailImageCount);
		param.put("THUMNAILIMAGECOUNT", thumnailImageCount);
		param.put("THUMNAILIMAGE", thumnailImage);
		param.put("IMAGESLIST", imagesList);
		param.put("BRANDOWNERNUM",(String)session.getAttribute("SEQ"));
		
		boolean result = false;
		String brandNUM = (String)param.get("BRANDNUM");
		if(brandNUM.equals("") || brandNUM == null){ //브랜드 상세페이지가 없으므로 인설트를 해줘야하는 부분
			result = orderBrandService.admin_brandInsert(param);
		}else { //브랜드 상세페이지가 있으므로 업데이트해줘야하는 부분
			result = orderBrandService.admin_brandUpdate(param);
		}
		return result;
	}
	

	@ResponseBody
	@RequestMapping("/imagePreview")
	public byte[] imagePreview(String fileName) {
		String IMG_LOCATION = "C:\\Temp/";	
		File file = new File(IMG_LOCATION+fileName);
		InputStream targetStream = null;
		try {
			targetStream = new FileInputStream(file);
			return 	IOUtils.toByteArray(targetStream);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
	@RequestMapping("/menuList")
	public String admin_menuList(HttpSession session,Model model,String keyword,@RequestParam(defaultValue="1")int page) {
		
		
		String authority = (String)session.getAttribute("AUTHORITY");
		String seq = (String)session.getAttribute("SEQ");

		Map<String,Object> pram = new HashMap<String,Object>();
		pram.put("KEYWORD", keyword);
		pram.put("SEQ", seq);
		
		Map<String,Object> viewData = orderBrandService.admin_menuView(pram,page,authority);
		
		if(viewData.get("warning") != null) {
			return "redirect:/";
		}
		viewData.put("keyword", keyword);
		model.addAllAttributes(viewData);
		return "admin_menuList";
	}
	
	@ResponseBody
	@RequestMapping("/menuDelete")
	public boolean admin_menuDelete(@RequestParam Map<String,Object> param) {
		return orderBrandService.admin_menuDelete(param);
	}
	
	@RequestMapping(value="/menuView",method=RequestMethod.GET)
	public String admin_menuView(Model model,String brandMenuNUM) {
		model.addAttribute("menuData",orderBrandService.admin_menuView(brandMenuNUM));
		return "admin_menuView";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/menuSave",method=RequestMethod.GET)
	public boolean admin_menuSave(HttpSession session,@RequestParam Map<String,Object> param) {
		String seq = (String)session.getAttribute("SEQ");
		String authority = (String)session.getAttribute("AUTHORITY");
		param.put("BRANDOWNERNUM", seq);
		return orderBrandService.admin_menuSave(param);
	}
	
	@ResponseBody
	@RequestMapping(value="/menuDown")
	public boolean admin_menuDown(@RequestParam Map<String,Object> param) {
		return orderBrandService.admin_menuDown(param);
	}
	
	@ResponseBody
	@RequestMapping(value="/menuUp")
	public boolean admin_menuUp(@RequestParam Map<String,Object> param) {
		return orderBrandService.admin_menuUp(param);
	}
	/////////////////////원용///////////////////////////////////////////
	
	////////////////////나래////////////////////////////////////////////
	@Autowired
	naraeService service;
	
	//관리자 화면 중 메인화면에 뿌려질 6개의 리스트를 뽑아서 리스트에 출력한다.
	@RequestMapping("/mainList")
	public String adminMainList(Model model) {

			List<Map<String, Object>> adminMasterMainList = service.selectAdminBrandList();
			
			model.addAttribute("MasterBrandList", adminMasterMainList);

		return "admin_mainList";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/mainRankUP") //admin mainList에서 upButton 눌렀을 때, 실행되는 함수
	public String adminUpButton(@RequestParam Map<String, Object> param) {
		
		//upbutton을 눌러서 이 함수가 실행하면
		
		String BRANDNUM = (String) param.get("BRANDNUM");
		
		String mainrank = (String) param.get("MAINRANK");
		
		int MAINRANK = Integer.parseInt(mainrank);
		
		
		
//		System.out.println("BRANDNUM : "+BRANDNUM);
//		System.out.println("MAINRANK : "+MAINRANK);
		
		//받아온 파람 중 메인랭크를 통해서 다음 랭크 brandNUM을 가져와서 수정시킨다.
		
		boolean updateMainRank = service.mainRankUp(BRANDNUM, MAINRANK);
		
	
		
		if(updateMainRank) {
			
			return "{\"msg\" : \"true\"}";
			
		}else {
			
			return "{\"msg\" : \"false\"}";
		}	
	}
	
	@ResponseBody
	@RequestMapping("/mainRankDOWN") //admin mainList에서 upButton 눌렀을 때, 실행되는 함수
	public String adminDownButton(@RequestParam Map<String, Object> param) {
	
		
		//upbutton을 눌러서 이 함수가 실행하면		
		String BRANDNUM = (String) param.get("BRANDNUM");
		
		String mainrank = (String) param.get("MAINRANK");
		
		int MAINRANK = Integer.parseInt(mainrank);
		
		boolean updateMainRank = service.mainRankDown(BRANDNUM, MAINRANK);
		
		if(updateMainRank) {
			
			return "{\"msg\" : \"true\"}";
			
		}else {
			
			return "{\"msg\" : \"false\"}";
		}	
	}
	
	
	//순번이 0번인 상태에서 down 버튼이 눌렸을 때, 비어있는 숫자로 들어가야한다
	//그 비어있는 숫자를 찾는 service 함수를 작성한다.
	@ResponseBody
	@RequestMapping("/zeroDown")
	public String zeroPushtheDown(@RequestParam Map<String, Object> param) {
		
	
		
		String BRANDNUM = (String) param.get("BRANDNUM");
		
		int blankNUM = service.selectmainRank();
		
		boolean result = service.updateRankNUM(BRANDNUM, blankNUM);
		
	
		
		if(result) {
			
			return "{\"msg\" : \"true\"}";
			
		}else {
			
			return "{\"msg\" : \"false\"}";
			
		}
		
		
	}
	
	
	//뾰롱
	//관리자 페이지 브랜드 관리를 마스터 권한이 눌렀을 때는 모든 브랜드 리스트를 보여주고 권한이 브랜드 권한이 누르면 본인 브랜드 상세페이지로 넘어가게 한다
	@RequestMapping("/brandList")
	public String adminBrandManage(Model model, HttpSession session,@RequestParam(defaultValue = "1")int page, 
			                                                        @RequestParam(required = false)String keyword,
			                                                        @RequestParam(required = false)String category) {	
			session.setAttribute("AUTHORITY", "MASTER");
			
			String authority = (String) session.getAttribute("AUTHORITY");
			
			if(authority.equals("MASTER")) {
				
				Map<String, Object> param = new HashMap<String, Object>();
				
				if(keyword != null) {
					
					param.put("keyword", keyword);
				}
				
				if(category != null) {
					
					param.put("category", category);
				}
				
				
				//모든 브랜드 리스트를 뽑아온다.
				model.addAttribute("viewData", service.adminMasterBrandAll(page, param));
				
			}else if(authority.equals("BRAND")) {
				
				//brandOwnerNUM을 통해서 brandNUM을 가져오고
				//그 브랜드넘을 통해 상세페이지로 넘어가게 한다.
				
			}
			


		return "admin_brandList";
	}
/////////////////////////나래//////////////////////////////////////////////////
	
	
	/*************************************강석 컨트롤러 시작************************************************************/
	@Autowired
	KangBrandService brandService;
	
	/***********************관리자 브랜드 아이디 관리 생성 시작***********************/
	@RequestMapping(value = "/newBrand", method = RequestMethod.GET)
	public String newBrandForm(HttpSession session) {
		
		return "admin_newBrand";
	}
	
	@ResponseBody
	@RequestMapping(value = "/newBrand", method = RequestMethod.POST)
	public boolean newBrand(@RequestParam Map<String, Object> params,HttpSession session) {
		
		String OWNEREMAIL = (String) params.get("OWNEREMAIL");
		String OWNERPHONE = (String) params.get("OWNERPHONE");

		//이메일과 폰번호 중복확인
		boolean emailResult = brandService.checkEmailNewBrand(OWNEREMAIL);
		if(emailResult) {
		}else {
			return false;
		}		
		
		boolean phoneNumResult = brandService.checkPhoneNumNewBrand(OWNERPHONE);
		if(phoneNumResult) {
		}else {
			return false;
		}
		
		//입력된 값을 DB에 저장
		boolean result = brandService.insertBrandOwnerNewBrand(params);
		if(result) {
			return true;
		}else {
			return false;
		}
	}
	/***********************관리자 브랜드 아이디 관리 생성 종료***********************/
	/*************************************강석 컨트롤러 종료************************************************************/
	
}
