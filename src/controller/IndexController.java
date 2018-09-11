package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import commons.Constants;
import service.BoardService;
import service.KangBrandService;
import service.KangHeadOfficeService;
import service.OrderBrandService;
import service.naraeService;

@Controller
public class IndexController {
	
	/////////////////////원용///////////////////////////////////////////
	@Autowired
	private OrderBrandService orderBrandService;
	@Autowired
	private BoardService boardSerivce;
	
	@RequestMapping(value="/adReference",method=RequestMethod.GET)
	public String adReference() {
		return "adReference";
	}
	
	@RequestMapping(value="/adReferenceResult",method=RequestMethod.GET)
	public String adReferenceResultGet(Model model,@RequestParam Map<String,Object> param, HttpServletRequest resquest) {
		model.addAttribute("msg","요청하신 페이지가 없습니다.");
		model.addAttribute("url",resquest.getContextPath()+"/");
		return "result";
	}
	
	@ResponseBody
	@RequestMapping(value="/adReferenceResult",method=RequestMethod.POST)
	public boolean adReferenceResult(@RequestParam Map<String,Object> param) {
		return boardSerivce.adReferenceResult(param);
	}
/////////////////////원용//////////////////////////////////////////
	
/////////////////////////////나래///////////////////////////////////
	@Autowired
	naraeService service;
	
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public String index(Model model, HttpSession session) {
		//메인화면에 뿌려지는 메인추천 리스트를 뿌려오는 것
		List<Map<String, Object>> mainList = service.selectAll();

		model.addAttribute("mainList", mainList);
	    
		return "main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/litlot", method=RequestMethod.POST)
	public String litlot(HttpSession session, @RequestParam double lit, @RequestParam double lot) {
		
		
			 Double myLit = (Double) session.getAttribute("lit");
			 
			if(myLit == null) {
				
			
				session.setAttribute("lit", lit);
				session.setAttribute("lot", lot);
				
			}
			
	
			
			return "{\"msg\" : \"true\"}";

		
	};
	
	@ResponseBody
	@RequestMapping("/denyLocation")
	public String denyLocation(HttpSession session) {
		
		Double myLit = (Double)session.getAttribute("lit");
	
		
		if(myLit == null) {
		
			
			session.setAttribute("lit", 37.497304);
			session.setAttribute("lot", 127.022672);
			
			return "{\"msg\" : \"true\"}";
			
		}
	
			return "{\"msg\" : \"true\"}";
	}
	
	
	@RequestMapping(value = "/admin/main",method=RequestMethod.GET)
	public String adminindex(Model model, HttpSession session) {
		
		//연습용 세션 마스터로 박아놓기

		String authority = (String)session.getAttribute("AUTHORITY");
		
		if(authority.equals("MASTER")) {

			Map<String, Object> MasterCount = service.adminMasterMainInfo();
			
			model.addAttribute("MasterCount", MasterCount);

			
		}else if(authority.equals("BRAND")) {
			
			//brandOwner숫자만 준다.
			//먼저 브랜드 ownerNUM을 통해서 브랜드 넘을 알아온다.
			
			//세션에 박혀있는 brandOwnerNUM을 가져온다.
			String brandOwnerNUM = (String) session.getAttribute("SEQ");
			
			String brandNUM = service.selectBrand(brandOwnerNUM);
			
			if(brandNUM == null) {
				
			
				
				Map<String, Object> masterMap = new HashMap<String, Object>();
				
				masterMap.put("NDELIVERTOTALCOUNT", 0);
				masterMap.put("NREGITOTALCOUNT", 0);
				masterMap.put("ORDERTOTALCOUNT", 0);
				masterMap.put("cancleDeli", 0);
				masterMap.put("cancleReser", 0);
				masterMap.put("reviewTotal", 0);
				masterMap.put("todayReview", 0);
				masterMap.put("inquireTotal", 0);
				masterMap.put("inquireToday", 0);
				masterMap.put("adTotal", 0);
				masterMap.put("adToday", 0);
				masterMap.put("salesTotal", 0);
				masterMap.put("salesMonth", 0);
				
				model.addAttribute("BrandCount", masterMap);
				
				return "admin_main";
				
			}
			
			
//			Map<String, Object> BrandCount = service.adminBrandMainInfo(brandOwnerNUM);
			Map<String, Object> BrandCount = service.adminBrandMainInfo(brandNUM);
			
			model.addAttribute("BrandCount", BrandCount);
		}
		
		return "admin_main";
	}
	
	//썸네일 사진 바이트로 가져오기
	@RequestMapping("/imageDown")
	@ResponseBody
	public byte[] imageDown(@RequestParam String brandNUM){
		
		byte[] image = service.getImegeAsByteArray(brandNUM);
		
		return image;
		
	}
	
	///////////////////////////나래/////////////////////////
	
	
	/*************************************강석 컨트롤러 시작************************************************************/
	@Autowired
	KangHeadOfficeService headofficeService;
	
	@Autowired
	KangBrandService brandService;
	
	/***********************관리자 페이지 로그인 시작***********************/
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminForm(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		
		Cookie[] cookies1 = request.getCookies(); 
	    if(cookies1 != null) {
	    	for(Cookie c : cookies1) {
	    		
	    		
	    		String member = (String) session.getAttribute("AUTHORITY");
		    	if(member != null) {
		    		if(member.equals("MEMBER")) {
						return "redirect:member/login";
			    	}
		    	}
		    	
		    	String master = c.getValue();
		    	
		    	if(master.equals("MASTER")) {
		    		if(c.getName().equals("loginCookieIdAdmin") && c.getValue()!=null && !c.getValue().equals("")) {
			    		session.setAttribute("USERID", c.getValue());
			    		session.setAttribute("SEQ", c.getValue());
						session.setAttribute("AUTHORITY","MASTER");
						
						return "redirect:admin/main";
			    	}
		    	}else {
		    		if(c.getName().equals("loginCookieIdAdmin") && c.getValue()!=null && !c.getValue().equals("")) {
			    		session.setAttribute("USERID", c.getValue());
			    		session.setAttribute("SEQ",brandService.getBrandInfo(c.getValue()).get("BRANDOWNERNUM"));
						session.setAttribute("AUTHORITY","BRAND");
						
						return "redirect:admin/brand/brandView";
			    	}
		    	}
		    }
	    }
		return "admin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin", method = RequestMethod.POST)
	public boolean admin(@RequestParam Map<String, Object> params, HttpSession session, HttpServletResponse response) {
		
		String master = (String) params.get("MASTER");
		String officePassword = (String) params.get("OFFICEPASSWORD");
		String AutoLogin = (String) params.get("AUTO");
		
		boolean adminResult = headofficeService.login(master, officePassword);
		boolean brandResult = brandService.login(master, officePassword);
		
		if(adminResult) {
			if (AutoLogin != null ){
				Cookie cookieId = new Cookie("loginCookieIdAdmin",master);
				
				cookieId.setPath("/");
                int amount = 60 * 60 * 24 * 1;
                cookieId.setMaxAge(amount); // 단위는 (초)임으로	 1일정도로 유효시간을 설정해 준다.
                //쿠키 적용
                response.addCookie(cookieId);
            }else {
    			Map<String, Object> owner = headofficeService.getHeadOfficeInfo(master);
    			
    			String ownerAuth = (String) owner.get(Constants.Office.HEADOFFICEAUTHORITY);
    			
    			session.setAttribute("USERID",master);
    		    session.setAttribute("SEQ",master);
    		    session.setAttribute("AUTHORITY",ownerAuth);
    		    
    			return adminResult;
            }
			//세션에 아이디를 담고 메인으로 이동
			Map<String, Object> owner = headofficeService.getHeadOfficeInfo(master);
			
			String ownerAuth = (String) owner.get(Constants.Office.HEADOFFICEAUTHORITY);
			
			session.setAttribute("USERID",master);
		    session.setAttribute("SEQ",master);
		    session.setAttribute("AUTHORITY",ownerAuth);
		    
			return adminResult;
		}else if(brandResult) {
			if (AutoLogin != null ){
				Cookie cookieId = new Cookie("loginCookieIdAdmin",master);
                
				cookieId.setPath("/");
                int amount = 60 * 60 * 24 * 1;
                cookieId.setMaxAge(amount); // 단위는 (초)임으로	 1일정도로 유효시간을 설정해 준다.
                //쿠키 적용
                response.addCookie(cookieId);

            }else {
            	Map<String, Object> brand = brandService.getBrandInfo(master);
    			
    			String brandId = (String) brand.get(Constants.Brand.OWNEREMAIL);
    			String brandSeq = (String) brand.get(Constants.Brand.BRANDOWNERNUM);
    			String brandAuth = (String) brand.get(Constants.Brand.BRANDAUTHORITY);
    			
    			session.setAttribute("USERID",brandId);
    			session.setAttribute("SEQ",brandSeq);
    		    session.setAttribute("AUTHORITY",brandAuth);
    		    
    			return brandResult;
            }
			//세션에 값을 담고 메인이동
			Map<String, Object> brand = brandService.getBrandInfo(master);
			
			String brandId = (String) brand.get(Constants.Brand.OWNEREMAIL);
			String brandSeq = (String) brand.get(Constants.Brand.BRANDOWNERNUM);
			String brandAuth = (String) brand.get(Constants.Brand.BRANDAUTHORITY);
			
			session.setAttribute("USERID",brandId);
			session.setAttribute("SEQ",brandSeq);
		    session.setAttribute("AUTHORITY",brandAuth);
			
			return brandResult;
		} else {
			return false;
		}
	}
	/***********************관리자 페이지 로그인 종료***********************/
	/*************************************강석 컨트롤러 종료************************************************************/
	
	
}
