package com.cyco.alarm.vo;

public class NoteVo {
	
	private String NOTE_ID;
	private String MEMBER_FROM;
	private String MEMBER_TO;
	private String MEMBER_NICKNAME; //내가 보낸 쪽지를 받는 사람의 닉네임
	private String NOTE_CONTENT;
	private String NOTE_DATE;
	public String getNOTE_ID() {
		return NOTE_ID;
	}
	public void setNOTE_ID(String nOTE_ID) {
		NOTE_ID = nOTE_ID;
	}
	public String getMEMBER_FROM() {
		return MEMBER_FROM;
	}
	public void setMEMBER_FROM(String mEMBER_FROM) {
		MEMBER_FROM = mEMBER_FROM;
	}
	public String getMEMBER_TO() {
		return MEMBER_TO;
	}
	public void setMEMBER_TO(String mEMBER_TO) {
		MEMBER_TO = mEMBER_TO;
	}
	public String getMEMBER_NICKNAME() {
		return MEMBER_NICKNAME;
	}
	public void setMEMBER_NICKNAME(String mEMBER_NICKNAME) {
		MEMBER_NICKNAME = mEMBER_NICKNAME;
	}
	public String getNOTE_CONTENT() {
		return NOTE_CONTENT;
	}
	public void setNOTE_CONTENT(String nOTE_CONTENT) {
		NOTE_CONTENT = nOTE_CONTENT;
	}
	public String getNOTE_DATE() {
		return NOTE_DATE;
	}
	public void setNOTE_DATE(String nOTE_DATE) {
		NOTE_DATE = nOTE_DATE;
	}
	
	
}
