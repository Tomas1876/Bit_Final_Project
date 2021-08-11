package com.cyco.member.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.cyco.common.vo.M_AuthVo;
import com.cyco.common.vo.MemberVo;
import com.cyco.common.vo.PointVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.member.dao.MemberDao;
import com.cyco.member.vo.V_MlistVo;


@Service
public class MemberService {
	private SqlSession sqlsession;
	
	
	
	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	
	// 맴버정보가져오기
	public MemberVo getMember(String email) {
	      
	      MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
	      MemberVo m = memberdao.getMember(email);	      
	      return m;	      
	}
		
	//회원가입
	public int regist(MemberVo member) {
	      
	      int result =0;
	      
	      MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
	      result = memberdao.registMember(member);
	      
	      return result;
	      
	}
	
	//로그인시 닉네임, 회원 번호 가져오기
	public HashMap<String, String> getLoginedName(String useremail) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		HashMap<String, String> member = memberdao.getLoginedName(useremail);

		
		return member;
	}
	
	//로그인시 탈퇴날짜 체크
	public void checkDeleteDate(String memeberid) {
		
	      MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
	      memberdao.checkDeleteDate(memeberid);
		
	}
	
	//로그인시 알림
	public int getOldAlarm(String memeberid) {
		int row = 0;
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		if(memberdao.getOldAlarm(memeberid) != null) {
			row = memberdao.getOldAlarm(memeberid);
		}
		
		return row;
	}
	
	//로그인시 참여중인 프로젝트 있는지 체크
	public HashMap<String, String> hasProject(String memberid){
		
		HashMap<String, String> p_info = new HashMap<String, String>();
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		if(memberdao.isProjectManager(memberid).size() != 0) {
			p_info.put("project_id",(String)memberdao.isProjectManager(memberid).get(0).getProject_id());
			//p_info.put("p_title",(String)memberdao.isProjectManager(memberid).get(0).getP_title());
			
		}else if(memberdao.isInProject(memberid).size() != 0){
			p_info.put("project_id", String.valueOf(memberdao.isInProject(memberid).get(0).get("PROJECT_ID")));
			//p_info.put("p_title", String.valueOf(memberdao.isInProject(memberid).get(0).get("P_TITLE")));

		} else {
			p_info.put("project_id", "none");
		}
		
		System.out.println("p_info " + p_info.toString());
		return p_info;
	}

	//기본 회원리스트 호출
	public List<V_MlistVo> memberList() {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		List<V_MlistVo> memberList = memberdao.getMemberList();
		System.out.println("기본 회원 리스트 호출");
		return memberList;
	}
	
	//포지션 리스트 호출(옵션용)
	public List<PositionVo> positionList() {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		List<PositionVo> positionList = memberdao.getPositionList();
		System.out.println("포지션리스트 호출");
		
		return positionList;
	}
	
	//포지션 필터링
	public List<V_MlistVo> memberPosition(String position) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<V_MlistVo> memberPosition = memberdao.getMemberPosition(position);
		
		return memberPosition;
	}
	
	//회원검색
	public List<V_MlistVo> memberNickname(String nickname) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<V_MlistVo> memberNickname = memberdao.getMemberNickname(nickname);
		
		return memberNickname;

	}
	
	// 포인트 관리 
	public int updatePoint(PointVo point) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int result = memberdao.updatePoint(point);
		
		return result;
	}
	
	public Boolean UpdateAuth(M_AuthVo auth) {
		
		Boolean bo = false;		 
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.UpdateAuth(auth);
		if(row > 0) {
			bo = true;
		}
		return bo;
	}
	
}