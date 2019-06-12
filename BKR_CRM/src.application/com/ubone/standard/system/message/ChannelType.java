package com.ubone.standard.system.message;

import com.ubone.framework.engine.CodeEnum;
import com.ubone.framework.util.code.Code;

/** 
 * <pre>
 *  설    명 : 메세지 채널 유형
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public enum ChannelType implements CodeEnum {
	Email("01"),
	SMS("02"),
	Messenger("03"),
	Etc("99", Code.SLEEP_STATUS_CODE);
	
	private String code;
	private String satus;
	
	private ChannelType(String code) {
		this(code, Code.ACTIVITY_STATUS_CODE);
	}
	
	private ChannelType(String code, String satus) {
		this.code = code;
		this.satus = satus;
	}
	
	public String getCode() {
		return code;
	}

	public String getDescription() {
		return name();
	}

	public String getParentCode() {
		return null;
	}

	public String getStatus() {
		return satus;
	}
	
	public static ChannelType valueOfCode(String code) {
		for(ChannelType element : ChannelType.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return Etc;
	}
}