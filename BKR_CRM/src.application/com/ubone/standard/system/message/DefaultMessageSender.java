package com.ubone.standard.system.message;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.util.StringUtils;

import com.ubone.ApplicationWorkCategory;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.Message.Sender;
import com.ubone.standard.system.message.dao.MessageDAO;
import com.ubone.standard.system.message.util.MessageCorrector;
import com.ubone.standard.system.message.util.Splitter;



/** 
 * <pre>
 *  설    명 : 메세지 발송 테이블을 통한 메세지 발송기
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.02
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2010 by ㈜ 유비원. All right reserved.
 */
public class DefaultMessageSender implements MessageSender {
	
	private static final Log logger = LogFactory.getLog(DefaultMessageSender.class);
	
	private Splitter splitter;
	public void setSplitter(Splitter splitter) {
		this.splitter = splitter;
	}
	
	private MessageCorrector[] messageCorrectors;
	public void setMessageCorrectors(MessageCorrector[] messageCorrectors) {
		this.messageCorrectors = messageCorrectors;
	}
	
	@Resource
	private MessageDAO messageDAO;
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.MessageSender#send(com.ubone.support.message.Message)
	 */
	public boolean send(Message message) {
		if(splitter != null) {
			List<Message> list = splitter.split(message);
			for (Message item : list) {
				insertMessageData(item);
			}
		}
		else {
			insertMessageData(message);
		}
		return true;
	}
	
	/**
	 * @param message
	 * @throws DataAccessException
	 */
	private void insertMessageData(Message message) {
	
		List<Recipient> recipients = message.getRecipients();
		if(recipients == null || recipients.size() == 0) {
			if(logger.isWarnEnabled()) {
				logger.warn("there is no recipient in message; " + message);
			}
			return;
		}
		
		if(messageCorrectors != null) {
			for(MessageCorrector messageCorrector : messageCorrectors) {
				message = messageCorrector.correct(message);
			}
		}
		
		//VOC 인경우 Sub Key를 추가로 첨부한다.
		String[] workKeys = message.getWorkkeys();
		String messageId = "";
 
		if(message.getWorkCategory().equals(ApplicationWorkCategory.VOC)){
			@SuppressWarnings("unchecked")
			ArrayList<String[]> empDispatchList = (ArrayList<String[]>)message.getParameter().getParameter("EMP_DISPATCH_LIST");
			
			if(!StringUtils.isEmpty(empDispatchList)){
				for(String[] empDispatch : empDispatchList){
					//message.setWorkKeys((String[])ArrayUtils.add(workKeys, empDispatch[0]));
					message.setSender(new Sender(empDispatch[1]));
					Parameter param = message.asParameter();
					
					String data  = param.getValue("message");
					
					// 메일 기본 정보 저장
					data = data.replaceAll("&lt;", "<");
					data = data.replaceAll("&gt;", ">");
					param.setParameter("message", data);
					
					messageId = messageDAO.insert(param);

					// 수신인 정보 저장
					for(Recipient recipient : recipients) {
						recipient.setMessageId(messageId);			
						messageDAO.insertTarget(recipient.asParameter());
					}
				}
			}else{
				//message.setWorkKeys((String[])ArrayUtils.add(workKeys, message.getParameter().getValue("ID_SUB_VOC")));
				Parameter param = message.asParameter();
				
				String data  = param.getValue("message");
				
				// 메일 기본 정보 저장
				data = data.replaceAll("&lt;", "<");
				data = data.replaceAll("&gt;", ">");
				param.setParameter("message", data);
				
				// 메일 기본 정보 저장
				messageId = messageDAO.insert(param);
				
				// 수신인 정보 저장
				for(Recipient recipient : recipients) {
					recipient.setMessageId(messageId);			
					messageDAO.insertTarget(recipient.asParameter());
				}
			}
			
		}else{
			//message.setWorkKeys((String[])ArrayUtils.add(workKeys, message.getParameter().getValue("ID_SUB_VOC")));
			//message.setWorkKeys((String[])ArrayUtils.add(workKeys, message.getParameter().getValue("ID_SUB_VOC")));
			Parameter param = message.asParameter();
			
			String data  = param.getValue("message");
			
			// 메일 기본 정보 저장
			data = data.replaceAll("&lt;", "<");
			data = data.replaceAll("&gt;", ">");
			param.setParameter("message", data);
			
			// 메일 기본 정보 저장
			messageId = messageDAO.insert(message.asParameter());
			
			// 수신인 정보 저장
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>> message.getRecipients().size() :  " +message.getRecipients().size());
			for(Recipient recipient : recipients) {
				recipient.setMessageId(messageId);			
				messageDAO.insertTarget(recipient.asParameter());
			}
		}
		
		/*
		
		//VOC 인경우 Sub Key를 추가로 첨부한다.
		if(message.getWorkCategory().equals(ApplicationWorkCategory.VOC)){
			message.setWorkKeys((String[])ArrayUtils.add(message.getWorkkeys(), message.getParameter().getValue("ID_SUB_VOC")));
		}
		
		String messageId = messageDAO.insert(message.asParameter());
		// 메일 기본 정보 저장
		
		// 수신인 정보 저장
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>> message.getRecipients().size() :  " +message.getRecipients().size());
		for(Recipient recipient : recipients) {
			recipient.setMessageId(messageId);			
			messageDAO.insertTarget(recipient.asParameter());
		}
		*/
	}
}