package com.cyco.project.vo;

import lombok.Data;

@Data
public class V_p_pd_Join_NameVo {
	private String project_id;
	private String member_id;
	private String field_code;
	private String field_name;
	private String adr_code;
	private String adr_name;
	private String p_title;
	private String p_content;
	private String p_image;
	private String p_state;
	private String duration_date;
	private String duration_id;
	
}

// 생성된 프로젝트 모든 정보 가져오는 Vo