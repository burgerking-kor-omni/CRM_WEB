package com.ubone.standard.login.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.security.acl.AccessDeniedException;
import com.ubone.framework.util.UserUtil;
import com.ubone.standard.login.domain.LoginResult;
import com.ubone.standard.login.domain.LoginResultType;
import com.ubone.standard.login.domain.VocUser;
import com.ubone.standard.login.service.LoginSO;

/**
 * <pre>
 *  파 일 명 : LoginController.java
 *  설    명 : 로그인 컨트롤러
 *  작 성 자 : 강영운
 *  작 성 일 : 2013.12.03
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
public class LoginController {

	@Resource
	private LoginSO loginSO;
	
	private static String LOGIN_URL  = "/screen/BCO001.ub";
	private static String LOGOUT_URL = "/logout.ub";
	private static String MAIN_PAGE  = "/login/loginSuccess.jsp";
	
	public LoginController(){
	}

	/**
	 * 로그인 요청 처리
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 * @throws Exception
	 */
	@RequestMapping("/login.ub")
	@SuppressWarnings("unchecked")
	public void login(HttpServletRequest request, HttpServletResponse response, Parameter parameter) throws Exception {
		
		// 로그인 타입 설정 (IDPW)
		request.getSession().setAttribute("LOGIN_TYPE", "IDPW");
		
		LoginResult result = loginSO.login(request, response, parameter);
		loginRedirect(request, response, result);
	}
	
	/**
	 * 모바일 로그인 요청 처리
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping("/mlogin.ub")
	@ResponseBody
	public String mobilelogin(HttpServletRequest request, HttpServletResponse response, Parameter parameter) throws Exception {
		// 로그인 타입 설정 (IDPW)
		request.getSession().setAttribute("LOGIN_TYPE", "IDPW");
		
		parameter.set(ConstantHolder.AUTH_KEY_USERNAME, parameter.get("loginId"));
		parameter.set(ConstantHolder.AUTH_KEY_PASSWORD, parameter.get("loginPw"));
		
		LoginResult soResult = loginSO.login(request, response, parameter);

		String message = soResult.getLoginResultType().toString();
		String resultStatus = soResult.getLoginResultType().getCode();
		
		JSONObject result = new JSONObject();
		JSONObject serviceMessage = new JSONObject();
		JSONObject userData = soResult.getUserData();
		JSONObject serviceMessageDetail = new JSONObject();
		
		serviceMessageDetail.put("message", message);
		serviceMessageDetail.put("resultStatus", resultStatus);
		
		serviceMessage.put("serviceMessage", serviceMessageDetail);
		
		serviceMessage.put("userData", userData);
		serviceMessage.put("extendAttributeMap", "[{}]");
		
		result.put("result", serviceMessage);
		
//		ArrayList<Map<?,?>> list = new ArrayList<Map<?,?>>();
//		list.add(soResult.getUserData());
//		Map<String, ArrayList<Map<?,?>>> userDataMap = new HashMap<String, ArrayList<Map<?,?>>>();
//		userDataMap.put("userData", list);
//		
//		JSONObject result = new JSONObject();
//		JSONObject resultDetail = new JSONObject();
//		JSONObject serviceMessage = new JSONObject();
//		JSONObject userData = new JSONObject(soResult.getUserData());
//		JSONObject serviceMessageDetail = new JSONObject();
//		JSONObject dataListDetail = new JSONObject();
//		JSONObject loginResultDetail = new JSONObject();
//		
//		serviceMessageDetail.put("resultStatus", "Success");
//		serviceMessage.put("serviceMessage", serviceMessageDetail);
//		
//		loginResultDetail.put("resultStatus", resultStatus);
//		loginResultDetail.put("message", message);
//		
//		dataListDetail.put("loginResult", loginResultDetail);
//		dataListDetail.put("userData", userData);
//		
//		resultDetail.put("serviceMessage", serviceMessageDetail);
//		resultDetail.put("dataList", dataListDetail);
//		resultDetail.put("extendAttributeMap", "[{}]");
//		
//		result.put("result", resultDetail);
		
		return result.toString();
		
	}
	
	/**
	 * 관리자가 특정사용자로 로그인하는 함수
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 * @throws Exception
	 */
	@RequestMapping("/impersonate.ub")
	@SuppressWarnings("unchecked")
	public void impersonate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Admin 권한이 있는지 체크 한다. 미존재시 접근 불가로 리턴처리한다.
		if(!UserUtil.getLoginUser().hasRole("100")){
			throw new AccessDeniedException("Access Denied");
		}
		// 로그인 타입 설정 (IDPW)
		request.getSession().setAttribute("LOGIN_TYPE", "IDPW");
		
		LoginResult result = loginSO.login(request, response, DataUtil.makeParameter(request.getParameterMap()));
		loginRedirect(request, response, result);
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
