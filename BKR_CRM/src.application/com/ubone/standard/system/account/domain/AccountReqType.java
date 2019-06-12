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
public enum AccountReqType {
	
	// 신규 계정 등록 신청
	NEW_REGIST_REQ("10")		
	 // 정지계정해지 신청
	, LOCK_TERMINATE_REQ("20")	
	// 비밀번호 초기화
	, PASSWORD_INIT("30")      
	//승인
	, PROC_ASSIGN_DONE("ASSN") 
	//거절
	, PROC_REJECT_DONE("RJCT") 
	, UNDEFINED("X");
	
	private String code;
	
	private AccountReqType(String code) {
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
	public static AccountReqType valueOfCode(String code) {
		for(AccountReqType element : AccountReqType.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return AccountReqType.UNDEFINED;
	}
}
