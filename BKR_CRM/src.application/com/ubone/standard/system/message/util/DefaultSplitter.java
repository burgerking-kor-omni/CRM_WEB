package com.ubone.standard.system.message.util;

import java.util.LinkedList;
import java.util.List;

import com.ubone.standard.system.message.Message;
import com.ubone.standard.system.message.Message.Recipient;

/** 
 * <pre>
 *  설    명 : 기본 메세지 분배기
 *             - 수신자당 한개의 메세지로 분리한다.
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class DefaultSplitter implements Splitter {

	public List<Message> split(Message message) {
		List<Message> list = new LinkedList<Message>();
		
		List<Recipient> recipients = message.getRecipients();
		if(recipients == null || recipients.size() == 0) {
			list.add(message);
			return list;
		}
		else {
			for(Recipient recipient : recipients) {
				Message splitedMessage = 
					new Message()
					.setWorkCategory(message.getWorkCategory())
					.setWorkKeys(message.getWorkkeys())
					.setChannelType(message.getChannelType())
					.setTitle(message.getTitle())
					.setMessage(message.getMessage())
					.setCdDispatchBiz(message.getCdDispatchBiz())
					.setUrl(message.getUrl())
					.setOccuredDate(message.getOccuredDate())
					.setPlanDate(message.getPlanDate())
					.setParameter(message.getParameter())
					.setSender(message.getSender())
					.addRecipient(recipient)
				    .setDispatch(message.getDispatch());
				
				list.add(splitedMessage);
			}
		}
		return list;
	}
}