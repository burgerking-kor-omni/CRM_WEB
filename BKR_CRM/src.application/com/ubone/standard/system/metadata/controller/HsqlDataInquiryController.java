package com.ubone.standard.system.metadata.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.web.util.HttpUtils;
import com.ubone.standard.system.metadata.service.HsqlDataInquirySO;

/** 
 * <pre>
 *  파 일 명 : HsqlDataInquiryController.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Controller
public class HsqlDataInquiryController {
	private static final String SERVICE_COMMAND = "/hsql";
	
	@Resource
	private HsqlDataInquirySO hsqlDataInquirySO;
	
	@RequestMapping({ SERVICE_COMMAND + "/{methodId}.do", SERVICE_COMMAND + "/{methodId}.ub"})
	public final String handlerRequest(Map<String, Object> resultMap
			, HttpServletRequest request
			, HttpServletResponse response
			, @PathVariable("methodId") String methodId
			) throws Exception{
		Parameter parameter = HttpUtils.getParameter(request);
		resultMap.put(ConstantHolder.KEY_PARAMETER, parameter);
		
		Result result = DataUtil.makeResult();
		if("categoryCode".equals(methodId)){
			result = hsqlDataInquirySO.getCategoryCodeList(parameter);
		}else if("pidList".equals(methodId)){
			result = hsqlDataInquirySO.getPidList(parameter);
		}else if("pidListDetail".equals(methodId)){
			result = hsqlDataInquirySO.getPidListDetail(parameter);
		}else if("screenName".equals(methodId)){
			result = hsqlDataInquirySO.getScreenName(parameter);
		}else if("pidListByAuto".equals(methodId)){
			result = hsqlDataInquirySO.getPidListByAuto(parameter);
		}
		resultMap.put(ConstantHolder.KEY_SERVICE_RESULT, result);
		
		return "json";
	}
}
