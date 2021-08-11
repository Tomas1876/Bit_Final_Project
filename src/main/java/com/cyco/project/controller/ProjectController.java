package com.cyco.project.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cyco.common.vo.AdrVo;
import com.cyco.common.vo.BookmarkVo;
import com.cyco.common.vo.M_AuthVo;
import com.cyco.common.vo.MemberVo;
import com.cyco.common.vo.P_FieldVo;
import com.cyco.common.vo.PointVo;
import com.cyco.common.vo.PositionVo;
import com.cyco.common.vo.SkillVo;
import com.cyco.member.security.ChangeAuth;
import com.cyco.member.service.MemberService;
import com.cyco.member.vo.V_MlistVo;
import com.cyco.project.service.ProjectService;
import com.cyco.project.vo.P_DetailVo;
import com.cyco.project.vo.P_DurationVO;
import com.cyco.project.vo.P_MemberVo;
import com.cyco.project.vo.P_SkillVo;
import com.cyco.project.vo.PmemberCountVo;
import com.cyco.project.vo.ProjectVo;
import com.cyco.project.vo.V_PjAdrField_Join_V_PDetail;
import com.cyco.project.vo.V_PjSk;
import com.cyco.project.vo.V_PmPosition;
import com.cyco.project.vo.V_PmPostion_Count;
import com.cyco.project.vo.V_p_pd_Join_NameVo;
import com.cyco.utils.UtilFile;

import net.sf.json.JSON;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value="project")
public class ProjectController {
	
	@Autowired
	private ProjectService service;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="list")
	public String getProjectList(Model m, HttpSession session) {
		// 프로젝트 리스트 첫 페이지
		// 모든 프로젝트 리스트 바로 뿌려주기.
		List<V_PjAdrField_Join_V_PDetail> project_list = service.getProjectList("");
		JSONArray json_project_list = JSONArray.fromObject(project_list);
		
		//각 프로젝트의 기술스택 리스트
		List<V_PjSk> pjsk_list = service.getPjSkList();
		JSONArray json_pjsk_list = JSONArray.fromObject(pjsk_list);
		
		//지역 리스트
		List<AdrVo> adr_list = service.getAdrList();
		
		//분야 리스트
		List<P_FieldVo> field_list = service.getFieldList();
		
		//기술스택 리스트
		List<SkillVo> skill_list =service.getSkillList();
		
		//프로젝트 멤버 자리 개수 리스트
		List<PmemberCountVo> membercount_list = service.getPmemberCountList();
		JSONArray json_membercout_list = JSONArray.fromObject(membercount_list);
		
		//북마크 리스트
		//유저가 로그인되어있으면 북마크 리스트 보내주기
		/*if(session.getAttribute("member_id")!=null) {*/
		List<BookmarkVo> raw_bookmark_list = service.getBookmarkList(String.valueOf(session.getAttribute("member_id")));
		
		if(raw_bookmark_list.isEmpty()) {
			raw_bookmark_list.add(new BookmarkVo(0, "0", "0"));
			//System.out.println("비어있나요 " + raw_bookmark_list);
		}
		JSONArray bookmark_list = JSONArray.fromObject(raw_bookmark_list);
		m.addAttribute("bookmark_list",bookmark_list);
		/*
		 * }else { List<BookmarkVo> x_bookmark_list = new ArrayList<BookmarkVo>();
		 * m.addAttribute("bookmark_list",x_bookmark_list); }
		 */
		
		List<V_PjAdrField_Join_V_PDetail> rcm_list;
		if(session.getAttribute("member_id")!=null) {
			//유저가 로그인되어있으면 추천리스트 출력
			rcm_list=service.getRcmProjectList(String.valueOf(session.getAttribute("member_id")));
		}
		else {
			rcm_list=service.getOrderedViewsList(null);
		}
		
		
		m.addAttribute("project_list",json_project_list);
		m.addAttribute("pjsk_list",json_pjsk_list);
		
		m.addAttribute("adr_list",adr_list);
		m.addAttribute("field_list",field_list);
		m.addAttribute("skill_list",skill_list);
		
		m.addAttribute("membercount_list",json_membercout_list);
		
		m.addAttribute("rcm_list",rcm_list);
		
		
		return "Project/ProjectList";
	}
	
	
	@RequestMapping(value="create",method = RequestMethod.GET)
	public String ProjectAdd(Model model, Authentication auth) {
		
		//System.out.println("멤버 : " + auth.getName());
		//System.out.println(memberService.getMember(auth.getName()));
		
		MemberVo member = memberService.getMember(auth.getName());
	
		
		int ProjectCount = service.CheckProject(""+member.getMEMBER_ID());
		
		if(ProjectCount > 0) {
			model.addAttribute("count", ProjectCount);
			
		}else {
		
		
			if(member.getHAVE_POINT() < 50) {
				model.addAttribute("errorMsg", "포인트부족");
				
			}else {
				
				List<AdrVo> AdrList = service.getAdrList();
				List<P_FieldVo> FieldList = service.getFieldList();
				List<SkillVo> SkillList = service.getSkillList();
				List<PositionVo> PositionList = service.getPositionList();
				List<P_DurationVO> DurationList = service.getDurationList();
				
				model.addAttribute("AdrList", AdrList);
				model.addAttribute("FieldList", FieldList);
				model.addAttribute("SkillList", SkillList);
				model.addAttribute("PositionList", PositionList);
				model.addAttribute("DurationList", DurationList);
				
				
			}
		}
		model.addAttribute("MemberVo", member);
		return "Project/ProjectCreate";
	}
	
	
	@Transactional
	@RequestMapping(value="create",method = RequestMethod.POST) 
	public String ProjectAdd(P_DetailVo detail, ProjectVo projectvo,
			@RequestParam("skil_code") String[] skil_code,
			@RequestParam("position_code") String[] position_code, 
			@RequestParam("field_selectCount") int[] field_selectCount,
			@RequestParam("uploadFile") MultipartFile uploadFile, 
			MultipartHttpServletRequest request,
			Authentication auth,
			Model model, HttpSession session) {
		
		MemberVo member = memberService.getMember(auth.getName());
		int ProjectCount = service.CheckProject(""+member.getMEMBER_ID());
		
		
		if(member.getHAVE_POINT() < 50 || ProjectCount > 0) {
			model.addAttribute("msg", "false");
			
		}else {
			// 파일 유틸 생성
			UtilFile utilFile = new UtilFile();
			
			// 받아오는 파일 받아오기
			String UploadFile = utilFile.FileUpload(request, uploadFile);
			String UploadFilename = utilFile.getFilename();
			detail.setP_image(UploadFilename);

			List<P_MemberVo> MemberList = new ArrayList<P_MemberVo>();
			List<P_SkillVo> SkillList = new ArrayList<P_SkillVo>();
			
			// 포지션VO 받아온대로  List에 add 
			for(int i = 0 ; i < position_code.length; i++) {
				for(int j = 0; j < field_selectCount[i]; j++) {
					MemberList.add(new P_MemberVo(null, null, position_code[i]));
				}
				
			}	
			
			// 스킬VO 받아온대로 List에 add
			for(String skill : skil_code) {
				SkillList.add(new P_SkillVo(null,skill));
			}
			
			// 프로젝트 insert service
			String project_id = service.CreateProject(projectvo, detail, SkillList, MemberList);
					
			
			int memberID = member.getMEMBER_ID();
			int have_Point = member.getHAVE_POINT();
			int use_Point = member.getUSE_POINT();
			
			// 포인트 처리
			PointVo point = new PointVo(memberID, have_Point -= 50, use_Point += 50);
			
			memberService.updatePoint(point);
			
			//이제 팀장으로 권한 변경(디비)
			String member_id = Integer.toString(member.getMEMBER_ID());
			M_AuthVo mauth = new M_AuthVo("3",member_id);
			memberService.UpdateAuth(mauth);
			  
			//시큐리티 권한 변경
			ChangeAuth chau = new ChangeAuth("ROLE_TEAMMANGER");
			
			model.addAttribute("msg", "true");
			model.addAttribute("projectId",project_id);
			
			session.setAttribute("project_id", project_id);
			session.setAttribute("p_title", detail.getP_title());
		}
	
		
		return "redirect:/project/projectCreateok";
	}
	
	@RequestMapping(value="projectCreateok",method = RequestMethod.GET) 
	public String ProjectAdd(String msg, String projectId, Model model, Authentication auth) {
		
		
		
		//기본회원목록넘기기
		List<V_MlistVo> memberList = memberService.memberList();
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("msg", msg);
		model.addAttribute("id", projectId);
		
		
		
		return "Project/ProjectCreateOk";
	}
	
	
	//프로젝트 상세 페이지
	@RequestMapping(value="detail",method = RequestMethod.GET)
	public String ProjectDetail(@RequestParam("project_id") String project_id, Model m, HttpSession session) {

		//조회수증가
		service.addViews(project_id);

		int reader = service.ProjectReaderCheck(project_id, String.valueOf(session.getAttribute("member_id")));
		
		String Check = "false";
		
		//프로젝트 멤버 검색
		List<V_PmPosition> pmlist = service.getProjectMemberList(project_id);
		
		//프로젝트 기술 
		List<V_PjSk> pjsk = service.getIfPjSkList(project_id);
		
		//프로젝트 상세의 포지션별 자리수
		List<V_PmPostion_Count> pmcountlist = service.getPmemberCount(project_id);
		
		//프로젝트 상세 내용을 담은 객체
		V_PjAdrField_Join_V_PDetail project = service.getOneProject(project_id);
		
		int BookMark = service.checkBookMark(project_id, String.valueOf(session.getAttribute("member_id")));


		if(reader > 0 && project.getP_state() == "모집중") {
			Check = service.MemberFullCheck(project_id);
		}
		
		
		m.addAttribute("Check",Check);
		m.addAttribute("project",project);
		m.addAttribute("pmcountlist",pmcountlist);
		m.addAttribute("pmlist",pmlist);
		m.addAttribute("pjsk",pjsk);
		m.addAttribute("bookMark",BookMark);
		
		
		return "Project/ProjectDetail";
	}
	
	@RequestMapping(value="edit",method = RequestMethod.GET)
	public String ProjectEdit(String project_id ,Model model, HttpSession session, Authentication auth) {
		
		
		String member_id = String.valueOf(session.getAttribute("member_id"));
		
		// 생성 된 프로젝트 정보들 가져오기
		V_p_pd_Join_NameVo project = new V_p_pd_Join_NameVo();
		project.setProject_id(project_id);
		project.setMember_id(member_id);
		project = service.getProjectJoinName(project);
		
		if(project == null) {
			model.addAttribute("error", "false");
			
		}else {
			
			if(project.getP_state().equals("진행중")) {
				model.addAttribute("state", "진행중");
				return "Project/ProjectEdit";
			}
			
			List<AdrVo> AdrList = service.getAdrList();
			List<P_FieldVo> FieldList = service.getFieldList();
			List<SkillVo> SkillList = service.getSkillList();
			List<P_DurationVO> DurationList = service.getDurationList();
			MemberVo member = memberService.getMember(auth.getName());
			List<SkillVo> CreateSkillList = service.getCreateProjectSkill(project_id);
			List<SkillVo> CreateNotInSkillList = service.getCreateNotInProjectSkill(project_id);
			List<V_PmPostion_Count> pmcountlist = service.getPmemberCount(project_id);
			List<String> members = service.getTeamMembers(project_id);
			
			model.addAttribute("AdrList", AdrList);
			model.addAttribute("FieldList", FieldList);
			model.addAttribute("SkillList", SkillList);
			model.addAttribute("DurationList", DurationList);
			model.addAttribute("Project", project);
			model.addAttribute("MemberVo", member);
			model.addAttribute("Pmcountlist",pmcountlist);
			model.addAttribute("CreateSkillList",CreateSkillList);
			model.addAttribute("CreateNotInSkillList",CreateNotInSkillList);
			model.addAttribute("Members",members);
			
		}
	
		return "Project/ProjectEdit";
	}
	

}