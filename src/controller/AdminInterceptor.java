package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("admin 인터셉터");
		String USERID = (String) request.getSession().getAttribute("USERID");
		String AUTHORITY = (String) request.getSession().getAttribute("AUTHORITY");
		String uri = request.getRequestURI();
		System.out.println(uri);
		String contextPath = request.getContextPath();
		String []check = uri.split("/");
		for (String string : check) {
			System.out.println(string);
		}
		
		if(USERID!=null) {
			if(AUTHORITY.equals("BRAND")) {
				//전부다 이동할 페이지로 리다이렉트 해줘야함 
				//브랜드가 url로 관리자 페이지에 접근하는것을 막는곳
				if(check[3].equals("pointList")) {
					return false;
				}else if(check[3].equals("questionList")) {
					return false;
				}else if(check[3].equals("noticeList")) {
					return false;
				}else if(check[3].equals("noticeDelete")) {
					return false;
				}else if(check[3].equals("noticeWriteForm")) {
					return false;
				}else if(check[3].equals("noticeWrite")) {
					return false;
				}else if(check[3].equals("noticeViewForm")) {
					return false;
				}else if(check[3].equals("noticeView")) {
					return false;
				}else if(check[3].equals("faqList")) {
					return false;
				}else if(check[3].equals("faqDelete")) {
					return false;
				}else if(check[3].equals("faqViewForm")) {
					return false;
				}else if(check[3].equals("faqView")) {
					return false;
				}else if(check[3].equals("faqWriteForm")) {
					return false;
				}else if(check[3].equals("faqWrite")) {
					return false;
				}else if(check[3].equals("memberList")) {
					return false;
				}else if(check[3].equals("memberInfo")) {
					return false;
				}else if(check[3].equals("memberOrderList")) {
					return false;
				}else if(check[3].equals("memberPointList")) {
					return false;
				}else if(check[3].equals("eventList")) {
					return false;
				}else if(check[3].equals("eventView")) {
					return false;
				}else if(check[3].equals("adReferenceList")) {
					return false;
				}else if(check[3].equals("adReferenceView")) {
					return false;
				}

			}
			return true;
		}else {
			response.sendRedirect(contextPath+"/member/loginForm");
			//로그인 요청  주소  써서 관리자 로그인 화면으로 보내야함
			return false;
		}
	
	}
	
}
