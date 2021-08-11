package com.cyco.board.vo;

import java.util.Date;
import lombok.Data;

@Data
public class BoardReplyVo {
//	게시글 번호
    private String FREE_ID;
//    댓글 번호
    private String REPLY_ID;
//    댓글쓴이
    private String MEMBER_ID;
//    	댓글쓴이 닉네임
    private String MEMBER_NICKNAME;
//    댓글 내용
    private String REPLY_CONTENT;
//    댓글 작성일자
    private Date REPLY_DATE;
//    부모
    private String REPLY_REF;
//    깊이
    private String DEPT;
//    순서
    private Integer STEP;
    
}
