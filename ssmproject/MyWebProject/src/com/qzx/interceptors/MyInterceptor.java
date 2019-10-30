package com.qzx.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class MyInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,ModelAndView modelAndView)
			throws Exception {
		String string = request.getRequestURI();
		if(string.indexOf("exit")!=-1) {
			HttpSession session = request.getSession();
			session.removeAttribute("loginName");
			session.removeAttribute("loginPassword");
			session.removeAttribute("SESSION_USERNAME");
			session.invalidate();
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Object user = request.getSession().getAttribute("loginName");
		if(user == null) {
			response.sendRedirect("./index.do");
			return false;
		}
		
		return true;
	}

	
}
