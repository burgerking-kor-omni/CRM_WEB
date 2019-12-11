package com.ubone.api.rest.user.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.api.rest.common.constant.ApiCommon;
import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.common.log.dao.LoginLogDAO;
import com.ubone.api.rest.user.dao.UserDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;
import com.ubone.standard.common.encrypto.IwtCrypt;
import com.ubone.standard.common.encrypto.Passwdcrypt;

/** 
 * <pre>
 *  파 일 명  : UserSO.java
 *  설    명   : API 회원용 SO
 *  작 성 자  : 
 *  작 성 일  : 2018.10.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */

@Service
public class UserSO {
	
	@Resource
	private ApiCommon apiCommon;
	
	@Resource
	private UserDAO userDAO;
	
	@Resource
	private LoginLogDAO loginLogDAO;
	
	/**
	 * 회원가입  - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result insertMember(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> returnTemp = new HashMap<String, Object>();
		
		// 1. 이메일 값을 이용한 회원정보조회
		Parameter chkMailParam = DataUtil.makeParameter();
		chkMailParam.setParameter("DS_EMAIL", parameter.getParameter("DS_EMAIL"));
		DataList dtChkMailData = userDAO.getMember(chkMailParam);
		
		// 1-1. 중복회원체크
		if (0 < dtChkMailData.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.JOIN_OVERLAP_EMAIL);
			resultInfo.put("result_message", "이미 사용중인 이메일 주소 입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", dtChkMailData));
			return result;
		}
		
		// 2. 실명인증값을 이용한 회원조회
		Parameter chkDiParam = DataUtil.makeParameter();
		chkDiParam.setParameter("DI", parameter.getParameter("DI"));
		DataList dtChkDiData = userDAO.getMember(chkDiParam);
		
		// 2-1. 중복회원체크
		if (0 < dtChkDiData.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.JOIN_OVERLAP_DI);
			resultInfo.put("result_message", "이미 서비스 가입 중인 회원 정보입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", dtChkDiData));
			return result;
		}
		
		// 3. 암호화
		parameter.setParameter("NM_MEMBER", IwtCrypt.aesEncryptHex(parameter.getParameter("NM_MEMBER").toString()));
		parameter.setParameter("NO_PHONE", IwtCrypt.aesEncryptHex(parameter.getParameter("NO_PHONE").toString()));
		parameter.setParameter("PASSWD", Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(parameter.getParameter("PASSWD").toString())));
		
		// 4. 연령대 계산
		if (!StringUtils.isEmpty(parameter.getParameter("DT_BIRTH"))) {
			String birthday = parameter.getParameter("DT_BIRTH");
			String cdAge = this.ageCalculation(birthday);
			parameter.setParameter("CD_AGE", cdAge);
		}
		
		// 5. 생일 계산
		if (!StringUtils.isEmpty(parameter.getParameter("DT_BIRTH"))) {
			String birthday = parameter.getParameter("DT_BIRTH");
			if (8 == birthday.length()) {
				parameter.setParameter("BIRTHDAY", birthday.substring(4));
			}
		}

		// 6. 저장
		String idMember = userDAO.insertMember(parameter);
		
		// 7. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_SUCCESS);
		resultInfo.put("result_message", "회원가입이 완료되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 8. 회원정보 조회
		Parameter searchParam = DataUtil.makeParameter();
		searchParam.setParameter("ID_MEMBER", idMember);
		if (StringUtils.isEmpty(searchParam.getParameter("ID_MEMBER"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_REQ_CHK_FAIL);
			resultInfo.put("result_message", "회원PK은 필수 입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", returnTemp));
			return result;
		}
		DataList dtData = userDAO.getMember(searchParam);
		
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * SNS 회원가입  - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result insertSnsMember(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> returnTemp = new HashMap<String, Object>();
		
		// 1. SNS 값을 이용한 회원정보조회
		Parameter chkSnsParam = DataUtil.makeParameter();
		chkSnsParam.setParameter("TP_SNS", parameter.getParameter("TP_SNS"));
		chkSnsParam.setParameter("SN_SNS", parameter.getParameter("SN_SNS"));
		DataList dtChkSns = userDAO.getMemberSns(chkSnsParam);
		
		// 1-2. 중복회원체크
		if (0 < dtChkSns.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.JOIN_OVERLAP_SNS);
			resultInfo.put("result_message", "이미 서비스 가입 중인 회원 정보입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", dtChkSns));
			return result;
		}
		
		// 2. 실명인증값 값을 이용한 회원정보조회
		Parameter chkDiParam = DataUtil.makeParameter();
		chkDiParam.setParameter("DI", parameter.getParameter("DI"));
		DataList dtChkDiData = userDAO.getMember(chkDiParam);
		
		// 2-1. 중복회원체크
		if (0 < dtChkDiData.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.JOIN_OVERLAP_DI);
			resultInfo.put("result_message", "이미 서비스 가입 중인 회원 정보입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", dtChkDiData));
			return result;
		}
		
		// 3. 이메일 값을 이용한 회원정보조회
		Parameter chkMailParam = DataUtil.makeParameter();
		chkMailParam.setParameter("DS_EMAIL", parameter.getParameter("DS_EMAIL"));
		DataList dtChkMailData = userDAO.getMember(chkMailParam);
		
		// 3-1. 중복회원체크
		if (0 < dtChkMailData.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.JOIN_OVERLAP_EMAIL);
			resultInfo.put("result_message", "이미 사용 중인 이메일 주소입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", dtChkMailData));
			return result;
		}
		
		// 4. 암호화
		parameter.setParameter("NM_MEMBER", IwtCrypt.aesEncryptHex(parameter.getParameter("NM_MEMBER").toString()));
		parameter.setParameter("NO_PHONE", IwtCrypt.aesEncryptHex(parameter.getParameter("NO_PHONE").toString()));
		// 비밀번호 값이 필수인데 SNS는 따로 비밀번호를 받지 않아 예외처리
		parameter.setParameter("PASSWD", Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(parameter.getParameter("SN_SNS").toString())));
		
		// 5. 연령대 계산
		if (!StringUtils.isEmpty(parameter.getParameter("DT_BIRTH"))) {
			String birthday = parameter.getParameter("DT_BIRTH");
			String cdAge = this.ageCalculation(birthday);
			parameter.setParameter("CD_AGE", cdAge);
		}
		
		// 6. 생일 계산
		if (!StringUtils.isEmpty(parameter.getParameter("DT_BIRTH"))) {
			String birthday = parameter.getParameter("DT_BIRTH");
			if (8 == birthday.length()) {
				parameter.setParameter("BIRTHDAY", birthday.substring(4));
			}
		}

		// 7. 저장
		String idMember = userDAO.insertMember(parameter);
		
		// 8. SNS 저장
		parameter.setParameter("ID_MEMBER", idMember);
		userDAO.insertMemberSns(parameter);
		
		// 9. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_SUCCESS);
		resultInfo.put("result_message", "회원가입이 완료되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 10. 회원정보 조회
		Parameter searchParam = DataUtil.makeParameter();
		searchParam.setParameter("ID_MEMBER", idMember);
		if (StringUtils.isEmpty(searchParam.getParameter("ID_MEMBER"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_REQ_CHK_FAIL);
			resultInfo.put("result_message", "회원PK는 필수 입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", returnTemp));
			return result;
		}
		DataList dtData = userDAO.getMember(searchParam);
		
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}

	/**
	 * 회원 로그인 처리 - Email
	 * @param HTTP 요청 파라미터  
	 * @return 로그인 성공/실패 여부
	 */
	public Result loginEmail(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();	// 회원정보 조회 예외시 사용
		
		// 1. 회원정보조회
		DataList dtData = userDAO.getMember(parameter);
		
		// 2. login 체크 - 이메일
		if (0 < dtData.getRowCount()) {
			// 3. 비밀번호 일치 확인
			String dcryptPw = Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(parameter.getParameter("PASSWD").toString()));	// 비밀번호 암호화
			if (!dcryptPw.equals(dtData.getString(0, "PASSWD"))) {
				// 3-1. login 실패건수 증가
				userDAO.updateLoginFailCnt(parameter);
				
				resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_ERROR_PW);
				resultInfo.put("result_message", "입력하신 아이디/비밀번호로 로그인 할 수 없습니다.\n다시 입력해 주세요.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
				result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData)));
				return result;
			}
			
			// 4. login info
			loginLogDAO.insertLoginLog(dtData.getString(0, "ID_MEMBER"));

			Parameter loginParam = DataUtil.makeParameter();
			loginParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
			loginParam.setParameter("CONNECT_GUBUN", parameter.getParameter("CONNECT_GUBUN"));
			loginParam.setParameter("TOKEN_PK", UUID.randomUUID().toString());
			loginParam.setParameter("WEB_TOKEN_PK", UUID.randomUUID().toString());
			userDAO.updateLoginMember(loginParam);
			
			// 4-1. 토큰처리로 인한 회원 정보 조회
			DataList dtMidData = userDAO.getMember(parameter);
			
			// 5. 휴면 계정 여부
			if (ApiConstantHolder.CD_STATUS_H.equals(dtData.getString(0, "CD_STATUS"))) {
				resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_DORMANCY);
				resultInfo.put("result_message", "해당 계정은 휴면상태입니다.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
				result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
				return result;
			}
			
			// 6. 비밀번호변경일
			if (ApiConstantHolder.FLAG_Y.equals(dtData.getString(0, "FG_AFTER"))) {				// 나중변경일이 존재
				if (ApiConstantHolder.FLAG_Y.equals(dtData.getString(0, "FG_AFTER_CHNG"))) {	// 나중변경이이 당일일때
					resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_PW_CHNG);
					resultInfo.put("result_message", "비밀번호를 변경할 시기입니다.");
					result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
					result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
					return result;
				}
			} else {
				if (180 <= Integer.parseInt(dtData.getString(0, "DAY_CHNG_PW"))) {				// 비밀번호 변경일 - 180일
					resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_PW_CHNG);
					resultInfo.put("result_message", "비밀번호를 변경할 시기입니다.");
					result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
					result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
					return result;
				}
			}
			
			// 7. 임시비밀번호 발급
			if (ApiConstantHolder.FLAG_Y.endsWith(dtData.getString(0, "YN_TEMP_PASSWD"))) {
				resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_TEMP_PW);
				resultInfo.put("result_message", "임시비밀번호가 발급된 회원입니다.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
				result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
				return result;
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_NONE_ID);
			resultInfo.put("result_message", "입력하신 아이디/비밀번호로 로그인 할 수 없습니다.\n다시 입력해 주세요.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", tempMap));
			return result;
		}

		resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_SUCCESS);
		resultInfo.put("result_message", "정상적으로 로그인되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 8. login 데이터
//		Parameter endParam = DataUtil.makeParameter();
//		endParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
//		DataList dtEndData = userDAO.getMember(endParam);
		Parameter endParam = DataUtil.makeParameter();
		endParam.setParameter("DS_EMAIL", parameter.getParameter("DS_EMAIL"));
		DataList dtEndData = userDAO.getMember(endParam);
		
		if (0 < dtEndData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtEndData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원 로그인 처리 - SNS
	 * @param HTTP 요청 파라미터  
	 * @return 로그인 성공/실패 여부
	 */
	public Result loginSns(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();	// 회원정보 조회 예외시 사용
		
		// 1. 회원정보조회
		DataList dtData = userDAO.getMemberSns(parameter);
		
		// 2. login 체크 - 이메일
		if (dtData.getRowCount() <= 0) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_NONE_ID);
			resultInfo.put("result_message", "등록되지 않은 회원입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", tempMap));
			return result;
		}
		
		// 3. login info
		loginLogDAO.insertLoginLog(dtData.getString(0, "ID_MEMBER"));
		
		Parameter loginParam = DataUtil.makeParameter();
		loginParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
		loginParam.setParameter("CONNECT_GUBUN", parameter.getParameter("CONNECT_GUBUN"));
		loginParam.setParameter("TOKEN_PK", UUID.randomUUID().toString());
		loginParam.setParameter("WEB_TOKEN_PK", UUID.randomUUID().toString());
		userDAO.updateLoginMember(loginParam);
		
		// 3-1. 토큰처리로 인한 회원 정보 조회
		DataList dtMidData = userDAO.getMember(parameter);
		
		// 4. 휴면 계정 여부
		if (ApiConstantHolder.CD_STATUS_H.equals(dtData.getString(0, "CD_STATUS"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_DORMANCY);
			resultInfo.put("result_message", "해당 계정은 휴면상태입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
			return result;
		}
		
		// 5. SNS 로그인시 회원 성별, 생일정보 수정
		parameter.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
		userDAO.updateMemberInfo(parameter);
		
		resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_SUCCESS);
		resultInfo.put("result_message", "정상적으로 로그인되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 6. login 데이터
//		Parameter endParam = DataUtil.makeParameter();
//		endParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
//		DataList dtEndData = userDAO.getMember(endParam);
		
		Parameter endParam = DataUtil.makeParameter();
		endParam.setParameter("TP_SNS", parameter.getParameter("TP_SNS"));
		endParam.setParameter("SN_SNS", parameter.getParameter("SN_SNS"));
		DataList dtEndData = userDAO.getMemberSns(endParam);
		
		if (0 < dtEndData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtEndData));
			result.addDataList(dtResultData);
		}
				
		return result;
	}
	
	/**
	 * 회원 로그인 처리 - 자동로그인
	 * @param HTTP 요청 파라미터  
	 * @return 로그인 성공/실패 여부
	 */
	public Result loginAuto(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();	// 회원정보 조회 예외시 사용
		
		// 1. 회원정보조회
		DataList dtData = userDAO.getMemberAuto(parameter);
		
		// 2. login 체크 - 이메일
		if (dtData.getRowCount() <= 0) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_CHANGE_TOKEN);
			resultInfo.put("result_message", "다른 기기에서 로그인하여 접속이 로그아웃 되었습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", tempMap));
			return result;
		}
		
		// 3. login info
		loginLogDAO.insertLoginLog(dtData.getString(0, "ID_MEMBER"));
		
		Parameter loginParam = DataUtil.makeParameter();
		loginParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
		loginParam.setParameter("CONNECT_GUBUN", parameter.getParameter("CONNECT_GUBUN"));
		loginParam.setParameter("TOKEN_PK", UUID.randomUUID().toString());
		loginParam.setParameter("WEB_TOKEN_PK", UUID.randomUUID().toString());
		userDAO.updateLoginMember(loginParam);
		
		// 3-1. 토큰처리로 인한 회원 정보 조회
		DataList dtMidData = userDAO.getMember(parameter);
		
		// 4. 휴면 계정 여부
		if (ApiConstantHolder.CD_STATUS_H.equals(dtData.getString(0, "CD_STATUS"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_DORMANCY);
			resultInfo.put("result_message", "해당 계정은 휴면상태입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
			return result;
		}
		
		resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_SUCCESS);
		resultInfo.put("result_message", "정상적으로 로그인되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 5. login 데이터
		Parameter endParam = DataUtil.makeParameter();
		endParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
		DataList dtEndData = userDAO.getMember(endParam);
		
//		Parameter endParam = DataUtil.makeParameter();
//		endParam.setParameter("CONNECT_GUBUN", parameter.getParameter("CONNECT_GUBUN"));
//		endParam.setParameter("APP_TOKEN", parameter.getParameter("APP_TOKEN"));
//		DataList dtEndData = userDAO.getMemberAuto(endParam);
		
		if (0 < dtEndData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtEndData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원 로그인 처리 - 신규앱 최초 로그인
	 * @param HTTP 요청 파라미터  
	 * @return 로그인 성공/실패 여부
	 */
	public Result loginToKenFirst(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();	// 회원정보 조회 예외시 사용
		
		// 1. 회원정보조회
		DataList dtData = userDAO.getMemberTokenFirst(parameter);
		
		// 2. login 체크 - 이메일
		if (dtData.getRowCount() <= 0) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_CHANGE_TOKEN);
			resultInfo.put("result_message", "유효한 정보가 존재하지 않습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", tempMap));
			return result;
		}
		
		// 3. login info
		loginLogDAO.insertLoginLog(dtData.getString(0, "ID_MEMBER"));
		
		Parameter loginParam = DataUtil.makeParameter();
		loginParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
		loginParam.setParameter("CONNECT_GUBUN", parameter.getParameter("CONNECT_GUBUN"));
		loginParam.setParameter("TOKEN_PK", UUID.randomUUID().toString());
		loginParam.setParameter("WEB_TOKEN_PK", UUID.randomUUID().toString());
		userDAO.updateLoginMember(loginParam);
		
		// 3-1. 토큰처리로 인한 회원 정보 조회
		DataList dtMidData = userDAO.getMember(parameter);
		
		// 4. 휴면 계정 여부
		if (ApiConstantHolder.CD_STATUS_H.equals(dtData.getString(0, "CD_STATUS"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_DORMANCY);
			resultInfo.put("result_message", "해당 계정은 휴면상태입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", this.commonMemberInfo(dtMidData)));
			return result;
		}
		
		resultInfo.put("result_code", ApiConstantHolder.RESULT_LOGIN_SUCCESS);
		resultInfo.put("result_message", "정상적으로 로그인되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 5. login 데이터
		Parameter endParam = DataUtil.makeParameter();
		endParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
		DataList dtEndData = userDAO.getMember(endParam);
		
		if (0 < dtEndData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtEndData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	
	
	
	
	/**
	 * 회원 로그인 처리 - (KIOSK)
	 * @param HTTP 요청 파라미터  
	 * @return 로그인 성공/실패 여부
	 */
	public Result loginKiosk(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		if (StringUtils.isEmpty(parameter.getParameter("BRCD_MEMBER"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_REQ_CHK_FAIL);
			resultInfo.put("result_message", "바코드은 필수 입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", tempMap));
			return result;
		}
		DataList dtData = userDAO.getMember(parameter);
		
		// 2. 조회된 회원여부 체크
		if (0 < dtData.getRowCount()) {
			resultCode = ApiConstantHolder.RESULT_LOGIN_SUCCESS;
			resultMessage = "정상적으로 로그인 되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_LOGIN_NONE_ID;
			resultMessage = "등록되지 않은 회원입니다..";
		}

		// 3. login 정보
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. login 데이터
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원  정보 조회 - (POS & KIOSK)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result getMemberInfo(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		if (StringUtils.isEmpty(parameter.getParameter("BRCD_MEMBER"))) {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_REQ_CHK_FAIL);
			resultInfo.put("result_message", "바코드은 필수 입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", tempMap));
			return result;
		}
		DataList dtData = userDAO.getMember(parameter);
		
		// 2. 조회된 회원여부 체크
		if (0 < dtData.getRowCount()) {
			resultCode = "01";
			resultMessage = "정상적으로 조회 되었습니다.";
		} else {
			resultCode = "99";
			resultMessage = "유효하지 않음 바코드 정보 입니다.";
		}

		// 3. 회원조회 정보
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. login 데이터
		if (0 < dtData.getRowCount()) {
			Map<String, Object> resultData = new HashMap<String, Object>();
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));
			resultData.put("nm_member", IwtCrypt.aesDecryptHex(dtData.getString(0, "NM_MEMBER")));
			resultData.put("no_phone", IwtCrypt.aesDecryptHex(dtData.getString(0, "NO_PHONE")));
			resultData.put("cnt_stamp", dtData.getString(0, "CNT_STAMP"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 *  회원정보수정(전화번호, SMS/EMAIL 수신동의여부) - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateMember(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 전화번호/이름 암호화
		String paramPhone = "";
		String paramName = "";
		if (StringUtils.isNotBlank(parameter.getParameter("NO_PHONE").toString())) {
			paramPhone = IwtCrypt.aesEncryptHex(parameter.getParameter("NO_PHONE").toString());
			parameter.setParameter("NO_PHONE", paramPhone);	
		}
		if (StringUtils.isNotBlank(parameter.getParameter("NM_MEMBER").toString())) {
			paramName = IwtCrypt.aesEncryptHex(parameter.getParameter("NM_MEMBER").toString());
			parameter.setParameter("NM_MEMBER", paramName);	
		}
		
		// 2. 회원정보조회
		Parameter chkParam = DataUtil.makeParameter();
		chkParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
		DataList dtData = userDAO.getMember(chkParam);
		
		// 2. 조회된 회원여부 체크
		if (0 < dtData.getRowCount()) {
			// 2-1. SMS 수신동의여부 변경 체크
			if (dtData.getString(0, "YN_SMS_RECV").equals(parameter.getParameter("YN_SMS_RECV"))) {
				parameter.setParameter("FLAG_SMS_RECV", "N");
			} else {
				// 2-2. SMS 수신동의여부가 변경됬을때 기존데이터에 따른 처리로직을 위한 값 셋팅
				parameter.setParameter("FLAG_SMS_RECV", "Y");
			}
			
			// 2-3. EMail 수신동의여부 변경 체크
			if (dtData.getString(0, "YN_EMAIL_RECV").equals(parameter.getParameter("YN_EMAIL_RECV"))) {
				parameter.setParameter("FLAG_EMAIL_RECV", "N");
			} else {
				// 2-4. EMail 수신동의여부가 변경됬을때 기존데이터에 따른 처리로직을 위한 값 셋팅
				parameter.setParameter("FLAG_EMAIL_RECV", "Y");
			}
			
			userDAO.updateMember(parameter);
			
			// 3. 변경이력저장
			// 3-1. 전화번호
			if (!paramPhone.equals(dtData.getString(0, "NO_PHONE"))) {
				Parameter chagParam2 = DataUtil.makeParameter();
				chagParam2.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
				chagParam2.setParameter("CD_CHNG_ITEM", ApiConstantHolder.CD_CHNG_ITEM_PHONE);
				chagParam2.setParameter("VAL_ITEM_BR", dtData.getString(0, "NO_PHONE"));
				chagParam2.setParameter("VAL_ITEM_AF", paramPhone);
				userDAO.insertMemberRecord(chagParam2);
			}
			// 3-2. SMS 수신동의
			if (ApiConstantHolder.FLAG_Y.equals(parameter.getParameter("FLAG_SMS_RECV"))) {
				Parameter chagParam3 = DataUtil.makeParameter();
				chagParam3.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
				chagParam3.setParameter("CD_CHNG_ITEM", ApiConstantHolder.CD_CHNG_ITEM_SMS);
				chagParam3.setParameter("VAL_ITEM_BR", dtData.getString(0, "YN_SMS_RECV"));
				chagParam3.setParameter("VAL_ITEM_AF", parameter.getParameter("YN_SMS_RECV"));
				userDAO.insertMemberRecord(chagParam3);
			}
			// 3-3. EMAIL 수신동의
			if (ApiConstantHolder.FLAG_Y.equals(parameter.getParameter("FLAG_EMAIL_RECV"))) {
				Parameter chagParam4 = DataUtil.makeParameter();
				chagParam4.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
				chagParam4.setParameter("CD_CHNG_ITEM", ApiConstantHolder.CD_CHNG_ITEM_EMAIL);
				chagParam4.setParameter("VAL_ITEM_BR", dtData.getString(0, "YN_EMAIL_RECV"));
				chagParam4.setParameter("VAL_ITEM_AF", parameter.getParameter("YN_EMAIL_RECV"));
				userDAO.insertMemberRecord(chagParam4);
			}
			
			resultCode = ApiConstantHolder.RESULT_UPDATE_SUCCESS;
			resultMessage = "정상적으로 수정되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
			resultMessage = "수정할 정보가 존재하지 않습니다.";
		}

		// 4. 정상처리
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 5. 회원 데이터
		if (0 < dtData.getRowCount()) {
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원정보수정 전 비밀번호 체크  - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkPasswd(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 비밀번호 암호화
		parameter.setParameter("PASSWD", Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(parameter.getParameter("PASSWD").toString())));
		
		// 2. 비밀번호 체크
		DataList dtData = userDAO.checkPasswd(parameter);
		
		// 3. 조회된 회원여부 체크
		if (0 < dtData.getRowCount()) {
			resultCode = ApiConstantHolder.PASSWORD_MATCH;
			resultMessage = "비밀번호가 일치합니다.";
		} else {
			resultCode = ApiConstantHolder.PASSWORD_NONE_MATCH;
			resultMessage = "비밀번호가 일치하지 않습니다.";
		}

		// 4. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 5. 회원 데이터
		if (0 < dtData.getRowCount()) {
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원정보수정(비밀번호) - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateMemberPw(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		Parameter chkParam = DataUtil.makeParameter();
		chkParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
		DataList dtData = userDAO.getMember(chkParam);
		
		// 2. 비밀번호 암호화
		String paramPw = Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(parameter.getParameter("PASSWD").toString()));
		parameter.setParameter("PASSWD", paramPw);
		
		// 3. 회원비밀번호 수정
		if (0 < dtData.getRowCount()) {
			userDAO.updateMemberPw(parameter);
			
			// 4. 변경이력저장
			Parameter chagParam = DataUtil.makeParameter();
			chagParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
			// 4-1. 비밀번호
			if (!paramPw.equals(dtData.getString(0, "PASSWD"))) {
				chagParam.setParameter("CD_CHNG_ITEM", ApiConstantHolder.CD_CHNG_ITEM_PW);
				chagParam.setParameter("VAL_ITEM_BR", "");
				chagParam.setParameter("VAL_ITEM_AF", "");
				userDAO.insertMemberRecord(chagParam);
			}
			
			resultCode = ApiConstantHolder.RESULT_UPDATE_SUCCESS;
			resultMessage = "정상적으로 수정되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
			resultMessage = "수정할 정보가 존재하지 않습니다.";
		}

		// 4. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 5. 회원 데이터
		if (0 < dtData.getRowCount()) {
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원 정보 중복 체크 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkJoin(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		String idMember = "";
		
		// 1. 회원 정보 중복 체크
		// 1-1. 이름 + 전화번호 암호화
		if (ApiConstantHolder.JOIN_CHK_GUBUN_EMAIL.equals(parameter.getParameter("CHK_GUBUN"))) {
			parameter.setParameter("DS_EMAIL", parameter.getParameter("CHK_VALUE01"));
		} else if (ApiConstantHolder.JOIN_CHK_GUBUN_NAME.equals(parameter.getParameter("CHK_GUBUN"))) {
			parameter.setParameter("NM_MEMBER", IwtCrypt.aesEncryptHex(parameter.getParameter("CHK_VALUE02").toString()));
			parameter.setParameter("NO_PHONE", IwtCrypt.aesEncryptHex(parameter.getParameter("CHK_VALUE03").toString()));
		} else if (ApiConstantHolder.JOIN_CHK_GUBUN_DI.equals(parameter.getParameter("CHK_GUBUN"))) {
			parameter.setParameter("DI", parameter.getParameter("CHK_VALUE04"));
		}
		
		// 1-2. 회원 정보 중복 체크 조회
		DataList dtData = userDAO.checkJoin(parameter);
		
		// 2. 조회된 회원여부 체크
		if (0 < dtData.getRowCount()) {
			// 2-1. 중복체크값에 따른 분기처리
			if (ApiConstantHolder.JOIN_CHK_GUBUN_EMAIL.equals(parameter.getParameter("CHK_GUBUN"))) {		// 이메일
				resultCode = ApiConstantHolder.JOIN_OVERLAP_EMAIL;
				resultMessage = "이미 사용중인 이메일 주소 입니다.";
				idMember = dtData.getString(0, "ID_MEMBER");
			} else if (ApiConstantHolder.JOIN_CHK_GUBUN_NAME.equals(parameter.getParameter("CHK_GUBUN"))) {	// 이름 + 전화번호
				resultCode = ApiConstantHolder.JOIN_OVERLAP_NAME;
				resultMessage = "이미 서비스 가입 중인 회원 정보입니다.";
				idMember = dtData.getString(0, "ID_MEMBER");
			} else if (ApiConstantHolder.JOIN_CHK_GUBUN_DI.equals(parameter.getParameter("CHK_GUBUN"))) {	// DI
				resultCode = ApiConstantHolder.JOIN_OVERLAP_DI;
				resultMessage = "이미 서비스 가입 중인 회원 정보입니다.";
				idMember = dtData.getString(0, "ID_MEMBER");
			}
		} else {
			resultCode = ApiConstantHolder.JOIN_OVERLAP_SUCCES;
			resultMessage = "가입이 가능합니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. return data
		resultData.put("id_member", idMember);
		resultData.put("chk_gubun", parameter.getParameter("CHK_GUBUN"));
		resultData.put("chk_value01", parameter.getParameter("CHK_VALUE01"));
		resultData.put("chk_value02", parameter.getParameter("CHK_VALUE02"));
		resultData.put("chk_value03", parameter.getParameter("CHK_VALUE03"));
		resultData.put("chk_value04", parameter.getParameter("CHK_VALUE04"));
		resultData.put("chk_value05", parameter.getParameter("CHK_VALUE05"));
		resultData.put("chk_value06", parameter.getParameter("CHK_VALUE06"));
		resultData.put("chk_value07", parameter.getParameter("CHK_VALUE07"));
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	/**
	 * 회원 정보 중복 체크 SNS - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkJoinSns(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		String idMember = "";
		
		// 1. 회원 정보 중복 체크
		parameter.setParameter("TP_SNS", parameter.getParameter("CHK_VALUE05"));
		parameter.setParameter("SN_SNS", parameter.getParameter("CHK_VALUE06"));
		parameter.setParameter("DS_EMAIL_SNS", parameter.getParameter("CHK_VALUE07"));
		
		// 1-2. 회원 정보 중복 체크 조회
		DataList dtChkSns = userDAO.getSns(parameter);
		
		// 2. 조회된 회원여부 체크
		if (0 < dtChkSns.getRowCount()) {
			resultCode = "41";
			resultMessage = "이미 서비스 가입 중인 회원 정보입니다.";
			idMember = dtChkSns.getString(0, "ID_MEMBER");
		} else {
			if (!StringUtils.isEmpty(parameter.getParameter("DS_EMAIL_SNS"))) {
				DataList dtChkSnsMember = userDAO.getSnsMember(parameter);
				
				if (0 < dtChkSnsMember.getRowCount()) {
					resultCode = "11";
					resultMessage = "이미 사용 중인 이메일 주소입니다.";
					idMember = dtChkSnsMember.getString(0, "ID_MEMBER");
				} else {
					resultCode = "01";
					resultMessage = "가입이 가능합니다.";
				}
			} else {
				resultCode = "01";
				resultMessage = "가입이 가능합니다.";
			}
		}

		// 3. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 회원 데이터
		resultData.put("id_member", idMember);
		resultData.put("chk_gubun", parameter.getParameter("CHK_GUBUN"));
		resultData.put("chk_value01", parameter.getParameter("CHK_VALUE01"));
		resultData.put("chk_value02", parameter.getParameter("CHK_VALUE02"));
		resultData.put("chk_value03", parameter.getParameter("CHK_VALUE03"));
		resultData.put("chk_value04", parameter.getParameter("CHK_VALUE04"));
		resultData.put("chk_value05", parameter.getParameter("CHK_VALUE05"));
		resultData.put("chk_value06", parameter.getParameter("CHK_VALUE06"));
		resultData.put("chk_value07", parameter.getParameter("CHK_VALUE07"));
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	/**
	 * 회원 ID 찾기 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result findMemberId(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원 정보 중복 체크
		// 1-1. 이름 + 전화번호 암호화
		parameter.setParameter("NM_MEMBER", IwtCrypt.aesEncryptHex(parameter.getParameter("NM_MEMBER").toString()));
		parameter.setParameter("NO_PHONE", IwtCrypt.aesEncryptHex(parameter.getParameter("NO_PHONE").toString()));
		
		// 1-2. 회원 정보 중복 체크 조회
		DataList dtData = userDAO.findMemberId(parameter);
		
		// 2. 조회된 회원여부 체크
		if (0 < dtData.getRowCount()) {
			resultCode = ApiConstantHolder.RESULT_SELECT_SUCCESS;
			resultMessage = Integer.toString(dtData.getRowCount()) + " 건에 회원정보가 조회되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_SELECT_FAIL;
			resultMessage = "회원정보가 존재하지 않습니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 회원 데이터
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", dtData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 비밀번호 초기화 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result resetMemberPassword(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 비밀번호 초기화
		// 1-1. 이름 암호화
		parameter.setParameter("NM_MEMBER", IwtCrypt.aesEncryptHex(parameter.getParameter("NM_MEMBER").toString()));
		
		// 1-2. 비밀번호 초기화 대상 조회
		DataList dtData = userDAO.getResetMember(parameter);
		
		// 2. 비밀번호 초기화 대상 체크
		if (0 < dtData.getRowCount()) {
			// 2-1. 임시비밀번호 생성 및 암호화
//			tempPassword = apiCommon.tempPassword();
//			String dcryptTempPassword = Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(tempPassword));
			
			// 2-2. 임시비밀번호 update
//			Parameter tempPwParam = DataUtil.makeParameter();
//			tempPwParam.setParameter("ID_MEMBER", dtData.getString(0, "ID_MEMBER"));
//			tempPwParam.setParameter("PASSWD", dcryptTempPassword);
//			userDAO.updateTempPassword(tempPwParam);
			
			if("01".equals(dtData.getString(0, "CD_JOIN_SITE"))) {
				resultCode = ApiConstantHolder.RESULT_SELECT_SUCCESS;
				resultMessage = "회원정보가 존재합니다.";
			}
			else {
				String siteTitle = "간편가입으";
				if("02".equals(dtData.getString(0, "CD_JOIN_SITE"))) {
					siteTitle = "네이버 아이디";
				}
				else if("03".equals(dtData.getString(0, "CD_JOIN_SITE"))) {
					siteTitle = "삼성카드 앱으";
				}
				else if("04".equals(dtData.getString(0, "CD_JOIN_SITE"))) {
					siteTitle = "카카오톡 아이디";
				}
				resultCode = "03";
				resultMessage = siteTitle + "로 회원가입 하셨습니다. 버거킹에서는 비밀번호를 변경 하실 수 없습니다.";
			}
		} else {
			resultCode = ApiConstantHolder.RESULT_SELECT_FAIL;
			resultMessage = "회원정보가 존재하지 않습니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 회원 데이터
		if (0 < dtData.getRowCount()) {
			Map<String, Object> resultData = new HashMap<String, Object>();
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));
			resultData.put("ds_email", parameter.getParameter("DS_EMAIL"));
			DataList dtResetData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResetData);
		}
		
		return result;
	}
	
	/**
	 * 휴먼고객해제 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result releaseDormancy(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		DataList dtChk = userDAO.getMember(parameter);
		
		// 2. 회원정보여부체크
		if (0 < dtChk.getRowCount()) {
			// 2-1. 휴먼해제 
			userDAO.updateDormancy(parameter);
			
			resultCode = ApiConstantHolder.DORMANCY_ACTIVATION;
			resultMessage = "계정이 활성화 되었습니다.";
		} else {
			resultCode = ApiConstantHolder.DORMANCY_DISABLED;
			resultMessage = "회원정보가 존재하지 않습니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 회원정보 재조회
		DataList dtData = userDAO.getMember(parameter);

		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 비밀번호 나중변경일 수정 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result changeLater(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		DataList dtChk = userDAO.getMember(parameter);
		
		// 2. 회원정보여부체크
		if (0 < dtChk.getRowCount()) {
			// 2-1. 나중변경일 수정 - 30일이후
			userDAO.updateChangeLater(parameter);
			
			resultCode = ApiConstantHolder.RESULT_UPDATE_SUCCESS;
			resultMessage = "정상적으로 수정되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
			resultMessage = "수정할 정보가 존재하지 않습니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 회원정보 재조회
		DataList dtData = userDAO.getMember(parameter);

		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 추가 약관 동의 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result addTermsAgree(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		DataList dtChk = userDAO.getMember(parameter);
		
		// 2. 회원정보여부체크
		if (0 < dtChk.getRowCount()) {
			// 2-1. 추가약관동의
			userDAO.updateAddTermsAgree(parameter);
			
			resultCode = ApiConstantHolder.RESULT_UPDATE_SUCCESS;
			resultMessage = "정상적으로 수정되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
			resultMessage = "수정할 정보가 존재하지 않습니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 회원정보 재조회
		DataList dtData = userDAO.getMember(parameter);

		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonMemberInfo(dtData));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원 탈퇴 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result deleteMember(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 회원정보조회
		DataList dtData = userDAO.getMember(parameter);
		
		// 2. 회원정보여부체크
		if (0 < dtData.getRowCount()) {
			// 2-1. 회원 탈퇴 테이블 정보 저장
			parameter.setParameter("CD_AGE", dtData.getString(0, "CD_AGE"));
			parameter.setParameter("CD_GENDER", dtData.getString(0, "CD_GENDER"));
			parameter.setParameter("CD_GRADE", dtData.getString(0, "CD_GRADE"));
			userDAO.insertDelMember(parameter);

			// 2-2. 회원 탈퇴
			userDAO.deletelMember(parameter);
			
			// 2-3. 회원 주소 탈퇴
			userDAO.deletelMemberAddr(parameter);
		
			// 2-4. 회원 SNS 탈퇴
			userDAO.deletelSnsMember(parameter);
			
			resultCode = ApiConstantHolder.RESULT_DELETE_SUCCESS;
			resultMessage = "정상적으로 삭제가 되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_DELETE_FAIL;
			resultMessage = "삭제할 정보가 존재하지 않습니다.";
		}

		// 3. 회원 정보 중복 체크 조회
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);

		if (0 < dtData.getRowCount()) {
			Map<String, Object> resultData = new HashMap<String, Object>();
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));                       /* 회원PK */
			resultData.put("nm_member", IwtCrypt.aesDecryptHex(dtData.getString(0, "NM_MEMBER").toString()));  /* 회원명 */
			resultData.put("ds_email", dtData.getString(0, "DS_EMAIL"));                         /* 회원이메일 */
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원정보셋팅
	 * @param DataList
	 * @return Map
	 */
	private Map<String, Object> commonMemberInfo(DataList dtData) throws Exception {
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		if (0 < dtData.getRowCount()) {
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));                          /* 회원PK */
			resultData.put("brcd_member", dtData.getString(0, "BRCD_MEMBER"));                      /* 회원바코드 */
			resultData.put("no_kiosk", dtData.getString(0, "NO_KIOSK"));                            /* 키오스크회원번호 */
			if (StringUtils.isNotBlank(dtData.getString(0, "NM_MEMBER").trim())) {
				resultData.put("nm_member", IwtCrypt.aesDecryptHex(dtData.getString(0, "NM_MEMBER")));  /* 회원명 */	
			}
			resultData.put("ds_email", dtData.getString(0, "DS_EMAIL"));                            /* 회원이메일 */
			if (StringUtils.isNotBlank(dtData.getString(0, "NO_PHONE").trim())) {
				resultData.put("no_phone", IwtCrypt.aesDecryptHex(dtData.getString(0, "NO_PHONE")));    /* 회원전화번호 */	
			}
			resultData.put("passwd", dtData.getString(0, "PASSWD"));                                /* 비밀번호 */
			resultData.put("dt_chng_passwd", dtData.getString(0, "DT_CHNG_PASSWD"));                /* 비밀번호최종변경일 */
			resultData.put("dt_after_chng_passwd", dtData.getString(0, "DT_AFTER_CHNG_PASSWD"));    /* 비밀번호나중에변경일 */
			resultData.put("yn_temp_passwd", dtData.getString(0, "YN_TEMP_PASSWD"));                /* 임시비밀번호발급여부 */
			resultData.put("cd_status", dtData.getString(0, "CD_STATUS"));                          /* 회원상태 */
			resultData.put("cd_grade", dtData.getString(0, "CD_GRADE"));                            /* 등급코드 */
			resultData.put("dt_chng_grade", dtData.getString(0, "DT_CHNG_GRADE"));                  /* 회원등급변경일자 */
			resultData.put("cnt_stamp", dtData.getString(0, "CNT_STAMP"));                          /* 스템프갯수 */
			resultData.put("dt_birth", dtData.getString(0, "DT_BIRTH"));                            /* 생년월일 */
			resultData.put("birthday", dtData.getString(0, "BIRTHDAY"));                            /* 생일 */
			resultData.put("cd_age", dtData.getString(0, "CD_AGE"));                                /* 연령대 */
			resultData.put("cd_gender", dtData.getString(0, "CD_GENDER"));                          /* 성별 */
			resultData.put("no_car", dtData.getString(0, "NO_CAR"));                                /* 차량번호 */
			resultData.put("cd_join_path", dtData.getString(0, "CD_JOIN_PATH"));                    /* 가입경로 */
			resultData.put("cd_join_site", dtData.getString(0, "CD_JOIN_SITE"));                    /* 가입사이트 */
			resultData.put("dt_join", dtData.getString(0, "DT_JOIN"));                              /* 가입일 */
			resultData.put("reg_ip", dtData.getString(0, "REG_IP"));                                /* 등록IP */
			resultData.put("yn_confirm", dtData.getString(0, "YN_CONFIRM"));                        /* 인증여부 */
			resultData.put("yn_confirm_re", dtData.getString(0, "YN_CONFIRM_RE"));                  /* 재인증여부 */
			resultData.put("cd_pin", dtData.getString(0, "CD_PIN"));                                /* 회원핀코드 */
			resultData.put("di", dtData.getString(0, "DI"));                                        /* 실명인증확인값 */
			resultData.put("dt_confirm", dtData.getString(0, "DT_CONFIRM"));                        /* 실명인증일 */
			resultData.put("yn_sms_recv", dtData.getString(0, "YN_SMS_RECV"));                      /* SMS수신여부 */
			resultData.put("dt_sms_recv", dtData.getString(0, "DT_SMS_RECV"));                      /* SMS수신동의일 */
			resultData.put("yn_email_recv", dtData.getString(0, "YN_EMAIL_RECV"));                  /* EMAIL수신여부 */
			resultData.put("dt_email_recv", dtData.getString(0, "DT_EMAIL_RECV"));                  /* EMAIL수신동의일 */
			resultData.put("yn_privacy_agree", dtData.getString(0, "YN_PRIVACY_AGREE"));            /* 개인정보수집동의여부 */
			resultData.put("dt_privacy_agree", dtData.getString(0, "DT_PRIVACY_AGREE"));            /* 개인정보수집동의일 */
			resultData.put("yn_bkr_agree", dtData.getString(0, "YN_BKR_AGREE"));                    /* 버거킹이용약관동의여부 */
			resultData.put("dt_bkr_agree", dtData.getString(0, "DT_BKR_AGREE"));                    /* 버거킹이용약관동의일 */
			resultData.put("dt_dormancy", dtData.getString(0, "DT_DORMANCY"));                      /* 휴면처리일 */
			resultData.put("token_pk", dtData.getString(0, "TOKEN_PK"));                            /* 토큰PK */
			resultData.put("web_token_pk", dtData.getString(0, "WEB_TOKEN_PK"));                    /* WEB토큰PK */
			resultData.put("cnt_fail_login", dtData.getString(0, "CNT_FAIL_LOGIN"));                /* 로그인실패건수 */
			resultData.put("dt_last_login", dtData.getString(0, "DT_LAST_LOGIN"));                  /* 최종로그인일시 */
			resultData.put("mig_target_chnn", dtData.getString(0, "MIG_TARGET_CHNN"));              /* 마이그대상채널 */
			resultData.put("dt_reg", dtData.getString(0, "DT_REG"));                                /* 최초등록일시 */
			resultData.put("id_reg_user", dtData.getString(0, "ID_REG_USER"));                      /* 최초등록자 */
			resultData.put("dt_upt", dtData.getString(0, "DT_UPT"));                                /* 최근수정일시 */
			resultData.put("id_upt_user", dtData.getString(0, "ID_UPT_USER"));                      /* 최근수정자 */
		}
		return resultData;
	}
	
	/**
	 * 회원 연령대 계산
	 * @param DataList
	 * @return Map
	 */
	private String ageCalculation(String birthday) {
		String cdAge = "";
		if (8 == birthday.length()) {
			Calendar current = Calendar.getInstance();
	        int currentYear  = current.get(Calendar.YEAR);
	        int age = currentYear - Integer.parseInt(birthday.substring(0, 4));
	        
	        if (age < 20) {
	        	cdAge = "10";
	        } else if (age >= 20 && age < 30) {
	        	cdAge = "20";
	        } else if (age >= 30 && age < 40) {
	        	cdAge = "30";
	        } else if (age >= 40 && age < 50) {
	        	cdAge = "40";
	        } else if (age >= 50 && age < 60) {
	        	cdAge = "50";
	        } else {
	        	cdAge = "60";
	        }
		}
		return cdAge;
	}

}
