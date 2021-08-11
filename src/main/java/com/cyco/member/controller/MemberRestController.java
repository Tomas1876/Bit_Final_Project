package com.cyco.member.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cyco.member.service.MemberDetailService;
import com.cyco.member.service.MemberService;
import com.cyco.member.vo.V_MlistVo;
import com.cyco.project.vo.P_DetailVo;

@RestController

@RequestMapping("member")
public class MemberRestController {
	MemberService memberservice;
	MemberDetailService memberdetailservice;

	@Autowired
	public void setMemberService(MemberService memberservice, MemberDetailService memberdetailservice) {
		this.memberservice = memberservice;
		this.memberdetailservice = memberdetailservice;
	}


	// 포지션 select
	@RequestMapping(value = "memberPosition/{position}", method = RequestMethod.GET)
	public List<V_MlistVo> getMemberPosition(@PathVariable("position") String position) {
		//System.out.println("RESTController, position: " + position);

		if(position.equals("전체")) {
			position = "";
		}

		List<V_MlistVo> memberPosition = memberservice.memberPosition(position);
		
		return memberPosition;
	}
	
	//회원 검색
	@RequestMapping(value = "memberSearch/{memberNickname}", method = RequestMethod.GET)
	public List<V_MlistVo> getMemberNickname(@PathVariable("memberNickname") String memberNickname) {
		System.out.println("RESTController, memberNickname: " + memberNickname);
		List<V_MlistVo> memberNicknameList = memberservice.memberNickname(memberNickname);
		
		return memberNicknameList;
	}
	
	//더보기
	@RequestMapping(value = "memberMore", method = RequestMethod.GET)
	public List<V_MlistVo> moreBtn() {
		//System.out.println("더보기버튼 restcontroller");
		List<V_MlistVo> memberList = memberservice.memberList();
		return memberList;
	}
	
	//회원 초대 전에 초대할 프로젝트 있는지 확인
	@RequestMapping(value = "ajax/checkprojectbeforeinvite", method = {RequestMethod.GET, RequestMethod.POST},produces = "application/json; charset=utf8")
	public HashMap<String, String> checkProjectBeforeInvite(String member_id) {
		
		
		//System.out.println("현재 멤버 아이디" + member_id);
		
		List<P_DetailVo> p_detail =memberdetailservice.checkProjectBeforeInvite(member_id);
		HashMap<String, String> map = new HashMap<String, String>();
		
		if(p_detail.size() != 0) {
			//System.out.println(p_detail.toString());
			map.put("p_title",p_detail.get(0).getP_title());
			map.put("project_id", p_detail.get(0).getProject_id());
		}	
		
		return map;
	}
}
