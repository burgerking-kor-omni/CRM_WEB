package com.ubone.standard.system.message.rule;

import java.util.Map;

import com.ubone.framework.data.BaseDataObject;
import com.ubone.framework.engine.CodeEnumUtils;
import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.engine.WorkflowActivity;
import com.ubone.framework.util.ConverterUtil;
import com.ubone.standard.system.message.ChannelType;
import com.ubone.standard.system.message.RecipientType;
import com.ubone.standard.system.message.SenderType;


/** 
 * <pre>
 *  설    명 : 시스템 메세지 Rule
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class SystemMessageRule extends BaseDataObject {
	
	/**
	 * 업무구분
	 */
	private WorkCategory workCategory;
	private SystemMessageRule setWorkCategory(String code) {
		this.workCategory = CodeEnumUtils.asWokrCategory(code);
		return this;
	}
	public WorkCategory getWorkCategory() {
		return workCategory;
	}
	
	/**
	 * Activity
	 */
	private WorkflowActivity workflowActivity;
	private SystemMessageRule setWorkflowActivity(String code) {
		this.workflowActivity = CodeEnumUtils.asWorkflowActivity(code);
		return this;
	}
	public WorkflowActivity getWorkflowActivity() {
		return workflowActivity;
	}
	
	/**
	 * 메세지 채널 유형
	 */
	private ChannelType channelType;
	private SystemMessageRule setChannelType(String code) {
		this.channelType = ChannelType.valueOfCode(code);
		return this;
	}
	public ChannelType getChannelType() {
		return channelType;
	}
	
	/**
	 * 메세지 조건 구문 1
	 */
	private String ruleStatement1 = "";
	private SystemMessageRule setRuleStatement1(String ruleStatement1) {
		this.ruleStatement1 = ruleStatement1;
		return this;
	}
	public String getRuleStatement1() {
		return ruleStatement1;
	}
	
	/**
	 * 메세지 조건 구문 2
	 */
	private String ruleStatement2 = "";
	private SystemMessageRule setRuleStatement2(String ruleStatement2) {
		this.ruleStatement2 = ruleStatement2;
		return this;
	}
	public String getRuleStatement2() {
		return ruleStatement2;
	}
	
	/**
	 * 메세지 조건 구문 3
	 */
	private String ruleStatement3 = "";
	private SystemMessageRule setRuleStatement3(String ruleStatement3) {
		this.ruleStatement3 = ruleStatement3;
		return this;
	}
	public String getRuleStatement3() {
		return ruleStatement3;
	}
	
	/**
	 * 메세지 조건 구문 4
	 */
	private String ruleStatement4 = "";
	private SystemMessageRule setRuleStatement4(String ruleStatement4) {
		this.ruleStatement4 = ruleStatement4;
		return this;
	}
	public String getRuleStatement4() {
		return ruleStatement4;
	}	
	
	
	/**
	 * 메세지 조건 구문 5
	 */
	private String ruleStatement5 = "";
	private SystemMessageRule setRuleStatement5(String ruleStatement5) {
		this.ruleStatement5 = ruleStatement5;
		return this;
	}
	public String getRuleStatement5() {
		return ruleStatement5;
	}	
	
	/**
	 * 메세지 조건 구문 6
	 */
	private String ruleStatement6 = "";
	private SystemMessageRule setRuleStatement6(String ruleStatement6) {
		this.ruleStatement6 = ruleStatement6;
		return this;
	}
	public String getRuleStatement6() {
		return ruleStatement6;
	}
	
	/**
	 * 메세지 제목
	 */
	private String title = "";
	private SystemMessageRule setTitle(String title) {
		this.title = title;
		return this;
	}
	public String getTitle() {
		return title;
	}
	
	/**
	 * 메세지 내용
	 */
	private String message = "";
	private SystemMessageRule setMessage(String message) {
		this.message = message;
		return this;
	}
	public String getMessage() {
		return message;
	}
	
	/**
	 * url
	 */
	private String url = "";
	private SystemMessageRule setUrl(String url) {
		this.url = url;
		return this;
	}
	public String getUrl() {
		return url;
	}
	
	/**
	 * 발송자 유형 
	 */
	private SenderType senderType;
	private SystemMessageRule setSenderType(String code) {
		this.senderType = SenderType.valueOfCode(code);
		return this;
	}
	public SenderType getSenderType() {
		return senderType;
	}
	
	/**
	 * 발송자 ID
	 */
	private String sendUserId = "";
	private SystemMessageRule setSendUserId(String sendUserId) {
		this.sendUserId = sendUserId;
		return this;
	}
	public String getSendUserId() {
		return sendUserId;
	}

	/**
	 * 수신자 유형
	 */
	private RecipientType recipientType;
	private SystemMessageRule setRecipientType(String code) {
		this.recipientType = RecipientType.valueOfCode(code);
		return this;
	}
	public RecipientType getRecipientType() {
		return recipientType;
	}
	
	/**
	 * 수신자 ID
	 */
	private String receiptUserId = "";
	private SystemMessageRule setReceiptUserId(String receiptUserId) {
		this.receiptUserId = receiptUserId;
		return this;
	}
	public String getReceiptUserId() {
		return receiptUserId;
	}
	
	/**
	 * 수신 업무권한 ID
	 */
	private String receiptRoleId = "";
	private SystemMessageRule setReceiptRoleId(String receiptRoleId) {
		this.receiptRoleId = receiptRoleId;
		return this;
	}
	public String getReceiptRoleId() {
		return receiptRoleId;
	}
	
	/**
	 * 수신 부서 ID
	 */
	private String receiptPartCode = "";
	private SystemMessageRule setReceiptPartCode(String receiptPartCode) {
		this.receiptPartCode = receiptPartCode;
		return this;
	}
	public String getReceiptPartCode() {
		return receiptPartCode;
	}

	/**
	 * 통보유형 구분
	 */
	private String cdDispatchBiz = "";
	private SystemMessageRule setCdDispatchBiz(String cdDispatchBiz) {
		this.cdDispatchBiz = cdDispatchBiz;
		return this;
	}
	public String getCdDispatchBiz() {
		return cdDispatchBiz;
	}

	
	
	public static SystemMessageRule valueOf(Map<String, Object> map) {
		return new SystemMessageRule()
			.setWorkCategory(ConverterUtil.stringOf(map.get("TP_BIZ")))
			.setWorkflowActivity(ConverterUtil.stringOf(map.get("TP_EVENT")))
			.setChannelType(ConverterUtil.stringOf(map.get("TP_DISPATCH_METHOD")))
			.setRuleStatement1(ConverterUtil.stringOf(map.get("DS_CONDITION1")))
			.setRuleStatement2(ConverterUtil.stringOf(map.get("DS_CONDITION2")))
			.setRuleStatement3(ConverterUtil.stringOf(map.get("DS_CONDITION3")))
			.setRuleStatement4(ConverterUtil.stringOf(map.get("DS_CONDITION4")))
			.setRuleStatement5(ConverterUtil.stringOf(map.get("DS_CONDITION5")))
			.setRuleStatement6(ConverterUtil.stringOf(map.get("DS_CONDITION6")))
			.setTitle(ConverterUtil.stringOf(map.get("DS_TITLE_MESSAGE")))
			.setMessage(ConverterUtil.stringOf(map.get("DS_CONTENT")))
			.setUrl(ConverterUtil.stringOf(map.get("DS_URL")))
			.setSenderType(ConverterUtil.stringOf(map.get("TP_MESSAGE_SENDER")))
			.setSendUserId(ConverterUtil.stringOf(map.get("ID_EMP_SEND")))
			.setRecipientType(ConverterUtil.stringOf(map.get("TP_MESSAGE_TARGET")))
			.setReceiptUserId(ConverterUtil.stringOf(map.get("ID_EMP_TARGET")))
			.setReceiptRoleId(ConverterUtil.stringOf(map.get("ID_ROLE_TARGET")))
			.setCdDispatchBiz(ConverterUtil.stringOf(map.get("CD_DISPATCH_BIZ")))
			.setReceiptPartCode(ConverterUtil.stringOf(map.get("ID_DEPT_TARGET")));
	}
}