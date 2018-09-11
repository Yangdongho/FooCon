package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.OrderBrandService;

@Controller
@RequestMapping("/brand")
public class BrandController {
	/////////////////////원용///////////////////////////////////////////
	@Autowired
	private OrderBrandService orderBrandService; 
	
	//브랜드 상세페이지 불러오는 매서드
	@RequestMapping("/brandView")
	public String brandView(HttpSession session, String brandNUM,Model model,HttpServletRequest resquest) {
		String seq = (String)session.getAttribute("SEQ");
		String authority = (String)session.getAttribute("AUTHORITY");

		Map<String,Object> brandView = orderBrandService.brandViewResult(brandNUM,seq,authority);
		if(brandView == null) {
			model.addAttribute("msg","요청하신 페이지가 없습니다.");
			model.addAttribute("url",resquest.getContextPath()+"/");
			return "result";
		}
		model.addAllAttributes(brandView);
		return "brandView";
	}
	
	
	@ResponseBody
	@RequestMapping("/reviewList")
	public Map<String,Object> reviewList(HttpSession session,@RequestParam Map<String,Object> param) {
		String seq = (String)session.getAttribute("SEQ");
		param.put("MEMBERNUM", seq);
		return orderBrandService.reviewList(param);
	}
	
	
	@ResponseBody
	@RequestMapping("/interest")
	public boolean interest(HttpSession session,@RequestParam Map<String,Object> param) {
		
	
		
		String seq = (String)session.getAttribute("SEQ"); 
		return orderBrandService.interestCheck(param,seq);
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
	/////////////////////원용///////////////////////////////////////////
}
