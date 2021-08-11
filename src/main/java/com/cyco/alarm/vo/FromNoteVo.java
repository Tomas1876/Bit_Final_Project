package com.cyco.alarm.vo;


import java.util.Date;

import lombok.Data;

@Data
public class FromNoteVo {
	
	private String NOTE_ID;
	private String member_FROM;
	private String member_TO;
	private String note_CONTENT;
	private Date NOTE_DATE;
}
