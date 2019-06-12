package com.ubone.standard.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.ubone.framework.util.hotlink.HotLink;

/** 
 * <pre>
 *  파 일 명 : SsoLoginSo.java
 *  설    명 : SSO Login Service Class
 *  작 성 자 : 유기태
 *  작 성 일 : 2015-04-16
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
*/
@Service
public class SsoLoginSO extends BaseLogin{

	/**
	 * 세션 유저정보에 핫링크 정보를 세팅한다.
	 * @param session
	 * @param hotLink
	 */
	public void setHotLink(HttpSession session, HotLink hotLink){
		//세션에 핫링크정보 세팅
		super.setHotLinkInfo(session, hotLink);
	}
	
	/**
	 * 파라미터를 추출하여 핫링크 정보를 가져온다.
	 * @param parameter
	 * @return
	 */
	public HotLink getHotLink(HttpServletRequest request){
		return super.getHotLinkInfo(request);
	}

}