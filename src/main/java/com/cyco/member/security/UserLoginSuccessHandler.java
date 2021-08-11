package com.cyco.member.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.cyco.common.vo.MemberVo;
import com.cyco.member.service.MemberService;


public class UserLoginSuccessHandler implements AuthenticationSuccessHandler{

	private static final Logger logger = LoggerFactory.getLogger(UserLoginSuccessHandler.class);

	
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest req,
			HttpServletResponse res, Authentication auth) throws IOException,
			ServletException {
		
		System.out.println("로그인 성공");
		
		User user = (User)auth.getPrincipal();


		System.out.println("현재 유저 정보 : " + auth.getPrincipal().toString());
		
		
		
		for(GrantedAuthority a : auth.getAuthorities()){
			logger.info(a.getAuthority());

		}
		logger.info(String.valueOf(user.isAccountNonExpired()));
		logger.info(String.valueOf(user.isAccountNonLocked()));
		logger.info(String.valueOf(user.isCredentialsNonExpired()));
		logger.info(String.valueOf(user.isEnabled()));
		req.setAttribute("username", auth.getName());

		req.getRequestDispatcher("checkLogin").forward(req, res);
	}

}
