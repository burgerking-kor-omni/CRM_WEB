package com.ubone.standard.system.message.util;

import org.apache.commons.lang.StringUtils;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.standard.system.message.ChannelType;
import com.ubone.standard.system.message.Message;


/** 
 * <pre>
 *  설    명 : 메세지 발신자 교정기
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class SenderCorrector implements MessageCorrector {
	
	private static final String email_pattern = "^([\\w-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([\\w-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.util.MessageCorrector#correct(com.ubone.support.message.Message)
	 */
	public Message correct(Message message) {
		// 발신자 정보가 없을 경우 시스템 계정으로 발송
		if(message.getSender() == null) {
			message.setSender(UserBuilder.buildSystemUser());
		}
		
		// 발신인 이메일 주소 확인
		if(message.getChannelType() == ChannelType.Email) {
			String email = message.getSender().getEmail();
			if(StringUtils.isEmpty(email) || email.matches(email_pattern) == false) {
				message.getSender().setEmail(ConfigHolder.SYSTEM_EMAIL);
			}
		}
		// 발신인 전화번호 확인
		else if(message.getChannelType() == ChannelType.SMS) {
			String phoneNumber = message.getSender().getPhoneNumber();
			phoneNumber = phoneNumber == null ? "" : phoneNumber.replaceAll("[^0-9]", "");
			if(StringUtils.isEmpty(phoneNumber)) {
				message.getSender().setPhoneNumber(ConfigHolder.SYSTEM_PHONE);
			}
		}
		return message;
	}
}