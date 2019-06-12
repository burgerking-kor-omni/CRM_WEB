package com.ubone.api.rest.voc.controller;

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
import com.ubone.api.rest.voc.service.VocSO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;
import com.ubone.standard.common.encrypto.IwtCrypt;

/**
 * <pre>
 *  파 일 명  : VocController.java
 *  설    명   : api voc 컨트롤러
 *  작 성 자  : 
 *  작 성 일  : 2018.10.29
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
@RequestMapping("/voc")
public class VocController {

	@Resource
	private VocSO vocSO;
	
	@Resource
	private ErrorDAO errorDAO;
	
	public VocController(){
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
	 * 문의/클레임 등록 - (Web & APP & CallCenter)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/insertVoc", method=RequestMethod.POST)
	public ModelAndView insertVoc(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
						
			parameter.setParameter("BIZ_CHNN", request.getParameter("biz_chnn"));                                   /* 입력채널 */
			parameter.setParameter("ID_BIZ_KEY", request.getParameter("biz_key"));                                  /* 업무별 key */
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));                                   /* 주문번호 */
			parameter.setParameter("ID_STORE", request.getParameter("id_store"));                                   /* 매장PK */
			parameter.setParameter("FG_MEMBER", request.getParameter("fg_member"));                                 /* 회원여부 */
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));                                 /* 회원PK */
			parameter.setParameter("NM_CUST_REAL", request.getParameter("nm_cust"));
			parameter.setParameter("NO_PHONE_REAL", request.getParameter("no_phone"));
			if (!StringUtils.isEmpty(request.getParameter("nm_cust"))) {
				parameter.setParameter("NM_CUST", IwtCrypt.aesEncryptHex(request.getParameter("nm_cust")));             /* 이름 */	
			}
			if (!StringUtils.isEmpty(request.getParameter("no_phone"))) {
				parameter.setParameter("NO_PHONE", IwtCrypt.aesEncryptHex(request.getParameter("no_phone")));           /* 연락처 */	
			}
			parameter.setParameter("DS_EMAIL", request.getParameter("ds_email"));                                   /* 이메일 */
			parameter.setParameter("YN_PRIVACY_AGREE", request.getParameter("yn_privacy_agree"));                   /* 개인정보수집동의 */
			parameter.setParameter("YN_SENSITIVE_AGREE", request.getParameter("yn_sensitive_agree"));               /* 민감정보수집동의 */
			parameter.setParameter("YN_PRIVACY_ORDER_AGREE", request.getParameter("yn_privacy_order_agree"));       /* 개인정보제3자제공동의 */
			parameter.setParameter("YN_SENSITIVE_ORDER_AGREE", request.getParameter("yn_sensitive_order_agree"));   /* 민감정보제3자제공동의 */
			parameter.setParameter("CD_VOC_STATUS", request.getParameter("cd_voc_status"));                         /* voc 진행 상태 */
			parameter.setParameter("CD_ACT_CAUSE", request.getParameter("cd_act_cause"));                           /* 처리유형 */
			parameter.setParameter("DS_ACT_CONT", request.getParameter("ds_act_cont"));                             /* 처리결과 */
			parameter.setParameter("CD_VOC_CAUSE", request.getParameter("cd_voc_cause"));                           /* 유형 */
			parameter.setParameter("DS_TITLE", request.getParameter("ds_title"));                                   /* 제목 */
			parameter.setParameter("DS_CONT", request.getParameter("ds_contents"));                             	/* 내용 */
			parameter.setParameter("ID_REG_USER", request.getParameter("id_reg_user"));                             /* 최초등록자ID */
			parameter.setParameter("ID_UPD_USER", request.getParameter("id_upd_user"));                             /* 최근수정자ID */
			parameter.setParameter("DT_VOC_REG", request.getParameter("dt_voc_reg"));                               /* 발생일 */
			parameter.setParameter("PAYMENT_TYPE", request.getParameter("payment_type"));                           /* 결제 방법 */
			parameter.setParameter("PAYMENT_PRC", request.getParameter("payment_prc"));                             /* 결제 금액 */
			parameter.setParameter("DT_ORDER", request.getParameter("dt_order"));                                   /* 주문일자 */
			parameter.setParameter("MENU_NM", request.getParameter("menu_nm"));                                     /* 메뉴명 */
			parameter.setParameter("CD_STATUS", request.getParameter("cd_status"));                                 /* 회원상태 */
			parameter.setParameter("POS_ORDER_NO", request.getParameter("pos_order_no"));                           /* POS 주문번호  */
			parameter.setParameter("OMNI_ORDER_NO", request.getParameter("order_no"));                              /* OMNI 주문번호 */
			parameter.setParameter("CALL_ORDER_NO", request.getParameter("call_order_no"));                         /* CALL 주문번호 */
			parameter.setParameter("FILE_LIST", request.getParameter("file_list"));                                 /* 첨부파일 */
			parameter.setParameter("FG_IMM_PROCESS", request.getParameter("fg_imm_process"));                       /* 즉시처리여부 - 콜센터사용 */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("BIZ_CHNN"))
					|| StringUtils.isEmpty(parameter.getParameter("ID_BIZ_KEY"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_VOC_CAUSE"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_VOC_STATUS"))
					|| StringUtils.isEmpty(parameter.getParameter("FG_MEMBER"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = vocSO.insertVoc(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 문의/클레임 수정 - (Web & APP & CallCenter)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateVoc", method=RequestMethod.POST)
	public ModelAndView updateVoc(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_VOC", request.getParameter("id_voc"));                                       /* VOC ID */
			parameter.setParameter("BIZ_CHNN", request.getParameter("biz_chnn"));                                   /* 입력채널 */
			parameter.setParameter("ID_BIZ_KEY", request.getParameter("biz_key"));                                  /* 업무별 key */
			parameter.setParameter("ORDER_NO", request.getParameter("order_no"));                                   /* 주문번호 */
			parameter.setParameter("ID_STORE", request.getParameter("id_store"));                                   /* 매장PK */
			parameter.setParameter("FG_MEMBER", request.getParameter("fg_member"));                                 /* 회원여부 */
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));                                 /* 회원PK */
			if (!StringUtils.isEmpty(request.getParameter("nm_cust"))) {
				parameter.setParameter("NM_CUST", IwtCrypt.aesEncryptHex(request.getParameter("nm_cust")));             /* 이름 */	
			}
			if (!StringUtils.isEmpty(request.getParameter("no_phone"))) {
				parameter.setParameter("NO_PHONE", IwtCrypt.aesEncryptHex(request.getParameter("no_phone")));           /* 연락처 */	
			}
			parameter.setParameter("DS_EMAIL", request.getParameter("ds_email"));                                   /* 이메일 */
			parameter.setParameter("YN_PRIVACY_AGREE", request.getParameter("yn_privacy_agree"));                   /* 개인정보수집동의 */
			parameter.setParameter("YN_SENSITIVE_AGREE", request.getParameter("yn_sensitive_agree"));               /* 민감정보수집동의 */
			parameter.setParameter("YN_PRIVACY_ORDER_AGREE", request.getParameter("yn_privacy_order_agree"));       /* 개인정보제3자제공동의 */
			parameter.setParameter("YN_SENSITIVE_ORDER_AGREE", request.getParameter("yn_sensitive_order_agree"));   /* 민감정보제3자제공동의 */
			parameter.setParameter("CD_VOC_STATUS", request.getParameter("cd_voc_status"));                         /* voc 진행 상태 */
			parameter.setParameter("CD_ACT_CAUSE", request.getParameter("cd_act_cause"));                           /* 처리유형 */
			parameter.setParameter("DS_ACT_CONT", request.getParameter("ds_act_cont"));                             /* 처리결과 */
			parameter.setParameter("CD_VOC_CAUSE", request.getParameter("cd_voc_cause"));                           /* 유형 */
			parameter.setParameter("DS_TITLE", request.getParameter("ds_title"));                                   /* 제목 */
			parameter.setParameter("DS_CONT", request.getParameter("ds_contents"));                             	/* 내용 */
			parameter.setParameter("ID_REG_USER", request.getParameter("id_reg_user"));                             /* 최초등록자ID */
			parameter.setParameter("ID_UPD_USER", request.getParameter("id_upd_user"));                             /* 최근수정자ID */
			parameter.setParameter("DT_VOC_REG", request.getParameter("dt_voc_reg"));                               /* 발생일 */
			parameter.setParameter("PAYMENT_TYPE", request.getParameter("payment_type"));                           /* 결제 방법 */
			parameter.setParameter("PAYMENT_PRC", request.getParameter("payment_prc"));                             /* 결제 금액 */
			parameter.setParameter("DT_ORDER", request.getParameter("dt_order"));                                   /* 주문일자 */
			parameter.setParameter("MENU_NM", request.getParameter("menu_nm"));                                     /* 메뉴명 */
			parameter.setParameter("CD_STATUS", request.getParameter("cd_status"));                                 /* 회원상태 */
			parameter.setParameter("POS_ORDER_NO", request.getParameter("pos_order_no"));                           /* POS 주문번호  */
			parameter.setParameter("OMNI_ORDER_NO", request.getParameter("order_no"));                              /* OMNI 주문번호 */
			parameter.setParameter("CALL_ORDER_NO", request.getParameter("call_order_no"));                         /* CALL 주문번호 */
			parameter.setParameter("FILE", request.getParameter("file"));                                           /* 첨부파일 */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_VOC"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_VOC_CAUSE"))
					|| StringUtils.isEmpty(parameter.getParameter("CD_VOC_STATUS"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = vocSO.updateVoc(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 문의/클레임 삭제 - (Web & APP & CallCenter)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/deleteVoc", method=RequestMethod.POST)
	public ModelAndView deleteVoc(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("BIZ_CHNN", request.getParameter("biz_chnn"));                                   /* 입력채널 */
			parameter.setParameter("ID_VOC", request.getParameter("id_voc"));                                       /* VOC key */
			parameter.setParameter("ID_BIZ_KEY", request.getParameter("biz_key"));                                  /* 업무별 key */
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_VOC"))
					|| StringUtils.isEmpty(parameter.getParameter("BIZ_CHNN"))
					|| StringUtils.isEmpty(parameter.getParameter("ID_BIZ_KEY"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			result = vocSO.deleteVoc(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}

}
