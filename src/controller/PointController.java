package controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import service.K_BoardService;

@Controller
@RequestMapping("/point")
public class PointController {
	
	/////////////////////////////////경아////////////////////////////////////////////////

	@Autowired
	K_BoardService Kservice;
	//(사용자)적립금 관리 화면 요청
	@RequestMapping("/pointList")
	public String pointList(@RequestParam(defaultValue="1") int pageNum, @RequestParam Map<String,Object>params,Model model,HttpSession session) {
//		session.getAttribute("MEMBERNUM");
		params.put("PAGENUM", pageNum);
		params.put("MEMBERNUM",session.getAttribute("SEQ"));
		model.addAttribute("totalMap", Kservice.selectAllUserPoint(params));
		
		return "pointList";
	}
	/////////////////////////////////경아////////////////////////////////////////////////
}
