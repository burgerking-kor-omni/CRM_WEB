package com.ubone.standard.system.account.domain;

/** 
 * <pre>
 *  파 일 명 : LoginStatCd.java
 *  설    명 : 로그인 상태코드 정의 Enum 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2013.12.31
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public enum AccountReqResultCode {
	
	//신규 계정 신청 등록이 되었습니다.
	  NEW_REQ_REGIST("01" , "@message.common.account.result.01")   				
	//신규 계정 신청이 승인중입니다.  
	, NEW_REQ_PROC_ING("02" , "@message.common.account.result.02") 				
	//신규 계정 신청이 처리되었습니다.
	, NEW_REQ_PROC_DONE("03" , "@message.common.account.result.03")     		
	
	//계정 잠금해제 신청 등록이 되었습니다.
	, RELEASE_LOCK_REQ_REGIST("11" , "@message.common.account.result.11")   	
	//계정 잠금해제 신청이 승인중입니다.
	, RELEASE_LOCK_REQ_PROC_ING("12", "@message.common.account.result.12")      
	//계정 잠금해제 신청이 처리되었습니다.
	, RELEASE_LOCK_REQ_PROC_DONE("13" , "@message.common.account.result.13")    
	
	//로그인 가능 계정입니다.
	, NORMAL("20" , "@message.common.account.result.20")                        
	//등록되지 않은 사용자입니다.
	, UNREGISTERED_USER("30" , "@message.common.account.result.30")             
	//메일정보가 일치하지 않습니다.
	, MAIL_MISMATCH("31" , "@message.common.account.result.31")                 
	//로그인 ID가 메일로 발송되었습니다.
	, SEND_MAIL("32" , "@message.common.account.result.32")                     
	//정의되지 않은 오류입니다.
	, UNDEFINED("X" , "@message.common.account.result.x");                      

	
	private String code;
	private String resultMessagekey;
		
	private AccountReqResultCode(String code , String resultMessagekey) {
		this.code = code;
		this.resultMessagekey = resultMessagekey;
	}
	
	public String getCode(){
		return this.code;
	}
	public String getResultMessagekey(){
		return this.resultMessagekey;
	}
	/**
	 * 코드로 부터 가져오기
	 * @param code
	 * @return LoginResultType
	 */
	public static AccountReqResultCode valueOfCode(String code) {
		for(AccountReqResultCode element : AccountReqResultCode.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return AccountReqResultCode.UNDEFINED;
	}
}
