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

import javax.mail.Multipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import service.DongHoService;
import service.OrderBrandService;
import 동호서비스.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
///////////////////////////동호////////////////////////////////////////////////////////
	@Autowired
	DongHoService dongHoService;
	
	@RequestMapping("/orderList")
	public String orderList(@RequestParam(defaultValue="1") int pageNum ,Model model,
							@RequestParam(required = false) String DELIVREGICHECK,
							HttpSession session, @RequestParam(required = false) String orderNumber) {
		Map<String,Object> order = new HashMap<String,Object>();

		if(orderNumber==null && session.getAttribute("SEQ")==null) {
			return "redirect:/";
		}
		if(orderNumber!=null) {
			Map<String,Object> viewData = new HashMap<String,Object>();
			List<Map<String,Object>> ordertList = new ArrayList<Map<String,Object>>();
			ordertList.add(dongHoService.getNonmemberOrderCheck(orderNumber));
			viewData.put("ordertList", ordertList);
			
			model.addAttribute("viewData",viewData);
		}
		else {
			order.put("memberNum",session.getAttribute("SEQ"));
			order.put("pageNumber", pageNum);
			if(DELIVREGICHECK!=null) {
				order.put("DELIVREGICHECK",DELIVREGICHECK);
			}
			model.addAttribute("viewData",dongHoService.getOrderList(order));
		
		}
			

		return "orderList";
	}
	
	@RequestMapping("/nonMemberOrderCheck")
	@ResponseBody
	public boolean nonMemberOrderCheck(String orderNumber) {
		if(dongHoService.getNonmemberOrderCheck(orderNumber)!=null) {
			return true;
		}
		return false;
		
	}
		
	@RequestMapping("/nonMemberOrderInfo")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> nonMemberOrderInfo(String orderNumber) {
		
		ResponseEntity<Map<String,Object>> entity = null;			
		Map<String,Object> order = dongHoService.getNonmemberOrderInfo(orderNumber);
		
		entity = new ResponseEntity<Map<String,Object>>(order,HttpStatus.OK);
		return entity;
	}
	
	
	@RequestMapping("/orderInfo")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> order(String orderNum) {

			ResponseEntity<Map<String,Object>> entity = null;			
			Map<String,Object> order = dongHoService.getOrderInfo(orderNum);
			entity = new ResponseEntity<Map<String,Object>>(order,HttpStatus.OK);
			return entity;
	}
	
	@RequestMapping("/writeReview")
	@ResponseBody
	public boolean writeReview(MultipartHttpServletRequest multi,HttpSession session) {
		
		MultipartFile file = multi.getFile("file");
		
		
		Map<String,Object> reviewParam = new HashMap<String,Object>();
		reviewParam.put("reviewContent", multi.getParameter("content"));
		reviewParam.put("starGrade", multi.getParameter("rating"));
		reviewParam.put("memberNum", session.getAttribute("SEQ"));//세션에서 받아오기
		reviewParam.put("brandNum", multi.getParameter("brandNum"));
		reviewParam.put("orderNum",multi.getParameter("orderNum"));
	
		return dongHoService.wirteReview(file, reviewParam);
		
		
	}
	
	@RequestMapping("/additionalOrderList")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> additionalOrderList(int pageNum,
								@RequestParam(required = false) String DELIVREGICHECK ,HttpSession session){
	
		ResponseEntity<Map<String,Object>> entity = null;

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("memberNum",session.getAttribute("SEQ"));
		param.put("pageNumber", pageNum);
		if(DELIVREGICHECK!=null) {
			param.put("DELIVREGICHECK",DELIVREGICHECK);
		}
	
		Map<String,Object> orderList = dongHoService.getOrderList(param);
	
		entity = new ResponseEntity<Map<String,Object>>(orderList,HttpStatus.OK);
		
		return entity;
	}
	
///////////////////////////동호////////////////////////////////////////////////////////
	
	/////////////////////원용///////////////////////////////////////////
	@Autowired
	private OrderBrandService orderBrandService;

	
	@RequestMapping(value="/orderForm",method=RequestMethod.GET)
	public String orderForm() {
		return "redirect:/";
	}
	
	@RequestMapping(value="/orderForm",method=RequestMethod.POST)
	public String orderForm(HttpSession session,Model model,String[] menuName,String[] menuPrice,String[] orderQuantity,String[] menuNUM,String brandNUM)throws Exception {
		String seq = (String)session.getAttribute("SEQ");
		Map<String,Object> orderFormView = orderBrandService.orderFormView(seq,brandNUM);
		
		List<Map<String,Object>> orderList = new ArrayList<Map<String,Object>>(); 
		for(int i = 0; i < menuName.length; i++) {
			Map<String,Object> orderMap = new HashMap<String, Object>();
			orderMap.put("menuName",menuName[i]);
			orderMap.put("menuPrice",menuPrice[i]);
			orderMap.put("orderQuantity",orderQuantity[i]);
			orderMap.put("menuNUM",menuNUM[i]);
			orderList.add(orderMap);
		}
		orderFormView.put("orderList", orderList);
		
		String orderListGson = new Gson().toJson(orderList);
		String orderListJson ="{\"orderListJson\":"+orderListGson+"}";
		orderFormView.put("orderListJson", orderListJson);
		model.addAllAttributes(orderFormView);
		return "orderForm";
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
	
	@ResponseBody
	@RequestMapping("/orderPaymentResulut")
	public boolean orderPaymentResult(HttpSession session,@RequestParam Map<String,Object> param) {
		String seq = (String)session.getAttribute("SEQ");
		param.put("MEMBERNUM", seq);
		return orderBrandService.orderInsert(param);
	}
	
	
	@RequestMapping("/success")
    public String success(Model model,HttpSession session) {
       model.addAttribute("seq",session.getAttribute("SEQ"));
       return "success";
    }
	//////////////////////원용///////////////////////////////////////////
}
