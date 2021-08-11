package com.cyco.admin.vo;

import lombok.Data;

@Data
public class MFieldCountVo implements ChartCount{
	private String id;
	private String name;
	private int count;
}
