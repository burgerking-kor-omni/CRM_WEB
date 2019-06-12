package com.ubone.api.rest.stamp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.common.error.dao.ErrorDAO;
import com.ubone.api.rest.stamp.service.StampSO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;

/**
 * <pre>
 *  파 일 명  : StampController.java
 *  설    명   : api stamp 컨트롤러
 *  작 성 자  : 
 *  작 성 일  : 2018.11.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
@RequestMapping("/stamp")
public class StampController {

	@Resource
	private StampSO stampSO;
	
	@Resource
	private ErrorDAO errorDAO;
	
	public StampController(){
	}
	
	Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * 공통 헤더 체크
	 * @param request Http Request Instance
	 */
	private boolean chkHeader(HttpServletRequest request) {
		// 1. 헤더값으로 넘어온 token 값 암호화
		String token = request.getHeader("access_token");
		
		// 2. 토큰 비교
		if (!ApiConstantHolder.API_ACCESS_TOKEN.equals(token)) {
			//return false;
		}
		return true;
}
	
	/**
	 * Return 데이터 공통 처리
	 * @param Result
	 */
	private ModelAndView ApiResultReturn(Result result) {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
		// 클라이언트로 넘길 Response 셋팅
		// HEAD 값 셋팅
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_CODE, result.getServiceMessage().getResultStatus());
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_MESSAGE, result.getServiceMessage().getMessage());
		
		// BODY 값 셋팅
		DataList dtResultInfo = result.getDataList("resultInfo");
		responseBodyMap.put("result_code", dtResultInfo.getString(0, "result_code"));
		responseBodyMap.put("result_message", dtResultInfo.getString(0, "result_message"));
		responseBodyMap.put("result_data", result.getDataList("resultData"));
		
		// return 할 Response 값 셋팅
		responseMap.put(ApiConstantHolder.CONST_HEAD, responseHeadMap);
        responseMap.put(ApiConstantHolder.CONST_BODY, responseBodyMap);
        
        // ModelAndView Add
		mv.addAllObjects(responseMap);
		
		return mv;
	}
	
	/**
	 * 실패 공통 처리
	 * @param Result
	 */
	private ModelAndView ApiResultFail() {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_CODE, "Success");
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_MESSAGE, "");
		responseBodyMap.put("result_code", ApiConstantHolder.RESULT_FAIL);
		responseBodyMap.put("result_message", "비정상적인 접근입니다.");
		responseBodyMap.put("result_data", null);
		
		// return 할 Response 값 셋팅
		responseMap.put(ApiConstantHolder.CONST_HEAD, responseHeadMap);
	    responseMap.put(ApiConstantHolder.CONST_BODY, responseBodyMap);
		
		// ModelAndView Add
		mv.addAllObjects(responseMap);
		
		return mv;
	}
	
	/**
	 * 필수값 체크 처리
	 * @param Result
	 */
	private ModelAndView ApiRequiredCheck() {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_CODE, "Success");
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_MESSAGE, "");
		responseBodyMap.put("result_code", ApiConstantHolder.RESULT_REQ_CHK_FAIL);
		responseBodyMap.put("result_message", "파라미터값이 불충분합니다.");
		responseBodyMap.put("result_data", null);
		
		// return 할 Response 값 셋팅
		responseMap.put(ApiConstantHolder.CONST_HEAD, responseHeadMap);
	    responseMap.put(ApiConstantHolder.CONST_BODY, responseBodyMap);
		
		// ModelAndView Add
		mv.addAllObjects(responseMap);
		
		return mv;
	}
	
	/**
	 * 오류처리
	 * @param Excepion
	 */
	private ModelAndView ApiError(Exception e) {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
		errorDAO.insertApiError("", "", e);
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_CODE, "Fail");
		responseHeadMap.put(ApiConstantHolder.CONST_SERVICE_MESSAGE, e.getClass().getName());
		responseBodyMap.put("result_code", null);
		responseBodyMap.put("result_message", null);
		responseBodyMap.put("result_data", null);
		
		// return 할 Response 값 셋팅
		responseMap.put(ApiConstantHolder.CONST_HEAD, responseHeadMap);
	    responseMap.put(ApiConstantHolder.CONST_BODY, responseBodyMap);
	    
		// ModelAndView Add
		mv.addAllObjects(responseMap);
		
		return mv;
	}
	
	/**
	 * 스템프적립가능여부 확인 - (KIOSK)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/getStampExcept", method=RequestMethod.POST)
	public ModelAndView getStampExcept(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		Result result = DataUtil.makeResult();
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환

		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}
			
			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("ID_STORE", request.getParameter("id_store"));			/* 매장ID */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_STORE"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = stampSO.getStampExcept(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 스템프적립 - (KIOSK)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/insertStampKiosk", method=RequestMethod.POST)
	public ModelAndView insertStampKiosk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		Result result = DataUtil.makeResult();
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환

		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}
			
			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("BRCD_MEMBER", request.getParameter("brcd_member"));			/* 바코드번호 */
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));				/* 주문번호 */
			parameter.setParameter("STOR_CD", request.getParameter("stor_cd"));				    /* 주문매장 */
			parameter.setParameter("CD_MTH_PURCHS", request.getParameter("cd_mth_purchs"));		/* 구매방법 */
			parameter.setParameter("CD_ORDER_CHNN", request.getParameter("cd_order_chnn"));		/* 주문채널 */
			parameter.setParameter("PRODUCT_LIST", request.getParameter("product_list"));		/* 상품목록 */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("BRCD_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("ORDER_NO"))
					|| StringUtils.isEmpty(parameter.getParameter("STOR_CD"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_MTH_PURCHS"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_ORDER_CHNN"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = stampSO.insertStampKiosk(parameter);
			
			// 3. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 스템프적립 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/insertStamp", method=RequestMethod.POST)
	public ModelAndView insertStamp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		Result result = DataUtil.makeResult();
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환

		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}
			
			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));				/* 회원PK */
			parameter.setParameter("STOR_CD", request.getParameter("id_store"));				/* 매장ID */
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));				/* 주문번호 */
			parameter.setParameter("CD_MTH_PURCHS", request.getParameter("cd_mth_purchs"));		/* 구매방법 */
			parameter.setParameter("CD_ORDER_CHNN", request.getParameter("cd_order_chnn"));		/* 주문채널 */
			parameter.setParameter("PRODUCT_LIST", request.getParameter("product_list"));		/* 상품목록 */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("ORDER_NO"))
					|| StringUtils.isEmpty(parameter.getParameter("STOR_CD"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_MTH_PURCHS"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_ORDER_CHNN"))
					|| StringUtils.isEmpty(parameter.getParameter("PRODUCT_LIST"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = stampSO.insertStamp(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 리워드쿠폰 사용에 따른 주문취소 가능여부 확인 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/checkStamp", method=RequestMethod.POST)
	public ModelAndView checkStamp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		Result result = DataUtil.makeResult();
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환

		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}
			
			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));                  /* 주문번호 */
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));                /* 회원PK */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("ORDER_NO"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = stampSO.checkStamp(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
		
	/**
	 * 스템프차감 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/deleteStamp", method=RequestMethod.POST)
	public ModelAndView deleteStamp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		Result result = DataUtil.makeResult();
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환

		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}
			
			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));                  /* 주문번호 */
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));                /* 회원PK */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("ORDER_NO"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = stampSO.deleteStamp(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}

}
