package com.cyco.utils;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class UtilFile {
	// 파일 객체 받아오는 유틸 
	String Filename;
	
	// 업로드 된 파일 받아와서 해당 경로에 붙여서 해당 경로 + 파일이름으로 리턴
	public String FileUpload(MultipartHttpServletRequest request, MultipartFile file) {
		
		String path = "";
		Filename = "";
		
		OutputStream out = null;
		PrintWriter printwirter = null;
		
		try {
			Filename = file.getOriginalFilename();
			byte[] bytes = file.getBytes();
			path = getSaveLocation(request);
			
			
			System.out.println("filename : " + Filename);
			System.out.println("path : " + path);
			
			
			File f = new File(path);
			
			if(Filename == null || Filename == "") {
				return null;
			}
			
			// 파일 이름이 중복이면 _ 붙이기
			if(Filename != null && !Filename.equals("") ) {
				if(f.exists()) {
					Filename = System.currentTimeMillis() + "_" + Filename;
					
					f = new File(path + Filename);
				}
			}
			
			
			out = new FileOutputStream(f);
			
			out.write(bytes);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			try {
				if(out != null) {
					out.close();
				}
				if(printwirter != null) {
					printwirter.close();
				}
				
				
			}catch (Exception e) {
				
				
			}
		}
		return path + Filename;
		
	}
	
	
	// 파일 이름 가져오기
	public String getFilename() {
		return Filename;
	}


	
	// 파일 경로 정해주는 메서드
	private String getSaveLocation(MultipartHttpServletRequest request) {
		
		// 기본 파일 경로
		String uploadpath = request.getSession().getServletContext().getRealPath("/");
		System.out.println("uploadpath : " + uploadpath);
		// 어떤 파일에 저장할것인지
		String attachpath =  request.getContextPath() + "/images";
		
		
		return uploadpath + attachpath;
		
	}
		
}