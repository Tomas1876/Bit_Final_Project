package com.cyco.project.vo;

import lombok.Data;

@Data
public class V_PjAdrField_Join_V_PDetail { 
	//p.project_id, p.member_id, p.adr_name, p.field_name,vpd.p_title, vpd.p_image, vpd.duration_date, vpd.p_content, vpd.p_state, vpd.p_views, vpd.p_date
	private String project_id; // 프로젝트 번호
	private String member_id; // 프로젝트 생성자 번호
	private String member_nickname; //프로젝트 생성자 닉네임
	private String member_image; // 프로젝트 생성자 프로필 사진
	private String adr_name; // 지역이름
	private String field_name; // 분야이름
	private String p_title; // 프로젝트 제목
	private String p_image; // 프로젝트 썸네일
	private String duration_date; // 프로젝트 기간
	private String p_content; // 프로젝트 본문
	private String p_state; // 프로젝트 상태
	private String p_views; // 조회수
	private String p_date; // 프로젝트 생성일
	
}
