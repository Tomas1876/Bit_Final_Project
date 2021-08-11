package com.cyco.alarm.vo;


import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
public class ToNoteVo {
	
	private String NOTE_ID;
	private String member_FROM;
	private String member_TO;
	private String note_CONTENT;
	private Date NOTE_DATE;
	private String NOTE_OK;
}
