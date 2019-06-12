package com.ubone.standard.system.message.util;

import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.message.MessageKeyword;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.Message.Sender;


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
public class AttachKewordConverter extends AbstractKewordConverter {
	
	@Override
	protected boolean isMyKeword(MessageKeyword keyword) {
		/*if(keyword == MessageKeyword.VOC_ATTACH) {
			return true;
		}*/
		return false;
	}
	
	@Override
	protected String replaceKeword(MessageKeyword keyword, String target, Parameter parameter, Sender sender, Recipient firstRecipient) {
		return target.replaceAll("\\{\\$" + keyword.getKeyword() + "\\}", "<a href='http://daum.net'>file</a>");
	}
}