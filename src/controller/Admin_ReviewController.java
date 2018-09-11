package controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.DongHoService;


@Controller
@RequestMapping("/admin/review")
public class Admin_ReviewController {
///////////////////////////동호////////////////////////////////////////////////////////
	//리뷰 리스트
	@Autowired
	DongHoService dongHoService;
	
	@RequestMapping("/reviewList")
	public String reviewList(Model model,@RequestParam(required = false)String keyword,
										 @RequestParam(required = false)String category,	
										 @RequestParam(defaultValue="1")int pageNumber,
										 HttpSession session) {

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("pageNumber", pageNumber);
		//param.put("brandNum", "BO22");
//		session.setAttribute("SEQ", "BO1");
//		session.setAttribute("AUTHORITY", "MASTER");
		if(!session.getAttribute("AUTHORITY").equals("MASTER")) {
			//session.getAttribute("brandNum");
			param.put("brandNum", session.getAttribute("SEQ"));
		}

		if(category!="" && category!=null) {
			param.put("category",category);
		}
		if(keyword!="" && keyword!=null) {
			param.put("keyword",keyword);
		}
		
		model.addAttribute("viewData",dongHoService.getReviewList(param));
		return "admin_reviewList";
	}
	
	@RequestMapping("/deleteReview")
	public String deleteReview(String reviewNum) {
		
		dongHoService.removeReview(reviewNum);
		return "redirect:reviewList";
	}
	
	
	
	//리뷰 등록 ajex
	@RequestMapping("/getReview")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getRiview(String reviewNum) {
	
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> review = dongHoService.getReview(reviewNum);	
		entity = new ResponseEntity<Map<String,Object>>(review,HttpStatus.OK);
	
		return entity;
	}
	
	@RequestMapping("/writeReply")
	@ResponseBody
	public boolean writeReply(@RequestParam Map<String,Object> reply) {

	
		return dongHoService.addReply(reply);
	}
	
	
	
	@RequestMapping("/reviewImg")
	@ResponseBody
	public byte[] eventImg(String reviewNum) {
		//이미지 요청
		return dongHoService.getImegeAsByteArray(reviewNum);
	}		
///////////////////////////동호////////////////////////////////////////////////////////
	
}
