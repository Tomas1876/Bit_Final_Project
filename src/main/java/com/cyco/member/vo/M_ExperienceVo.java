package com.cyco.member.vo;


import lombok.Data;

@Data
public class M_ExperienceVo {

	//회원 프로젝트 경험 테이블	
	private String member_id;
	private String exp_title;
	private String ex_position;
	private String ex_skill;
	private String ex_content;
	private String ex_duration;
	private String ex_count;
	
}