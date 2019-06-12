package com.ubone.standard.login.service;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.BasicUserContainer;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.domain.UserContainer;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.framework.security.session.LoginHttpSessionBindingListener;
import com.ubone.framework.security.session.SessionManager;
import com.ubone.framework.security.user.BasicRoleAppendStrategy;
import com.ubone.framework.security.user.ExtendRoleAppendStrategy;
import com.ubone.framework.util.hotlink.HotLink;
import com.ubone.framework.util.hotlink.JdbcHotLinkRepository;
import com.ubone.framework.web.util.HttpUtils;
import com.ubone.standard.login.dao.LoginDAO;
import com.ubone.ubcom.util.TextString;
import com.ubone.ubmeta.page.util.CommUtil;

/** 
 * <pre>
 *  파 일 명 : BaseLogin.java
 *  설    명 : 로그인로그 목록조회 및 조회, 저장하는 비지니스 로직을 처리 하는 비지니스 컴포넌트
 *  작 성 자 : 강영운
 *  작 성 일 : 2013.12.23
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
*/
public abstract class BaseLogin {

	@Resource
	private LoginDAO loginDAO;
	
	@Resource 
	private SessionManager sessionManager;
	
	@Resource
	private JdbcHotLinkRepository hotLinkRepository;
	
	@Resource
	private BasicRoleAppendStrategy basicRoleAppendStrategy;

	@Resource
	private ExtendRoleAppendStrategy extendRoleAppendStrategy;
	
	/**
	 * 세션 메니저의 로그인 처리를 통한 Framework 내의 로그인 관련 기능을 구동하는 함수
	 * @param result 로그인 결과 인스턴스
	 */
	protected UserContainer loginForSessionManager(HttpServletRequest request, HttpServletResponse response, User user, boolean isRunSessionManager) {
		// Password 정보 삭제
		user.clearPassword();
		
		HttpSession session = request.getSession();
		
		// 핫링크 정보 저장
		HotLink hotLinkInfo = new HotLink();
		if(session.getAttribute(ConstantHolder.KEY_PARAMETER_HOTLINK) != null){
			hotLinkInfo = (HotLink) session.getAttribute(ConstantHolder.KEY_PARAMETER_HOTLINK);
		}

		UserContainer userContainer = new BasicUserContainer(user.getLoginId(), user, true, HttpUtils.getRemoteAddr(request));
		userContainer.setSessionId(session.getId());
		userContainer.setLocale(new Locale(user.getLanguageCode()));
		userContainer.setNewLoginToken();

		if(isRunSessionManager){
			try{
				ServiceContext.setUserContainer(userContainer);
				sessionManager.onLogin(userContainer, request, response);
			}finally{
				ServiceContext.removeUserContainer();
			}
		}	

		/**
		 * 주의 : sessionManager.onLogin 이후에 Security의 설정에 따라 세션이 새롭게 생성될 수 있으니 
		 *        request.getSession을 통해서 다시한번 세션 정보를 가져온다.
		 */
		HttpSession newSession = request.getSession(); 
		// 저장한 핫링크 정보 세팅
		this.setHotLinkInfo(newSession, hotLinkInfo);
		// 세션 다국어 정보 설정
		newSession.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, userContainer.getLocale());

		// 중복로그인 체크를 위한 세션관리 설정 - ub-framework-security-1.6.3 이후 지원 됨.
//		LoginHttpSessionBindingListener listener = new LoginHttpSessionBindingListener();
//		newSession.setAttribute(user.getLoginId(), listener);
		
		return userContainer;
	}
	
	/**
	 * 로그인 사용자의 권한 정보 설정
	 * @param builder 사용자 빌더 객체
	 */
	protected void setRoleInfo(UserBuilder builder){
		DataList userRoleList = loginDAO.getListUserRole(builder);
		if(userRoleList != null) {
			for(int i=0; i<userRoleList.getRowCount(); i++) {
				builder.addRole(userRoleList.getString(i, "ROLE_ID"));

				// 관리자여부
				if("Y".equals(userRoleList.getString(i, "ADMIN_YN"))){
					builder.setIsSystemAdmin(true);
				}
				
				// 맵핑코드 제외여부
				if("Y".equals(userRoleList.getString(i, "EXCEPT_MAP_YN"))){
					builder.setIsExceptCodeMapp(true);
				}
			}
		}
		
		basicRoleAppendStrategy.append(builder);
		extendRoleAppendStrategy.append(builder);
	}
	
	/**
	 * 세션 유저정보에 ssoInfo정보를 세팅한다.
	 * @param user
	 * @param ssoParam
	 */
	protected void setHotLinkInfo(HttpSession session, HotLink hotLink){
		if(session.getAttribute(ConstantHolder.KEY_USER) == null || hotLink.getHotLinkId() == null){
			return;
		}
	
		//세션의 유저정보 로드
		UserContainer userContainer = (UserContainer)session.getAttribute(ConstantHolder.KEY_USER);
		User user = userContainer.getUser();

		//세션에 핫링크 정보 세팅
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put(ConstantHolder.KEY_PARAMETER_HOTLINK, hotLink);
		user.setSsoInfo(map);
		
		//네비게이션을 위한 menuId 세션에 추가
		session.setAttribute("menuId", hotLink.getMenuId());
	}
	
	/**
	 * hotlink 정보를 받아온다.
	 * @param parameter
	 * @return
	 */
	protected HotLink getHotLinkInfo(HttpServletRequest request){
		Parameter parameter = DataUtil.makeParameter(request.getParameterMap());
		String hotLinkId = parameter.get(ConstantHolder.KEY_PARAMETER_HOTLINK);
		
		HotLink hotLink = new HotLink();
		
		if(!"".equals(hotLinkId)){
			hotLink = hotLinkRepository.findByHotLinkId(hotLinkId);
			
			if(hotLink != null){
				String param   = replaceRequestValue(hotLink.getParam(), parameter);
				String linkUrl = "/screen/"+hotLink.getScreenId()+".ub"+param;
				hotLink.setLinkUrl(linkUrl);
			}
		}
		return hotLink;
	}
	
	/**
	 * 파라미터 템플릿에 맞게 데이터를 치환한다.
	 * @param templatetag
	 * @param parameter
	 * @return
	 */
	private String replaceRequestValue(String templatetag, Parameter parameter){
		String html = TextString.fixNull(templatetag);
		
		while(true){
			String attribute = CommUtil.getBetweenString( html, "#[", "]" );
			if( attribute==null ) break;
			html = TextString.replace(html, "#["+attribute+"]", TextString.fixNull(parameter.getValue(attribute)));
		}
	
		return html;		
	}	
}