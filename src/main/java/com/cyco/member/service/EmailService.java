package com.cyco.member.service;
 
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletResponse;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.cyco.member.vo.EmailVo;


 
 
@Service // 서비스 빈으로 등록
public class EmailService{
 
    @Autowired
    private JavaMailSender mailSender; // root-context.xml에 설정한 bean, 의존성을 주입
    
    @Autowired
    private VelocityEngine velocityengine; //https://m.blog.naver.com/PostView.naver?blogId=greygost&logNo=220846663731&proxyReferer=https:%2F%2Fwww.google.com%2F
    
    public int sendMail(EmailVo vo) {
        Map<String, Object> model = new HashMap<String,Object>();
        int random = (int)(Math.random() * 999999) + 1;
        
        try {
            // 이메일 객체
        	MimeMessage msg = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
            model.put("random", random + "");
            model.put("content",vo.getMessage());
            String text = VelocityEngineUtils.mergeTemplateIntoString(velocityengine, "com/cyco/member/vo/emailtemplate.vm", "UTF-8", model);
            
            // 이메일 수신자
            helper.setTo(new InternetAddress(vo.getReceiveMail()));

            // 이메일 발신자
            helper.setFrom( new InternetAddress(vo.getSenderMail(), vo.getSenderName()));
 
            // 이메일 제목 
            helper.setSubject(vo.getSubject());
            
            // 이메일 본문
            helper.setText(text, true);
            
            msg.setContent(text, "text/html; charset=UTF-8");
    
            // 이메일 보내기
            mailSender.send(msg);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return random; 
    }
}
