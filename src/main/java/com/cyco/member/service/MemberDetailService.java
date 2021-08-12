package com.cyco.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cyco.common.vo.Apply_Join_P_datailVo;
import com.cyco.common.vo.BookMark_Join_P_detailVo;
import com.cyco.common.vo.M_DurationVo;
import com.cyco.common.vo.M_SkillVo;
import com.cyco.common.vo.MemberVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.common.vo.SkillVo;
import com.cyco.common.vo.StatVo;
import com.cyco.member.dao.MemberDao;
import com.cyco.member.vo.M_ExperienceVo;
import com.cyco.member.vo.MemberDetailPageVo;
import com.cyco.member.vo.MyProject_Join_Member;
import com.cyco.member.vo.MyReviewVo;
import com.cyco.member.vo.Project_TeamLeaderVo;
import com.cyco.member.vo.ReviewVo;
import com.cyco.member.vo.V_Duration;
import com.cyco.member.vo.V_myProjectVo;
import com.cyco.project.vo.P_DetailVo;
import com.cyco.project.vo.P_DurationVO;
import com.cyco.project.dao.ProjectDao;


@Service
public class MemberDetailService {
	
	private SqlSession sqlsession;
	
	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	@Autowired
	PasswordEncoder pwdEncoder;
	
	//반영 결과 있으면 리턴하기
	public String getResult(Integer row) {
		
		if(row > 0) {
			return "success";
		}
		
		return "fail";
	}
	
	
	//마이페이지 진입시 비밀번호 체크
	public boolean checkPwd(Map<String, String> data) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MemberVo member = memberdao.getMyDetail(data.get("useremail"));

		boolean checkpassword = pwdEncoder.matches(data.get("userPwd"), member.getMEMBER_PWD());
		System.out.println("테스트중: " + checkpassword);
		
		return checkpassword;
	}
	

	//마이페이지 정보 불러오기
	public MemberVo getMyDetail(String useremail) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MemberVo member = memberdao.getMyDetail(useremail);
		
		System.out.println("테스트중: " + member);
		
		return member;
	}
	
	//프로필 이미지 변경
	public int editProfile(String id, String filename) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.editProfile(id, filename);
		
		return row;
		
	}
	
	//개인정보 수정
	public int editInfo(String column, String info, int userid) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.editPersnalInfo(column, info, userid);
		
		return row;
	}
	
	//암호화된 비밀번호 수정
	public int editPwd(String column, String info, int userid) {
		
		//클라이언트에서 회원이 변경한 비밀번호를 암호화한다
		info = pwdEncoder.encode(info);
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.editPersnalInfo(column, info, userid);
		
		return row;
	}
	
	//보유 기술 스택 리스트 뽑기
	public List<MemberDetailPageVo> getPreferSkills(String userid){
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<MemberDetailPageVo> list = new ArrayList<MemberDetailPageVo>();
		
		list = memberdao.getPreferSkills(userid);
		
		return list;
		
	}
	
	//포지션 리스트 뽑기
	public List<MemberDetailPageVo> getPreferPosition(String userid){
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<MemberDetailPageVo> list = new ArrayList<MemberDetailPageVo>();
		
		list = memberdao.getPreferPosition(userid);
		
		return list;
		
	}

	
	//선호 기간 리스트 뽑기
	public List<MemberDetailPageVo> getPreferDurations(String userid){
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<MemberDetailPageVo> list = new ArrayList<MemberDetailPageVo>();
		
		list = memberdao.getPreferDurations(userid);
		
		return list;
		
	}
	
	//프로젝트 경험 리스트 뽑기
	public List<M_ExperienceVo> getExperiences(String userid){
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<M_ExperienceVo> list = new ArrayList<M_ExperienceVo>();
		
		list = memberdao.getExperiences(userid);
		
		return list;
		
	}
	
	//마이페이지에서 프로젝트 경험 없음이 없음이라고 입력한건지 확인
	public String haveExperience(String userid) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		String result = memberdao.haveExperience(userid);
	
		return result;
	}
	
	//모달 안에 스택 태그 뽑기
	public List<StatVo> getTags(String type){
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<StatVo> list = new ArrayList<StatVo>();
		
		if(type.equals("type=skill")) {
			List<SkillVo> slist = new ArrayList<SkillVo>();
			slist = memberdao.getSkills();
			for(int i = 0; i < slist.size(); i++) {
				list.add(slist.get(i));
			}
		} else if(type.equals("type=position")) {
			List<PositionVo> plist = new ArrayList<PositionVo>();
			plist = memberdao.getPositions();
			for(int i = 0; i < plist.size(); i++) {
				list.add(plist.get(i));
			}
		} else if(type.equals("type=duration")) {
			List<P_DurationVO> dlist = new ArrayList<P_DurationVO>();
			dlist = memberdao.getDurations();
			for(int i = 0; i < dlist.size(); i++) {
				list.add(dlist.get(i));
			}
		}

		return list;
		
	}
	
	//기존에 선택했던 기술 삭제
	public String deleteSkills(String memberid) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);		
		int row = memberdao.deleteSkills(memberid);
		return getResult(row);
	}	
	
	//뷰단에서 변경한 기술 스탯 디비에 반영하기
	public String editSkills(List<M_SkillVo> stat) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		System.out.println("전달된거" + stat);
		int row =  memberdao.insertSkills(stat);
		return getResult(row);
		
	}
	
	//프로젝트 경험 있/없 디비에 반영하기
	public String updateExperience(String memberid, int answer) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.updateExperience(memberid, answer);	
		return getResult(row);
	}
	
	//프로젝트 경험 삭제하기
	public String  deleteExperience(String ex_id, String memberid) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.deleteExperience(ex_id, memberid);
		return getResult(row);
	}
	
	//프로젝트 경험 업데이트 하기
	public String updateExperiences(M_ExperienceVo mex) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.updateExperiences(mex);
		return getResult(row);
	}
	
	//뷰단에서 변경한 포지션 업데이트
	public String updatePosition(String position_id, String member_id) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);		
		int row = memberdao.updatePosition(position_id,member_id);
		return getResult(row);
	}
	
	
	//기존에 선택했던 선호기간 삭제
	public String deleteDurations(String memberid) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);	
		int row = memberdao.deleteDurations(memberid);
		return getResult(row);
	}
	
	
	//뷰단에서 변경한 스탯 디비에 반영하기
	public String editDurations(List<M_DurationVo> stat) {
		
		System.out.println("스탯 비동기 변경하기 editDurations");
		System.out.println(stat);
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row =  memberdao.insertDurations(stat);
		return getResult(row);
		
	}
	
	// 마이페이지에서 기입한 프로젝트 경험들 디비에 insert
	public String insertExperiences(List<M_ExperienceVo> newEx) {
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int row = memberdao.insertExperiences(newEx);
		return getResult(row);
	}
	
	//회원 추가정보 모두 기입시 최초 입력인지 체크해서 맞으면 포인트 지급
	public String givePointFirstTime(String member_id) {
		
		String result = "fail";
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		
		if(memberdao.checkPoint(member_id) != null) {
			
			//포인트 컬럼에서 회원 아이디로 사용포인트, 보유포인트가 모두 0인지 확인했을 때 결과가 있으면 포인트 지급
			int row = memberdao.givePointFirstTime(member_id);
			result = getResult(row);					
		}
		
		return result;
		
	}
	
	//마이페이지에서 회원 탈퇴시 팀장인지 확인
	public Integer isTeamManager(String quit_id) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int result = 0;
		if(memberdao.isTeamManager(quit_id) != null) {
			result = memberdao.isTeamManager(quit_id);
		}

		return result;		
	}
	
	//마이페이지에서 회원 탈퇴날짜 업데이트
	public Integer updateDeleteDate(String quit_id) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		int result = memberdao.updateDeleteDate(quit_id);
		
		return result;
	}
	
	
	//회원상세 기본정보 가져오기
	public MemberVo getMemberDetail(String memberid) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		MemberVo member = memberdao.getMemberDetail(memberid);
		
		return member;
	}
	
	//회원상세 리뷰목록 가져오기
	public List<ReviewVo> getReviewList(String memberid) {
		
		MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		List<ReviewVo> reviewList = memberdao.getReviewList(memberid);
		
		return reviewList;
	}	
	
	//포인트 충전하기
	   public int chargePoint(String memberid, String point) {
//	      1행리턴
	      System.out.println("서비스 memberid: " +memberid);
	      System.out.println("서비스 point : " +point);
	      MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
	      int row = memberdao.chargePoint(memberid, point);
	      System.out.println("서비스 row : " + row);
	      return row;
	   }
	   
	   //회원상세 프로젝트 초대 모달 노출 전 초대할 프로젝트 있는지 확인
	   public List<P_DetailVo> checkProjectBeforeInvite(String memberid) {
		   
		   MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		   List<P_DetailVo> p_detail = memberdao.checkProjectBeforeInvite(memberid);

		   return p_detail;
	   }
	   	//북마크,지원목록 페이지
	   	//북마크 목록 가져오기
	   	public List<BookMark_Join_P_detailVo> getBookmarkList(String memberid) {
		   MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
		   List<BookMark_Join_P_detailVo> bookmark_list = memberdao.getBookmarkList(memberid);
		   
		   return bookmark_list;
	   	}
	   
	   	//북마크 삭제(delete)
		public void deleteBookMark(String projectid, String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			memberdao.deletBookMark(projectid, memberid);
		}
		
		//지원목록 가져오기
		public List<Apply_Join_P_datailVo> getApplyList(String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			List<Apply_Join_P_datailVo> apply_list = memberdao.getApplyList(memberid);
			
			return apply_list;
		}
		
		//지원 취소
		public void deleteApply(String applyid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			memberdao.deleteApply(applyid);
		}
		
		//내프로젝트, 후기 페이지
		//로그인한 회원이 팀장인 프로젝트목록 가져오기
		public List<Project_TeamLeaderVo> getTeamLeader(String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			List<Project_TeamLeaderVo> teamLeaderList = memberdao.getTeamLeader(memberid);
			
			return teamLeaderList;
		}
		
		//로그인한 회원이 팀원인 프로젝트목록 가져오기
		public List<V_myProjectVo> getTeamMember(String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			List<V_myProjectVo> teamMemberList = memberdao.getTeamMember(memberid);
			
			return teamMemberList;
		}
		
		//리뷰작성용 팀장 조회
		public MyProject_Join_Member writeReviewLeader(String projectid, String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			MyProject_Join_Member writeReviewLeader = memberdao.writeReviewLeader(projectid, memberid);
			
			if(writeReviewLeader == null) {
				MyProject_Join_Member dummyMember = new MyProject_Join_Member();
				dummyMember.setMember_nickname("dummy");
				writeReviewLeader = dummyMember;
			}
			
			return writeReviewLeader;
		}
		
		//리뷰작성용 팀원 조회
		public List<MyProject_Join_Member> writeReviewMember(String projectid, String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			List<MyProject_Join_Member> writeReviewMember = memberdao.writeReviewMember(projectid, memberid);
			
			return writeReviewMember;
		}
		
		//리뷰 작성하기
		public void setReview(List<ReviewVo> writeReviewList) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			memberdao.setReview(writeReviewList);
		}
		
		//로그인한 회원이 작성한 리뷰 가져오기
		public List<ReviewVo> getMyReview(String memberid) {

			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			List<ReviewVo> reviewList = memberdao.getMyReview(memberid);
			
			return reviewList;
		}
		
		//리뷰작성시 포인트지급
		public void giveReviewPoint(String memberid) {
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			memberdao.giveReviewPoint(memberid);
		}
		
		//로그인한 회원이 해당 프로젝트에 작성한 리뷰 조회
		public List<MyReviewVo> getMyProjectReview(String projectid, String memberid) {
			
			MemberDao memberdao = sqlsession.getMapper(MemberDao.class);
			List<MyReviewVo> myProjectReview = memberdao.getMyProjectReview(projectid, memberid);
			
			return myProjectReview;
		}
}
