package com.ubone.standard.system.message.util;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.message.MessageKeyword;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.Message.Sender;


/** 
 * <pre>
 *  설    명 : 시스템 기본 설정값으로 예약어 변환 처리
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class SystemInfomationKewordConverter extends AbstractKewordConverter {
	
	@Override
	protected boolean isMyKeword(MessageKeyword keyword) {
		return keyword == MessageKeyword.SYSTEM_URL; 
	}
	
	@Override
	protected String replaceKeword(MessageKeyword keyword, String target, Parameter parameter, Sender sender, Recipient firstRecipient) {
		String value = "";
		if(keyword == MessageKeyword.SYSTEM_URL) {
			value = ConfigHolder.APPLICATION_URL;
		}
		return target.replaceAll("\\{\\$" + keyword.getKeyword() + "\\}", value);
	}
}