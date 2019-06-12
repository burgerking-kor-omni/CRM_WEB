package com.ubone.standard.system.message.util;

import com.ubone.standard.system.message.Message;



/** 
 * <pre>
 *  설    명 : 메세지 교정기
 *             - 메세지의 제목, 본분, url 등의 예약어 정보를 변환하거나
 *               발신자 정보 교정등의 부가적인 처리를 한다.
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface MessageCorrector {

	/**
	 * 메세지 교정
	 * @param message
	 * @return 교정된 message
	 */
	Message correct(Message message);
}
