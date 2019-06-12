package com.ubone.standard.system.message.util;

import java.util.ArrayList;

import org.springframework.util.StringUtils;

import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.message.Message;
import com.ubone.standard.system.message.MessageKeyword;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.Message.Sender;


/** 
 * <pre>
 *  설    명 : 예약어 변환 처리 기본 구현
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public abstract class AbstractKewordConverter implements MessageCorrector {
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.util.MessageCorrector#correct(com.ubone.support.message.Message)
	 */
	public Message correct(Message message) {
		String title = message.getTitle();
		String contents = message.getMessage();
		String url = message.getUrl();
		
		Parameter parameter = message.getParameter();
		Sender sender = message.getSender();
		Recipient firstRecipient = message.getRecipients().get(0);

		@SuppressWarnings("unchecked")
		ArrayList<String[]> empDispatchList = (ArrayList<String[]>)message.getParameter().getParameter("EMP_DISPATCH_LIST");
		
		if(!StringUtils.isEmpty(empDispatchList)){
			for(String[] empDispatch : empDispatchList){
				
				parameter.setParameter("NM_VOC_CAUSE", empDispatch[0]);
				
				for(MessageKeyword keyword : MessageKeyword.values()) {
					
					if(isMyKeword(keyword)) {
						if(title.indexOf(keyword.getCode()) >= 0) {
							title = replaceKeword(keyword, title, parameter, sender, firstRecipient);
						}
						if(contents.indexOf(keyword.getCode()) >= 0) {
							contents = replaceKeword(keyword, contents, parameter, sender, firstRecipient);
						}
						if(url.indexOf(keyword.getCode()) >= 0) {
							url = replaceKeword(keyword, url, parameter, sender, firstRecipient);	
						}
					}
				}
			}
			
		}else{
			for(MessageKeyword keyword : MessageKeyword.values()) {
				
				if(isMyKeword(keyword)) {
					if(title.indexOf(keyword.getCode()) >= 0) {
						title = replaceKeword(keyword, title, parameter, sender, firstRecipient);
					}
					if(contents.indexOf(keyword.getCode()) >= 0) {
						contents = replaceKeword(keyword, contents, parameter, sender, firstRecipient);
					}
					if(url.indexOf(keyword.getCode()) >= 0) {
						url = replaceKeword(keyword, url, parameter, sender, firstRecipient);	
					}
				}
			}
		}
		message.setTitle(title);
		message.setMessage(contents);
		message.setUrl(url);
		return message;
	}

	abstract protected boolean isMyKeword(MessageKeyword keyword);

	abstract protected String replaceKeword(MessageKeyword keyword, String target, Parameter parameter, Sender sender, Recipient firstRecipient);
}