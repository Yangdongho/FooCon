package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class Interceoptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("인터셉터가 요청 가로챈");
		String userid = (String) request.getSession().getAttribute("userid");
		
		//멤버 로그인후 갈 수 있는 곳
		/*if(userid!=null) {
			return true;
		}else {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/member/loginForm");
			//로그인 요청  주소  써서 로그인 화면으로 보내야함
			return false;
		}
*/		
		return true;
	}
	
	
}
