package com.cyco.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVo {

	private int review_id;
	private String review_content;
	private String review_date;
	private int review_grade;
	private String writer_id;
	private String review_member;
	private String project_id;
	
	private String member_nickname;
}
