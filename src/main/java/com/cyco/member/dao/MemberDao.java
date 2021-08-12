package com.cyco.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.cyco.common.vo.Apply_Join_P_datailVo;
import com.cyco.common.vo.BookMark_Join_P_detailVo;
import com.cyco.common.vo.M_AuthVo;
import com.cyco.common.vo.M_DurationVo;
import com.cyco.common.vo.M_SkillVo;
import com.cyco.common.vo.MemberVo;
import com.cyco.common.vo.PointVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.common.vo.SkillVo;
import com.cyco.member.vo.M_ExperienceVo;
import com.cyco.member.vo.MemberDetailPageVo;
import com.cyco.member.vo.MyProject_Join_Member;
import com.cyco.member.vo.MyReviewVo;
import com.cyco.member.vo.Project_TeamLeaderVo;
import com.cyco.member.vo.ReviewVo;
import com.cyco.member.vo.V_Duration;
import com.cyco.member.vo.V_MlistVo;
import com.cyco.member.vo.V_myProjectVo;
import com.cyco.project.vo.P_DetailVo;
import com.cyco.project.vo.P_DurationVO;
import com.cyco.project.vo.P_MemberVo;


@Repository
public interface MemberDao {
	
	//멤버 정보 가져오기
	public MemberVo getMember(String email);
	//멤버리스트 출력
	
	public List<V_MlistVo> getMemberList();
	//포지션리스트 출력(셀렉트태그용)
	public List<PositionVo> getPositionList();
	//포지션필터링
	public List<V_MlistVo> getMemberPosition(String position);
	//닉네임 검색
	public List<V_MlistVo> getMemberNickname(String nickname);
	
	//기술스택 중복 제거
	//public List<V_MlistVo> getFilterMemberSkill(List<V_MlistVo> list);
	
	/////////////////////////////////////////////////////////////////////////
	//회원가입용
	public Integer checkEmail(String email);
	
	public Integer checkNickName(String nickName);
	
	public Integer checkPhone(String phone);
	
	public int registMember(MemberVo member);
	/////////////////////////////////////////////////////////////////////////
	
	//로그인시 탈퇴날짜 체크
	public Integer checkDeleteDate(String memberid);
	
	//로그인시 닉네임, 아이디값 메인으로 가져오기
	public HashMap<String, String> getLoginedName(String memberemail);
	
	//로그인시 받은 알림 있는지 체크
	public Integer getOldAlarm(String memberid);
	
	//로그인시 참여중인(팀장으로) 프로젝트 있는지 체크
	public List<P_DetailVo> isProjectManager(String memberid);
	//로그인시 참여중인(멤버로) 프로젝트 있는지 체크
	public List<HashMap<String, String>> isInProject(String memberid);
	
	//마이페이지 개인정보 가져오기
	public MemberVo getMyDetail(String useremail);
	
	//마이페이지 프로필 이미지 수정
	public Integer editProfile(String id, String filename);
	
	//마이페이지 개인정보 수정
	public Integer editPersnalInfo(String column, String info, int userid);	
	
	//마이페이지+회원상세 기술 가져오기
	public List<SkillVo> getSkills();
	
	//마이페이지+회원상세 보유 기술 가져오기
	public List<MemberDetailPageVo> getPreferSkills(String userid);
	
	//마이페이지+회원상세 포지션 가져오기
	public List<PositionVo> getPositions();
	
	//마이페이지+회원상세 선호 포지션 가져오기
	public List<MemberDetailPageVo> getPreferPosition(String userid);
	
	//마이페이지+회원상세 기간 가져오기
	public List<P_DurationVO> getDurations();
	
	//마이페이지+회원상세 선호 기간 가져오기
	public List<MemberDetailPageVo> getPreferDurations(String userid);
	
	//마이페이지+회원상세 프로젝트 경험 가져오기
	public List<M_ExperienceVo> getExperiences(String userid);
	
	//마이페이지에서 프로젝트 경험 없음이 없음이라고 입력한건지 확인
	public String haveExperience(String userid);
	
	//마이페이지+회원상세 기술, 기간, 포지션 수정 시 삭제 및 재등록
	public Integer deleteSkills(String memberid);	
	public Integer insertSkills(List<M_SkillVo> skills);	
	public Integer updatePosition(@Param("position_id")String position_id, @Param("member_id")String member_id);	
	public Integer deleteDurations(String memberid);
	public Integer insertDurations(List<M_DurationVo> stat);
	
	//마이페이지 프로젝트 경험 있/없 업데이트
	public Integer updateExperience(String memberid, int answer);
	
	//마이페이지 프로젝트 경험 있는 사람은 기입하기^^
	public Integer insertExperiences(M_ExperienceVo mex);
	
	//마이페이지 프로젝트 경험 삭제
	public Integer deleteExperience(String ex_id, String memberid);
	
	//마이페이지 프로젝트 경험 수정하기
	public Integer updateExperiences(M_ExperienceVo mex);
	
	//마이페이지 모든 정보 입력시 포인트 지급 이전에 체크
	public Integer checkPoint(String member_id);
	
	//위의 함수로 체크했을 때, 보너스 포인트 받은 적 없으면포인트 지급(최초 1회)
	public Integer givePointFirstTime(String member_id);
	
	//마이페이지 회원 탈퇴시 팀장인지 확인
	public Integer isTeamManager(String quit_id);
	//마이페이지 회원 탈퇴시 탈퇴날짜 업데이트
	public Integer updateDeleteDate(String quit_id);
	
	//회원 상세 페이지 이메일 가져오기
	public MemberVo getMemberDetail(String memberid);

	// 포인트 관리 쿼리
	public int updatePoint(PointVo point);
	
	public Integer chargePoint(String memberid, String point);
	
	//회원 상세 페이지 리뷰목록 가져오기
	public List<ReviewVo> getReviewList(String userid);

	//회원 상세 프로젝트 초대 모달 전에 초대할 프로젝트는 있는지 확인
	public List<P_DetailVo> checkProjectBeforeInvite(String memberid);
	
	//##북마크, 지원목록 페이지
	//북마크한 프로젝트 목록
	public List<BookMark_Join_P_detailVo> getBookmarkList(String memberid);
	
	//북마크 취소
	public void deletBookMark(String projectid, String memberid);
	
	//지원한 프로젝트 목록
	public List<Apply_Join_P_datailVo> getApplyList(String memberid);
	
	//지원 취소
	public void deleteApply(String applyid);
	
	//##내 프로젝트 목록/후기 페이지
	//로그인한 회원이 팀장인 프로젝트 목록
	public List<Project_TeamLeaderVo> getTeamLeader(String memberid);
	
	//로그인한 회원이 팀원인 프로젝트 목록
	public List<V_myProjectVo> getTeamMember(String memberid);
  
	//후기작성용 팀장,팀원 목록
	public List<V_myProjectVo> getReviewMember(String projectid);
	
	//멤버 권한 수정
	public int UpdateAuth(M_AuthVo auth);
	//후기작성용 팀장 조회
	public MyProject_Join_Member writeReviewLeader(String projectid, String memberid);
	
	//후기작성용 팀원 조회
	public List<MyProject_Join_Member> writeReviewMember(String projectid, String memberid);
	
	//후기 작성
	public void setReview(List<ReviewVo> reviewList);
	
	//후기 작성시 포인트 지급
	public void giveReviewPoint(String memberid);
	
	//로그인한 회원이 작성한 리뷰 가져오기
	public List<ReviewVo> getMyReview(String memberid);
	
	//로그인한 회원이 해당 프로젝트에 남긴 리뷰 조회
	public List<MyReviewVo> getMyProjectReview(String projectid, String memberid);
	
	//이메일, 비밀번호 찾기
	//이메일찾기 전 해당 유저의 정보가 존재하는지 확인
	public int beforeFindEmail(String userName, String userPhone);
	//이메일찾기
	public String findEmail(String userName, String userPhone);
	
	//비밀번호찾기 전 해당 유저의 정보가 존재하는지 확인
	public int beforeFindPwd(String userName, String userEmail);
	
	//비밀번호찾기 인증 완료 후 비밀번호 변경
	public void findPwdEdit(String userEmail, String userPwd);
	
	//패널티 먹으면 패널티 업뎃
	public int penalyMember(String member_id);
	
}
