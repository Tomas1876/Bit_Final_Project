package com.cyco.common.vo;

import lombok.Data;

@Data
public class SkillVo extends StatVo{
	//select * from skill;
	private String project_id;
	private String skill_code;
	private String skill_name;
	private String skill_enabled;

}