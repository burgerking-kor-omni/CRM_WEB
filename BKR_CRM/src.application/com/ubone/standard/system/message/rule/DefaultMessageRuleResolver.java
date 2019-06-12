package com.ubone.standard.system.message.rule;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Component;

import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.event.Event;
import com.ubone.framework.security.user.UserRepository;
import com.ubone.framework.util.ConverterUtil;
import com.ubone.framework.util.ReservedKeyword;
import com.ubone.standard.system.department.dao.SearchDeptManageDAO;
import com.ubone.standard.system.message.ChannelType;
import com.ubone.standard.system.message.Message;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.MessageException;
import com.ubone.standard.system.message.SenderType;
import com.ubone.standard.system.user.dao.UserManageInquiryDAO;
import com.ubone.standard.system.user.service.CustomerColumn;

/** 
 * <pre>
 *  설    명 : 메세지 규칙 해석기
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.02
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2010 by ㈜ 유비원. All right reserved.
 */
@Component
public class DefaultMessageRuleResolver implements MessageRuleResolver {
	
	/**
	 * logger
	 */
	private static final Log logger = LogFactory.getLog(DefaultMessageRuleResolver.class);
	
	@Resource
	private UserRepository userRepository;
	@Resource
	private SearchDeptManageDAO searchDeptManageDAO;
	@Resource
	private UserManageInquiryDAO userManageInquiryDAO;

		
	/* (non-Javadoc)
	 * @see com.ubone.support.message.rule.MessageRuleResolver#resolve(com.ubone.support.message.rule.SystemMessageRule, com.ubone.framework.engine.event.Event)
	 */
	public Message resolve(SystemMessageRule systemMessageRule, Event event) {
		Message message = new Message()
			.setParameter(event.getParameter())
			.setWorkCategory(event.getWorkCategory())
			.setWorkKeys(event.getEventSourcekeys())
			.setOccuredDate(event.getEventOccuredTimestamp())
			.setChannelType(systemMessageRule.getChannelType())
			.setTitle(systemMessageRule.getTitle())
			.setUrl(systemMessageRule.getUrl())
			.setCdDispatchBiz(systemMessageRule.getCdDispatchBiz())
			.setMessage(systemMessageRule.getMessage())
			.setDispatch(event.getParameter().get("DS_DISPATCH"));
		
		User sender = resolveSender(systemMessageRule, event);
		message.setSender(sender);
		
		List<Recipient> recipients = resolveRecipients(systemMessageRule, event);
		
		for (Recipient recipient : recipients) {
			message.addRecipient(recipient);
		}		
		
		return message;
	}
	
	private User resolveSender(SystemMessageRule systemMessageRule, Event event) {		
		User sender = event.getEventSourceUser();
		if(systemMessageRule.getSenderType() == SenderType.System) {
			sender = UserBuilder.buildSystemUser();
		}
		else if(systemMessageRule.getSenderType() == SenderType.Employee) {
			String userId = systemMessageRule.getSendUserId();
			try {
				sender = userRepository.findByUserId(userId);
			}
			catch(EmptyResultDataAccessException ex) {
				throw new MessageException("Can't find user[id=" + userId + "] who send message from UserRepository; ");
			}
		}
		else if(systemMessageRule.getSenderType() == SenderType.Worker) {
			String userIdKeyword = systemMessageRule.getSendUserId();
			String userId = ConverterUtil.stringOf(ReservedKeyword.getKeywordRealValue(userIdKeyword, event.getParameter()));

			if(StringUtils.isEmpty(userId)) {
				throw new MessageException("Can't find " + userIdKeyword + " from Parameter; ");
			}
			else {
				try {
					sender = userRepository.findByUserId(userId);
				}
				catch(EmptyResultDataAccessException ex) {
					throw new MessageException("Can't find user[id=" + userId + "] who send message from UserRepository; ");
				}
			}
		}
		return sender;
	}
	
	private List<Recipient> resolveRecipients(SystemMessageRule systemMessageRule, Event event) {
		List<Recipient> recipients = new LinkedList<Recipient>();
		switch (systemMessageRule.getRecipientType()) {
			case Customer:
				String customerId = event.getParameter().get(CustomerColumn.ID_CUST.name());
				
				if(StringUtils.isEmpty(customerId)){
					throw new MessageException("Can't find key[" + CustomerColumn.ID_CUST.name() + "] for finding customer id from Parameter; ");
				}
				
				if(systemMessageRule.getChannelType() == ChannelType.Email) {
					String email = event.getParameter().get(CustomerColumn.EMAIL.name());
					Recipient recipient = Recipient.customerRecipientWithEmail(customerId, email);
					recipients.add(recipient);
				}
				else {
					String phoneNumber = event.getParameter().get(CustomerColumn.ID_PHONE_MOBILE.name());
					Recipient recipient = Recipient.customerRecipientWithPhoneNumber(customerId, phoneNumber);
					recipients.add(recipient);
				}
				break;
				
			case Employee: {
				String userId = event.getParameter().get("ID_VOC_ACT_EMP");
				try {
					User user = userRepository.findByUserId(userId);
					recipients.add(Recipient.userRecipient(user));
				}
				catch(EmptyResultDataAccessException ex) {
					throw new MessageException("Can't find user[id=" + userId + "] who recieve message from UserRepository; ");
				}
				break;
			}
			
			case Worker: {
				/*String userIdKeyword = event.getParameter().get("ID_VOC_ACT_EMP");
				String userId = ConverterUtil.stringOf(ReservedKeyword.getKeywordRealValue(userIdKeyword, event.getParameter()));*/
				int count = event.getParameter().getValues("ID_VOC_ACT_EMP").length;
				String userId[] = new String[count];
				
				for(int i=0; i<count; i++){
					userId[i] = event.getParameter().getValues("ID_VOC_ACT_EMP")[i];
					
					if(StringUtils.isEmpty(userId[i])) {
						throw new MessageException("Can't find " + userId + " from Parameter; ");
					}
				}
				
				try {
					
					for(int i=0; i< count; i++){
						User user = userRepository.findByUserId(userId[i]);
						recipients.add(Recipient.userRecipient(user));
					}

				}
				catch(EmptyResultDataAccessException ex) {
					if(logger.isWarnEnabled()) {
						logger.warn("Can't find user[id=" + userId + "] who recieve message from UserRepository; ");
					}
				}
				break;
			}
			
			case Role: {
				List<User> users = userRepository.findByRoleId(systemMessageRule.getReceiptRoleId());
				if(users != null) {
					for(User user : users) {
						recipients.add(Recipient.userRecipient(user));
					}
				}
				break;
			}
			
			case RoleInDepartment: {
				String partCodeKeyword = systemMessageRule.getReceiptPartCode();
				String partCode = "";
				
				if(ReservedKeyword.isKeyword(partCodeKeyword)) {
					partCode = ConverterUtil.stringOf(ReservedKeyword.getKeywordRealValue(partCodeKeyword, event.getParameter()));
					
					if(StringUtils.isEmpty(partCode)){
						//throw new MessageException("Can't find " + partCodeKeyword + " from Parameter; ");
						partCode = "";
					}
				} else {
					partCode = partCodeKeyword;
				}
				
				List<User> users = searchDeptManageDAO.findByRoleIdAndPartCode(systemMessageRule.getReceiptRoleId(), partCode);
				if(users != null) {
					for (User user : users) {
						recipients.add(Recipient.userRecipient(user));
					}
				}
				break;
			}
			
			case SalesEmployee: {
				String partCodeKeyword = systemMessageRule.getReceiptPartCode();
				String partCode = "";
				
				if(ReservedKeyword.isKeyword(partCodeKeyword)) {
					partCode = ConverterUtil.stringOf(ReservedKeyword.getKeywordRealValue(partCodeKeyword, event.getParameter()));
					
					if(StringUtils.isEmpty(partCode)){
						//throw new MessageException("Can't find " + partCodeKeyword + " from Parameter; ");
						partCode = "";
					}
				} else {
					partCode = partCodeKeyword;
				}
				
				List<User> users = userManageInquiryDAO.findByUserSalesEmp(partCode);
				if(users != null) {
					for (User user : users) {
						recipients.add(Recipient.userRecipient(user));
					}
				}
				break;
			}	
			
			case StoreOwner: {
				String partCodeKeyword = systemMessageRule.getReceiptPartCode();
				String partCode = "";
				
				if(ReservedKeyword.isKeyword(partCodeKeyword)) {
					partCode = ConverterUtil.stringOf(ReservedKeyword.getKeywordRealValue(partCodeKeyword, event.getParameter()));
					
					if(StringUtils.isEmpty(partCode)){
						//throw new MessageException("Can't find " + partCodeKeyword + " from Parameter; ");
						partCode = "";
					}
				} else {
					partCode = partCodeKeyword;
				}
				
				List<User> users = userManageInquiryDAO.findByUserStoreOwner(partCode);
				if(users != null) {
					for (User user : users) {
						recipients.add(Recipient.userRecipientStoreEmp(user));
					}
				}
				break;
			}
			case Partner: {
				String email = event.getParameter().get("EMAIL");
				String nmPartner = event.getParameter().get("NM_PARTNER");
				
				if(!StringUtils.isEmpty(email)){
					recipients.add(Recipient.userRecipientPartner(email, nmPartner));
				}
				break;
			}
		}
		
		return recipients;
	}
}