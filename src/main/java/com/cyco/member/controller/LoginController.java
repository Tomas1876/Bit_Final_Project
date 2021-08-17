package com.cyco.member.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cyco.member.service.MemberService;

@Controller
public class LoginController {

	MemberService memberservice;

	@Autowired
	public void setMemberService(MemberService memberservice) {
		this.memberservice = memberservice;
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {

		System.out.println("This is login by get");

		return "Member/Login";

	}

	@RequestMapping(value="checkLogin", method = RequestMethod.POST)
	  public ModelAndView checkInfo(String username, HttpSession session) {

		  HashMap<String, String> map = memberservice.getLoginedName(username);
		  
		  memberservice.checkDeleteDate(String.valueOf(map.get("MEMBER_ID")));
		  ModelMap mmp = new ModelMap();

		  session.setAttribute("nickname", map.get("MEMBER_NICKNAME"));
		  session.setAttribute("member_id", map.get("MEMBER_ID"));		 
		  
		  //로그인 했을 때 밀린 알림 받기
		  int row = memberservice.getOldAlarm(String.valueOf(map.get("MEMBER_ID")));
		  
		  if(row> 0) {
			  String msg = map.get("MEMBER_NICKNAME")+"님께서 읽지 않은 메시지가 " + Integer.toString(row) +"건 있습니다";		  
			  mmp.addAttribute("alarm", msg);
		  }
		  
	  return new ModelAndView("Main/CycoMain",mmp);
	  
	  }
	
}
