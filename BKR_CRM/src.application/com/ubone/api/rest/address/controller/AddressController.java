package com.ubone.api.rest.address.controller;

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

import com.ubone.api.rest.address.service.AddressSO;
import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.common.error.dao.ErrorDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;

/**
 * <pre>
 *  파 일 명  : AddressController.java
 *  설    명   : api address 컨트롤러
 *  작 성 자  : 
 *  작 성 일  : 2018.09.28
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
@RequestMapping("/address")
public class AddressController {

	@Resource
	private AddressSO addressSO;
	
	@Resource
	private ErrorDAO errorDAO;
	
	public AddressController(){
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
	 * 주소등록 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/insertAddress", method=RequestMethod.POST)
	public ModelAndView insertAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));                     // 회원PK
			parameter.setParameter("ID_STORE", request.getParameter("id_store"));                       // 매장PK
			parameter.setParameter("BRANCH_IDX", request.getParameter("branch_idx"));                   // 매장 소구역 코드
			parameter.setParameter("DELIVERY_TIME", request.getParameter("delivery_time"));             // 배달 예상시간
			parameter.setParameter("NIGHT_STORE_PK", request.getParameter("night_store_pk"));           // 야간 매장PK
			parameter.setParameter("NIGHT_BRANCH_IDX", request.getParameter("night_branch_idx"));       // 야간 매장 소구역 코드
			parameter.setParameter("NIGHT_DELIVERY_TIME", request.getParameter("night_delivery_time")); // 야간 배당 예상시간
			parameter.setParameter("NM_ADDR", request.getParameter("nm_addr"));                         // 주소제목
			parameter.setParameter("YN_ADDR_BASE", request.getParameter("yn_addr_base"));               // 기본주소여부
			parameter.setParameter("ZIP_CODE", request.getParameter("zip_code"));                       // 우편번호
			parameter.setParameter("DS_ADDR_STREET", request.getParameter("ds_addr_street"));           // 도로명주소
			parameter.setParameter("DS_ADDR_STREET_DTL", request.getParameter("ds_addr_street_dtl"));   // 도로명주소상세
			parameter.setParameter("DS_ADDR", request.getParameter("ds_addr"));                         // 지번주소
			parameter.setParameter("DS_ADDR_DTL", request.getParameter("ds_addr_dtl"));                 // 지번주소상세
			parameter.setParameter("CUST_DONG_SI", request.getParameter("cust_dong_si"));               // 주문시 사용 - 지번주소 시
			parameter.setParameter("CUST_DONG_GU", request.getParameter("cust_dong_gu"));               // 주문시 사용 - 지번주소 구
			parameter.setParameter("CUST_DONG_DONG", request.getParameter("cust_dong_dong"));           // 주문시 사용 - 지번주소 동
			parameter.setParameter("CUST_DONG_APPEND", request.getParameter("cust_dong_append"));       // 주문시 사용 - 지번주소 번지
			parameter.setParameter("CUST_GIL_SI", request.getParameter("cust_gil_si"));                 // 주문시 사용 - 도로명 시
			parameter.setParameter("CUST_GIL_GU", request.getParameter("cust_gil_gu"));                 // 주문시 사용 - 도로명 구
			parameter.setParameter("CUST_GIL_GIL", request.getParameter("cust_gil_gil"));               // 주문시 사용 - 도로명 길
			parameter.setParameter("CUST_GIL_APPEND", request.getParameter("cust_gil_append"));         // 주문시 사용 - 도로명 건물번호
			parameter.setParameter("CUST_GIL_DONG_DESC", request.getParameter("cust_gil_dong_desc"));   // 주문시 사용 - 주소 추가 상세 주소
			parameter.setParameter("X_COORDINATES", request.getParameter("x_coordinates"));             // 주문시 사용 - 회원좌표X
			parameter.setParameter("Y_COORDINATES", request.getParameter("y_coordinates"));             // 주문시 사용 - 회원좌표Y
			parameter.setParameter("CD_SEARCH_CHNN", request.getParameter("cd_search_chnn"));           // 조회채널구분

			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}

			// 3. 비즈니스 로직 구현
			Result result = addressSO.insertAddress(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 주소삭제 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/deleteAddress", method=RequestMethod.POST)
	public ModelAndView deleteAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("NO_ADDRESS", request.getParameter("no_address"));    // 주소일련번호
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));      // 회원PK
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("NO_ADDRESS"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}

			// 3. 비즈니스 로직 구현
			Result result = addressSO.deleteAddress(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 주소수정 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateAddress", method=RequestMethod.POST)
	public ModelAndView updateAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("NO_ADDRESS", request.getParameter("no_address"));    				// 주소일련번호
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));                     // 회원PK
			parameter.setParameter("ID_STORE", request.getParameter("id_store"));                       // 매장PK
			parameter.setParameter("BRANCH_IDX", request.getParameter("branch_idx"));                   // 매장 소구역 코드
			parameter.setParameter("DELIVERY_TIME", request.getParameter("delivery_time"));             // 배달 예상시간
			parameter.setParameter("NIGHT_STORE_PK", request.getParameter("night_store_pk"));           // 야간 매장PK
			parameter.setParameter("NIGHT_BRANCH_IDX", request.getParameter("night_branch_idx"));       // 야간 매장 소구역 코드
			parameter.setParameter("NIGHT_DELIVERY_TIME", request.getParameter("night_delivery_time")); // 야간 배당 예상시간
			parameter.setParameter("NM_ADDR", request.getParameter("nm_addr"));                         // 주소제목
			parameter.setParameter("YN_ADDR_BASE", request.getParameter("yn_addr_base"));               // 기본주소여부
			parameter.setParameter("ZIP_CODE", request.getParameter("zip_code"));                       // 우편번호
			parameter.setParameter("DS_ADDR_STREET", request.getParameter("ds_addr_street"));           // 도로명주소
			parameter.setParameter("DS_ADDR_STREET_DTL", request.getParameter("ds_addr_street_dtl"));   // 도로명주소상세
			parameter.setParameter("DS_ADDR", request.getParameter("ds_addr"));                         // 지번주소
			parameter.setParameter("DS_ADDR_DTL", request.getParameter("ds_addr_dtl"));                 // 지번주소상세
			parameter.setParameter("CUST_DONG_SI", request.getParameter("cust_dong_si"));               // 주문시 사용 - 지번주소 시
			parameter.setParameter("CUST_DONG_GU", request.getParameter("cust_dong_gu"));               // 주문시 사용 - 지번주소 구
			parameter.setParameter("CUST_DONG_DONG", request.getParameter("cust_dong_dong"));           // 주문시 사용 - 지번주소 동
			parameter.setParameter("CUST_DONG_APPEND", request.getParameter("cust_dong_append"));       // 주문시 사용 - 지번주소 번지
			parameter.setParameter("CUST_GIL_SI", request.getParameter("cust_gil_si"));                 // 주문시 사용 - 도로명 시
			parameter.setParameter("CUST_GIL_GU", request.getParameter("cust_gil_gu"));                 // 주문시 사용 - 도로명 구
			parameter.setParameter("CUST_GIL_GIL", request.getParameter("cust_gil_gil"));               // 주문시 사용 - 도로명 길
			parameter.setParameter("CUST_GIL_APPEND", request.getParameter("cust_gil_append"));         // 주문시 사용 - 도로명 건물번호
			parameter.setParameter("CUST_GIL_DONG_DESC", request.getParameter("cust_gil_dong_desc"));   // 주문시 사용 - 주소 추가 상세 주소
			parameter.setParameter("X_COORDINATES", request.getParameter("x_coordinates"));             // 주문시 사용 - 회원좌표X
			parameter.setParameter("Y_COORDINATES", request.getParameter("y_coordinates"));             // 주문시 사용 - 회원좌표Y

			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("NO_ADDRESS"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = addressSO.updateAddress(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 주소수정 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/getPosSchedule", method=RequestMethod.POST)
	public ModelAndView getPosSchedule(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("STOR_CD", request.getParameter("stor_cd"));    		// 점포 코드

			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("STOR_CD"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = addressSO.getPosSchedule(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}

}
