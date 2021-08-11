package com.cyco.project.vo;

import lombok.Data;

@Data
public class P_MemberVo {
	String member_id;
	String project_id;
	String position_id;
	
	
	public P_MemberVo(String member_id, String project_id, String position_id) {
		super();
		this.member_id = member_id;
		this.project_id = project_id;
		this.position_id = position_id;
	}
	public P_MemberVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
