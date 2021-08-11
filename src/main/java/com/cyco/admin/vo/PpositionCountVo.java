package com.cyco.admin.vo;

import lombok.Data;

@Data
public class PpositionCountVo implements ChartCount{
	private String id;
	private String name;
	private int count;
}
