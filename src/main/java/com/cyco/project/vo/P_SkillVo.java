package com.cyco.project.vo;

import lombok.Data;

@Data
public class P_SkillVo {
	String project_id;
	String skill_code;
	
	
	public P_SkillVo(String project_id, String skill_code) {
		super();
		this.project_id = project_id;
		this.skill_code = skill_code;
	}
	public P_SkillVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}


