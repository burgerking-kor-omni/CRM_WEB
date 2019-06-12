package com.ubone.standard.system.message;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;

import com.ubone.framework.data.DataList;
import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.engine.WorkflowActivity;
import com.ubone.framework.engine.event.Event;
import com.ubone.framework.engine.event.EventHandler;
import com.ubone.framework.util.UBELParser;
import com.ubone.standard.system.message.dao.MessageDAO;
import com.ubone.standard.system.message.rule.MessageRuleResolver;
import com.ubone.standard.system.message.rule.SystemMessageRule;

/** 
 * <pre>
 *  설    명 : 시스템 이벤트 정보를 수신하여
 *             메세지 발송이 걸린 이벤트인 경우
 *             수신된 이벤트와 관련된 모든 메세지를 발송한다.
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class SystemMessageEventHandler implements EventHandler {
	
	private static final Log logger = LogFactory.getLog(SystemMessageEventHandler.class);	

	@Resource
	private MessageDAO messageDAO;
	
	@Resource
	private MessageRuleResolver messageRuleResolver;
	
	@Resource
	private MessageSender messageSender;

	public boolean isBindingFor(WorkCategory category) {
		return true;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.event.EventHandler#handleEvent(com.ubone.framework.engine.event.Event)
	 */
	public void handleEvent(Event event) {
		List<SystemMessageRule> matchedRules = getMatchedRules(event.getWorkCategory(), event.getWorkflowActivity());
		for(SystemMessageRule systemMessageRule : matchedRules) {
			triggerMessageEvent(event, systemMessageRule);
		}
	}
	
	private List<SystemMessageRule> getMatchedRules(WorkCategory workCategory, WorkflowActivity workflowActivity) {
		DataList list = messageDAO.findRuleBy(workCategory, workflowActivity);
		List<SystemMessageRule> matchedRules = new LinkedList<SystemMessageRule>();
		for(Map<String, Object> row : list.getRows()) {
			matchedRules.add(SystemMessageRule.valueOf(row));
		}
		return matchedRules;
	}

	private void triggerMessageEvent(Event event, SystemMessageRule systemMessageRule) {
		if(estimateRule(event, systemMessageRule) == false) {
			return;
		}
		
		try {
			Message message = messageRuleResolver.resolve(systemMessageRule, event);
			messageSender.send(message);
			if(logger.isDebugEnabled()) {
				logger.debug("system event message sended; " + message);
			}
		}
		catch (DataAccessException e) {
			messageSendErrorHandle(e, systemMessageRule);
		}
		catch (MessageException e) {
			messageSendErrorHandle(e, systemMessageRule);
		}
	}
	
	private boolean estimateRule(Event event, SystemMessageRule systemMessageRule) {
		String ruleStatement = systemMessageRule.getRuleStatement1();
		if(StringUtils.isNotEmpty(ruleStatement) && !UBELParser.match(ruleStatement, event.getParameter())) {
			return false;
		}

		ruleStatement = systemMessageRule.getRuleStatement2();
		if(StringUtils.isNotEmpty(ruleStatement) && !UBELParser.match(ruleStatement, event.getParameter())) {
			return false;
		}

		ruleStatement = systemMessageRule.getRuleStatement3();
		if(StringUtils.isNotEmpty(ruleStatement) && !UBELParser.match(ruleStatement, event.getParameter())) {
			return false;
		}
		
		ruleStatement = systemMessageRule.getRuleStatement4();
		if(StringUtils.isNotEmpty(ruleStatement) && !UBELParser.match(ruleStatement, event.getParameter())) {
			return false;
		}		
		
		ruleStatement = systemMessageRule.getRuleStatement5();
		if(StringUtils.isNotEmpty(ruleStatement) && !UBELParser.match(ruleStatement, event.getParameter())) {
			return false;
		}	
		
		ruleStatement = systemMessageRule.getRuleStatement6();
		if(StringUtils.isNotEmpty(ruleStatement) && !UBELParser.match(ruleStatement, event.getParameter())) {
			return false;
		}		
		return true;
	}
	
	/**
	 * 예외 발생을 더 이상 전파하지 않도록 예외 정보를 로깅 후 처리를 이어간다. 
	 */
	private void messageSendErrorHandle(Exception e, SystemMessageRule systemMessageRule) {
		if(logger.isErrorEnabled()) {
			logger.error("system event message sending failed; " + systemMessageRule, e);
		}
	}
}