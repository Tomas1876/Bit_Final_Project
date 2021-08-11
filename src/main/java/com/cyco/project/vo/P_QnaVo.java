package com.cyco.project.vo;

import lombok.Data;

@Data
public class P_QnaVo {
	String qna_id;
	String project_id;
	String qna_content;
	String qna_date;
	String enabled;
	String step;
	String ref;
	String member_id;
	String member_nickname;
	String member_image;
	
	String replycount;
	
}
