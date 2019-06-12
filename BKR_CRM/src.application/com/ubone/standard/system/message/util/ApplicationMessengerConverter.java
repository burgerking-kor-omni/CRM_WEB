package com.ubone.standard.system.message.util;

import com.ubone.standard.system.message.ChannelType;
import com.ubone.standard.system.message.Message;



/** 
 * <pre>
 *  설    명 : 메신저 사용시 줄바꿈 문자를 <br/> 태그로 변환한다.
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class ApplicationMessengerConverter implements MessageCorrector {
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.util.MessageCorrector#correct(com.ubone.support.message.Message)
	 */
	public Message correct(Message message) {
		if(message.getChannelType() == ChannelType.Messenger) {
			String contents = this.replaceNewLineToTag(message.getMessage());
			message.setMessage(contents);
		}
		return message;
	}
	
	private String replaceNewLineToTag(String str) {
		str = str.replaceAll("\n", "<br>");
		return  str.toString();
	}
}