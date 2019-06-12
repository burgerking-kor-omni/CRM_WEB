package com.ubone.standard.system.message.rule;

import com.ubone.framework.engine.event.Event;
import com.ubone.standard.system.message.Message;
import com.ubone.standard.system.message.MessageException;


/** 
 * <pre>
 *  설    명 : 메세지 규칙 해석기
 *             메세지 규칙으로부터 실제 발송할 메세지 정보를 생성한다
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface MessageRuleResolver {

	/**
	 * 메세지 규칙으로부터 실제 발송할 메세지 정보를 생성한다
	 * @param systemMessageRule
	 * @param event
	 * @return
	 * @throws MessageException
	 */
	Message resolve(SystemMessageRule systemMessageRule, Event event);
}
