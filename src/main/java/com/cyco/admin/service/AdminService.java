package com.cyco.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cyco.admin.dao.AdminDao;
import com.cyco.admin.vo.ChartCount;
import com.cyco.admin.vo.MemberListVo;
import com.cyco.admin.vo.StateCountVo;
import com.cyco.common.vo.P_FieldVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.common.vo.SkillVo;
import com.cyco.member.dao.MemberDao;
import com.cyco.member.vo.V_MlistVo;

@Service
public class AdminService {
	
	@Autowired
	private SqlSession sqlsession; 
	
	
	// ----------------------- Site Manage ------------------------------
	//Skill 리스트 가져오기
	public List<SkillVo> getSkillLsit() {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		List<SkillVo> list = dao.getSkillList();
		
		return list;
	}
	//Position 리스트 가져오기
	public List<PositionVo> getPositionList() {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		List<PositionVo> list = dao.getPositionList();
		return list;
	}
	//Field 리스트 가져오기
	public List<P_FieldVo> getFieldList() {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		List<P_FieldVo> list = dao.getFieldList();
		return list;
	}
	// -------------------------------------------------------------------
	
	
	//----------------------- Member Manage ------------------------------
	// 전체 회원 리스트 가져오기
	public List<MemberListVo> getMemberList(){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		List<MemberListVo> list = dao.getMemberList(""); //파라미터가 ""이면 전체검색
		return list;
	}
	
	//---------------------- Chart ---------------------------
	//정상적으로 활동중인 회원 수
	public int getMemberCount() {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getMemberCount();
	}
	
	//지금까지 생성된 프로젝트 수
	public int getProjectCount() {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getProjectCount();
	}
	
	//프로젝트가 가지는 기술, 포지션, 분야 랭크
	public List<ChartCount> getPSkillCount(){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getPSkillCount();
	}
	public List<ChartCount> getPpositionCount(){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getPpositionCount();
		
	}
	public List<ChartCount> getPFieldCount(){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getPFieldCount();
	}
	
	//화원이 가지는 기술, 포지션
	public List<ChartCount> getMSkillCount(){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getMSkillCount();
	}
	public List<ChartCount> getMpositionCount(){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getMpositionCount();
		
	}
	
	
	//프로젝트 상태 카운트 - 도넛예정
	public List<StateCountVo> getStateCount() {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		return dao.getStateCount();
	}
	
	
	
	
	
	
	// ------------------------ ajax -------------------------------
	
	// 기술, 분야, 포지션 - 추가 및 상태수정
	public Map<String, String> updateSiteList(Map<String, Object> data) {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		
		Map<String, String> map = new HashMap<String, String>();
		
		List<Object> newlist = (List<Object>) data.get("new"); // 추가될 객체 배열
		List<Object> updatelist=(List<Object>) data.get("update"); // 업데이트될 객체배열
		String code= (String) data.get("code"); // skill / field / position 구분자
		
		
		int addresult=0; // insert 결과 행수
		int upresult=0; // update 결과행수
		if(newlist.size()>0) {
			//여러개 한번에 insert 가능
			addresult+=dao.insertSite(newlist, code);
		}
		if(updatelist.size()>0) {
			//여러개 update불가능... 개수만큼 반복적으로 update
			for(Object obj : updatelist) {
				upresult+=dao.updateSite(obj, code);
			} 
			
		}
		// 두가지의 결과 행 수를 담은 map 반환
		map.put("add", Integer.toString(addresult));
		map.put("update", Integer.toString(upresult));
		
		return map;
	}
	// 회원 닉네임으로 검색하는 기능
	public List<MemberListVo> getSearchList(String nickname){
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		nickname = nickname.trim();// 공백제거
		List<MemberListVo> list = dao.getMemberList(nickname);
		return list;
	}
	
	// 회원의 영구정지 상태를 변경하는 기능
	@Transactional
	public Map<String,Object> updateMemberEnabled(Map<String,String> data) {
		AdminDao dao = sqlsession.getMapper(AdminDao.class);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", "false");
		
		/*
		 	권한체크 먼저해주고
			 	1 : 뭐 없는 멤버
			 	2 : 기존멤버
			 	3 : 팀장
			 	4 : 패널티
			 	5 : 밴
			 	
			* 팀장이라면 밴 먹이고 다른팀원에게 팀장 위임 -> 다시 일반멤버로
			* 기존멤버이면 밴 먹이고 진행중 플젝(p_member) 빠지기-> 다시 일반멤버
			* 
		 	
		 */
		String member_id = data.get("member_id");
		
		String auth=dao.getMemberAuth(member_id);
		
		
		// 일반 회원이라면

		if(auth.equals("2")) {
			//1. 진행중 or 모집중이던 p_member에서 null처리
			//2. 지원내역 null처리
			//3. 밴 되는 회원 -> 권한 바꿔주고, enabled
			auth="5";
			data.put("auth", auth);
			dao.procedureBanMember(data);
			
			result.put("result", "true");
		}
		
		//팀장이라면
		else if(auth.equals("3")){
			//팀장 위임 처리
			//모집중, 진행중 프로젝트가 있는지 확인
			//팀원 아무나 한명 지목해서
			//	1. 팀장위임 해주고
			//     1-1. 모집된 팀원이 없으면 플젝 삭제.
			
			//	2. 프로젝트 생성자로 바꿔주고 -> project, p_detail
			//  3. 밴 되는 회원 -> 권한 바꿔주고, enabled
			
			auth="5";
			data.put("auth", auth);
			
			Map <String, Object> map = new HashMap<String, Object>();
			map.putAll(data);
			dao.procedureBanLeader(map);
			
			System.out.println(map);
			
			result.put("result", "true");
			result.put("list", map.get("output"));
		}
		//이미 밴당한 회원 해제
		else if(auth.equals("5")){
			auth="2";
			data.put("auth", auth);
			
			dao.procedureCancelBan(data);
			
			result.put("result", "true");
		}
		//기본회원, 패널티당한 회원 처리 -> 그냥 아무처리없이 밴
		else {
			auth="5";
			data.put("auth", auth);
			dao.procedureCancelBan(data);
			
			result.put("result", "true");
		}

		return result;
	}
	// ---------------------------------------------------------
}
