package com.cyco.alarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cyco.alarm.service.AlarmService;
import com.cyco.alarm.vo.V_FromNote_Member_Vo;
import com.cyco.alarm.vo.V_ToNote_Member_Vo;


@RequestMapping(value="/messages")
@Controller
public class AlarmController {
	
	@Autowired
	AlarmService alarmservice;
	
	//쪽지 페이지 진입
	@RequestMapping(value="/")
	public ModelAndView getAllMessages(Authentication auth){
	
		List<V_ToNote_Member_Vo> tolist = alarmservice.getReceivedMessages(auth.getName());
		List<V_FromNote_Member_Vo> fromlist = alarmservice.getSendMessages(auth.getName()); 	
	
		ModelMap mmp = new ModelMap();
		
		mmp.put("email", auth.getName());
		mmp.put("tolist", tolist);
		mmp.put("fromlist", fromlist);
		
		return new ModelAndView("Member/MyMessages",mmp);
		
	}
	
	

}
