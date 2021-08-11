package com.cyco.member.vo;

import lombok.Data;

@Data
public class MemberDetailPageVo {
	
	//회원상세에서 detail부분 편하게 출력하려고 만든 vo
	
	private String skill_name;
	private String skill_enabled;
	private int member_id;
	private String position_name;
	private String position_enabled;
	private String position_id;
	private String du_date;
	
	
	

}
