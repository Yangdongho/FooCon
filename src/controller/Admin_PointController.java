package controller;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import service.K_BoardService;

@Controller
@RequestMapping("/admin/point")
public class Admin_PointController {
	/////////////////////////////////경아////////////////////////////////////////////////
	@Autowired
	K_BoardService Kservice;
	//(본사) 적립금현환 화면 요청
	@RequestMapping("/pointList")
	public String pointList(@RequestParam(defaultValue="1") int pageNum,@RequestParam Map<String,Object>params,@RequestParam(required=false)String keyword,Model model) {
		
		params.put("PAGENUM",pageNum);
		Map<String, Object> totalMap = Kservice.selectAllPointAdmin(params);
		totalMap.put("keyword", keyword);
		model.addAttribute("totalMap", totalMap);
		
		return "admin_pointList";
	}
	/////////////////////////////////경아////////////////////////////////////////////////
}
