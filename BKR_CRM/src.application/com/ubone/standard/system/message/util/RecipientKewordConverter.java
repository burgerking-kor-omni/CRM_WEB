package com.ubone.standard.system.message.util;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.EmptyResultDataAccessException;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.security.user.UserRepository;
import com.ubone.standard.system.message.MessageKeyword;
import com.ubone.standard.system.message.RecipientType;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.Message.Sender;
import com.ubone.standard.system.user.dao.UserManageInquiryDAO;
import com.ubone.standard.system.user.service.CustomerColumn;


/** 
 * <pre>
 *  설    명 : 수신자 관련 정보 예약어 변환 처리
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class RecipientKewordConverter extends AbstractKewordConverter{

	private static final Log logger = LogFactory.getLog(RecipientKewordConverter.class);
	
	@Resource
	private UserRepository userRepository;
	
	@Resource
	private UserManageInquiryDAO userManageInquiryDAO;
	
	@Override
	protected boolean isMyKeword(MessageKeyword keyword) {
		if(keyword == MessageKeyword.RECIPIENT_ID
				|| keyword == MessageKeyword.RECIPIENT_NAME) {
			return true;
		}
		return false;
	}
	
	@Override
	protected String replaceKeword(MessageKeyword keyword, String target, Parameter parameter, Sender sender, Recipient firstRecipient) {
		String value = getRecipientId(firstRecipient);
		if(keyword == MessageKeyword.RECIPIENT_NAME) {
			value = findRecipientName(firstRecipient);
		}
		return target.replaceAll("\\{\\$" + keyword.getKeyword() + "\\}", value);
	}
	
	private String getRecipientId(Recipient recipient) {
		if(RecipientType.Employee.equals(recipient.getRecipientType())) {
			return recipient.getEmployeeId();
		}
		else {
			return recipient.getCustomerId();
		}
	}
	
	private String findRecipientName(Recipient recipient) {
		String name = "";
		if(recipient.getRecipientType().equals(RecipientType.Customer.getCode())) {
			
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("USER_ID", recipient.getCustomerId());
			DataList custDetail = userManageInquiryDAO.getUserDetail(parameter);
			if(custDetail == null || custDetail.getRowCount() == 0)  {
				if(logger.isWarnEnabled()) {
					logger.warn("Can't find user[id=" + recipient.getEmployeeId() + "]; ");
				}
			}
			else {
				name = custDetail.get(CustomerColumn.NM_CUST.name());
			}
		}
		else {
			try {
				User user = userRepository.findByUserId(recipient.getEmployeeId());
				name = user.getName();
			}
			catch(EmptyResultDataAccessException ex) {
				if(logger.isWarnEnabled()) {
					logger.warn("Can't find user[id=" + recipient.getEmployeeId() + "]; ");
				}
			}
		}
		return name;
	}
}