package com.ubone.standard.system.message.util;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.code.Code;
import com.ubone.framework.util.code.CodeRepository;
import com.ubone.standard.system.message.MessageKeyword;
import com.ubone.standard.system.message.Message.Recipient;
import com.ubone.standard.system.message.Message.Sender;


/** 
 * <pre>
 *  설    명 : 파라미터에 담긴 실제값으로 예약어 변환 처리
 *             - 모든 예약어 변환처리중 마지막에 실행되야 한다.
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class ParameterKewordConverter extends AbstractKewordConverter {

	private static final Log logger = LogFactory.getLog(ParameterKewordConverter.class);
	
	@Resource
	private CodeRepository codeRepository;
	
	@Override
	protected boolean isMyKeword(MessageKeyword keyword) {
		return true;
	}
	
	@Override
	protected String replaceKeword(MessageKeyword keyword, String target, Parameter parameter, Sender sender, Recipient firstRecipient) {
			String value = parameter.get(keyword.getKeyword());
			if(keyword.getCodeCategory() != null) {
				value = getCodeDescription(keyword.getCodeCategory(), value, parameter);
			}
			
			if(StringUtils.isEmpty(value)) {
				if(logger.isWarnEnabled()) {
					logger.warn("there is no named [" + keyword.getKeyword() + "]  data in parameter; " + target);
				}
			}
			
			return target.replaceAll("\\{\\$" + keyword.getKeyword() + "\\}", value.replaceAll("\\n", "<br>"));
	}
	
	private String getCodeDescription(String codeCategory, String value, Parameter parameter) {
		Code code = codeRepository.findByCategoryId(codeCategory, parameter);					
		String name = code.getCodeName(value);
		return name == null ? value : name;
	}
}