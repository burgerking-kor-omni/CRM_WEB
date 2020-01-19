package com.ubone.api.rest.common.constant;

import com.ubone.framework.util.property.PropertyService;
import com.ubone.framework.util.property.PropertyUtil;

/** 
 * <pre>
 *  파 일 명  : ApiConstantHolder.java
 *  설    명   : Api Constant Holder
           API 상수값들의 관리를 집중하기 위한 클래스
 *  작 성 자  : 
 *  작 성 일  : 2018.10.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public final class ApiConstantHolder {
	
	private static PropertyService propertyService;
	
	static {
		propertyService = PropertyUtil.makeClassPathReadOnlyPropertyService("resource/config/constantApi.xml");
	}
	
	
	// ========================================================
	// 프레임웍 기본 상수
	// ========================================================
	/**
	 * 상수샘플 키 : voc.sample.constant
	 */
	public static final String SAMPLE = propertyService.get("api.sample.constant", "apiConstant");
	
	// ========================================================
	// 시스템 모드
	// ========================================================
	public static final String SYSTEM_MODE_LOCAL		= "local";	// 로컬
	public static final String SYSTEM_MODE_DEV			= "dev";	// 개발
	public static final String SYSTEM_MODE_OPER			= "real";	// 운영
	
	// ========================================================
	// API Access Token
	// ========================================================
	public static final String API_ACCESS_TOKEN				= "";
	
	// ========================================================
	// API 공통 Const
	// ========================================================
	public static final String CONST_HEAD				= "head";
	public static final String CONST_BODY				= "body";
	public static final String CONST_SERVICE_CODE		= "service_code";
	public static final String CONST_SERVICE_MESSAGE	= "service_message";
	
	// ========================================================
	// Y / N
	// ========================================================
	public static final String FLAG_Y					= "Y";
	public static final String FLAG_N					= "N";
	
	// ========================================================
	// 공통 - 비정상적 접근
	// ========================================================	
	public static final String RESULT_REQ_CHK_FAIL		= "98";		// 필수체크값 없음
	public static final String RESULT_FAIL				= "99";		// 비정상적인 접근
	
	// ========================================================
	// 공통 - 등록/수정/삭제
	// ========================================================
	public static final String RESULT_SELECT_SUCCESS	= "01";		// 성공
	public static final String RESULT_SELECT_FAIL		= "02";		// 실패
	public static final String RESULT_INSERT_SUCCESS	= "01";		// 성공
	public static final String RESULT_INSERT_FAIL		= "02";		// 실패
	public static final String RESULT_UPDATE_SUCCESS	= "01";		// 성공
	public static final String RESULT_UPDATE_FAIL		= "02";		// 실패
	public static final String RESULT_DELETE_SUCCESS	= "01";		// 성공
	public static final String RESULT_DELETE_FAIL		= "02";		// 실패
	
	// ========================================================
	// 회원 가입 구분
	// ========================================================
	public static final String JOIN_BKR						= "01";	// 버거킹
	public static final String JOIN_SNS						= "02";	// SNS
	
	// ========================================================
	// 로그인구분
	// ========================================================
	public static final String LOGIN_GUBUN_EMAIL			= "01";	// 이메일
	public static final String LOGIN_GUBUN_TOKEN			= "02";	// APP 토큰
	public static final String LOGIN_GUBUN_SNS				= "03";	// SNS
	public static final String LOGIN_GUBUN_TOKEN_F			= "04";	// 최초 로그인

	// ========================================================
	// 회원 정보 중복 체크 구분
	// ========================================================
	public static final String JOIN_CHK_GUBUN_EMAIL			= "01";	// 이메일
	public static final String JOIN_CHK_GUBUN_NAME			= "02";	// 이름 + 전화번호
	public static final String JOIN_CHK_GUBUN_DI			= "03";	// 실명인증값
	public static final String JOIN_CHK_GUBUN_SNS			= "04";	// SNS
	
	// ========================================================
	// 회원 정보 중복 체크 결과 구분
	// ========================================================
	public static final String JOIN_OVERLAP_SUCCES			= "01";	// 성공
	public static final String JOIN_OVERLAP_EMAIL			= "11";	// 이메일 중복
	public static final String JOIN_OVERLAP_DI				= "21";	// 실명인증값 중복
	public static final String JOIN_OVERLAP_NAME			= "31";	// 이름 + 전화번호 중복
	public static final String JOIN_OVERLAP_SNS				= "41";	// SNS 중복
	
	// ========================================================
	// 회원 로그인 결과
	// ========================================================
	public static final String RESULT_LOGIN_SUCCESS			= "01";	// 성공
	public static final String RESULT_LOGIN_NONE_ID			= "11";	// 아이디 없음
	public static final String RESULT_LOGIN_ERROR_PW		= "21";	// 비밀번호 오류
	public static final String RESULT_LOGIN_DORMANCY		= "31";	// 휴면계정
	public static final String RESULT_LOGIN_PW_CHNG			= "41";	// 비밀번호변경
	public static final String RESULT_LOGIN_TEMP_PW			= "51";	// 임시비밀번호 발급중
	public static final String RESULT_CHANGE_TOKEN			= "61";	// 토큰값 변경
	public static final String RESULT_LOGIN_FAIL			= "99";	// 회원로그인 실패
	
	// ========================================================
	// 회원 상태
	// ========================================================
	public static final String CD_STATUS_A					= "A";	// 성공
	public static final String CD_STATUS_H					= "H";	// 휴먼
	public static final String CD_STATUS_S					= "S";	// 탈퇴
	
	// ========================================================
	// 회원 정보수정 항목
	// ========================================================
	public static final String CD_CHNG_ITEM_PHONE			= "01";	// 휴대폰번호
	public static final String CD_CHNG_ITEM_PW				= "02";	// 비밀번호
	public static final String CD_CHNG_ITEM_SMS				= "03";	// SMS 수신동의
	public static final String CD_CHNG_ITEM_EMAIL			= "04";	// EMAIL 수신동의
	public static final String CD_CHNG_ITEM_NAME			= "05";	// 이름
	
	// ========================================================
	// 비밀번호 일치
	// ========================================================
	public static final String PASSWORD_MATCH				= "01";	// 일치
	public static final String PASSWORD_NONE_MATCH			= "02";	// 미일치
	
	// ========================================================
	// 휴먼계정 활성화
	// ========================================================
	public static final String DORMANCY_ACTIVATION			= "01";	// 활성화
	public static final String DORMANCY_DISABLED			= "02";	// 비활성화
	
	// ========================================================
	// 스템프
	// ========================================================
	public static final String STAMP_POSSIBLE				= "01";	// 적립가능
	public static final String STAMP_NONE_MEMBER			= "11";	// 회원미존재
	public static final String STAMP_NONE_PRODUCT			= "21";	// 상품미존재
	public static final String STAMP_NONE_STORE				= "31";	// 제외매장
	public static final String STAMP_NONE_CONDITION			= "41";	// 조건불충분
	public static final String STAMP_NONE_STAMP				= "51";	// 스템프 적립 불가
	
	// ========================================================
	// 스템프 설정구분
	// ========================================================
	public static final String STAMP_DEFAULT				= "01";	// 기본
	public static final String STAMP_EVENT					= "02";	// 이벤트
	
	// ========================================================
	// 스템프 증/차감
	// ========================================================
	public static final String CD_INCREMENT_PLUS			= "01";	// 증가
	public static final String CD_INCREMENT_MINUS			= "02";	// 차감
	
	public static final String TP_INCREMENT_PLUS_MENU		= "01";	// 상품구입
	public static final String TP_INCREMENT_PLUS_MONEY		= "02";	// 머니충전
	public static final String TP_INCREMENT_MINUS_ORDER		= "03";	// 주문취소
	public static final String TP_INCREMENT_MINUS_CHANGE	= "04";	// 스템프전환
	
	// ========================================================
	// 스템프 취소
	// ========================================================
	public static final String STAMP_CANCEL					= "01";	// 취소가능
	public static final String STAMP_NONE_SAVE_STANP		= "02";	// 적립된 스템프 없음
	public static final String STAMP_NONE_CANCEL_STANP		= "03";	// 취소가능 스템프 없음
	public static final String STAMP_NONE_CANCEL			= "11";	// 취소불가
	
	// ========================================================
	// 리워드 구분
	// ========================================================
	public static final String TP_REWARD_FIVE				= "5";	// 5개
	public static final String TP_REWARD_TNE				= "10";	// 10개
	
	// ========================================================
	// 다우기술 쿠폰 상태
	// ========================================================
	public static final String DAU_STATUS_NONE				= "N";	// 대기
	public static final String DAU_STATUS_ACTIVE			= "A";	// 교환
	public static final String DAU_STATUS_CANCEL			= "C";	// 취소
	
	// ========================================================
	// 다우기술 return 상태
	// ========================================================
	public static final String DAU_SUCCESS					= "000";	// 성공
	public static final String DAU_ERROR					= "999";	// 사이트ID 미일치
	
	// ========================================================
	// 쿠폰 체크
	// ========================================================
	public static final String COUPON_SUCCESS				= "01";	// 성공
	public static final String COUPON_NOT_VALID				= "11"; // 유효하지 않음
	public static final String COUPON_ALREADY_PUBLISH				= "21"; // 이미 발행된 쿠폰
	
	// ========================================================
	// 메일 전송
	// ========================================================
	public static final String MAIL_SEND_CHNN_APP			= "01";	// App
	public static final String MAIL_SEND_CHNN_WEB			= "02";	// Web
	public static final String MAIL_SEND_CHNN_MW			= "03";	// Mobile Web
	public static final String MAIL_SEND_CHNN_CC			= "04";	// Call Center
	
	// ========================================================
	// 메일 전송
	// ========================================================
	public static final String COUPON_STORE_EXCEPT			= "01";	// 제외매장
	public static final String COUPON_STORE_NON_CHNN		= "11";	// 채널정보오류
	
	/**
	 * constant String 값을 읽어온다.
	 * @param key
	 * @return String config value
	 */
	public static String get(String key) {       
		return propertyService.get(key);
	}
	
	/**
	 * constant String 값을 읽어온다.
	 * @param key
	 * @param defaultValue
	 * @return String config value
	 */
	public static String get(String key, String defaultValue) {
		return propertyService.get(key, defaultValue);
	}
	
	/**
	 * constant boolean 값을 읽어온다.
	 * @param key
	 * @return boolean config value
	 */
	public static boolean getBoolean(String key) {
		return propertyService.getBoolean(key);
	}
	
	/**
	 * constant int 값을 읽어온다.
	 * @param key
	 * @return int config value
	 */
	public static int getInt(String key) {
		return propertyService.getInt(key);
	}
}
