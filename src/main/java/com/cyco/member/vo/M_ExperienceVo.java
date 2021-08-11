package com.cyco.member.vo;


import lombok.Data;

@Data
public class M_ExperienceVo {

	//회원 프로젝트 경험 테이블	
	private String MEMBER_ID;
	private String EXP_TITLE;
	private String EX_POSITION;
	private String EX_SKILL;
	private String EX_CONTENT;
	private String EX_DURATION;
	private String ex_count;
	
}