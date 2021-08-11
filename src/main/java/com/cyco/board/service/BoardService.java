package com.cyco.board.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.cyco.board.vo.BoardReplyVo;
import com.cyco.board.vo.BoardVo;
import com.cyco.utils.FileVO;
import com.cyco.utils.SearchVO;


@Service
public class BoardService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private DataSourceTransactionManager txManager;
	
//	게시글 전체데이터갯수 구하기
	public Integer selectBoardCount(SearchVO param) throws Exception {
		return sqlSession.selectOne("selectBoardCount", param);
    }
//	게시글 목록
	public List<?> selectBoardList(SearchVO param) throws Exception { 
		return sqlSession.selectList("selectBoardList", param);
    }
//	게시글 등록 + 수정 +파일등록
	public void insertBoard(BoardVo param, List<FileVO> filelist, String[] fileno) throws Exception {
//		트랜잭션(Transaction) 처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		
		try{
	    	if (param.getFREE_ID()==null || "".equals(param.getFREE_ID())) {
	    		 sqlSession.insert("insertBoard", param);
	    	} else {
	    		sqlSession.update("updateBoard", param);
	    	}
	
	    	if (fileno != null) {
	    		HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteBoardFile", fparam);
	    	}
	    	
	    	for (FileVO f : filelist) {
	    		f.setParentPK(param.getFREE_ID());
	   		 	sqlSession.insert("insertBoardFile", f);
	    	}
			txManager.commit(status);
		} catch (Exception ex) {
			txManager.rollback(status);
			System.out.println("데이터 저장 오류 : " + ex.toString());
		}	    	
    }
//	게시글 읽기
	public BoardVo selectBoardOne(String param) throws Exception {
		return sqlSession.selectOne("selectBoardOne", param);
    }
//	조회수 증가
	public void updateBoardRead(String param) throws Exception {
	    sqlSession.update("updateBoardRead", param);
	}
//	게시글 삭제
	public void deleteBoardOne(String param) throws Exception {
		sqlSession.delete("deleteBoardOne", param);
    }
//	파일 삭제 목록 선택
	public List<?> selectBoardFileList(String param) throws Exception {
		return sqlSession.selectList("selectBoardFileList", param);
    }
//	댓글리스트 가져오기
	public List<?> selectBoardReplyList(String param){
		return sqlSession.selectList("selectBoardReplyList", param);
	}
	
//	댓글 등록 + 수정
	public void insertBoardReply(BoardReplyVo param) {
        if (param.getREPLY_ID() == null || "".equals(param.getREPLY_ID())) {
            if (param.getREPLY_REF() != null) {
                BoardReplyVo replyInfo = sqlSession.selectOne("selectBoardReplyParent", param.getREPLY_REF());
                param.setDEPT(replyInfo.getDEPT());
                param.setSTEP(replyInfo.getSTEP() + 1);
                sqlSession.selectOne("updateBoardReplyOrder", replyInfo);
            } else {
                Integer STEP = sqlSession.selectOne("selectBoardReplyMaxOrder", param.getFREE_ID());
                param.setSTEP(STEP);
            }
            
            sqlSession.insert("insertBoardReply", param);
        } else {
            sqlSession.insert("updateBoardReply", param);
        }
    }   
//	댓글 삭제 -  자식 댓글이 있으면 삭제 안됨. 
    public boolean deleteBoardReply(String param) {
//        Integer cnt = sqlSession.selectOne("selectBoardReplyChild", param);
        
//        if ( cnt > 0) {
//            return false;
//        }
//        
//        sqlSession.update("updateBoardReplyOrderDelete", param);
//        
        sqlSession.delete("deleteBoardReply", param);
        
        return true;
    }    

}
