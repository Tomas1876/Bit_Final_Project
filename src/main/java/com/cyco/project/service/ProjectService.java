package com.cyco.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cyco.alarm.dao.AlarmDao;
import com.cyco.alarm.vo.AlarmVo;
import com.cyco.common.vo.AdrVo;
import com.cyco.common.vo.BookmarkVo;
import com.cyco.common.vo.M_AuthVo;
import com.cyco.common.vo.P_FieldVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.common.vo.SkillVo;
import com.cyco.member.dao.MemberDao;
import com.cyco.member.security.ChangeAuth;
import com.cyco.member.service.MemberService;
import com.cyco.project.dao.ProjectDao;
import com.cyco.project.vo.ApplyVo;
import com.cyco.project.vo.P_DetailVo;
import com.cyco.project.vo.P_DurationVO;
import com.cyco.project.vo.P_FeedVo;
import com.cyco.project.vo.P_MemberVo;
import com.cyco.project.vo.P_QnaVo;
import com.cyco.project.vo.P_SkillVo;
import com.cyco.project.vo.PmemberCountVo;
import com.cyco.project.vo.ProjectVo;
import com.cyco.project.vo.V_ApplyMemberList;
import com.cyco.project.vo.V_PjAdrField_Join_V_PDetail;
import com.cyco.project.vo.V_PjSk;
import com.cyco.project.vo.V_PmPosition;
import com.cyco.project.vo.V_PmPostion_Count;
import com.cyco.project.vo.V_p_pd_Join_NameVo;

@Service
public class ProjectService {
	
	@Autowired
	private SqlSession sqlsession;
	
	@Autowired
	private MemberService memberService;
	
//	public List<ProjectVO> getProjectList(String adr_code, String field_name, String p_state, String skill_code){
//	첫 프로젝트 리스트 화면 출력.
//	넘길 리스트
//	project_list
//	adr_list
//	skill_list
//	field_list
	public List<V_PjAdrField_Join_V_PDetail> getProjectList(String p_state){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		String where = "";
		Map<String, String> map = new HashMap<String, String>();
		map.put("where","");
		map.put("p_state", p_state);
		
		List<V_PjAdrField_Join_V_PDetail> project_list = dao.getProjectList(map);
		return project_list;
	}
	
//	ProjectList with Filter
//	오버로딩 함수
	public List<V_PjAdrField_Join_V_PDetail> getProjectList(List<String> filterlist, String p_state){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		String where =null;
		//넘어온 id리스트가 있을경우
		if(filterlist.size()>0) {
			where = "where p.project_id in (";
			where +=filterlist.get(0);
			for(int i=1; i<filterlist.size(); i++) {
				where +=","+filterlist.get(i);
			}
			where += ")";
		}
		//넘어온 리스트가 없을경우
		else {
			return null;
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("where",where);
		map.put("p_state", p_state);
		List<V_PjAdrField_Join_V_PDetail> list = dao.getProjectList(map);
		
		return list;
	}
	
//	필터링으로 선택된 field_code , adr_code , p_state을 가진 Map객체로 
//	필터링된 Project_id 뽑아오기
	public List<String> getFilteredProjectList(Map<String, String> data){
		List<String> list = new ArrayList<String>();
		if(data.get("field_code").equals("") && data.get("adr_code").equals("") && data.get("p_state").equals("")) {
			return null;
		}
		
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		list = dao.getFilteredProjectList(data);
		return list;
	}

//	Filtered Project_id List
//	P_Skill테이블에서 Project_id 뽑아오기
	public List<String> getFilteredProjectSkillList(Map<String, String> data,List<String> Flist){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		String skill_code = data.get("skill_code");
		List<String> idlist = new ArrayList<String>();
		
		//input값이 아무것도 없을떄 return null
		if(skill_code.equals("") && Flist==null) {
			return null;
		}
		//skill_code inpupt값이 없다면 Flist를 다시 return
		else if(skill_code.equals("") && Flist!=null) {
			return Flist;
		}
		
		
		//skill_code input값이 하나라도 있다면 밑에 코드 실행
		
		//skill_code로 필터링된 리스트 뽑기
		List<String> list = dao.getFilteredProjectSkillList(skill_code);
		
		
		// list와 Flist에서 중복되는값 찾기
		// Flist의 값이 존재할 경우(3개 필터링 결과값이 있다.)
		if(Flist!=null) {
			//list값이 하나라도 있으면
			if(list.size()>0) {
				for(String l : list) {
					//contains()를 이용하여 Flist에 list의 l값이 있으면 중복.
					if(Flist.contains(l)) {
						idlist.add(l);
					}
				}
				//for문을 다 돌았지만 중복되는 값이 없을때 처리 필요
			}
			//list값이 하나도 없을때 => 중복검사할 필요도 없이 비어있는 list return
			else {
				idlist.addAll(list);
			}
		}
		// Flist에 값이 없다(3개 필터링 값이 없다)면 skill_code 필터링한 list만 넣어준다.
		else {
			//list값이 하나라도 존재한다면
			if(list.size()>0) {
				idlist.addAll(list);
			}
//			skill_code 필터링 list도 없다면 비어있는 list return
			else {
				idlist.addAll(list);
			}
		}
		//중복제거된 리스트 리턴
		return idlist;
	}
	
	public List<AdrVo> getAdrList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<AdrVo> adr_list = dao.getAdrList();
		
		return adr_list;
	}
	public List<P_FieldVo> getFieldList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<P_FieldVo> field_list = dao.getFieldList();
		
		return field_list;
	}
	public List<SkillVo> getSkillList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<SkillVo> skill_list = dao.getSkillList();
		
		return skill_list;
	}
	public List<V_PjSk> getPjSkList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<V_PjSk> pjsk_list = dao.getPjSkList();
		
		return pjsk_list;
	}
	
	public List<V_PjSk> getIfPjSkList(String projectID){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<V_PjSk> pjsk_list = dao.getIfPjSkList(projectID);
		
		return pjsk_list;
	}
	
	public List<PositionVo> getPositionList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<PositionVo> position_list = dao.getPositionList();
		
		return position_list;
	}
	
	public List<P_DurationVO> getDurationList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<P_DurationVO> duration_list = dao.getDurationList();
		
		return duration_list;
	}
	
	//북마크 시작
	//북마크리스트
	public List<BookmarkVo> getBookmarkList(String memberid) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<BookmarkVo> bookmark_list = dao.getBookmarkList(memberid);
		
		return bookmark_list;
	}
	
	//북마크 존재여부 확인
	public int checkBookMark(String projectid, String memberid) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		int checkNum = dao.checkBookMark(projectid, memberid);
		
		return checkNum;
	}
	
	//북마크 추가(insert)
	public void setBookMark(BookmarkVo bookmark) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		dao.setBookMark(bookmark);
	}
	
	//북마크 삭제(delete)
	public void deleteBookMark(String projectid, String memberid) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		dao.deletBookMark(projectid, memberid);
	}
	
	//북마크 끝
	
	//프로젝트 검색 - 제목으로만 검색
	public List<V_PjAdrField_Join_V_PDetail> getSearchedProjectList(Map<String, String> projectname){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		Map<String, String> map = new HashMap<String, String>();
		
		//검색 where절
		String where= "where vpd.p_title like '%" + projectname.get("projectname") + "%'";
		
		//map에 whrer절과 이미 위에서 사용된 dao를 사용하기 위해 파라미터로 사용되는 p_state도 같이 넣어준다.
		//p_state는 '완료'가 아니어야 하기 때문에 다른 문자열을 넣어주낟.
		map.put("where", where);
		map.put("p_state", "검색");
		
		List<V_PjAdrField_Join_V_PDetail> searched_list = dao.getProjectList(map);
		
		return searched_list;
	}
	
	//전체프로젝트 멤버의 남은 자리 개수를 담은 리스트 가져오기
	public List<PmemberCountVo> getPmemberCountList(){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<PmemberCountVo> membercount_list = dao.getPmemberCountList("all");
		
		return membercount_list;
	}
	
	// 프로젝트 생성 --------------------------------------------------------
	//프로젝트 상셍에서 포지션 별 전체 자리수와 남은 자리수 뽑기
	public List<V_PmPostion_Count> getPmemberCount(String project_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<V_PmPostion_Count> pmcountlist = dao.getPmemberCount(project_id);
		
		// 확인 안했는지 확인..
		for(int i = 0; i < pmcountlist.size(); i++) {
			int returnCount = dao.ApplyCheckMember(project_id, pmcountlist.get(i).getPosition_id());
			pmcountlist.get(i).setCount(returnCount);
		}
		
		
		return pmcountlist;
	}
	
	
	//	프로젝트 상세 - 프로젝트 id를 통해 하나만 가져오기
	public V_PjAdrField_Join_V_PDetail getOneProject(String project_id){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		V_PjAdrField_Join_V_PDetail project = dao.getOneProject(project_id);
		return project;
	}
	
	//프로젝트 멤버 검색. project_id를 통한 조건검색 가능
	public List<V_PmPosition> getProjectMemberList(String project_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<V_PmPosition> pmlist = dao.getProjectMemberList(project_id);
		
		
		return pmlist;
		
		
	}
	
	//프로젝트 체크
	public int CheckProject(String member_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.CheckProject(member_id);
		
		return result;
	}
	
	
	// ----------------------------------------------------------
	// 프로젝트 생성
	@Transactional
	public String CreateProject(ProjectVo project,P_DetailVo p_detail, List<P_SkillVo> skill, List<P_MemberVo> member) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		dao.setProjectInsert(project);
		
		// 프로젝트 테이블 먼저 insert 후 project_id 값 리턴이 된다.
		// 그후 리턴된 id 값을 각 Vo 객체에 주입 시켜준다.
		p_detail.setProject_id(project.getProject_id());
		
		for(int i = 0 ; i < skill.size(); i++) {
			skill.get(i).setProject_id(project.getProject_id());
		}
		for(int i = 0 ; i < member.size(); i++) {
			member.get(i).setProject_id(project.getProject_id());
		}
		
		// 프로젝트상세 insert
		dao.setProjectDetail(p_detail);
		
		// 프로젝트스킬 insert
		dao.setProjectSkillList(skill);
		// 프로젝트멤버 insert
		dao.setProjectMemberList(member);
				
		return project.getProject_id();
	}
	// ---------------------------------------------------------

	
	// 프로젝트 + 기술
	public void setProjectSkillList(List<P_SkillVo> p) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		dao.setProjectSkillList(p);
		
	}
	
	// 프로젝트 맴버
		public void setProjectMemberList(List<P_MemberVo> m) {
			ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
			
			dao.setProjectMemberList(m);
			
		}
			
	// 프로젝트 지원내역
	public int CheckProjectApply(ApplyVo apply) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.CheckProjectApply(apply);
		
		return result;
	}
	
	// 프로젝트 지원하고 알림테이블에도 인서트
	@Transactional
	public int setProjectApply(ApplyVo apply, AlarmVo alarm) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		AlarmDao alarmdao = sqlsession.getMapper(AlarmDao.class);
		System.out.println("apply" + apply.toString());
		System.out.println("alarm" + alarm.toString());
		
		 dao.setProjectApply(apply);
		 int result = alarmdao.insertAlarm(alarm);
		
		return result;
	}
	
	// 만들어진 프로젝트 정보 가져오기
	public V_p_pd_Join_NameVo getProjectJoinName(V_p_pd_Join_NameVo project) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		
		V_p_pd_Join_NameVo result = dao.getProjectJoinName(project);
		
		return result;
	}
	
	// 생성된 프로젝트 기술 스텍 가져오기
	public List<SkillVo> getCreateProjectSkill(String project_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<SkillVo> skill = dao.getCreateProjectSkill(project_id);
		
		return skill;
	}
	
	// 생성된 프로젝트에서 없는 기술 스텍 가져오기
	public List<SkillVo> getCreateNotInProjectSkill(String project_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<SkillVo> skill = dao.getCreateNotInProjectSkill(project_id);
		
		return skill;
	}
	
	
	
	// 프로젝트 업데이트
	@Transactional
	public int updateProject(ProjectVo project,P_DetailVo p_detail,List<P_SkillVo> skill) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		
		// 프로젝트 업데이트
		int result = dao.updateProject(project);
		
		// 프로젝트 상세정보 업데이트
		dao.updateP_detail(p_detail);
		
		// 프로젝트 스킬도 여기서 같이 삭제
		dao.deleteP_skill(project.getProject_id());
		
		// 프로젝트 스킬 insert
		dao.setProjectSkillList(skill);
		
		return result;
	}
	

	
	//프로젝트 추천리스트
	public List<V_PjAdrField_Join_V_PDetail> getRcmProjectList(String member_id) {
		/*
			
		 	1. 회원 정보 가져오기 ( skill, position, duration, 모집중)
		 	2. 가져온 정보를 가공하기
		 	3. 회원이 원하는 포지션의 자리가 있는 프로젝트를 먼저 걸름 -> p_membervo
		 	4. 회원이 가지고 있는 기술을 하나라도 가지고있는 프로젝트를 걸름 -> p_skillvo테이블 사용해서 id뽑기
		 	5. 회원이 원하는 기간을 하나라도 가지고있는 프로젝트를 걸름-> p_detailvo
		 	6. 모집중인 프로젝트를 걸름 -> p_detail
		 	7. 걸러진 리스트에서 중복되는 결과만 모음
		 	8. 그중에서 대표스킬이 포함되어있는 프로젝트를 먼저 보여줌.
		 	9. 또 그중에서 조회수가 높은걸 보여줌
		 	
		 	이후
		 	
		 	1. 필터링 결과가 9개 미만일때 처리 -> 모집중 , 포지션 , 기술 , 기간 중
		 								  기간부터 하나씩 빼서 필터링하여 리스트가 9개 이상일때까지 반복
		 	2. 비회원, 추가기입x 회원일경우 조회수 높은순으로 출력
		 	3. 
		*/
		
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		
		List<String> mposlist = dao.getFilteredMPosition(member_id);//포지션필터링 리스트
		List<String> msklist = dao.getFilteredMSkill(member_id); // 스킬 필터링 리스트
		List<String> mdulist =  dao.getFilteredMDuration(member_id); // 기간 필터링 리스트
		List<String> reculist = dao.getFilteredRecruting(member_id); // 모집중 필터링 리스트
		
		map.put("reculist", reculist);
		map.put("mposlist", mposlist);
		map.put("msklist", msklist);
		map.put("mdulist", mdulist);

		List<V_PjAdrField_Join_V_PDetail> resultlist = new ArrayList<V_PjAdrField_Join_V_PDetail>();
		List<String> filtered_list = new ArrayList<String>();
		
		if(mposlist !=null && msklist !=null && mdulist !=null && reculist !=null) {
			if(mposlist.size()>0 && msklist.size()>0 && mdulist.size()>0 && reculist.size()>0) {
				filtered_list =allFilteredList(map);
				//보여줄 리스트가 9개보다 작을때
				int count=0;
				for(; filtered_list.size()<9; count++) {
					System.out.println("결과값이 9보다작다. list.size : " + filtered_list.size());
					if(count==0) {
						map.remove("mdulist");
					}else if(count==1) {
						map.remove("msklist");
					}else if(count==2) {
						map.remove("mposlist");
					}
					else {
						System.out.println("모집중이고 조회수 순으로 출력");
						resultlist=getOrderedViewsList(null);
						return resultlist;
					}
					filtered_list = allFilteredList(map);
					
				}
				//msklist전까지만 필터링되었을때 -> 대표스킬로정렬하는 의미가 있다.
				if(count<1) {
					filtered_list = dao.getOrderedSkill(filtered_list, member_id);
					resultlist=getOrderedViewsList(filtered_list);
				}
				//msklist이후라면 대표스킬로 정렬하는 의미가 없기때문에 
				else {
					resultlist=getOrderedViewsList(filtered_list);
				}
			}
			else {
				//Just 조회수 정렬
				resultlist=getOrderedViewsList(null);
			}
		}
		else {
			//Just 조회수 정렬
			resultlist=getOrderedViewsList(null);
		}
		return resultlist;
	}
	//조회수 순으로 리스트 출력(Just 조회수 정렬)
	public List<V_PjAdrField_Join_V_PDetail> getOrderedViewsList(List<String> filtered_list) {
		//모집중
		//조회수
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);

		List<V_PjAdrField_Join_V_PDetail> list = dao.getRecommList(filtered_list);
		if(list.size()>9) {
			list = list.subList(0, 9);
		}
		return list;
		
	}
	public List<String> allFilteredList(Map<String, List<String>> map) {
		List<String> result = new ArrayList<String>();
		for(String l : map.get("reculist")) {
			//contains()를 이용하여 중복확인
			if(map.get("mposlist") !=null) {
				if(map.get("mposlist").contains(l)) {
					System.out.println("mposlist 확인");
					
					
					if(map.get("msklist") != null) {
						if(map.get("msklist").contains(l)) {
							System.out.println("msklist 확인");
							
							
							if(map.get("mdulist") != null) {
								if(map.get("mdulist").contains(l)) {
									System.out.println("mdulist 확인");
									result.add(l);
								}
							}
							else {
								result.add(l);
							}
						}
					}
					else {
						result.add(l);
					}
				}
			}
			
		}
		return result;
	}
	
	
	
	// 프로젝트 지원한 멤버 아이디
	public List<V_ApplyMemberList> getApplyMemberList(V_ApplyMemberList memberlist){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<V_ApplyMemberList> member = dao.getApplyMemberList(memberlist);
		
		return member;
		
	}
	
	// 프로젝트 멤버로 있는지 확인
	public int Ismember(String member_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int member = dao.Ismember(member_id);
		
		return member;
	}
	
	
	// 프로젝트 승인시 처리 서비스
	@Transactional
	public int ApplyMember_Ok(ApplyVo apply, AlarmVo alarm) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		AlarmDao alarmdao = sqlsession.getMapper(AlarmDao.class); 
		int result = 0;
		
		int check = dao.getIsMemberApplyount(apply);
		int maxPostionCount = dao.getPositionConut(apply);
		
		
		if (check == maxPostionCount) {
			result = -1;
		    return result;	
		}else {
			dao.ApplyMember_Ok(apply);
			
			
			P_MemberVo membervo = new P_MemberVo(apply.getMember_id(), apply.getProject_id(), apply.getPosition_id());
			
			result = dao.ApplyMemberUpdate(membervo);
			alarmdao.insertAlarm(alarm);
		}
		
		
		return result;
	}
	
	// 프로젝트 거절
	@Transactional
	public int ApplyMember_No(ApplyVo apply, AlarmVo alarm) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		AlarmDao alarmdao = sqlsession.getMapper(AlarmDao.class);
		int result = dao.ApplyMember_No(apply);
		alarmdao.insertAlarm(alarm);
		
		return result;
	}
	
	// 프로젝트 추방
	@Transactional
	public int getOutMember(P_MemberVo p_member, AlarmVo alarm) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		AlarmDao alarmdao = sqlsession.getMapper(AlarmDao.class);
		ApplyVo apply = new ApplyVo();
		apply.setMember_id(p_member.getMember_id());
		apply.setProject_id(p_member.getProject_id());
		
		
		int result = dao.getOutMember(p_member);
		alarmdao.insertAlarm(alarm);
		dao.ApplyMember_GetOut(apply);
		
		return result;
	}
	
	// 프로젝트 위임
	@Transactional
	public int ToHandOverAuth(ApplyVo apply, P_MemberVo member, AlarmVo alarm) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		AlarmDao alarmdao = sqlsession.getMapper(AlarmDao.class);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		// 리더 변경
		int result = dao.ToHandOverAuth(apply);
		M_AuthVo mauth = new M_AuthVo("3",apply.getMember_id());
		memberdao.UpdateAuth(mauth);
		
		// 리더 -> 멤버로 변경
		dao.ReaderMemberChange(member);
		M_AuthVo memberCh = new M_AuthVo("2",member.getMember_id());
		memberdao.UpdateAuth(memberCh);
		
		// 권한 받은 멤버 삭제
		dao.getAuthMemberDel(apply);
		
		
		
		//알림 테이블 인서트
		alarmdao.insertAlarm(alarm);
		
		return result;
	}
	
	// 리터 체크
	public int ProjectReaderCheck(String project_id, String member_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		// 리더 변경
		int result = dao.ProjectReaderCheck(project_id,member_id);
	
		
		return result;
	}
	
	// 프로젝트 삭제
	public int CountMemberDel(String project_id, String postiion_id, String count) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.CountMemberDel(project_id, postiion_id, count);
		
		return result;
	}
	
	// 프로젝트 탈퇴
	@Transactional
	public String ProjectWithdrawal(String member_id, String project_id, String state) {
		String returnURL = "Error";
		
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		// 프로젝트 리더 인지 확인
		int projectReader = dao.ProjectReaderCheck(project_id, member_id);
		
		// 리더이면
		if(projectReader > 0) {
				// 멤버 있는지 확인
				int isMember = dao.isNotNullMember(project_id);
			
				if(isMember > 0) {
					returnURL = "isMember";
					return returnURL;
				}
			
				// 프로젝트 삭제
				int delete = dao.DeleteProject(project_id, member_id);
				
					if(delete > 0) {
						if(!state.equals("모집중")) {
							// 시큐리티 권한 변경
							ChangeAuth chau = new ChangeAuth("ROLE_PENALTY");
							M_AuthVo mauth = new M_AuthVo("4",member_id);
							memberdao.UpdateAuth(mauth);
							// 지원 했던 내역 전부 추방으로 전환
							dao.ProjectApplyWithdrawal(member_id);
							// 패널티컬럼 업뎃
							memberdao.penalyMember(member_id);
							
						}else {
							// 시큐리티 권한 변경
							ChangeAuth chau = new ChangeAuth("ROLE_MEMBER");
							M_AuthVo mauth = new M_AuthVo("2",member_id);
							memberdao.UpdateAuth(mauth);
						}
						returnURL = "DeleteProjecet";
						return returnURL;
					}else {
						returnURL = "Error";
						return returnURL;
					}
					
		// 리더가 아니면	
		}else {
			
			P_MemberVo p_member = dao.getmemberPosition(member_id, project_id);
			// 프로젝트 상태가 모집중이 아니면
			int OutMember = dao.getOutMember(p_member);
			
			
			if(OutMember > 0) {
				if(!state.equals("모집중")) {
					
					// 시큐리티 권한 변경
					ChangeAuth chau = new ChangeAuth("ROLE_PENALTY");
					M_AuthVo mauth = new M_AuthVo("4",member_id);
					memberdao.UpdateAuth(mauth);
					// 지원 했던 내역 전부 추방으로 전환
					dao.ProjectApplyWithdrawal(member_id);
					// 패널티컬럼 업뎃
					memberdao.penalyMember(member_id);
					
				}else {
					// 시큐리티 권한 변경
					ChangeAuth chau = new ChangeAuth("ROLE_MEMBER");
					M_AuthVo mauth = new M_AuthVo("2",member_id);
					memberdao.UpdateAuth(mauth);
				}
				returnURL = "OutProjecet";
				return returnURL;
			}else {
				returnURL = "Error";
				return returnURL;
			}
			
		}
	}
	
	// qna 리스트 가져오기
	public List<P_QnaVo> getProjectQna(String project_id){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<P_QnaVo> p_qna = dao.getProjectQna(project_id);
		
		return p_qna;
		
	}
	
	// qna댓글 가져오기
	public List<P_QnaVo> getProjectQnaReply(String project_id, String REF){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		List<P_QnaVo> p_qna = dao.getProjectQnaReply(project_id,REF);
		
		return p_qna;
		
	}
	
	// qna 글쓰기
	public int writeQna(P_QnaVo qnavo) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.writeQna(qnavo);
		
		return result;
	}
	
	// qna 댓글 쓰기
	public int writeQnaReply(P_QnaVo qnavo) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.writeQnaReply(qnavo);
		
		return result;
	}
	
	// qna 수정
	public int EditQna(P_QnaVo qnavo) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.EditQna(qnavo);
		
		return result;
	}
	
	// qna 삭제
	public int DeleteQna(P_QnaVo qnavo) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		
		int result = dao.DeleteQna(qnavo);
		
		return result;
	}
	
	// 멤버가 가득 찼는지 확인
	public String MemberFullCheck(String project_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		String returnURL = "false";
		
		int isNotnull = dao.isNotNullMember(project_id);
		int IsAllmember = dao.isAllMemberCount(project_id);
		
		
		if(isNotnull == IsAllmember) {
			returnURL = "true";
		}
		
		return returnURL;
		
	}
	

	// 프로젝트 완료 전환
	public String projectComplete(String member_id,  P_DetailVo p_detail) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		AlarmDao alarmdao = sqlsession.getMapper(AlarmDao.class);
		String returnURl = "false";
		
		// 프로젝트 리더 인지 확인
		int projectReader = dao.ProjectReaderCheck(p_detail.getProject_id(), member_id);
		
		System.out.println(projectReader);
		// 프로젝트 상태가 진행중이고 로그인 상태가 리더인지 확인
		if(p_detail.getP_state().equals("진행중") && projectReader > 0) {
			int result = dao.projectComplete(p_detail);

			System.out.println(result);
			if(result > 0) {
				returnURl = "true";
			}
			
		}
		
		return returnURl;
}
	//프로젝트 상태 변경시 알림 보낼 멤버 목록
	public List<String> getTeamMembers(String project_id){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<String> members = dao.getTeamMembers(project_id);
		
		return members;
	}
	
	//프로젝트 상세 진입시 조회수 증가
	public void addViews(String project_id) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		dao.addViews(project_id);

	}
	
	//프로젝트 피드 가져오기
	public List<P_FeedVo> getFeedList(String project_id){
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		List<P_FeedVo> feedList = dao.getFeedList(project_id);
		
		return feedList;
	}
	
	//프로젝트 피드 작성하기
	public int WriteProjectFeed(P_FeedVo feed) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		int result = dao.WriteProjectFeed(feed);
		
		return result;
	}
	
	// 프로젝트 피드 수정
	public int EditProjectFeed(P_FeedVo feed) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		int result = dao.EditProjectFeed(feed);
		
		return result;
	}
	
	// 프로젝트 피드 삭제
	public int DeleteProjectFeed(P_FeedVo feed) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		int result = dao.DeleteProjectFeed(feed);
		
		return result;
	}
}

