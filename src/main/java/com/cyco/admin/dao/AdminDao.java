package com.cyco.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cyco.admin.vo.ChartCount;
import com.cyco.admin.vo.MemberListVo;
import com.cyco.admin.vo.StateCountVo;
import com.cyco.common.vo.P_FieldVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.common.vo.SkillVo;
import com.cyco.member.vo.V_MlistVo;

public interface AdminDao {

	//Site manage
	public List<SkillVo> getSkillList();
	public List<PositionVo> getPositionList();
	public List<P_FieldVo> getFieldList();

	//Member manage
	public List<MemberListVo> getMemberList(String nickname);
	
	
	//chart
	//정상적으로 활동중인 회원 수
	public int getMemberCount();
	
	//지금까지 생성된 프로젝트 수
	public int getProjectCount();
	
	//프로젝트가 가지는 기술, 포지션, 분야 랭크
	public List<ChartCount> getPSkillCount();
	public List<ChartCount> getPpositionCount();
	public List<ChartCount> getPFieldCount();
	
	//회원이 가지는 기술, 포지션
	public List<ChartCount> getMSkillCount();
	public List<ChartCount> getMpositionCount();
	
	
	//프로젝트 상태 카운트 - 도넛예정
	public List<StateCountVo> getStateCount();
	
	
	//ajax
	public int getSkillNameCheck(String name);
	public int insertSite(@Param("list") List<Object> list, @Param("code") String code);
	public int updateSite(@Param("obj") Object obj, @Param("code") String code);
	
	public List<V_MlistVo> getMemberSearch(String nickname);
	
	/* 회원 영구정지 */
	
	//회원 권한 가져오기
	public String getMemberAuth(String member_id);
	
	//일반회원 밴 먹이기 (리턴값 없음)
	void procedureBanMember(@Param("data") Map<String, String> data);
	
	//팀장회원 밴 먹이기
	void procedureBanLeader(@Param("data") Map<String, Object> data);
	public List<String> getPMemberList(int project_id);
	void procedureCancelBan(@Param("data") Map<String, String> data);
}
