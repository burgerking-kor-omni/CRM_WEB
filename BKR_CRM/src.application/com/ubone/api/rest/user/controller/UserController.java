package com.ubone.api.rest.user.controller;

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
import com.ubone.api.rest.user.service.UserSO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;

/**
 * <pre>
 *  파 일 명  : UserController.java
 *  설    명   : api user 컨트롤러
 *  작 성 자  : 
 *  작 성 일  : 2018.09.28
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserSO userSO;
	
	@Resource
	private ErrorDAO errorDAO;
	
	public UserController(){
	}
	
	Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * 공통 헤더 체크
	 * @param request Http Request Instance
	 */
	private boolean chkHeader(HttpServletRequest request) throws Exception {
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
	private ModelAndView ApiResultReturn(Result result) throws Exception {
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
	private ModelAndView ApiResultFail() throws Exception {
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
	private ModelAndView ApiRequiredCheck() throws Exception {
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
	 * 회원가입  - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/insertMember", method=RequestMethod.POST)
	public ModelAndView insertMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("JOIN_GUBUN", request.getParameter("join_gubun"));				// 가입구분
			parameter.setParameter("TP_SNS", request.getParameter("tp_sns"));						// SNS 구분 
			parameter.setParameter("SN_SNS", request.getParameter("sn_sns"));						// SNS SECRET 값
			parameter.setParameter("NM_MEMBER", request.getParameter("nm_member"));					// 회원명                                       
			parameter.setParameter("DS_EMAIL", request.getParameter("ds_email"));					// 회원이메일
			parameter.setParameter("NO_PHONE", request.getParameter("no_phone"));					// 회원전화번호
			parameter.setParameter("PASSWD", request.getParameter("passwd"));						// 비밀번호
			parameter.setParameter("DT_BIRTH", request.getParameter("dt_birth"));				    // 생년월일
			parameter.setParameter("CD_GENDER", request.getParameter("cd_gender"));					// 성별
			parameter.setParameter("CD_JOIN_PATH", request.getParameter("cd_join_path"));			// 가입경로
			parameter.setParameter("CD_JOIN_SITE", request.getParameter("cd_join_site"));			// 가입사이트
			parameter.setParameter("REG_IP", request.getParameter("reg_ip"));						// 등록IP
			parameter.setParameter("YN_CONFIRM", request.getParameter("yn_confirm"));				// 인증여부
			parameter.setParameter("CD_PIN", request.getParameter("cd_pin"));						// 회원핀코드
			parameter.setParameter("DI", request.getParameter("di"));								// 실명인증확인값
			parameter.setParameter("YN_SMS_RECV", request.getParameter("yn_sms_recv"));				// SMS수신여부
			parameter.setParameter("YN_EMAIL_RECV", request.getParameter("yn_email_recv"));			// EMAIL수신여부
			parameter.setParameter("YN_PRIVACY_AGREE", request.getParameter("yn_privacy_agree"));	// 개인정보수집동의여부
			parameter.setParameter("YN_BKR_AGREE", request.getParameter("yn_bkr_agree"));			// 버거킹이용약관동의여부
			parameter.setParameter("TOKEN_PK", request.getParameter("token_pk"));					// 푸시토큰PK
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("JOIN_GUBUN"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			} else {
				if (ApiConstantHolder.JOIN_BKR.equals(parameter.getParameter("JOIN_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("PASSWD"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.JOIN_SNS.equals(parameter.getParameter("JOIN_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("TP_SNS"))
							|| StringUtils.isEmpty(parameter.getParameter("SN_SNS"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else {
					mv = this.ApiRequiredCheck();
					return mv;
				}
				
				if (StringUtils.isEmpty(parameter.getParameter("NM_MEMBER"))
						|| StringUtils.isEmpty(parameter.getParameter("DS_EMAIL"))
						|| StringUtils.isEmpty(parameter.getParameter("NO_PHONE"))
						|| StringUtils.isEmpty(parameter.getParameter("DI"))) {
					mv = this.ApiRequiredCheck();
					return mv;
				}
			}

			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();
			
			if (ApiConstantHolder.JOIN_BKR.equals(parameter.getParameter("JOIN_GUBUN"))) {
				result = userSO.insertMember(parameter);
			} else if (ApiConstantHolder.JOIN_SNS.equals(parameter.getParameter("JOIN_GUBUN"))) {
				result = userSO.insertSnsMember(parameter);
			}

			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원 로그인 처리 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("CHK_GUBUN", request.getParameter("chk_gubun"));	// 로그인구분 (01:이메일, 02:app 토큰, 03:SNS)
			parameter.setParameter("CONNECT_GUBUN", request.getParameter("connect_gubun"));	// 접속구분 (01:APP, 02:WEB)
			parameter.setParameter("DS_EMAIL", request.getParameter("ds_email"));	// 비밀번호
			parameter.setParameter("PASSWD", request.getParameter("passwd"));		// E-Mail(로그인ID)
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));	// 회원PK
			parameter.setParameter("APP_TOKEN", request.getParameter("app_token"));	// APP 토큰
			parameter.setParameter("TP_SNS", request.getParameter("tp_sns"));		// SNS 구분 
			parameter.setParameter("SN_SNS", request.getParameter("sn_sns"));		// SNS SECRET 값
			parameter.setParameter("CD_GENDER", request.getParameter("cd_gender"));	// SNS 성별
			parameter.setParameter("BIRTHDAY", request.getParameter("birthday"));	// SNS 생일
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("CHK_GUBUN"))
					|| StringUtils.isEmpty(parameter.getParameter("CONNECT_GUBUN"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			} else {
				if (ApiConstantHolder.LOGIN_GUBUN_EMAIL.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("DS_EMAIL"))
							|| StringUtils.isEmpty(parameter.getParameter("PASSWD"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.LOGIN_GUBUN_TOKEN.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("APP_TOKEN"))
							|| StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.LOGIN_GUBUN_SNS.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("DS_EMAIL"))
							|| StringUtils.isEmpty(parameter.getParameter("TP_SNS"))
							|| StringUtils.isEmpty(parameter.getParameter("SN_SNS"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.LOGIN_GUBUN_TOKEN_F.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("DS_EMAIL"))
							|| StringUtils.isEmpty(parameter.getParameter("APP_TOKEN"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else {
					mv = this.ApiRequiredCheck();
					return mv;
				}
			}
			
			// 2. 비즈니스 로직 구현 - 로그인 구분에 따른 분기처리
			Result result = DataUtil.makeResult();
		
			if (ApiConstantHolder.LOGIN_GUBUN_EMAIL.equals(parameter.getParameter("CHK_GUBUN"))) {			// 이메일 로그인
				result = userSO.loginEmail(parameter);
			} else if (ApiConstantHolder.LOGIN_GUBUN_TOKEN.equals(parameter.getParameter("CHK_GUBUN"))) {	// APP Auto 로그인
				result = userSO.loginAuto(parameter);
			} else if (ApiConstantHolder.LOGIN_GUBUN_SNS.equals(parameter.getParameter("CHK_GUBUN"))) {		// SNS 로그인
				result = userSO.loginSns(parameter);
			} else if (ApiConstantHolder.LOGIN_GUBUN_TOKEN_F.equals(parameter.getParameter("CHK_GUBUN"))) {
				result = userSO.loginToKenFirst(parameter);
			}
				
			// 3. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원 로그인 처리 - (KIOSK)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/loginKiosk", method=RequestMethod.POST)
	public ModelAndView loginKiosk(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("BRCD_MEMBER", request.getParameter("brcd_member"));	// 회원바코드
			
			// 2. 비즈니스 로직 구현
			Result result = userSO.loginKiosk(parameter);
			
			// 3. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원  정보 조회 - (POS & KIOSK)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/member", method=RequestMethod.POST)
	public ModelAndView getMemberInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("BRCD_MEMBER", request.getParameter("brcd_member"));	// 회원바코드
			
			// 2. 비즈니스 로직 구현
			Result result = userSO.getMemberInfo(parameter);
			
			// 3. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원정보수정(전화번호, SMS/EMAIL 수신동의여부) - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateMember", method=RequestMethod.POST)
	public ModelAndView updateMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));			// 회원PK
			parameter.setParameter("NM_MEMBER", request.getParameter("nm_member"));			// 회원이름
			parameter.setParameter("NO_PHONE", request.getParameter("no_phone"));			// 전화번호
			parameter.setParameter("YN_SMS_RECV", request.getParameter("yn_sms_recv"));		// SMS 수신여부
			parameter.setParameter("YN_EMAIL_RECV", request.getParameter("yn_email_recv"));	// EMail 수신여부
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("NO_PHONE"))
					|| StringUtils.isEmpty(parameter.getParameter("YN_SMS_RECV"))
					|| StringUtils.isEmpty(parameter.getParameter("YN_EMAIL_RECV"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			result = userSO.updateMember(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원정보수정 전 비밀번호 체크  - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/chkPw", method=RequestMethod.POST)
	public ModelAndView checkPasswd(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));	// 회원PK
			parameter.setParameter("PASSWD", request.getParameter("passwd"));		// 비밀번호
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("PASSWD"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = userSO.checkPasswd(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원정보수정(비밀번호) - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/updateMemberPw", method=RequestMethod.POST)
	public ModelAndView updateMemberPw(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));	// 회원PK
			parameter.setParameter("PASSWD", request.getParameter("passwd"));		// 비밀번호
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("PASSWD"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 2. 비즈니스 로직 구현
			Result result = userSO.updateMemberPw(parameter);
			
			// 3. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}

	/**
	 * 회원 정보 중복 체크 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/chkJoin", method=RequestMethod.POST)
	public ModelAndView checkJoin(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("CHK_GUBUN", request.getParameter("chk_gubun"));		// 중복체크값 (01:이메일, 02:이름 + 전화번호, 03:DI, 04:SNS)
			parameter.setParameter("CHK_VALUE01", request.getParameter("chk_value01"));	// chk_gubun 이 '01' 일때 필수 / 아이디 값 셋팅 - 메일주소
			parameter.setParameter("CHK_VALUE02", request.getParameter("chk_value02"));	// chk_gubun 이 '02' 일때 필수 / 이름 값 셋팅
			parameter.setParameter("CHK_VALUE03", request.getParameter("chk_value03"));	// chk_gubun 이 '02' 일때 필수 / 전화번호 값 셋팅
			parameter.setParameter("CHK_VALUE04", request.getParameter("chk_value04"));	// chk_gubun 이 '03' 일때 필수 / DI 값 셋팅
			parameter.setParameter("CHK_VALUE05", request.getParameter("chk_value05"));	// chk_gubun 이 '04' 일때 필수 / SNS 구분 값 셋팅
			parameter.setParameter("CHK_VALUE06", request.getParameter("chk_value06"));	// chk_gubun 이 '04' 일때 필수 / SNS KEY 값 셋팅
			parameter.setParameter("CHK_VALUE07", request.getParameter("chk_value07"));	// chk_gubun 이 '04' 일때 필수 / SNS 이메일 값 셋팅
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("CHK_GUBUN"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			} else {
				if (ApiConstantHolder.JOIN_CHK_GUBUN_EMAIL.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("CHK_VALUE01"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.JOIN_CHK_GUBUN_NAME.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("CHK_VALUE02"))
							|| StringUtils.isEmpty(parameter.getParameter("CHK_VALUE03"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.JOIN_CHK_GUBUN_DI.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("CHK_VALUE04"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else if (ApiConstantHolder.JOIN_CHK_GUBUN_SNS.equals(parameter.getParameter("CHK_GUBUN"))) {
					if (StringUtils.isEmpty(parameter.getParameter("CHK_VALUE05"))
							|| StringUtils.isEmpty(parameter.getParameter("CHK_VALUE06"))
							||StringUtils.isEmpty(parameter.getParameter("CHK_VALUE07"))) {
						mv = this.ApiRequiredCheck();
						return mv;
					}
				} else {
					mv = this.ApiRequiredCheck();
					return mv;
				}
			}
			
			// 3. 비즈니스 로직 구현
			Result result = DataUtil.makeResult();

			// 중복체크 항목에 따른 분기처리
			if (ApiConstantHolder.JOIN_CHK_GUBUN_EMAIL.equals(parameter.getParameter("CHK_GUBUN"))
					|| ApiConstantHolder.JOIN_CHK_GUBUN_NAME.equals(parameter.getParameter("CHK_GUBUN"))
					|| ApiConstantHolder.JOIN_CHK_GUBUN_DI.equals(parameter.getParameter("CHK_GUBUN"))) {
				result = userSO.checkJoin(parameter);
			} else if (ApiConstantHolder.JOIN_CHK_GUBUN_SNS.equals(parameter.getParameter("CHK_GUBUN"))) {
				result = userSO.checkJoinSns(parameter);
			}
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원 ID 찾기 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public ModelAndView findMemberId(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("NM_MEMBER", request.getParameter("nm_member"));		// 회원명
			parameter.setParameter("NO_PHONE", request.getParameter("no_phone"));		// 회원전화번호
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("NM_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("NO_PHONE"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = userSO.findMemberId(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 비밀번호 초기화 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/resetPw", method=RequestMethod.POST)
	public ModelAndView resetMemberPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("NM_MEMBER", request.getParameter("nm_member"));		// 회원명
			parameter.setParameter("DS_EMAIL", request.getParameter("ds_email"));		// 회원이메일
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("NM_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("DS_EMAIL"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = userSO.resetMemberPassword(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 휴먼고객해제 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/releaseDormancy", method=RequestMethod.POST)
	public ModelAndView releaseDormancy(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));		// 회원PK
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}

			// 3. 비즈니스 로직 구현
			Result result = userSO.releaseDormancy(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 비밀번호 나중변경일 수정 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/changeLater", method=RequestMethod.POST)
	public ModelAndView changeLater(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));		// 회원PK
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}

			// 3. 비즈니스 로직 구현
			Result result = userSO.changeLater(parameter);

			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		
		return mv;
	}
	
	/**
	 * 추가 약관 동의 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/addTermsAgree", method=RequestMethod.POST)
	public ModelAndView addTermsAgree(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));		// 회원PK
			
			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}

			// 3. 비즈니스 로직 구현
			Result result = userSO.addTermsAgree(parameter);
			
			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}
	
	/**
	 * 회원 탈퇴 - (Web & APP)
	 * @param request Http Request Instance
	 * @param response Http Reqponse Instance
	 */
	@RequestMapping(value="/deleteMember", method=RequestMethod.POST)
	public ModelAndView deleteMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
			parameter.setParameter("ID_MEMBER", request.getParameter("id_member"));	// 회원PK
			parameter.setParameter("TP_DEL", request.getParameter("tp_del"));		// 탈퇴구분
			parameter.setParameter("DS_DEL", request.getParameter("ds_del"));		// 탈퇴사유

			// 2. 필수 체크
			if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))
					|| StringUtils.isEmpty(parameter.getParameter("TP_DEL"))) {
				mv = this.ApiRequiredCheck();
				return mv;
			}
			
			// 3. 비즈니스 로직 구현
			Result result = userSO.deleteMember(parameter);

			// 4. Return 데이터 공통 처리
			mv = this.ApiResultReturn(result);			
		} catch (Exception e) {
			// API Error 저장
			return this.ApiError(e);
		}
		return mv;
	}

}
