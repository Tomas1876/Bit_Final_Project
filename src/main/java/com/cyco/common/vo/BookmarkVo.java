package com.cyco.common.vo;

import lombok.Data;

@Data
public class BookmarkVo {
	private int bookmark_id;
	private String project_id;
	private String member_id;
	
	public BookmarkVo(int bookmark_id, String project_id, String member_id) {
		super();
		this.bookmark_id = bookmark_id;
		this.project_id = project_id;
		this.member_id = member_id;
	}
}
