package com.ubone.standard.login.domain;


/** 
 * <pre>
 *  파 일 명 : LoginResultType.java
 *  설    명 : 로그인 결과유형 정의 Enum 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2013.12.31
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public enum LoginResultType {
	  SUCCESS("00")					// 정상로그인
	, NOT_EXISTS_LOGIN_ID("01")		// 로그인ID 미존재
	, NO_MATCHED_PASSWD("02")		// 패스워드 불일치
	, MAX_FAIL_PASSWD("03")			// 패스워드 실패 허용횟수 초과
	
	, ACCOUNT_NEW_REGIST("20")		// 신규 계정 등록중
	, ACCOUNT_NEW_REJECT("21")		// 신규 계정 등록 반려
	, ACCOUNT_NEW_OK("22")			// 신규 계정 등록 승인
	
	, ACCOUNT_LOCK_TERMINATE_OK("10")		// 정지계정해지 승인
	, ACCOUNT_LOCK_TERMINATE_REJECT("11")	// 정지계정해지 반려
	, ACCOUNT_LOCK_TERMINATE_REGIST("12")	// 정지계정해지 신청중
	
	, IP_ACCESS_DENIED("30")		// 접근IP 제한
	
	, LOCKED_LOGIN_ID("40")			// 로그인 계정 잠김 상태
	, HOLDED_LOGIN_ID("41")			// 로그인 계정 중지 상태
	
	, DUPLICATE_LOGIN("50")			// 현재 사용자 계정이 사용중 (중복로그인)
	, EXPIRE_PASSWORD("60")			// 패스워드 만료
	, EXPIRE_PASSWORD_WARRING("61")	   // 패스워드 만료 경고
	, NO_PERMISSION("70")			// 사용자의 권한 할당이 없을 경우
	, PERIOD_NOT_EXCEEDING_ONLINE("80") // 미접속기간 초과 
	, RETIREE("90")					// 퇴사자 상태
	, EXPIRE_SMS_AUTH("95")		// SMS 인증기간 초과
	
	, UNDEFINED("X");
	;
	
	private String code;
	
	private LoginResultType(String code) {
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
	public static LoginResultType valueOfCode(String code) {
		for(LoginResultType element : LoginResultType.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return LoginResultType.UNDEFINED;
	}
}
