package com.ubone.standard.login.domain;

import java.sql.Timestamp;

import org.apache.commons.lang.BooleanUtils;

import com.ubone.framework.engine.domain.BasicUser;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.standard.system.account.domain.AccountReqType;

/**
 * <pre>
 *  파 일 명 : VocUser.java
 *  설    명 : VOC User Domain 객체
 *  작 성 자 : 강영운
 *  작 성 일 : 2013.12.03
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public class VocUser extends BasicUser implements User{
	
	private static final long serialVersionUID = 4468933152412310457L;

	private boolean loginYn;					// [필수]로그인 가능여부
	private LoginStatusCd loginStatusCd;		// [필수]로그인 상태코드
	private SsoData sso = new SsoData();		// [필수]SSO 정보

	/**
	 * 회사코드
	 */
	private String companyCd;
	
	/**
	 * 패스워드 변경일시
	 */
	private Timestamp changeDtPassword;
	
	/**
	 * 이전 패스워드
	 */
	private String beforePassword;
	
	/**
	 * 계정요청승인상태코드
	 */
	private String accountApprStatusCd;
	
	/**
	 * 계정요청구분코드
	 */
	private AccountReqType accountReqType;
	
	
	
	/**
	 * 최종접속일시
	 */
	private Timestamp lastLoginDt;
	
	/**
	 * 최종접속IP
	 */
	private String lastLoginIp;
	
	/**
	 * 상위부서코드
	 */
	private String deptIdUp;
	
	/**
	 * 직책코드
	 */
	private String dutyCode;
	
	/**
	 * 점정보
	 */
	private String cdBranch;
	
	/**
	 * 점정보
	 */
	private String nmBranch;
	
	/**
	 * 로그인 실패 카운트
	 */
	private int loginFailCnt;
	
	/**
	 * 로그인 횟수
	 */
	private int loginCnt;
	
	/**
	 * 이용약관 동의 일시
	 */
	private String agreeUseDt;
	
	/**
	 * 이용약관 동의여부
	 */
	private boolean isAgreeUse = false; 
	
	
	public VocUser() {
		super(new UserBuilder());
	}

	public VocUser(UserBuilder userBuilder) {
		super(userBuilder);
	}
	
	public Timestamp getChangeDtPassword() {
		return changeDtPassword;
	}

	public void setChangeDtPassword(Timestamp changeDtPassword) {
		this.changeDtPassword = changeDtPassword;
	}

	public void setChangeDtPassword(String changeDtPassword) {
		if(changeDtPassword != null && !changeDtPassword.equals("")){
			this.changeDtPassword = Timestamp.valueOf(changeDtPassword);
		}
	}
	
	public String getBeforePassword() {
		return beforePassword;
	}

	public void setBeforePassword(String beforePassword) {
		this.beforePassword = beforePassword;
	}

	public boolean isLoginYn() {
		return loginYn;
	}

	public void setLoginYn(boolean loginYn) {
		this.loginYn = loginYn;
	}

	public void setLoginYn(String loginYn) {
		if(loginYn != null && !loginYn.equals("")){
			this.loginYn = BooleanUtils.toBoolean(loginYn, "Y", "N");
		}
	}

	public LoginStatusCd getLoginStatusCd() {
		return loginStatusCd;
	}

	public void setLoginStatusCd(LoginStatusCd loginStatusCd) {
		this.loginStatusCd = loginStatusCd;
	}

	public void setLoginStatusCd(String loginStatusCd) {
		this.loginStatusCd =LoginStatusCd.valueOfCode(loginStatusCd);
	}
	

	public void setAccountApprStatusCd(String accountApprStatusCd) {
		this.accountApprStatusCd = accountApprStatusCd;
	}
	
	public Timestamp getLastLoginDt() {
		return lastLoginDt;
	}

	public void setLastLoginDt(Timestamp lastLoginDt) {
		this.lastLoginDt = lastLoginDt;
	}

	public void setLastLoginDt(String lastLoginDt) {
		if(lastLoginDt != null && !lastLoginDt.equals("")){
			this.lastLoginDt = Timestamp.valueOf(lastLoginDt);
		}
	}	
	
	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	
	public AccountReqType getAccountReqType() {
		return accountReqType;
	}
	
	public void setAccountReqType(AccountReqType accountReqType) {
		this.accountReqType = accountReqType;
	}
	
	public void setAccountReqType(String accountReqType) {
		this.accountReqType =AccountReqType.valueOfCode(accountReqType);
	}
	
	public String getAccountApprStatusCd() {
		return accountApprStatusCd;
	}

	public void setDeptIdUp(String deptIdUp) {
		this.deptIdUp= deptIdUp;
	}
	
	public String getDutyCode() {
		return dutyCode;
	}
	
	public void setDutyCode(String dutyCode) {
		this.dutyCode= dutyCode;
	}

	public String getCdBranch() {
		return cdBranch;
	}
	
	public void setCdBranch(String cdBranch) {
		this.cdBranch =cdBranch;
		
	}
	
	public String getNmBranch() {
		return nmBranch;
	}
	
	public void setNmBranch(String nmBranch) {
		this.nmBranch =nmBranch;
		
	}

	public int getLoginFailCnt() {
		return loginFailCnt;
	}

	public void setLoginFailCnt(int loginFailCnt) {
		this.loginFailCnt = loginFailCnt;
	}

	public int getLoginCnt() {
		return loginCnt;
	}

	public void setLoginCnt(int loginCnt) {
		this.loginCnt = loginCnt;
	}
	
	/**
	 * @return the sso
	 */
	public SsoData getSso() {
		return sso;
	}

	/**
	 * @param sso the sso to set
	 */
	public void setSso(SsoData sso) {
		this.sso = sso;
	}

	public String getCompanyCd() {
		return companyCd;
	}

	public void setCompanyCd(String companyCd) {
		this.companyCd = companyCd;
	}

	public String getAgreeUseDt() {
		return agreeUseDt;
	}

	public void setAgreeUseDt(String agreeUseDt) {
		this.agreeUseDt = agreeUseDt;
	}

	public boolean isAgreeUse() {
		return isAgreeUse;
	}

	public void setAgreeUse(String agreeUse) {
		if(agreeUse != null && !agreeUse.equals("")){
			this.isAgreeUse = BooleanUtils.toBoolean(agreeUse, "Y", "N");
		}
	}
	
}
