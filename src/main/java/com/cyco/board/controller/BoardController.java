package com.cyco.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.cyco.board.service.BoardService;
import com.cyco.board.vo.BoardReplyVo;
import com.cyco.board.vo.BoardVo;
import com.cyco.utils.FileUtil;
import com.cyco.utils.FileVO;
import com.cyco.utils.SearchVO;

@Controller
@RequestMapping(value="board")
public class BoardController {
	
	@Autowired
	private BoardService boardSvc;
	
 // 리스트
    @RequestMapping(value = "list")
   	public String boardList(SearchVO searchVO, ModelMap modelMap) throws Exception {
//    	페이징 호출1(컨트롤러에서 호출하고 JSP에서 호출)
    	System.out.println("게시판 리스트");
    	searchVO.pageCalculate( boardSvc.selectBoardCount(searchVO) ); 

    	List<?> listview   = boardSvc.selectBoardList(searchVO);
        
    	modelMap.addAttribute("listview", listview);
		modelMap.addAttribute("searchVO", searchVO);
        return "Board/BoardList";
    }
//	글쓰기 + 글수정 + 파일삭제 양식
	@RequestMapping(value = "/form")
   	public String boardForm(HttpServletRequest request, ModelMap modelMap) throws Exception {
		System.out.println("게시판 등록폼 호출");
    	String FREE_ID = request.getParameter("FREE_ID");
    	if (FREE_ID!=null) {
    		BoardVo boardInfo = boardSvc.selectBoardOne(FREE_ID);
        	List<?> listview = boardSvc.selectBoardFileList(FREE_ID);
        
    		modelMap.addAttribute("boardInfo", boardInfo);
        	modelMap.addAttribute("listview", listview);
    	}
    	
        return "Board/BoardForm";
    }
	
//	글쓰기 + 글수정 처리 + 파일 저장
	 @RequestMapping(value = "/save")
	   	public String boardSave(HttpServletRequest request, BoardVo boardInfo) throws Exception {
	    	String[] fileno = request.getParameterValues("fileno");
	    	System.out.println("게시판 등록");
	    	FileUtil fs = new FileUtil();
			List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

	   		boardSvc.insertBoard(boardInfo, filelist, fileno);

	        return "redirect:list";
	    }
//	읽기
	@RequestMapping(value = "/read")
	public String boardRead(HttpServletRequest request, ModelMap modelMap) throws Exception {
		System.out.println("게시판 읽기");
			String FREE_ID = request.getParameter("FREE_ID");
	        
//	        조회수증가
	        boardSvc.updateBoardRead(FREE_ID);
//	        게시글 조회
	        BoardVo boardInfo = boardSvc.selectBoardOne(FREE_ID);
//	        파일 리스트 읽어오기
	        List<?> listview = boardSvc.selectBoardFileList(FREE_ID);
//	       댓글 리스트 읽어오기
	        List<?> replylist = boardSvc.selectBoardReplyList(FREE_ID);
	        
	        
	        modelMap.addAttribute("boardInfo", boardInfo);
	        modelMap.addAttribute("listview", listview);
	        modelMap.addAttribute("replylist", replylist);
	       
	        return "Board/BoardRead";
	}
	
//	삭제
	@RequestMapping(value = "/delete")
    public String boardDelete(HttpServletRequest request) throws Exception {
		System.out.println("게시판 삭제");
     String FREE_ID = request.getParameter("FREE_ID");
    
     boardSvc.deleteBoardOne(FREE_ID);
    
     return "redirect:list";
}
//	파일 다운로드
    @RequestMapping(value = "fileDownload")
    public void fileDownload(HttpServletRequest request,HttpServletResponse response) {
    	System.out.println("파일 다운로드");
        String path = "c:\\workspace\\fileupload\\"; 
        
        String filename = request.getParameter("filename");
        String downname = request.getParameter("downname");
        String realPath = "";
        
        if (filename == null || "".equals(filename)) {
            filename = downname;
        }
        
        try {
            filename = URLEncoder.encode(filename, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }
        
        realPath = path + downname.substring(0,4) + "/" + downname;

        File file1 = new File(realPath);
        if (!file1.exists()) {
            return ;
        }
        
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realPath);

            int ncount = 0;
            byte[] bytes = new byte[512];

            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (FileNotFoundException ex) {
            System.out.println("FileNotFoundException");
        } catch (IOException ex) {
            System.out.println("IOException");
        }
    }
//    댓글 저장
    @RequestMapping(value = "/replysave")
    public String boardReplySave(HttpServletRequest request, BoardReplyVo boardReplyInfo) {
    	System.out.println("댓글 저장");
        boardSvc.insertBoardReply(boardReplyInfo);

        return "redirect:read?FREE_ID=" + boardReplyInfo.getFREE_ID();
    }
    
//    댓글 삭제
    @RequestMapping(value = "/replydelete")
    public String boardReplyDelete(HttpServletRequest request, BoardReplyVo boardReplyInfo) {
    	System.out.println("댓글 삭제");
    	boardSvc.deleteBoardReply(boardReplyInfo.getREPLY_ID());

        return "redirect:read?FREE_ID=" + boardReplyInfo.getFREE_ID();
    }      
}
