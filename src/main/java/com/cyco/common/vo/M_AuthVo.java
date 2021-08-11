package com.cyco.common.vo;

import lombok.Data;

@Data
public class M_AuthVo {
	String authority_id;
	String member_id;
	
	
	public M_AuthVo(String authority_id, String member_id) {
		super();
		this.authority_id = authority_id;
		this.member_id = member_id;
	}
	
	
}
