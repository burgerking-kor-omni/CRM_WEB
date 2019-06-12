package com.ubone.standard.system.message;

/** 
 * <pre>
 *  설    명 : 메세지 발송기
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface MessageSender {
	
	/**
	 * 메세지 발송
	 * @param message 발송할 메세지
	 * @return true when message sent successfully
	 * @throws DataAccessException
	 */
	boolean send(Message message);
}
