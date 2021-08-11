package com.cyco.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cyco.admin.service.AdminService;
import com.cyco.admin.vo.MemberListVo;

@RequestMapping("/ajaxadmin")
@RestController
public class AdminRestController {
	
	@Autowired
	private AdminService service;
	
	/* 사이트 관리 */
	//업데이트 실행 함수
	@RequestMapping(value="/site", method=RequestMethod.PUT)
	public Map<String, String> getSkillUpdate(@RequestBody Map<String, Object> data) {

		
		return service.updateSiteList(data);
	}
	
	/* 회원 관리 */
	//회원 리스트 출력
	@RequestMapping(value="/member", method=RequestMethod.GET)
	public List<MemberListVo> getMemberSearch(@RequestParam String nickname) {

		return service.getSearchList(nickname);
	}
	
	//회원 영구정지 상태 업데이트
	@RequestMapping(value="/member", method=RequestMethod.PUT)
	public Map<String,Object> updateMemberEnabled(@RequestBody Map<String, String> data) {
		
		return service.updateMemberEnabled(data);
	}

}
