package com.cyco.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cyco.common.vo.PositionVo;
import com.cyco.member.service.MemberDetailService;
import com.cyco.member.service.MemberService;
import com.cyco.member.vo.ReviewVo;
import com.cyco.member.vo.V_MlistVo;
import com.cyco.project.vo.V_PjAdrField_Join_V_PDetail;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("member")
public class MemberController {
	MemberService memberservice;
	MemberDetailService memberdetailservice;
	
	@Autowired
	public void setMemberService(MemberService memberservice, MemberDetailService memberdetailservice) {
		this.memberservice = memberservice;
		this.memberdetailservice = memberdetailservice;
	}
	
	@RequestMapping("list")
	public String memberList(Model m) {
		//기본회원목록넘기기
		List<V_MlistVo> memberList = memberservice.memberList();
		JSONArray json_memberList = JSONArray.fromObject(memberList);
		//System.out.println("멤버리스트제이슨 " + json_memberList);
		/*
		 * // 모든 프로젝트 리스트 바로 뿌려주기.
		List<V_PjAdrField_Join_V_PDetail> project_list = service.getProjectList("");
		JSONArray json_project_list = JSONArray.fromObject(project_list);
		 */
		
		//포지션목록 넘기기
		List<PositionVo> positionList = memberservice.positionList();
		
		//System.out.println("기본회원리스트 controller");
		//System.out.println("memberlist"+memberList);
		
		m.addAttribute("memberList", json_memberList);
		m.addAttribute("positionList", positionList);
		
		return "Member/MemberList"; 
	}
	
	//임시 에러페이지 경로설정
	@RequestMapping("error")
	public String errorPage(Model m) {
		
		return "Main/ErrorPage"; 
	}
	
	//회원 상세 정보 불러오기
		@RequestMapping(value="memberdetailpage")
		public ModelAndView getMemberDetail(@RequestParam("memberid") String memberid){
			
			//System.out.println("member_id" + memberid);
			
			String useremail = memberdetailservice.getMemberDetail(memberid).getMEMBER_EMAIL();
			//System.out.println("useremail" + useremail);
			ModelMap mmp = new ModelMap();
			
			mmp.addAttribute("aboutmember",memberdetailservice.getMemberDetail(memberid));
			
			
			//System.out.println("상세 페이지 회원 " +memberdetailservice.getMemberDetail(memberid).toString());
			//리뷰목록
			List<ReviewVo> row_reviewList = memberdetailservice.getReviewList(memberid);
			int answer = 0;
			if(row_reviewList.size() != 0) {
				for (int i = 0; i < row_reviewList.size() ; i++) {
					answer = answer + row_reviewList.get(i).getReview_grade() ;
				}
				double gradeAvg = 0;
				gradeAvg = (double)answer/row_reviewList.size();
				//System.out.println("반올림하기 전 gradeAvg: " + gradeAvg);
				gradeAvg = Math.round(gradeAvg * 100) / 100.0;
				
				//System.out.println("row_reviewList.size(): " + row_reviewList.size());
				//System.out.println("answer: " + answer + "/gradeAvg: " + gradeAvg);
				
				mmp.addAttribute("gradeAvg", gradeAvg);
			}
			
		    
			
			
			JSONArray reviewList = JSONArray.fromObject(row_reviewList);
			//System.out.println("리뷰목록JSON: " + reviewList);
			mmp.addAttribute("reviewList", reviewList);
			
			mmp.addAttribute("skills",memberdetailservice.getPreferSkills(useremail));
			mmp.addAttribute("position",memberdetailservice.getPreferPosition(useremail));
			mmp.addAttribute("durations",memberdetailservice.getPreferDurations(useremail));
			mmp.addAttribute("experiences", memberdetailservice.getExperiences(useremail));
			mmp.addAttribute("member_id",memberid);
			
			return new ModelAndView("/Member/MemberDetail",mmp) ;

		}
}
