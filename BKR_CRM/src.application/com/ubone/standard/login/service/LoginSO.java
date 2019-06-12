package com.ubone.standard.login.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.domain.UserContainer;
import com.ubone.framework.util.hotlink.HotLink;
import com.ubone.framework.web.util.HttpUtils;
import com.ubone.standard.login.dao.LoginDAO;
import com.ubone.standard.login.domain.LoginResult;
import com.ubone.standard.login.domain.LoginResultType;
import com.ubone.standard.login.domain.LoginStatusCd;
import com.ubone.standard.login.domain.SsoData;
import com.ubone.standard.login.domain.VocUser;
import com.ubone.standard.system.account.dao.AccountManageDAO;

/** 
 * <pre>
 *  파 일 명 : LoginSO.java
 *  설    명 : 사용자 로그인 처리 하는 서비스를 제공한다.
 *  작 성 자 : Administrator
 *  작 성 일 : 2013.12.23
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
*/
@Service
@Transactional
public class LoginSO extends BaseLogin{

	@Resource
	private LoginDAO loginDAO;
	
	@Resource 
	private AccountManageDAO accountManageDAO;
	
//	/**
//	 * 최초 로그인사용자 설정을 저장한 후 결과를 리턴한다
//	 * 
//	 * [리턴]
//	 * 성공하면 True를 반환하고 실패시 False를 리턴한다
//	 * 
//	 * @param parameter
//	 */
//	public int modifyFirstLoginUserConfig(Parameter parameter) {
//		String loginId = parameter.get("loginId");
//		String pwd = parameter.get("pwd");
//		
//		if (StringUtils.isEmpty(loginId)) throw new ServiceException("Login ID is null.", ServiceContext.getCurrentService().getId());
//		if (StringUtils.isEmpty(pwd)) throw new ServiceException("Password is null.", ServiceContext.getCurrentService().getId());
//
//		DataList loginInfo = loginManagerBO.getLoginInfo(parameter);
//		
//		if (loginInfo.size() == 0) {
//			throw new ServiceException("Invalid user info", ServiceContext.getCurrentService().getId());
//		} else {
//			String inPwd = parameter.get("pwd");
//			String dbPwd = loginInfo.get(0, "pwd");
//			
//			if (!dbPwd.equals(inPwd)) {
//				throw new ServiceException("The password is different in DB.", ServiceContext.getCurrentService().getId());
//			} else {
//				return loginManagerBO.modifyFirstLoginUserConfig(parameter);
//			}
//		}
//	}
//
//	/**
//	 * 사용자 로그인 정보를 조회하고 결과를 리턴한다
//	 * 
//	 * [리턴]
//	 * 비밀번호, 이전 비밀번호, 사용자 언어코드
//	 * 
//	 * @param parameter 로그인 ID
//	 */
//	public DataList getLoginInfo(Parameter parameter) {
//		parameter.set("loginId", UserUtil.getLoginUser().getLoginId());
//		return loginDAO.getLoginInfo(parameter);
//	}
	
	/**
	 * 로그인을 처리하고 결과를 리턴한다
	 * 
	 * [리턴]
	 * 성공하면 0을  반환하고 실패시 결과사유코드값을 리턴한다
	 * 
	 * @param parameter    사용자ID, 비밀번호, 등록IP주소(접속IP주소)
	 */
	public LoginResult login(HttpServletRequest request, HttpServletResponse response, Parameter parameter) {
		
//		Boolean as = ConfigHolder.getBoolean("framework.login.validator.expired");
		
		LoginResult result = new LoginResult();
		
		String loginIP  = HttpUtils.getRemoteAddr(request);
		String loginId  = parameter.get(ConstantHolder.AUTH_KEY_USERNAME);
		String password = parameter.get(ConstantHolder.AUTH_KEY_PASSWORD);
		
		result.setLoginId(loginId);
		result.setLoginIP(loginIP);
		
		VocUser user = getLoginUserInfo(loginId);
		if(user == null){
			Parameter param = DataUtil.makeParameter();
			param.set("APPR_STATUS", "REQ");
			param.set("LOGIN_ID", loginId);
			if(!"".equals(loginId) && accountManageDAO.getAccountRequestDetail(param).size() >0){
				result.setLoginResultType(LoginResultType.ACCOUNT_NEW_REGIST);
			}else{
				result.setLoginResultType(LoginResultType.NOT_EXISTS_LOGIN_ID);
			}
			return result;
		}
		
		// 로그인 가능 할 경우
		if(user.isLoginYn()){

			/**
			 * 패스워드 변경일로 60일이 지나면 패스워드를 변경요청 상태로 처리
			 */
//			if(compareDate(user.getChangeDtPassword(), 60)){ 
//				Parameter param = DataUtil.makeParameter();
//				param.set("loginYn", "N");
//				param.set("status", LoginStatusCd.EXPIRE_PASSWORD.getCode());
//				param.set("loginId", user.getLoginId());
//				
//				loginDAO.updateLoginStatus(param);
//			    result.setLoginResultType(LoginResultType.EXPIRE_PASSWORD);
//				
//				return result;
//			}
			
			/**
			 * 미접속기간초과 30일이상 미접속 계정을 블럭처리
			 */
//			if(compareDate(user.getLastLoginDt(), 30)){ //
//				Parameter param = DataUtil.makeParameter();
//				param.set("loginYn", "N");
//				param.set("status", LoginStatusCd.PERIOD_NOT_EXCEEDING_ONLINE.getCode());
//				param.set("loginId", user.getLoginId());
//				
//				loginDAO.updateLoginStatus(param);
//				result.setLoginResultType(LoginResultType.PERIOD_NOT_EXCEEDING_ONLINE);
//				
//				return result;
//			}
			
			// 패스워드 일치여부 체크
			if(user.getPassword().equals(password)){
				
				if(compareDate(user.getChangeDtPassword(),50)){ // 패스워드 변경기간 50일~60일
					result.setLoginResultType(LoginResultType.EXPIRE_PASSWORD_WARRING);
				}else{
					result.setLoginResultType(LoginResultType.SUCCESS);
				}

				// 로그인 세션 관리자에 로그인 처리 요청
				UserContainer userContainer = super.loginForSessionManager(request, response, user, true);

				// 로그인 정상처리시 정보 업데이트
				loginDAO.updateLoginInfoForSuccess(userContainer);
				
				result.setUserData(makeUserData(user));
				
				return result; 
			}else{
				loginDAO.updaePwdFailCount(parameter);
				if(user.getLoginFailCnt()>=5){
					Parameter param = DataUtil.makeParameter();
					param.set("loginYn", "N");
					param.set("status", LoginStatusCd.OVERFLOW_FAIL_PASSWORD.getCode());
					param.set("loginId", user.getLoginId());
					
					loginDAO.updateLoginStatus(param);
				    result.setLoginResultType(LoginResultType.MAX_FAIL_PASSWD);
				    
				}else{
					result.setLoginResultType(LoginResultType.NO_MATCHED_PASSWD);
				}
				
				return result;
			}
		}else{

			if(user.getLoginStatusCd() == LoginStatusCd.NORMAL){
				result.setLoginResultType(LoginResultType.UNDEFINED);
			
			}else if(user.getLoginStatusCd() == LoginStatusCd.ACCOUNT_LOCK_TERMINATE_REJECT){
				result.setLoginResultType(LoginResultType.ACCOUNT_LOCK_TERMINATE_REJECT);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.ACCOUNT_LOCK_TERMINATE_REGIST){
				result.setLoginResultType(LoginResultType.ACCOUNT_LOCK_TERMINATE_REGIST);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.EXPIRE_PASSWORD){
				result.setLoginResultType(LoginResultType.EXPIRE_PASSWORD);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.OVERFLOW_FAIL_PASSWORD){
				result.setLoginResultType(LoginResultType.MAX_FAIL_PASSWD);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.PERIOD_NOT_EXCEEDING_ONLINE){
				result.setLoginResultType(LoginResultType.PERIOD_NOT_EXCEEDING_ONLINE);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.RETIREE){
				result.setLoginResultType(LoginResultType.RETIREE);
				
			}else{
				
				result.setLoginResultType(LoginResultType.UNDEFINED);
				
			}
			return result;
		}
		
		
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @param loginId
	 * @return
	 */
	public LoginResult loginForSso(HttpServletRequest request, HttpServletResponse response, String loginId) {
		
		LoginResult result = new LoginResult();
		
		String loginIP = HttpUtils.getRemoteAddr(request);
		
		// 1.결과정보에 로그인ID와 IP를 셋팅
		result.setLoginId(loginId);
		result.setLoginIP(loginIP);
		
		// 2.로그인ID에 해당하는 사용자 정보 조회
		VocUser user = getLoginUserInfo(loginId);
		
		// 3.사용자가 없는 경우의 오류 처리
		if(user == null){
			result.setLoginResultType(LoginResultType.NOT_EXISTS_LOGIN_ID);
		}
		
		// 4.로그인이 가능한 사용자인 경우
		if(user.isLoginYn()){
			
			// 4.1. 파싱된 SSO 데이터를 생성 (JSP에서 파싱된 데이터를 로딩함)
			SsoData ssoData = (SsoData) request.getSession().getAttribute("SSO_DATA");
			if(ssoData != null){
				// 4.2. 사용자 객체에 SSO 정보를 셋팅함
				user.setSso(ssoData);
			}
			
			// 로그인 세션 관리자에 로그인 처리 요청
			UserContainer userContainer = super.loginForSessionManager(request, response, user, true);

			// 로그인 정상처리시 정보 업데이트
			loginDAO.updateLoginInfoForSuccess(userContainer);
			
			result.setLoginResultType(LoginResultType.SUCCESS);
			return result; 
		
		}else{

			if(user.getLoginStatusCd() == LoginStatusCd.NORMAL){
				result.setLoginResultType(LoginResultType.UNDEFINED);
			
			}else if(user.getLoginStatusCd() == LoginStatusCd.ACCOUNT_LOCK_TERMINATE_REJECT){
				result.setLoginResultType(LoginResultType.ACCOUNT_LOCK_TERMINATE_REJECT);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.ACCOUNT_LOCK_TERMINATE_REGIST){
				result.setLoginResultType(LoginResultType.ACCOUNT_LOCK_TERMINATE_REGIST);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.EXPIRE_PASSWORD){
				result.setLoginResultType(LoginResultType.EXPIRE_PASSWORD);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.OVERFLOW_FAIL_PASSWORD){
				result.setLoginResultType(LoginResultType.MAX_FAIL_PASSWD);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.PERIOD_NOT_EXCEEDING_ONLINE){
				result.setLoginResultType(LoginResultType.PERIOD_NOT_EXCEEDING_ONLINE);
				
			}else if(user.getLoginStatusCd() == LoginStatusCd.RETIREE){
				result.setLoginResultType(LoginResultType.RETIREE);
				
			}else{
				result.setLoginResultType(LoginResultType.UNDEFINED);
				
			}
			return result;
		}
	}
	
	private boolean compareDate(Timestamp inputDt , int validDays) {
		boolean returnbl  = false;
		if(inputDt != null){
			Date date= new Date();
			Timestamp currentDt = new Timestamp(date.getTime());
			long gapDays = (currentDt.getTime() - inputDt.getTime()) / 1000 / 60 / 60 / 24;
			
			returnbl  = gapDays > validDays;	
		}
		
		return returnbl;
	}
	
	/**
	 * 로그인 세션에 추가할 사용자 인스턴스를 생성하는 함수
	 * @param loginId 로그인ID
	 * @return User Instance
	 */
	public VocUser getLoginUserInfo(String loginId){

		// 로그인 ID에 해당하는 사용자 정보 조회
		DataList dlLogin = loginDAO.getLoginInfo(loginId);
		if(dlLogin.getRowCount() == 0){
			return null;
		}
		
		return createUser(dlLogin);
	}
	
	/**
	 * User 객체를 생성하는 함수
	 * @param dlLogin 로그인 데이터 리스트
	 * @return User Instance
	 */
	private VocUser createUser(DataList dlLogin){
		
		//---------------------------------------------------------------------------
		// 1. Framework 내에서 사용될 사용자 기본 정보 등록
		//---------------------------------------------------------------------------
		UserBuilder builder = new UserBuilder();
		builder.setId(dlLogin.getString(0, "USER_ID"));
		builder.setName(dlLogin.getString(0, "USER_NM"));
		
		builder.setLoginId(dlLogin.getString(0, "LOGIN_ID"));
		builder.setPassword(dlLogin.getString(0, "PASSWD"));
		
		builder.setPartCode(dlLogin.getString(0, "DEPT_ID"));
		builder.setPartName(dlLogin.getString(0, "DEPT_NM"));
		
		builder.setEmail(dlLogin.getString(0, "EMAIL_DS"));
		builder.setLanguageCode(dlLogin.getString(0, "LANG_CD"));

		//---------------------------------------------------------------------------
		// 2. 권한 정보 추가
		//---------------------------------------------------------------------------
		super.setRoleInfo(builder);
		
		//---------------------------------------------------------------------------
		// 3. Voc 사용자 정보 설정
		//---------------------------------------------------------------------------
		VocUser user = new VocUser(builder);
		user.setChangeDtPassword(dlLogin.getString(0, "CHNG_DT_PASSWD"));
		user.setBeforePassword(dlLogin.getString(0, "BEF_PASSWD"));
		user.setLoginYn(dlLogin.getString(0, "LOGIN_YN"));
		user.setLoginStatusCd(dlLogin.getString(0, "STATUS"));
		user.setLastLoginIp(dlLogin.getString(0, "LOGIN_IP"));
		user.setLastLoginDt(dlLogin.getString(0, "LOGIN_DT"));
		user.setDeptIdUp(dlLogin.getString(0,"DEPT_ID_UP"));
		user.setDutyCode(dlLogin.getString(0,"DUTY_CD"));
		user.setCdBranch(dlLogin.getString(0,"CD_BRANCH"));
		user.setNmBranch(dlLogin.getString(0,"NM_BRANCH"));
		user.setLoginFailCnt(Integer.parseInt(dlLogin.getString(0, "LOGIN_FAIL_CNT")));
		user.setCompanyCd(dlLogin.getString(0,"COMPANY_CD"));				// 회사코드

		//---------------------------------------------------------------------------
		// 4. 계정요청 정보 조회
		//---------------------------------------------------------------------------
		DataList dlAccountRequestStatus = accountManageDAO.getAccountRequestStatus(user.getLoginId());
		
		if(dlAccountRequestStatus != null && dlAccountRequestStatus.getRowCount() != 0){
			user.setAccountReqType(dlAccountRequestStatus.getString(0, "REQ_TYPE"));
			user.setAccountApprStatusCd(dlAccountRequestStatus.getString(0, "APPR_STATUS"));	
		}

		return user;
	}

	/**
	 * 
	 * @param loginToken
	 * @return
	 */
	public UserContainer getUserContainerByToken(HttpServletRequest request, HttpServletResponse response, String loginToken) {

		// 로그인 ID에 해당하는 사용자 정보 조회
		String loginIp = HttpUtils.getRemoteAddr(request);
		DataList dlLogin = loginDAO.getLoginInfoByLoginToken(loginToken, loginIp);
		if(dlLogin.getRowCount() == 0){
			return null;
		}
		
		// Voc User 생성
		VocUser user = createUser(dlLogin);
		
		// 로그인 세션 관리자에 로그인 처리 요청
		return super.loginForSessionManager(request, response, user, false);
	}

	/**
	 * 토큰의 유효성을 체크 하는 함수
	 * @param request
	 * @param response
	 * @param loginToken
	 * @return
	 */
	public boolean isValidToken(HttpServletRequest request, HttpServletResponse response, String loginToken) {
		
		// 로그인 ID에 해당하는 사용자 정보 조회
		String loginIp = HttpUtils.getRemoteAddr(request);
		DataList dlLogin = loginDAO.getLoginInfoByLoginToken(loginToken, loginIp);
		return (dlLogin.getRowCount() > 0);
	}
	
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
	
	private JSONObject makeUserData(VocUser user) {
		JSONObject userData = new JSONObject();
		JSONArray rolesArray = new JSONArray();
		
		for (int i = 0; i < user.getRoles().length; i++) {
			rolesArray.put(user.getRoles()[i]);
		}
		
		try {
			userData.put("USER_ID"			, user.getLoginId());
			userData.put("USER_NM"			, URLEncoder.encode(user.getName(), "UTF-8"));
			userData.put("PART_CODE"		, user.getPartCode());
			userData.put("PART_NAME"		, URLEncoder.encode(user.getPartName(), "UTF-8"));
			userData.put("LAST_LOGIN_DT"	, user.getLastLoginDt());
			userData.put("USER_EMAIL"		, user.getEmail());
			userData.put("MAX_ROLE"			, user.getMaxRole());
			userData.put("MIN_ROLE"			, user.getMinRole());
			userData.put("ROLES"			, rolesArray);
		} catch (JSONException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return userData;
	}

}