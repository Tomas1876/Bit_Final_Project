package com.cyco.member.controller;



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cyco.common.vo.MemberVo;
import com.cyco.member.service.MemberService;



@Controller
public class RegisterController {
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private MemberService service;

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String join() {

		System.out.println("This is join by get");

		return "Member/Register";

	}

	
	@RequestMapping(value = "register", method = RequestMethod.POST)
    //public String joinOK(MemberVo member, HttpServletResponse res) throws IOException {
	public ModelAndView joinOK(MemberVo member, HttpServletResponse res) throws IOException {
		
		System.out.println("This is joinOK");
		member.setMEMBER_PWD(this.bCryptPasswordEncoder.encode(member.getMEMBER_PWD()));
		ModelMap mmp = new ModelMap();
		
		int result = 0;
		
		result = service.regist(member);

		String msg ="";
		
		if (result > 0) {
			System.out.println("삽입 성공");

			msg="success";
			
		} else {
			System.out.println("삽입 실패");
			
			msg="fail";
			
		}
			mmp.put("msg", msg);
		
		return new ModelAndView("Member/Login", mmp);
        
    }
	
	@RequestMapping(value = "findAccount", method = RequestMethod.GET)
	public String findAccount() {

		System.out.println("This is findAccount by get");

		return "Member/FindAccount";

	}
	  

}
