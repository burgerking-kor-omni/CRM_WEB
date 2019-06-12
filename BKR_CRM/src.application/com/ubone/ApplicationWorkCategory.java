package com.ubone;

import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.util.code.Code;

/** 
 * <pre>
 *  설    명 : VOC 업무 유형 Enum
 *  작 성 자 : 임경철
 *  작 성 일 : 2011.01.25
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public enum ApplicationWorkCategory implements WorkCategory {
	
	/**
	 * VOC
	 */
	VOC("VOC", Code.ACTIVITY_STATUS_CODE, "TBS_VOC_DIST", "ID_VOC", "ID_SUB_VOC"), 
	
	
	
	/**
	 * 요청관리
	 */
	REQUEST("요청관리", Code.ACTIVITY_STATUS_CODE, "TBS_VOC_REQUEST", "SEQ_VOC_REQ"), 
	/**
	 * 요청관리
	 */
	APPROVAL("결재관리", Code.ACTIVITY_STATUS_CODE, "TBS_APPROVAL", "ID_APPR"), 
	
	/**
	 * 신청관리
	 */
	APPLY("신청관리", Code.ACTIVITY_STATUS_CODE, "TBS_VOC_APPLY", "SEQ_VOC_APPL"), 
	
	/**
	 * 개선과제
	 */
	ISSUE("개선", Code.ACTIVITY_STATUS_CODE, "TBS_ISSUE", "ID_ISSUE"),
	
	/**
	 * 개선활동
	 */
	ISSUEACT("개선활동", Code.ACTIVITY_STATUS_CODE, "ISSUEACT", "ID_ISSUE_ACT"), 
	
	/**
	 * 공지사항
	 */
	NOTICE("공지사항", Code.ACTIVITY_STATUS_CODE, "TBS_NOTICE", "ID_NOTICE"),
	
	/**
	 * 처리지침
	 */
	GUIDE("처리지침", Code.ACTIVITY_STATUS_CODE, "TBS_ACT_GUIDE", "ID_GUIDE_ACT"),
	
	/**
	 * BBS
	 */
	BBS("BBS", Code.ACTIVITY_STATUS_CODE, "TBS_BBS", "ID_BULLETIN"),
	
	/**
	 * EXP
	 */
	EXP("EXP", Code.ACTIVITY_STATUS_CODE, "EXP", "SCREEN_ID"),
	
	/**
	 * FAQ
	 */
	FAQ("FAQ", Code.ACTIVITY_STATUS_CODE, "SYS_FAQ", "ID_FAQ"),

	/**
	 * BOARD
	 */
	BOARD("BOARD", Code.ACTIVITY_STATUS_CODE, "SYS_BOARD_ARTICLE", "ID_BOARD", "ID_ARTICLE", "ID_SUB"),
	
	/**
	 * BOARD REPLY
	 */
	REPLY("REPLY", Code.ACTIVITY_STATUS_CODE, "SYS_BOARD_REPLY", "ID_BOARD", "ID_ARTICLE", "ID_REPLY", "ID_SUB"),
	
	/**
	 * 쿠폰관리
	 */
	COUPON("쿠폰관리", Code.ACTIVITY_STATUS_CODE, "TBS_COUPON","CD_COUPON"),
		
	/**
	 * UnDefined
	 */
	UnDefined("UnDefined", Code.SLEEP_STATUS_CODE, "UnDefined", "UnDefined");
	
	private String description;
	private String status;
	private String tableName;
	private String[] primaryKeyNames;
	
	private ApplicationWorkCategory(String description, String status, String tableName, String...primaryKeyNames) {
		this.description = description;
		this.status = status;
		this.tableName = tableName;
		this.primaryKeyNames = primaryKeyNames;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getCode()
	 */
	public String getCode() {
		return name();
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
		return status;
	}
	
	/**
	 * 업무 테이블 명 가져오기
	 * @return the value of this work table name
	 */
	public String getTableName() {
		return tableName;
	}
	
	/**
	 * 업무 키 배열 가져오기
	 * @return the value of this work table primary key names array
	 */
	public String[] getPrimaryKeyNames() {
		return primaryKeyNames;
	}
	
	/**
	 * 코드로 부터  가져오기
	 * @param code
	 * @return WorkCategory
	 */
	public static ApplicationWorkCategory valueOfCode(String code) {
		for(ApplicationWorkCategory element : ApplicationWorkCategory.values()) {
			if(code.equals(element.getCode())) {
				return element;
			}
		}
		return ApplicationWorkCategory.UnDefined;
	}
}
