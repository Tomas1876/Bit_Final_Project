package com.cyco.member.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;


public class UserLoginFailureHandler implements AuthenticationFailureHandler{

	private static final Logger logger = LoggerFactory.getLogger(UserLoginFailureHandler.class);

	@Override
	public void onAuthenticationFailure(HttpServletRequest req,
			HttpServletResponse res, AuthenticationException auth)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		logger.info(auth.getLocalizedMessage());
		logger.info(auth.getMessage());
		logger.info(req.getParameter("password"));
		
		for(StackTraceElement s : auth.getStackTrace()){
			logger.info(s.getClassName());
			logger.info(s.getFileName());
			logger.info(s.getMethodName());
			logger.info(s.getLineNumber()+"");
			logger.info(s.isNativeMethod()+"");
		}
		
		System.out.println("로그인 실패");
		System.out.println("사유 : " + auth.getMessage());
		System.out.println(req.getParameter("username"));
		req.setAttribute("errMsg",auth.getMessage());

		res.sendRedirect("login?error=true");

	}
	
	
	
}
