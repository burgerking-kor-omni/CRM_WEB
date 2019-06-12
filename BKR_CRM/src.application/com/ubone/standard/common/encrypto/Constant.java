package com.ubone.standard.common.encrypto;

import java.util.HashMap;
import java.util.Map;

import java.util.logging.Level;

//import org.apache.log4j.Level;

//import lombok.extern.log4j.Log4j2;

//import org.apache.logging.log4j.Level;

public class Constant {

	public static final String DIR_BANNER = "banner";
	public static final String DIR_NOTICE = "notice";
	public static final String DIR_PRODUCT= "product";
	public static final String DIR_COUPON= "coupon";
	public static final String DIR_CPN_LST= "coupon/lst";
	public static final String DIR_CPN_DTL= "coupon/dtl";
	public static final String DIR_PROMO_LST= "promoton/lst";
	public static final String DIR_PROMO_DTL= "promoton/dtl";
	public static final String DIR_PUSH_MESSAGE= "pushMessage";
	public static final String DIR_STORE = "store";
	public static final String DIR_POPUP = "banner";
	public static final String UPLOAD_DIR = "/data/files";
	public static final String EMPTY_PAGE = "empty";
	public static final String CHEONGWON = "F";
	public static final String SESSION_USER = "userInfo";
	public static final String SESSION_AUTHKEY = "findPassword";
	public static final String SESSION_REDIRECT = "";
	public static final String SESSION_LOGIN_REQ = "";
	public static final String ROLE_USER = "ROLE_USER";
	public static final String ROLE_SUPERVISOR = "ROLE_SUPERVISOR";
	public static final String ROLE_ANONYMOUS = "ROLE_ANONYMOUS";
	public static final String AJAX_SUCCESS = "success";
	public static final String AJAX_ERROR = "error";
	public static final int COOKIE_EXPIRY = 60 * 60 * 24 * 7;
	public final static String STATUS_ACTIVE = "0";
	public final static String STATUS_REMOVED = "9";
	public final static String STATUS_REMOVED_1 = "1";
	public final static String STATUS_ING = "2"; 
	public final static String STATUS_Y = "Y";
	public final static String STATUS_N = "N";
	public final static String MENU_TYPE_F = "F";
	public final static String MENU_TYPE_P = "P";
	public final static String STATUS_0 = "0";
	public final static String STATUS_1 = "1";
	public final static String STATUS_2 = "2";
	public final static String STATUS_3 = "3";
	public final static String STATUS_4 = "4";
	

	public final static Map<String, String> DELIVERY_AGENCY_NAME = new HashMap<String, String>();
	static {
		DELIVERY_AGENCY_NAME.put("01", "직영라이더");
		DELIVERY_AGENCY_NAME.put("02", "바로고");
		DELIVERY_AGENCY_NAME.put("03", "메쉬코리아");
		DELIVERY_AGENCY_NAME.put("04", "기타");
	}
	
	public final static Map<Integer, String> SURVERY_ITEM_TITLE = new HashMap<Integer, String>();
	static {
		SURVERY_ITEM_TITLE.put(1, "신속성");
		SURVERY_ITEM_TITLE.put(2, "직원친절도");
		SURVERY_ITEM_TITLE.put(3, "메뉴품질");
		SURVERY_ITEM_TITLE.put(4, "메뉴온도");
		SURVERY_ITEM_TITLE.put(5, "앱사용편의성");
	}

    public static final Level IWT_DEBUG_LOG_LEVEL = Level.ALL;
}
