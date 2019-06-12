package com.ubone.standard.alimy.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Result;
import com.ubone.standard.alimy.service.AlimyLoginSO;

/**
 * <pre>
 *  파 일 명 : AlimyLoginController.java
 *  설    명 : 알리미 로그인 컨트롤러
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.04.20
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
public class AlimyLoginController {

	@Resource
	private AlimyLoginSO alimyLoginSO;
	
	/**
	 * 로그인 요청 처리
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 * @throws Exception
	 */
	@RequestMapping("/alimyLogin.ub")
	public String login(Map<String, Object> resultMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Result result = alimyLoginSO.login(request, response, DataUtil.makeParameter(request.getParameterMap()));
		resultMap.put(ConstantHolder.KEY_SERVICE_RESULT,  result);
		
		return "json";
	}
}
