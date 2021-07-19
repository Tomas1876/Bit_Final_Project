package com.cyco.member.controller;

import java.io.IOException;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.cyco.member.dao.MemberDao;
import com.cyco.member.service.EmailService;
import com.cyco.member.service.MemberDetailService;
import com.cyco.member.vo.EmailVo;

@RequestMapping(value="register/")
@RestController
public class RegisterRestComtroller {
	
	MemberDetailService memberdetailservice;
	EmailService emailservice;
		
	@Autowired
	public void setMemberDetailService(MemberDetailService memberdetailservice) {
		this.memberdetailservice = memberdetailservice;
	}
	
	@Autowired
	public void setEmailService(EmailService emailservice) {
		this.emailservice = emailservice;
	}
	
	@Autowired
	PasswordEncoder pwdEncoder;
   
   private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	EmailService emailService;
	
	@RequestMapping(value="emailcheck.ajax", method=RequestMethod.GET)
	public String checkEmail(String email) {
		
		
		String mail = email.replace("email=","").replace("%40","@");
		
		System.out.println("중복체크할 메일 : " + mail );
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		String result = "able";
		
		if(memberdao.checkEmail(mail) != null) {
			result = "disable";
		} else {
			result = "able";
		}
		

		System.out.println("결과값 : " + result);
		
		return result;
	}

	
	@RequestMapping(value="emailcheck.ajax", method=RequestMethod.POST)
	public int mailSending(EmailVo vo ,HttpServletRequest request, String email, HttpServletResponse response_email) throws IOException {
		int random = 0; 
		
		vo.setSenderName("CYCO");
		vo.setSenderMail("cycoding1004@gmail.com");
		vo.setSubject("[CYCODING]사이좋게 코딩하자 사이코딩 인증 메일입니다");
		
		System.out.println(vo);
		try {
			random = emailservice.sendMail(vo); 
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        
        return random;
        
    }
	
	
	@RequestMapping(value="nicknamecheck.ajax")
	public String checkNickName(String nickName) {
		
		System.out.println("This is checkNickName");
		
		
		System.out.println("중복체크할 닉네임 : " + nickName );
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		String result = "able";
		
		if(memberdao.checkNickName(nickName) != null) {
			
			result = "disable";
		} else {
			result = "able";
		}
		

		System.out.println("결과값 : " + result);
		
		return result;
	}
	
	@RequestMapping(value="phonecheck.ajax")
	public String checkPhone(String phone) {
		
		System.out.println("This is checkPhone");
		
		
		System.out.println("중복체크할 번호 : " + phone );
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		String result = "able";
		
		if(memberdao.checkPhone(phone) != null) {
			result = "disable";
		} else {
			result = "able";
		}
		

		System.out.println("결과값 : " + result);
		
		return result;
	}
	
	@RequestMapping(value="ajax/findEmail")
	public String findEmail(@RequestParam Map<String, String> data) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String result = "";
		
		String userName = data.get("userName");
		String userPhone = data.get("userPhone");
		
		int exist = memberdao.beforeFindEmail(userName, userPhone);
		
		if(exist == 0) {
			result = "noExist";
		}else {
			String userEmail = memberdao.findEmail(userName, userPhone);
			int indexOf = userEmail.indexOf("@");
			
			StringBuffer sb = new StringBuffer(userEmail);
			String cutEmail = sb.replace( 3 , indexOf, "*******" ).toString();
			
			result = cutEmail;
		}
		
		return result;
	}
	
	@RequestMapping(value="ajax/findPwd")
	public String beforeFindPwd(@RequestParam Map<String, String> data) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		String result = "";
		
		String userName = data.get("userName");
		String userEmail = data.get("userEmail");
		
		int exist = memberdao.beforeFindPwd(userName, userEmail);
		
		if(exist == 0) {
			result = "noExist";
		}else {
			result = "Exist";
		}
		return result;
	}
	
	//비밀번호 찾기용 메일보내기 findPwdEmailSend
	@RequestMapping(value="findPwdEmailSend.ajax", method=RequestMethod.POST)
	public String findPwdEmailSend(HttpServletRequest request, String email, HttpServletResponse response_email) throws IOException {
		 
		System.out.println("인증메일 발송 컨트롤러");

        Random r = new Random();
        int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
        
        //템플릿 test
        String template = "com/cyco/member/vo/emailtemplate.vm";
        //
        
        String setfrom = "cycoding196@gmail.com";
        String tomail = request.getParameter("userEmail"); // 받는 사람 이메일
        String title = "[CYCODING]사이좋게 코딩하자 사이코딩 인증 메일입니다"; // 제목
        String content =
        
        System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성        
        System.getProperty("line.separator")+
                
        "안녕하세요 회원님!" +
        System.getProperty("line.separator")+ 
        "비밀번호를 변경하기 위해 아래의 인증코드를 입력해주세요."
        
        +System.getProperty("line.separator")+        
        System.getProperty("line.separator")+

        "[ " +dice+ " ]"
        
        +System.getProperty("line.separator")+       
        System.getProperty("line.separator")+
        
        "위의 인증번호를 인증번호 창에 입력하시면 다음 단계로 진행이 가능합니다." // 내용
        
        +System.getProperty("line.separator")+
        System.getProperty("line.separator")+
        
        "감사합니다!";
        
        String result = "fail";
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                    true, "UTF-8");

            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            
            mailSender.send(message);
            
            String number = Integer.toString(dice);
            
            result = "success-" + number;
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        System.out.println(dice);
        
        ModelAndView mav = new ModelAndView();
        
        mav.addObject("dice", dice);
        mav.addObject("result", result);
        
        return result;
        
    }
	
	// 회원 개인정보 수정
	@RequestMapping(value = "editPwd.ajax")
	public String editPwd(String newPwd, String userEmail, HttpSession session) {
		
		String userPwd = pwdEncoder.encode(newPwd);
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		memberdao.findPwdEdit(userEmail, userPwd);
			
		return "success";
	}
	
	

}