package com.cyco.member.vo;

import lombok.Data;

@Data
public class MyReviewVo {
	private String review_member;
	private String member_nickname;
	private String review_content;
	private int review_grade;
	private String Position_name;
}
