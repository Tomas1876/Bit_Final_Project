package com.cyco.alarm.dao;

import java.util.List;

import com.cyco.alarm.vo.AlarmVo;
import com.cyco.alarm.vo.FromNoteVo;
import com.cyco.alarm.vo.ToNoteVo;
import com.cyco.alarm.vo.V_FromNote_Member_Vo;
import com.cyco.alarm.vo.V_ToNote_Member_Vo;

public interface AlarmDao {
	
	
	//----------------알림 수신 트랜잭션 처리-----------------
	//쪽지 발신함 insert
	public Integer insertFromNote(FromNoteVo fnote);
	//쪽지 수신함 insert
	public Integer insertToNote(ToNoteVo tonote);
	
	//모든 알림 이벤트가 일어나면 알림 게시판에 인서트가 일어난다(트랜잭션)
	public Integer insertAlarm(AlarmVo alarm);
	//--------------------------------------------------
	// 이건 트랜잭션 없이 알림 insert
	public int makeAlarm(List<AlarmVo> alarms);
	
	//알림 헤더 메뉴에서 보여줄 것들
	public List<AlarmVo> getNewAlarms(String memberid);

	//알림페이지에서 전체 알림(+ 새 쪽지 있없 여부 체크 위해 쪽지 테이블 체크)
	public List<AlarmVo> getAllAlarms(String useremail);
	public List<String> hasNewMessages(String useremail);
	
	//알림 확인하면 상태 변경
	public Integer checkAlarm(String alarm_id);
	
	//알림 삭제
	public Integer deleteAlarm(String alarm_id);

	
	//쪽지 페이지 진입시 수신 메시지 불러오기
	public List<V_ToNote_Member_Vo> getReceivedMessages(String useremail);
	
	//쪽지 페이지 진입시 발신 메시지 불러오기
	public List<V_FromNote_Member_Vo> getSendMessages(String useremail);
	
	//받은 쪽지 확인하면 상태 업데이트
	public Integer updateNoteOk(String noteid);
	
	//쪽지 삭제
	public Integer deleteNotes(String table, List<String> noteid);
	
	
}
