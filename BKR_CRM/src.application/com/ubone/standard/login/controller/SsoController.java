package com.ubone.standard.login.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.util.hotlink.HotLink;
import com.ubone.standard.login.domain.LoginResult;
import com.ubone.standard.login.domain.LoginResultType;
import com.ubone.standard.login.domain.SsoData;
import com.ubone.standard.login.domain.VocUser;
import com.ubone.standard.login.service.LoginSO;

/**
 * <pre>
 *  파 일 명 : SsoController.java.java
 *  설    명 : SSO 컨트롤러
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.11.04
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
public class SsoController {

	@Resource
	private LoginSO loginSO;
	
	// SSO모듈을 JSP에서 처리할 페이지를 설정한다.
	// 즉, SSO의 상태에 따른 메세지 및 또는 특정SSO의 ActiveX를 이용한 SSO 등이 존재할 수 있으므로
	// 해당 모듈에 적용이 무난한 방법으로 접근 처리함.
	private static String LOGIN_URL  = "/sso/sso.jsp";				
	private static String LOGOUT_URL = "/logout.ub";
	private static String MAIN_PAGE  = "/login/ssoSuccess.jsp";
	
	/**
	 * SSO 모듈을 이용한 로그인 처리
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 * @throws Exception
	 */
	@RequestMapping("/sso.ub")
	@SuppressWarnings("unchecked")
	public void sso(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String contextPath = request.getContextPath();
		
		HotLink hotLink = (HotLink)request.getSession().getAttribute(ConstantHolder.KEY_PARAMETER_HOTLINK);
		
		if(hotLink == null){
		
			//핫링크정보 생성
			hotLink = loginSO.getHotLink(request);
			
			//현재 세션에 SSO 정보 저장
			request.getSession().setAttribute(ConstantHolder.KEY_PARAMETER_HOTLINK, hotLink);
		}
	
		// SSO 정보중에서 로그인에 필요한 정보를 세션에서 가져옴.
		// JSP에서 SSO 파싱이 완료되면 현재 세션에 로그인에 필요한 정보를 저장함.
		// 로그인이 정상적으로 처리되면 새로운 세션이 생성이 되므로 현재 임시로 저장된 정보는 사라짐.
		SsoData ssoData = (SsoData)request.getSession().getAttribute("SSO_DATA");
		
		// 1. loginId가 유효하면
		if(ssoData != null){
			
			// 정상적인 로그인 처리
			LoginResult result = loginSO.loginForSso(request, response, ssoData.getLoginId());
			
			// 새로운 세션에 핫링크 정보를 할당.
			loginSO.setHotLink(request.getSession(), hotLink);
			
			// 로그인 결과에 따른 페이지 이동 (ID/PW와 같은 분기 처리를 이용함)
			loginRedirect(request, response, result);
		}else{
			//로그인 페이지로 이동
			response.sendRedirect(contextPath + LOGIN_URL);
		}	
	}
	
	/**
	 * 로그인 이후 처리
	 *  - 계정의 상태에 따라 분기 페이지로 redirect 처리를 한다.
	 *   
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 * @param loginResult 로그인 결과 정보
	 * @return ModelAndView Instance
	 * @throws IOException
	 */
	private void loginRedirect(HttpServletRequest request, HttpServletResponse response, LoginResult loginResult) throws IOException {
		
		String contextPath = request.getContextPath();
		if(!StringUtils.isEmpty(request.getContextPath())){
			contextPath = StringUtils.replace(request.getContextPath(), "https", "http");
		}
		String returnPath = contextPath + MAIN_PAGE;
		
		if(request.getParameter("returnUrl") != null){
			//request parameter로 returnUrl이 넘어오면 그 url로 보낸다.
			returnPath = request.getParameter("returnUrl");
		}

		if (returnPath.endsWith(LOGOUT_URL) ||returnPath.endsWith(LOGIN_URL)) {
			// returnURL 이 login 관련 URL 이면 infinite loop 이 됨. 이런 경우에는 그냥 main page로.
			returnPath = contextPath + MAIN_PAGE;
		}
		
		// 로그인 결과에 따른 페이지 분기
		if(loginResult.getLoginResultType() == LoginResultType.SUCCESS){
			response.sendRedirect(returnPath);
		}else if(loginResult.getLoginResultType() == LoginResultType.ACCOUNT_LOCK_TERMINATE_OK){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=accountLockTerminateOk");
		}else if(loginResult.getLoginResultType() == LoginResultType.ACCOUNT_LOCK_TERMINATE_REGIST){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=accountLockTerminateRegist");
		}else if(loginResult.getLoginResultType() == LoginResultType.ACCOUNT_LOCK_TERMINATE_REJECT){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=accountLockTerminateReject");
		}else if(loginResult.getLoginResultType() == LoginResultType.ACCOUNT_NEW_REGIST){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=accountNewRegist");
		}else if(loginResult.getLoginResultType() == LoginResultType.ACCOUNT_NEW_REJECT){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=accountNewReject");
		}else if(loginResult.getLoginResultType() == LoginResultType.DUPLICATE_LOGIN){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=duplicateLogin");
		}else if(loginResult.getLoginResultType() == LoginResultType.EXPIRE_PASSWORD){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=expirePassword");
		}else if(loginResult.getLoginResultType() == LoginResultType.EXPIRE_PASSWORD_WARRING){
			VocUser user = loginSO.getLoginUserInfo(loginResult.getLoginId());
			Date date= new Date();
			Timestamp currentDt = new Timestamp(date.getTime());
			long gapDays = 60-(currentDt.getTime() - user.getChangeDtPassword().getTime()) / 1000 / 60 / 60 / 24;
			
			response.sendRedirect(returnPath+"?pwChange=require&pwLimitDay="+gapDays);
		}else if(loginResult.getLoginResultType() == LoginResultType.HOLDED_LOGIN_ID){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=holdedLoginId");
		}else if(loginResult.getLoginResultType() == LoginResultType.IP_ACCESS_DENIED){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=ipAccessDenied");
		}else if(loginResult.getLoginResultType() == LoginResultType.LOCKED_LOGIN_ID){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=lockedLoginId");
		}else if(loginResult.getLoginResultType() == LoginResultType.MAX_FAIL_PASSWD){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=maxFailPassword");
		}else if(loginResult.getLoginResultType() == LoginResultType.NO_MATCHED_PASSWD){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=fail");
		}else if(loginResult.getLoginResultType() == LoginResultType.NO_PERMISSION){
			response.sendRedirect(contextPath + "/");
		}else if(loginResult.getLoginResultType() == LoginResultType.NOT_EXISTS_LOGIN_ID){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=fail");
		}else if(loginResult.getLoginResultType() == LoginResultType.UNDEFINED){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=undefined");
		}else if(loginResult.getLoginResultType() == LoginResultType.RETIREE){
			response.sendRedirect(contextPath + "//login/logout.jsp?flag=retiree");
		}else if(loginResult.getLoginResultType() == LoginResultType.PERIOD_NOT_EXCEEDING_ONLINE){
			response.sendRedirect(contextPath + "/login/logout.jsp?flag=periodNotExceedingOnline");
		}
	}
}
