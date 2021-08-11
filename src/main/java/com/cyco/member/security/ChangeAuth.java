package com.cyco.member.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

public class ChangeAuth {
	
	// role에 새로 부여할 권한의 풀네임을 적는다 ex) ROLE_MEMBER
	public ChangeAuth(String role){
		
		//현재 로그인된 기존 계정의 정보를 가져옴
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		//권한을 담는 객체
		List<GrantedAuthority> updatedAuthorities = new ArrayList<>(auth.getAuthorities());
		
		updatedAuthorities.clear();
		//새로 추가할 권한을 입력한다
		updatedAuthorities.add(new SimpleGrantedAuthority(role));
		
		//추가한 정보로 다시 시큐리티가 관리할 수 있는 객체를 생성해준다
		Authentication newAuth = 
				  new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(), updatedAuthorities);
		
		//시큐리티가 관리하는 객체를 새로 만든 newAuth로 변경해준다
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		
		System.out.println(role + "로 권한 변경 완료");
		
		//사용법 참고 https://taesan94.tistory.com/135
		//시큐리티 인증 관련 처리에 대한 설명 https://flyburi.com/584

	}

}
