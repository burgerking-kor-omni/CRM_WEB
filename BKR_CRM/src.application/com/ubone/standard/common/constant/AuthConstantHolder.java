package com.ubone.standard.common.constant;

import com.ubone.framework.util.property.PropertyService;
import com.ubone.framework.util.property.PropertyUtil;

/** 
 * <pre>
 *  파 일 명  : AuthConstantHolder.java
 *  설    명   : Auth Constant Holder
           Auth 상수값들의 관리를 집중하기 위한 클래스
 *  작 성 자  : 강현준
 *  작 성 일  : 2019.01.14
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public final class AuthConstantHolder {
	
	private static PropertyService propertyService;
	
	static {
		propertyService = PropertyUtil.makeClassPathReadOnlyPropertyService("resource/config/constant.xml");
	}
	
	
	// ========================================================
	// 프레임웍 기본 상수
	// ========================================================
	/**
	 * 상수샘플 키 : auth.code.constant
	 */
	public static final String SAMPLE = propertyService.get("auth.code.constant", "authConstant");
	
	// ========================================================
		// 권한 
		// ========================================================
		public static final String ROLE_SYSTEM_ADMIN		=	"100";		//시스템 관리자	
		public static final String ROLE_NORMAL_ADMIN		=	"200";		//일반 관리자
		public static final String ROLE_VOC_ADMIN			=	"300";		//VOC 관리자
		public static final String ROLE_IT_ADMIN			=	"400";		//IT 관리자
		public static final String ROLE_NORMAL_USER			=	"999";		//일반 사용자
	
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
