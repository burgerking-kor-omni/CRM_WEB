package com.ubone.standard.system.account.service;

import java.util.Random;

import javax.annotation.Resource;

import org.hsqldb.lib.StringUtil;
import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.standard.login.dao.LoginDAO;
import com.ubone.standard.login.domain.LoginStatusCd;
import com.ubone.standard.mail.MailSender;
import com.ubone.standard.system.account.dao.AccountManageDAO;
import com.ubone.standard.system.account.domain.AccountReqResultCode;
import com.ubone.standard.system.account.domain.AccountReqType;
import com.ubone.standard.system.user.dao.UserManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : AccountManageSO.java
 *  설    명 : 계정 관리
 *  작 성 자 : 김태완
 *  작 성 일 : 2014. 4. 18.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
@Service
public class AccountManageSO {
	
	private static final String INCUMBENT_CD = "INCUMBENT_CD";
	private static final String STATUS_LOWER = "status";
	private static final String REQ_TYPE2 = "REQ_TYPE";
	private static final String LOGIN_YN_LOWER = "loginYn";
	private static final String LOGIN_ID_LOWER = "loginId";
	private static final String LOGIN_ID = "LOGIN_ID";
	private static final String APPR_STATUS = "APPR_STATUS";
	private static final String STATUS = "STATUS";
	private static final String LOGIN_YN = "LOGIN_YN";
	private static final String EMAIL_DS = "EMAIL_DS";
	private static final String USER_NM = "USER_NM";
	private static final String USER_ID = "USER_ID";
	private static final String MOBILE_NO = "MOBILE_NO";
	private static final String EMAIL_DS_2 = "EMAIL_DS_2";
	private static final String EMAIL_DS_1 = "EMAIL_DS_1";
	private static final String MOBILE_NO_3 = "MOBILE_NO_3";
	private static final String MOBILE_NO_2 = "MOBILE_NO_2";
	private static final String MOBILE_NO_1 = "MOBILE_NO_1";
	
	@Resource 
	private AccountManageDAO accountManageDAO;
	@Resource 
	private LoginDAO loginDAO;
	@Resource
	private UserManageInquiryDAO userManageInquiryDAO;
	
	
	/**
	 * 계정 중복체크
	 * @param parameter
	 * @return
	 */
	public DataList duplicateCheck(Parameter parameter){
		return accountManageDAO.selectDuplicate(parameter);
	}
	
	/**
	 * 계정 중복체크(롯데닷컴)
	 * @param parameter
	 * @return
	 */
	public DataList loginIdCheck(Parameter parameter){
		return accountManageDAO.selectLoginId(parameter);
	}
	
	/**
	 * 전화번호 체크
	 * @param parameter
	 * @return
	 */
	public DataList mobPhoneCheck(Parameter parameter){
		String mobNum = parameter.get(MOBILE_NO_1)+parameter.get(MOBILE_NO_2)+parameter.get(MOBILE_NO_3);
		parameter.setParameter(MOBILE_NO, mobNum);
		
		return accountManageDAO.selectMobPhone(parameter);
	}
	
	/**
	 * 이메일 체크
	 * @param parameter
	 * @return
	 */
	public DataList emailCheck(Parameter parameter){
		String email = parameter.get(EMAIL_DS_1)+"@"+parameter.get(EMAIL_DS_2);
		parameter.setParameter(EMAIL_DS, email);
	
		return accountManageDAO.selectEmail(parameter);
	}
	
	/**
	 * 사용자 신청(롯데닷컴용)
	 * @param parameter
	 * @return
	 */
	public String createAccounteReq(Parameter parameter){
		String mobNum = parameter.get(MOBILE_NO_1)+parameter.get(MOBILE_NO_2)+parameter.get(MOBILE_NO_3);
		String email = parameter.get(EMAIL_DS_1)+"@"+parameter.get(EMAIL_DS_2);
		String result = "";
		parameter.setParameter(MOBILE_NO, mobNum);
		parameter.setParameter(EMAIL_DS, email);
		parameter.setParameter("PASSWD", (String)parameter.getParameter("PASSWD"));
		
		result = accountManageDAO.insertAccountRequest(parameter);
		
		// 로그인정보 상태값 변경
		Parameter param = DataUtil.makeParameter();
		param.set(LOGIN_YN_LOWER, "N");
		param.set(STATUS_LOWER, LoginStatusCd.ACCOUNT_LOCK_TERMINATE_REGIST.getCode());
		param.set(LOGIN_ID_LOWER, parameter.get(LOGIN_ID));
		loginDAO.updateLoginStatus(param);
		
		// 유저정보 코드 변경
		param.set(INCUMBENT_CD, "R");
		//param.set("beforeIncumbent", "E");
		accountManageDAO.updateUserIncumbent(param);

		return result;
	}
	
	/**
	 * 계정신청 등록
	 * @param parameter
	 * @return String ( "01" : 신청완료 , "02" : 기신청중 , "03" : 로그인계정보유중 )
	 */
	public String insertAccountRequest(Parameter parameter){
		
		String result = "-1";
		String reqType = parameter.getValue(REQ_TYPE2);
		
		if(AccountReqType.NEW_REGIST_REQ.getCode().equals(reqType)){//신규요청
			result = newAccountRegist(parameter); 
			
		}else if(AccountReqType.LOCK_TERMINATE_REQ.getCode().equals(reqType)){//계정잠금해제요청
			
			result = accountRelease(parameter);
		}
		
		return result;
	}

	/**
	 * 계정잠금 해제 신청
	 * @param parameter
	 * @return
	 */
	private String accountRelease(Parameter parameter) {
		AccountReqResultCode result =  AccountReqResultCode.UNDEFINED;
		//로그인정보조회
		
		DataList loginInfo = loginDAO.getLoginInfo(parameter.getValue(LOGIN_ID));
		
		String loginYn = "N"; 
		String loginStatusCd = "00";
		if(loginInfo != null && loginInfo.getRowCount() != 0){
			loginYn = loginInfo.get(0, LOGIN_YN);
			loginStatusCd = loginInfo.get(0, STATUS);
		}
		
		if("Y".equals(loginYn)){
			result = AccountReqResultCode.NORMAL;
		}else{
		    
			if(LoginStatusCd.ACCOUNT_LOCK_TERMINATE_OK.getCode().equals(loginStatusCd)){
				
				result = AccountReqResultCode.RELEASE_LOCK_REQ_PROC_ING;
				
			}else{
				//잠금해제신청
				accountManageDAO.insertAccountRequest(parameter);
				
				result = AccountReqResultCode.RELEASE_LOCK_REQ_REGIST;
			}
		}
		return ResultUtils.makeResultForMessage(result.getResultMessagekey());
	}

	private String newAccountRegist(Parameter parameter) {
		AccountReqResultCode result =AccountReqResultCode.UNDEFINED;
		
		//계정신청조회
		parameter.setParameter(APPR_STATUS, "REQ");
		DataList accountRequestDetail = accountManageDAO.getAccountRequestDetail(parameter);
		
		if(accountRequestDetail.getRowCount() > 0){
			if(StringUtil.isEmpty(accountRequestDetail.getString(0, "APPR_DT"))){ //요청처리중
				result = AccountReqResultCode.NEW_REQ_PROC_ING;
			}else{ //요청처리완료
				result = AccountReqResultCode.NEW_REQ_PROC_DONE;
			}	
		}else{
			accountManageDAO.insertAccountRequest(parameter);
			result = AccountReqResultCode.NEW_REQ_REGIST;
		}
		return ResultUtils.makeResultForMessage(result.getResultMessagekey());
	}
	
	/**
	 * 계정신청 목록 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectAccountRequest(Parameter parameter){
		 return accountManageDAO.selectAccountRequest(parameter); 
	}
	
	
	/**
	 * 계정신청 상세 조회
	 * @param parameter
	 * @return 
	 */
	public DataList getAccountRequestDetail(Parameter parameter){
		 return accountManageDAO.getAccountRequestDetail(parameter); 
	}
	
	/**
	 * 신청 목록 조회
	 * @param parameter
	 * @return 
	 */
	public DataList getAccountRequestList(Parameter parameter){
		 return accountManageDAO.getAccountRequestList(parameter); 
	}
	
	
	/**
	 * 계정신청 승인/반려 처리
	 * @param parameter
	 * @return 
	 */
	public String decisionAccountRequest(Parameter parameter){
		
		AccountReqResultCode result = AccountReqResultCode.UNDEFINED;

		String LOGIN_ID_UPPERCASE = parameter.getValue(LOGIN_ID);
		
		DataList accountRequestDetail = accountManageDAO.getAccountRequestDetail(parameter);
		String REQ_TYPE = accountRequestDetail.getString(0, REQ_TYPE2);
		
		parameter.setParameter(USER_ID, accountRequestDetail.getString(0, LOGIN_ID));
		parameter.setParameter(LOGIN_ID, accountRequestDetail.getString(0, LOGIN_ID));
		parameter.setParameter("PASSWD", accountRequestDetail.getString(0, "PASSWD"));
		parameter.setParameter(USER_NM, accountRequestDetail.getString(0, USER_NM));
		parameter.setParameter(MOBILE_NO, accountRequestDetail.getString(0, MOBILE_NO));
		parameter.setParameter(EMAIL_DS, accountRequestDetail.getString(0, EMAIL_DS));
		
		Parameter makeUserAddedParameter = DataUtil.makeUserAddedParameter(parameter);
		if(AccountReqType.NEW_REGIST_REQ.getCode().equals(REQ_TYPE)){//신규계정신청
			
			if("OK".equals( parameter.getValue(STATUS))){ //승인

				//사용자등록
				String userId = userManageInquiryDAO.insertUser(makeUserAddedParameter);
				
				//로그인정보 등록
				makeUserAddedParameter.setParameter(USER_ID, userId);
				makeUserAddedParameter.setParameter(LOGIN_YN, "Y");
				makeUserAddedParameter.setParameter(STATUS, LoginStatusCd.NORMAL.getCode());
				loginDAO.insertLoginInfo(makeUserAddedParameter);
				
				//신규계정신청 상태 변경(정상)
				parameter.setParameter(APPR_STATUS, AccountReqType.PROC_ASSIGN_DONE.getCode());
				accountManageDAO.updateAccountRequestStatus(makeUserAddedParameter);
				
				result = AccountReqResultCode.NEW_REQ_PROC_DONE;
				
				
			}else if("NO".equals( parameter.getValue(STATUS))){//반려
				//계정요청정보 수정 (정상)
				parameter.setParameter(APPR_STATUS, AccountReqType.PROC_REJECT_DONE.getCode());
				accountManageDAO.updateAccountRequestStatus(makeUserAddedParameter);
				
				result = AccountReqResultCode.NEW_REQ_PROC_DONE;
				
			}
			
		}else if(AccountReqType.LOCK_TERMINATE_REQ.getCode().equals(REQ_TYPE)){//계정정지해제신청
			
			if("OK".equals( parameter.getValue(STATUS))){ //승인
				//로그인 정보 수정
				Parameter userAddedParameter = DataUtil.makeUserAddedParameter();
				userAddedParameter.setParameter(LOGIN_YN_LOWER, "Y");
				userAddedParameter.setParameter(STATUS_LOWER, LoginStatusCd.ACCOUNT_LOCK_TERMINATE_OK.getCode());
				userAddedParameter.setParameter(LOGIN_ID_LOWER, LOGIN_ID_UPPERCASE);
				loginDAO.updateLoginStatus(userAddedParameter);

				//계정요청정보 수정 (승인)
				parameter.setParameter(APPR_STATUS, AccountReqType.PROC_ASSIGN_DONE.getCode());
				accountManageDAO.updateAccountRequestStatus(makeUserAddedParameter);
				
				result = AccountReqResultCode.RELEASE_LOCK_REQ_PROC_DONE;
				
				
			}else if("NO".equals( parameter.getValue(STATUS))){//반려
				//계정요청정보 수정 (반려)
				parameter.setParameter(APPR_STATUS, AccountReqType.PROC_REJECT_DONE.getCode());
				accountManageDAO.updateAccountRequestStatus(makeUserAddedParameter);
				
				result = AccountReqResultCode.RELEASE_LOCK_REQ_PROC_DONE;
				
			}
		}
		
		return ResultUtils.makeResultForMessage(result.getResultMessagekey());
	}
	
	public String findID(Parameter parameter){
		AccountReqResultCode returnStr = AccountReqResultCode.NORMAL;

		DataList userInfo = accountManageDAO.findUserInfo(parameter);
		
		if(userInfo.getRowCount() > 0 ){
			String pEmail = parameter.getValue(EMAIL_DS);
			if(pEmail != null && pEmail.equals(userInfo.get(0, EMAIL_DS)) ){

				//메일발송.
				MailSender sender = new MailSender();
				
				String title = "VOC 로그인ID 입니다.";
				String content =  " VOC 로그인ID는 [ " + userInfo.getString(0, LOGIN_ID) +" ] 입니다." ;
				String fromEmail = "김태완 <tantluskim@gmail.com>";
				
				String toEmail = userInfo.getString(0, USER_NM) + " <"+pEmail+">";
				
				sender.sendMail( fromEmail , toEmail , title , content );
				
				returnStr = AccountReqResultCode.SEND_MAIL;
				
			}else{
				returnStr = AccountReqResultCode.MAIL_MISMATCH;
			}
		}else{
			returnStr = AccountReqResultCode.UNREGISTERED_USER;
		}
		
		return ResultUtils.makeResultForMessage(returnStr.getResultMessagekey());
	}
	
	
	
	public String passWdInit(Parameter parameter){
		AccountReqResultCode returnStr = AccountReqResultCode.NORMAL;

		DataList userInfo = accountManageDAO.findUserInfo(parameter);
		
		if(userInfo.getRowCount() > 0 ){
			String pEmail = parameter.getValue(EMAIL_DS);
			
			if(pEmail != null && pEmail.equals(userInfo.get(0, EMAIL_DS)) ){
				
				//비밀번호 초기화
				String initPasswd = makeInitPasswd();
				String LOGIN_ID_LOWERCASE = userInfo.getString(0, LOGIN_ID);
				
				Parameter makeUserAddedParameter = DataUtil.makeUserAddedParameter();
				makeUserAddedParameter.setParameter(LOGIN_ID, LOGIN_ID_LOWERCASE);
				makeUserAddedParameter.setParameter("PASSWD", initPasswd);
				
				accountManageDAO.updatePassWord(makeUserAddedParameter);

				//메일발송.
				MailSender sender = new MailSender();
				
				String title = "VOC 로그인 비밀번호 초기화 메일 입니다.";
				String content =  " 로그인 비밀번호는 [ " + initPasswd +" ] 입니다." ;
				String fromEmail = "VOC담당자 <voc@ubqone.com>";
				
				String toEmail = userInfo.getString(0, USER_NM) + " <"+pEmail+">";
				
				sender.sendMail( fromEmail , toEmail , title , content );
				
				returnStr = AccountReqResultCode.SEND_MAIL;
				
			}else{
				returnStr = AccountReqResultCode.MAIL_MISMATCH;
			}
		}else{
			returnStr = AccountReqResultCode.UNREGISTERED_USER;
		}
		
		return ResultUtils.makeResultForMessage(returnStr.getResultMessagekey());
	}

	private String makeInitPasswd() {
		Random random = new Random();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < 10; i++) {
			if (random.nextBoolean()) {
				sb.append(String.valueOf((char) ((int) (random.nextInt(26)) + 97)));
			} else {
				sb.append(random.nextInt(10));
			}
		}

		String initPasswd= sb.toString();
		return initPasswd;
	}
	
	public int updateAccountRequest(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		int result = 0;
		DataList acccountRequest = null;
				
		String incumbentUser = parameter.getValue(INCUMBENT_CD);
		
		acccountRequest = accountManageDAO.getAccountRequestList(parameter);
		// 사용자 로그인정보 조회
		DataList userInfo = loginDAO.getLoginInfo(acccountRequest.getString(0, LOGIN_ID));

		if(acccountRequest.size()>0){
			parameter.setParameter(USER_NM, acccountRequest.getString(0, USER_NM));
			parameter.setParameter(MOBILE_NO, acccountRequest.getString(0, MOBILE_NO));
			parameter.setParameter(EMAIL_DS, acccountRequest.getString(0, EMAIL_DS));
			parameter.setParameter(USER_ID, acccountRequest.getString(0, USER_ID));
			parameter.setParameter("PASSWD", acccountRequest.getString(0, "PASSWD"));	
		}
		
		// 로그인정보 유무에 대한 처리
		if(userInfo.size() >0){
			loginDAO.updateLoginInfo(parameter);		
		}else{
			try {
				loginDAO.insertLoginInfo(parameter);	
			} catch (Exception e) {
				return 123123;
			}	
		}
		
		// 사용자정보 업데이트 및 승인처리
		if("E".equals(incumbentUser)){
			result = accountManageDAO.updateAccountReq(parameter);			
		}else{
			result = accountManageDAO.updateAccountReq(parameter);
			accountManageDAO.updateUserInfo(parameter);			
		}

		//권한 재등록
		loginDAO.deleteApRoleCompstion(parameter);	
		loginDAO.insertApRoleCompostion(parameter);

		
		return result;		
	}
	
	public int updateAccountReturn(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		int result = 0;
		
		result = accountManageDAO.updateAccountReturn(parameter);
		
		if(result != 0){
			// 로그인 상태값 변경
			Parameter param = DataUtil.makeParameter();
			param.set(LOGIN_YN_LOWER, "N");
			param.set(STATUS_LOWER, LoginStatusCd.ACCOUNT_LOCK_TERMINATE_REJECT.getCode());
			param.set(LOGIN_ID_LOWER, parameter.get(LOGIN_ID));
			loginDAO.updateLoginStatus(param);
			
			DataList sysUserDetail = userManageInquiryDAO.getSysUserDetail(param);
			// 유저정보 코드 변경
			if(sysUserDetail.get(MOBILE_NO).equals(null) && sysUserDetail.get(EMAIL_DS).equals(null)){
				param.set(INCUMBENT_CD, "N");
			}else{
				param.set(INCUMBENT_CD, "E");
			}
			
			//param.set("beforeIncumbent", "R");
			accountManageDAO.updateUserIncumbent(param);
		}
	
		return result;
	}
	 
}
