package com.cyco.board.vo;

import java.util.Date;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.cyco.utils.utiletc;
import lombok.Data;

@Data
public class BoardVo {
//	글번호
	private Long FREE_ID;
//	글제목
	private String FREE_TITLE;
//	글쓴이
	private int MEMBER_ID;
//	글내용
	private String FREE_CONTENT;
//	작성일
	private Date FREE_DATE;
//	조회수
	private int FREE_VIEWS;
//	닉네임
	private String MEMBER_NICKNAME;
//	게시글에 첨부된 파일 갯수
	private String filecnt;
//	첨부파일 목록
	private List<MultipartFile> uploadfile;
//	게시물 제목을 글자수에 맞추어 자르기
	public String getShortTitle(Integer len){
		return utiletc.getShortString(FREE_TITLE, len);
	}
	
	
}
