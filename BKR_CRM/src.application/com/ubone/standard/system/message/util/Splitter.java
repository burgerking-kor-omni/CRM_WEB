package com.ubone.standard.system.message.util;

import java.util.List;

import com.ubone.standard.system.message.Message;



/** 
 * <pre>
 *  설    명 : 메세지 분배기
 *             - 상황에 따라 메세지의 수신자 별로 메세지를 나누어 보낼 경우
 *               메세지를 수신자당 한개의 메세지로 분리한다.
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface Splitter {

	/**
	 * 메세지 분리
	 * @param message
	 * @return 수신자 건수 만큼 수신자당 한개의 메세지로 나눈 메세지 List
	 */
	List<Message> split(Message message);
}
