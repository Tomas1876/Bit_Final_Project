package com.cyco.alarm.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AlarmVo {
	
	private String ALARM_ID;
	private String MEMBER_ID;
	private List<String> members;
	private String ALARM_CODE;
	private String ALARM_DATE;
	private String ALARM_OK;
	private String ALARM_CONTENT;
	private String URL;
	
}
