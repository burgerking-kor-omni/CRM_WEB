package com.ubone.standard.system.message.util;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.EmptyResultDataAccessException;

import com.ubone.framework.engine.domain.User;
import com.ubone.framework.security.user.UserRepository;
import com.ubone.standard.system.message.ChannelType;
import com.ubone.standard.system.message.Message;
import com.ubone.standard.system.message.RecipientType;
import com.ubone.standard.system.message.Message.Recipient;


/** 
 * <pre>
 *  설    명 : 메세지 수신자 교정기
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class RecipientCorrector implements MessageCorrector {
	
	private static final Log logger = LogFactory.getLog(RecipientCorrector.class);
	
	@Resource
	private UserRepository userRepository;
	
	
	private static final String email_pattern = "^([\\w-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([\\w-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.util.MessageCorrector#correct(com.ubone.support.message.Message)
	 */
	public Message correct(Message message) {
		List<Recipient> list = new LinkedList<Recipient>();
		for(Recipient recipient : message.getRecipients()) {
			// 수신인 이메일 주소 확인
			if(message.getChannelType() == ChannelType.Email) {
				if(!verifiedEmail(recipient)) {
					continue;
				}
			}
			// 수신인 전화번호 확인
			else if(message.getChannelType() == ChannelType.SMS) {
				if(!verifiedPhoneNumber(recipient)) {
					continue;
				}
			}
			
			list.add(recipient);
		}
		return message.setRecipient(list);
	}

	
	private boolean verifiedEmail(Recipient recipient) {
		String email = findContactInfo(ChannelType.Email, recipient);
		if(StringUtils.isEmpty(email)) {
			if(logger.isWarnEnabled()) {
				logger.warn("recipient has no email address; " + recipient);
			}
			return false;
		}
		if(!email.matches(email_pattern)) {
			if(logger.isWarnEnabled()) {
				logger.warn("recipient has no valid email address[" + email + "]; " + recipient);
			}
			return false;
		}
		
		recipient.setEmail(email);
		return true;
	}
	
	private boolean verifiedPhoneNumber(Recipient recipient) {
		String phoneNumber = findContactInfo(ChannelType.SMS, recipient);
		phoneNumber = phoneNumber == null ? "" : phoneNumber.replaceAll("[^0-9]", "");
		if(StringUtils.isEmpty(phoneNumber)) {
			if(logger.isWarnEnabled()) {
				logger.warn("recipient has no valid phone number[" + recipient.getPhoneNumber() + "]; " + recipient);
			}
			return false;
		}
		
		recipient.setPhoneNumber(phoneNumber);
		return true;
	}
	
	
	private String findContactInfo(ChannelType channelType, Recipient recipient) {
		String contactInfo = "";
		if(channelType == ChannelType.Email) {
			contactInfo = recipient.getEmail();
		}
		else if(channelType == ChannelType.SMS) {
			contactInfo = recipient.getPhoneNumber();
		}
		
		if(StringUtils.isEmpty(contactInfo)) {
			if(recipient.getRecipientType().equals(RecipientType.Customer.getCode())) {
				/*
				DataList custDetail = customerDAO.getDetail(recipient.getCustomerId());
				if(custDetail == null || custDetail.getRowCount() == 0)  {
					if(logger.isWarnEnabled()) {
						logger.warn("Can't find customer[id=" + recipient.getCustomerId() + "]; ");
					}
				}
				else {
					if(channelType == ChannelType.Email) {
						contactInfo = custDetail.get(CustomerColumn.DS_EMAIL.name());
					}
					else if(channelType == ChannelType.SMS) {
						contactInfo = custDetail.get(CustomerColumn.ID_PHONE_MOBILE.name());
					}
				}
				*/
			}
			else {
				try {
					User user = userRepository.findByUserId(recipient.getEmployeeId());
					if(channelType == ChannelType.Email) {
						contactInfo = user.getEmail();
					}
					else if(channelType == ChannelType.SMS) {
						contactInfo = user.getMobilePhoneNumber();
					}
				}
				catch(EmptyResultDataAccessException ex) {
					if(logger.isWarnEnabled()) {
						logger.warn("Can't find user[id=" + recipient.getEmployeeId() + "]; ");
					}
				}
			}
		}
		
		return contactInfo;
	}
}