package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import service.DongHoService;

@Controller
@RequestMapping("/admin/order")
public class Admin_OrderController {
///////////////////////////동호////////////////////////////////////////////////////////
	@Autowired
	DongHoService dongHoService;

	@RequestMapping("/orderList")
	public String orderList(Model model,@RequestParam(required = false)String keyword,
										 @RequestParam(required = false)String category,	
										 @RequestParam(defaultValue="1")int pageNumber,
										 HttpSession session) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("keyword", keyword);
		param.put("pageNumber", pageNumber);
	
		
		
		
		
		if(!session.getAttribute("AUTHORITY").equals("MASTER")) {
			//session.getAttribute("brandNum");
			param.put("brandNum", session.getAttribute("SEQ"));
		}
	
		
		if(category!="" && category!=null) {
			param.put("category",category);
		}
										//getAdminOrderList
		model.addAttribute("viewData",dongHoService.getAdminOrderList(param));
		//model.addAttribute("AUTHORITY",session.getAttribute("AUTHORITY"));
		model.addAttribute("AUTHORITY","MASTER");
		
		return "admin_orderList";
	}
	
	@RequestMapping("/orderView")
	public String orderView(String orderNum,Model model) {
		
		model.addAttribute("order",dongHoService.getOrder(orderNum));
	
		return "admin_orderView";
	}
	
	@RequestMapping("/writeMemo")
	public String orderView(@RequestParam Map<String,Object> param) {
		dongHoService.addMemo(param);
		return "redirect:orderList";
	}
	
	@RequestMapping("/excel")
	public View Excel(HttpServletResponse response,HttpSession session) {
		 	
        String filename = "테스트입니다.";
        response.setHeader("Content-disposition", "attachment; filename=" + filename + ".xlsx"); //target명을 파일명으로 작성
 
        //엑셀에 작성할 리스트를 가져온다.
        String brandNum = "MASTER";
        List<Map<String,Object>> excelList =  dongHoService.getExcelList(brandNum);
        ExcelView excelView = new ExcelView(excelList); 
        return excelView;
        
		
	}
///////////////////////////동호////////////////////////////////////////////////////////
}
