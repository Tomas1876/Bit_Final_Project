package com.cyco.admin.vo;

import lombok.Data;

@Data
public class MemberListVo {
	private int member_id;
	private String member_nickname;
	private String position_name;
	private String skill_name;
	private String enabled;
	private int count;
	
	//페이지 로우넘
	private int rownum;
}
