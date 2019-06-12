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
public enum MessageKeyword implements CodeEnum {
	CUST_NAME("NM_CUST", "고객명"),
	NM_CORP("NM_CORP", "점포명"),
	
	VOC_ID("ID_VOC", "VOC ID"),
	VOC_SUB_ID("ID_SUB_VOC", "VOC SUBID"),
	VOC_NAME("DS_TITLE", "VOC 제목"),
	VOC_PATTERN_NAME("NM_VOC_PATTERN", "VOC 유형명"),
	VOC_CAUSE_NAME("NM_VOC_CAUSE", "내용 유형명"),
	NM_COMP("NM_COMP", "회사구분명"),
	NM_VOC_REG_EMP("NM_VOC_REG_EMP", "VOC등록자"),
	
	VOC_CAUSE_NAME_FULL("NM_VOC_CAUSE_FULL", "내용 유형명 FULL"),
	
	VOC_CONFIRM_DATE("DT_VOC_RECV_DT", "접수일자"),
	VOC_CONTENTS("DS_CONT", "VOC 내용"),
	VOC_DT_REG("DT_REG", "등록일자"),
	DS_REQ_TITLE("DS_REQ_TITLE", "요청 제목"),
	DS_REQ_CONT("DS_REQ_CONT", "요청 제목"),
	DS_APPL_TITLE("DS_APPL_TITLE", "신청 제목"),
	DS_APPL_CONT("DS_APPL_CONT", "신청 제목"),
	CD_VOC_IMPORTANCE("NM_VOC_IMPORTANCE", "중요도"),
	
	ACTIVITY("ACTIVITY", "메일 ACTIVITY"),
	ACTIVITY_DESC("ACTIVITY_DESC", "메일 ACTIVITY 상세"),
	SEQ_VOC_REQ("SEQ_VOC_REQ", "신청관리키"),
	SEQ_VOC_REQ_TGT("SEQ_VOC_REQ_TGT", "신청관리서브키"),
	
	TOP_LOGO_IMG("TOP_LOGO_IMG", "상단브랜드이미지"),
	BOTTOM_LOGO_IMG("BOTTOM_LOGO_IMG", "하단브랜드이미지"),
	BOTTOM_ADDR_IMG("BOTTOM_ADDR_IMG", "하단주소이미지"),
	TOP_LOGO_COLOR("TOP_LOGO_COLOR", "백컬러"),
	LEFT_IMG("LEFT_IMG", "좌측이미지"),
	
	
	NM_BRAND("NM_BRAND", "브랜드명"),
	PHONE_BRAND("PHONE_BRAND", "브랜드전화번호"),
	LINK_URL("HOMEPAGE_URL", "홈페이지LINKURL"),
	
	VOC_CHARGE_PART_NAME("NM_DEPT_CHRG", "담당부서명"),
	VOC_CHARGE_EMP_NAME("NM_EMP_CHRG", "담당자명"),
	VOC_CHARGE_EMP_EMAIL("EMAIL_DS_CHRG", "담당자 이메일"),
	VOC_CHARGE_EMP_PHONE("PHONE_NO_CHRG", "담당자 전화번호"),
	VOC_COMPLETE_PLAN_DATE("DT_END_VOC_PLAN", "종결예정일시"),
	VOC_RESULT("DS_ACT_RSLT", "처리내용"),
	ACTIVITY_BIZ_NAME("NM_BIZ", "업무명"),
	SYSTEM_URL("SYSTEM_URL", "URL"),
	RECIPIENT_ID("ID_RECIPIENT", "사용자ID"),
	RECIPIENT_NAME("NM_RECIPIENT", "수신인이름"),
	
	ID_CSI_VOC("ID_CSI_VOC", "만족도조사"),
	ID_ANSWER_CSI_VOC("ID_ANSWER_CSI_VOC", "만족도조사답변"),
	MAIL_URL("MAIL_URL", "MAIL URL"),
	DS_CONTENT("DS_CONTENT","THANK_MAIL 내용"),
	DS_ACT_CONT("DS_ACT_CONT","DS_ACT_CONT"),
	NM_EMP("NM_EMP","NM_EMP"),
	DS_COMMENT("DS_COMMENT","DS_COMMENT"),	
	DT_VOC_RECV("DT_VOC_RECV", "DT_VOC_RECV"),
	DT_VOC_ASN("DT_VOC_ASN", "DT_VOC_ASN"),
	ID_VOC_ACT_EMP("ID_VOC_ACT_EMP","ID_VOC_ACT_EMP"),
	NM_VOC_ACT_EMP("NM_VOC_ACT_EMP","NM_VOC_ACT_EMP"),
	NM_PC("NM_PC","NM_PC"),
	DS_CONT_FIRST("DS_CONT_FIRST","1차응대완료"),
	DS_REPLY("DS_REPLY","답변내용"),
	DS_THANKU_TITLE("DS_THANKU_TITLE","감사메일제목"),
	PARTNER_TITLE("PARTNER_TITLE","협력사메일제목"),
	NM_PARTNER("NM_PARTNER","협렵사명"),
	TP_PHONE("TP_PHONE","고객회신전화번호"),
	FG_REPLY_SMS("FG_REPLY_SMS","고객문자회신여부"),
	FG_PROCESS_IMME("FG_PROCESS_IMME","즉시처리여부"),
	DS_DISPATCH("DS_DISPATCH","통보내용")
	;
	
	

	
	private String code;
	private String description;
	private String keyword;
	private String codeCategory;
	
	private MessageKeyword(String keyword, String description) {
		this(keyword, description, null);
	}
	
	private MessageKeyword(String keyword, String description, String codeCategory) {
		this.code = "{$" + keyword + "}";
		this.description = description;
		this.keyword = keyword;
		this.codeCategory = codeCategory;
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
	
	public String getKeyword() {
		return keyword;
	}
	
	public String getCodeCategory() {
		return codeCategory;
	}
	
	/**
	 * 코드로 부터 가져오기
	 * @param code
	 * @return SenderType
	 */
	public static MessageKeyword valueOfCode(String code) {
		for(MessageKeyword element : MessageKeyword.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return null;
	}
}