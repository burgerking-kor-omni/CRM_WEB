package com.ubone.standard.login.domain;

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
public enum LoginStatusCd {
	
	  NORMAL("00")							// 정상로그인
	  
	, ACCOUNT_LOCK_TERMINATE_OK("10")		// 잠금해제승인
	, ACCOUNT_LOCK_TERMINATE_REJECT("11")	// 정지계정해지 반려
	, ACCOUNT_LOCK_TERMINATE_REGIST("12")	// 정지계정해지 신청중
	
	, EXPIRE_PASSWORD("20")					// 패스워드 기간만료
	, OVERFLOW_FAIL_PASSWORD("30")			// 로그인 실패 허용횟수 초과
	, PERIOD_NOT_EXCEEDING_ONLINE("40")		// 미접속기간 초과
	, RETIREE("90")							// 퇴사자
	, EXPIRE_SMS_AUTH("95")					// SMS 인증기간 초과
	
	, UNDEFINED("X");
	;
	
	private String code;
	
	private LoginStatusCd(String code) {
		this.code = code;
	}
	
	public String getCode(){
		return this.code;
	}

	/**
	 * 코드로 부터 가져오기
	 * @param code
	 * @return LoginResultType
	 */
	public static LoginStatusCd valueOfCode(String code) {
		for(LoginStatusCd element : LoginStatusCd.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return LoginStatusCd.UNDEFINED;
	}
}
