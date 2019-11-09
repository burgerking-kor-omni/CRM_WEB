package com.ubone.api.rest.coupon.controlller;

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
import com.ubone.api.rest.coupon.service.CouponSO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;

/**
 * <pre>
 *  파 일 명  : CouponController.java
 *  설    명   : api coupon 컨트롤러
 *  작 성 자  : 
 *  작 성 일  : 2018.11.14
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
@RequestMapping("/coupon")
public class CouponController {

	@Resource
	private CouponSO couponSO;
	
	@Resource
	private ErrorDAO errorDAO;
	
	public CouponController(){
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
	 * 쿠폰상태수정 - (다우기술)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateCouponUseDau", method=RequestMethod.POST)
	public void updateCouponUseDau(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		String returnMsg = "";
		
		try {
			// 0. Access Token 체크
//			if (!this.chkHeader(request)) {
//				mv = this.ApiResultFail();
//				return mv;
//			}

			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("SITE_ID", request.getParameter("site_id"));			// 업체ID
			parameter.setParameter("PIN_NUM", request.getParameter("no_cpn"));			// 쿠폰번호
			parameter.setParameter("STATUS", request.getParameter("status"));			// 상태
			parameter.setParameter("USEDATE", request.getParameter("usedate"));			// 사용일자
			parameter.setParameter("USE_AMT", request.getParameter("use_amt"));			// 사용가격
			parameter.setParameter("CANCEL_AMT", request.getParameter("cancel_amt"));	// 취소가격

			logger.info("/coupon/updateCouponUseDau request : " + request.getRemoteAddr() + " : " + parameter);
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("SITE_ID"))
					|| StringUtils.isEmpty(parameter.getParameter("PIN_NUM"))
					|| StringUtils.isEmpty(parameter.getParameter("STATUS"))
					|| StringUtils.isEmpty(parameter.getParameter("USEDATE"))) {
				returnMsg = ApiConstantHolder.DAU_ERROR + "|필수값오류";
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = couponSO.updateCouponUseDau(parameter);
			
			DataList dtResultInfo = result.getDataList("resultInfo");
			returnMsg = dtResultInfo.getString(0, "result_code") + "|" + dtResultInfo.getString(0, "result_message");

			logger.info("/coupon/updateCouponUseDau response : " + returnMsg);
		} catch (Exception e) {
			// API Error 저장
			returnMsg = ApiConstantHolder.DAU_ERROR + "|시스템오류";
		}
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(returnMsg);
	}
	
	/**
	 * 쿠폰상태수정(Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateCouponUse", method=RequestMethod.POST)
	public ModelAndView updateCouponUse(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		
		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}

			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("NO_PIN", request.getParameter("no_pin"));				// 핀일련번호
			parameter.setParameter("STATUS", request.getParameter("status"));				// 상태
			parameter.setParameter("ID_STORE_USE", request.getParameter("id_store_use"));	// 사용매장코드
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));			// 사용한주문번호
			parameter.setParameter("AMT_USE", request.getParameter("amt_use"));				// 사용가격
			parameter.setParameter("AMT_CANCEL", request.getParameter("amt_cancel"));		// 취소가격

			logger.info("/coupon/updateCouponUse request : " + request.getRemoteAddr() + " : " + parameter);
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("NO_PIN"))
					|| StringUtils.isEmpty(parameter.getParameter("STATUS"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = couponSO.updateCouponUse(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);

			logger.info("/coupon/updateCouponUse response : " + mv);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 쿠폰 상세 조회(Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/getCouponDetail", method=RequestMethod.POST)
	public ModelAndView getCouponDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		
		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}

			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			if ("0".equals(request.getParameter("id_member"))) {
				parameter.setParameter("ID_MEMBER", "NON");	// 회원PK
			} else {
				parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));	// 회원PK	
			}
			
			if ("0".equals(request.getParameter("no_pin"))) {
				parameter.setParameter("NO_PIN", null);	// 핀일련번호
			} else {
				parameter.setParameter("NO_PIN", request.getParameter("no_pin"));	// 핀일련번호
			}
			
			parameter.setParameter("UDID", request.getParameter("udid"));			// 기기ID
			parameter.setParameter("FG_APP", request.getParameter("fg_app"));		// APP 여부
			parameter.setParameter("CD_COUPON", request.getParameter("cd_coupon"));	// 쿠폰
//			parameter.setParameter("NO_PIN", request.getParameter("no_pin"));		// 핀일련번호

			logger.info("/coupon/getCouponDetail request : " + request.getRemoteAddr() + " : " + parameter);
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("CD_COUPON"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = couponSO.getCouponDetail(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);

			logger.info("/coupon/response response : " + mv);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 리워드 쿠폰 등록 (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateRewardCoupon", method=RequestMethod.POST)
	public ModelAndView updateRewardCoupon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		
		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}

			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("NO_MEMBER_STAMP_REWARD", request.getParameter("no_member_stamp_reward"));	// 회원스템프리워드일련번호
			parameter.setParameter("CD_COUPON", request.getParameter("cd_coupon"));								// 쿠폰
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));								// 회원PK

			logger.info("/coupon/updateRewardCoupon request : " + request.getRemoteAddr() + " : " + parameter);
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("NO_MEMBER_STAMP_REWARD"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_COUPON"))
					|| StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = couponSO.updateRewardCoupon(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);

			logger.info("/coupon/updateRewardCoupon response : " + mv);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 쿠폰 사용여부 체크 (KIOSK)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/checkUseCoupon", method=RequestMethod.POST)
	public ModelAndView checkUseCoupon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		
		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}

			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("PIN_NUM", request.getParameter("pin_num"));	// 핀번호

			logger.info("/coupon/checkUseCoupon request : " + request.getRemoteAddr() + " : " + parameter);
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("PIN_NUM"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = couponSO.checkUseCoupon(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);

			logger.info("/coupon/checkUseCoupon response : " + mv);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 쿠폰 제외매장 여부 조회
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/checkCouponStore", method=RequestMethod.POST)
	public ModelAndView checkCouponStore(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 클라이언트로 넘길 Response 셋팅
		ModelAndView mv = new ModelAndView("jsonView");	// 이곳에서 JSON으로 변환
		
		try {
			// 0. Access Token 체크
			if (!this.chkHeader(request)) {
				mv = this.ApiResultFail();
				return mv;
			}

			// 1. 비즈니스 구현을 위한  parameter 셋팅
			Parameter parameter = DataUtil.makeParameter();
			parameter.setParameter("CD_CHNN", request.getParameter("cd_chnn"));			// 조회채널 (01 : POS / KIOSK, 02 : APP/WEB)
			parameter.setParameter("CD_COUPON", request.getParameter("cd_coupon"));			// 쿠폰번호
			parameter.setParameter("ID_STORE_USE", request.getParameter("id_store_use"));	// 사용매장코드
			parameter.setParameter("PIN_NUM", request.getParameter("pin_num"));				// 핀번호

			logger.info("/coupon/checkCouponStore request : " + request.getRemoteAddr() + " : " + parameter);
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("CD_CHNN"))
					|| StringUtils.isEmpty(parameter.getParameter("ID_STORE_USE"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = couponSO.checkCouponStore(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);

			logger.info("/coupon/checkCouponStore response : " + mv);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}

}
