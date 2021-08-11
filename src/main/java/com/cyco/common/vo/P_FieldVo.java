package com.cyco.common.vo;

import java.util.List;

import lombok.Data;

@Data
public class P_FieldVo {
	//select field_code, field_name,field_enable from p_field;
	private String field_code;
	private String field_name;
	private String field_enabled;
	

	private List<P_FieldVo>  FieldVoList;
	
}
