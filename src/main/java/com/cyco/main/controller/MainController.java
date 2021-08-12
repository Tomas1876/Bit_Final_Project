package com.cyco.main.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@Autowired
	SessionRegistry sessionRegistry;

	@RequestMapping(value="/main")
	public String MainToGo() {
		System.out.println("this is main");
		
		
		//시큐리티 로그아웃 실험중
		String useremail = "99999@cycoding.com";
		
		List<Object> loggedUsers = sessionRegistry.getAllPrincipals();
		for (Object principal : loggedUsers) {
		    if(principal instanceof User) {
		        final User loggedUser = (User) principal;
		        if(useremail.equals(loggedUser.getUsername().toString())) {
		            List<SessionInformation> sessionsInfo = sessionRegistry.getAllSessions(principal, false);
		            if(null != sessionsInfo && sessionsInfo.size() > 0) {
		                for (SessionInformation sessionInformation : sessionsInfo) {
		                    System.out.println("Exprire now :" + sessionInformation.getPrincipal().toString());
		                    sessionInformation.expireNow();
		                    sessionRegistry.removeSessionInformation(sessionInformation.getSessionId());
		                    // User is not forced to re-logging
		                }
		            }
		        }
		    }
		} 
		
		return "Main/CycoMain";
	
	}
	
	@RequestMapping(value="/forbidden")
	public String forbidden() {
		System.out.println("접근 권한이 없는 페이지입니다");

		return "Main/Forbidden";
	
	}
	
	
}
