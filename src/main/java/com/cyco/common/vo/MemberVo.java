
package com.cyco.common.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class MemberVo implements UserDetails{


	private int MEMBER_ID;
	private String MEMBER_EMAIL;
	private String MEMBER_PWD;
	private String MEMBER_NAME;
	private String MEMBER_NICKNAME;
	private String MEMBER_PHONE;
	private String MEMBER_IMAGE;
	private String ENABLED;

	//이건 포인트 테이블
	private int HAVE_POINT;
	private int USE_POINT;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
	
		return null;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return MEMBER_PWD;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return MEMBER_NICKNAME;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}
}