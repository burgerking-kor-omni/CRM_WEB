package com.ubone.standard.system.message;

import com.ubone.framework.engine.CodeEnum;
import com.ubone.framework.util.code.Code;

/** 
 * <pre>
 *  설    명 : 발송자 유형
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public enum SenderType implements CodeEnum {
	System("01", "시스템"),
	Employee("02", "직원"),
	Worker("03", "업무담당자"),
	EventSourceUser("04", "실행 직원");
	
	private String code;
	private String description;
	
	private SenderType(String code, String description) {
		this.code = code;
		this.description = description;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getCode()
	 */
	public String getCode() {
		return code;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getDescription()
	 */
	public String getDescription() {
		return description;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getParentCode()
	 */
	public String getParentCode() {
		return "";
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getStatus()
	 */
	public String getStatus() {
		return Code.ACTIVITY_STATUS_CODE;
	}
	
	/**
	 * 코드로 부터 가져오기
	 * @param code
	 * @return SenderType
	 */
	public static SenderType valueOfCode(String code) {
		for(SenderType element : SenderType.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return System;
	}
}