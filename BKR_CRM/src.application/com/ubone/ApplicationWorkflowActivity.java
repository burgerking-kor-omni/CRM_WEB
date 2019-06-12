package com.ubone;

import com.ubone.framework.engine.WorkflowActivity;
import com.ubone.framework.util.code.Code;

/** 
 * <pre>
 *  설    명 : VOC Workflow Activity Enum
 *  작 성 자 : 임경철
 *  작 성 일 : 2011.01.25
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public enum ApplicationWorkflowActivity implements WorkflowActivity {
	
	/**
	 * 신청
	 */
	REQUEST("신청"),
	/**
	 * 접수(확정)
	 */
	CONFIRM("접수"),
	/**
	 * 반려
	 */
	RETURN("반려"),
	/**
	 * 배정
	 */
	ASSIGN("배정"),
	/**
	 * 처리
	 */
	PROCESSING("처리"),
	/**
	 * 1차처리
	 */
	PROCESSING_ONCE("1차처리"),
	/**
	 * 2차처리
	 */
	PROCESSING_TWICE("2차처리"),
	/**
	 * 3차처리
	 */
	PROCESSING_THIRD("3차처리"),
	/**
	 * 종결
	 */
	COMPLETE("종결"),
	/**
	 * Thanku-mail
	 */
	THANKU_MAIL("Thanku-mail"),
	/**
	 * 협력사메일발송
	 */
	PARTNER_MAIL("협력사메일발송"),
	/**
	 * 
	 * 사용자정의
	 */
	USER_DEFINED("사용자정의", Code.SLEEP_STATUS_CODE);
	
	private String description;
	private String status;
	
	private ApplicationWorkflowActivity(String description) {
		this(description, Code.ACTIVITY_STATUS_CODE);
	}
	
	private ApplicationWorkflowActivity(String description, String status) {
		this.description = description;
		this.status = status;
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
	 * 코드로 부터  가져오기
	 * @param code
	 * @return WorkflowActivity
	 */
	public static ApplicationWorkflowActivity valueOfCode(String code) {
		for(ApplicationWorkflowActivity element : ApplicationWorkflowActivity.values()) {
			if(code.equals(element.getCode())) {
				return element;
			}
		}
		return ApplicationWorkflowActivity.USER_DEFINED;
	}
}