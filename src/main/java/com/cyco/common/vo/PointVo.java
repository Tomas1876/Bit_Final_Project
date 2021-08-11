package com.cyco.common.vo;

import lombok.Data;

@Data
public class PointVo {
	int member_id;
	int have_point;
	int use_point;
	
	public PointVo(int member_id, int have_point, int use_point) {
		super();
		this.member_id = member_id;
		this.have_point = have_point;
		this.use_point = use_point;
	}
	public PointVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
