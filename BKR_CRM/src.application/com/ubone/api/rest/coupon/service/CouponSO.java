package com.ubone.api.rest.coupon.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.coupon.dao.CouponDAO;
import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;
import com.ubone.standard.common.encrypto.IwtCrypt;

/** 
 * <pre>
 *  파 일 명  : CouponSO.java
 *  설    명   : API coupon SO
 *  작 성 자  : 
 *  작 성 일  : 2018.11.14
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */

@Service
public class CouponSO {
	
	@Resource
	private CouponDAO couponDAO;
	
	/**
	 * 쿠폰복구 - (POS & Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateCouponUseDau(Parameter parameter) throws Exception {

		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 어플리케이션 머드에 따른 값 셋팅
		String siteId = "";
		if ("real".equals(ConfigHolder.APPLICATION_MODE)) {	// 운영모드
			siteId = ConfigHolder.get("dau.real.site.id");
		} else {
			siteId = ConfigHolder.get("dau.dev.site.id");
		}
		
		// 1. 데이터 정합성 판단
		// 1-1. 사이트ID
		if (!siteId.equals(parameter.getParameter("SITE_ID"))) {
			resultCode = ApiConstantHolder.DAU_ERROR;
			resultMessage = "site_id오류";
		} else {
			// 1-2. 상태값
			if (!ApiConstantHolder.DAU_STATUS_ACTIVE.equals(parameter.getParameter("STATUS"))
					&& !ApiConstantHolder.DAU_STATUS_CANCEL.equals(parameter.getParameter("STATUS"))) {
				resultCode = ApiConstantHolder.DAU_ERROR;
				resultMessage = "상태오류";
			} else {
				// 2. 쿠폰번호조회
				DataList dtCouponPin = couponDAO.getCouponPin(parameter);
				
				// 2-1. 쿠폰존재여부 확인
				if (0 < dtCouponPin.getRowCount()) {
					// 2-2. 상태 확인
					if (ApiConstantHolder.DAU_STATUS_CANCEL.equals(parameter.getParameter("STATUS"))
							&& !ApiConstantHolder.DAU_STATUS_ACTIVE.equals(dtCouponPin.getString(0, "STATUS"))) {
						resultCode = ApiConstantHolder.DAU_ERROR;
						resultMessage = "상태오류";
					} else {
						if (ApiConstantHolder.DAU_STATUS_ACTIVE.equals(parameter.getParameter("STATUS"))
								&& ApiConstantHolder.DAU_STATUS_ACTIVE.equals(dtCouponPin.getString(0, "STATUS"))) {
							resultCode = ApiConstantHolder.DAU_ERROR;
							resultMessage = "상태오류";
						} else {
							String fgObj = "N";
							
							// 3. 수정
							if (ApiConstantHolder.DAU_STATUS_CANCEL.equals(parameter.getParameter("STATUS"))) {
								Parameter objParam = DataUtil.makeParameter();
								objParam.setParameter("CD_COUPON", dtCouponPin.getString(0, "CD_COUPON"));
								DataList dtObj = couponDAO.getCouponObj(objParam);
								
								// 리워드 쿠폰이면 상태값을 사용전으로 변경
								if (0 < dtObj.getRowCount()) {
									if ("4".equals(dtObj.getString(0, "CD_COUPON_OBJ"))) {
										fgObj = "Y";
									}
								}
							}
							
							parameter.setParameter("FG_OBJ", fgObj);
							couponDAO.updateCouponUseDau(parameter);
							resultCode = ApiConstantHolder.DAU_SUCCESS;
							resultMessage = "정상";							
						}
					}

				} else {
					resultCode = ApiConstantHolder.DAU_ERROR;
					resultMessage = "쿠폰번호오류";
				}
			}
		}

		// 3. 정상처리
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 쿠폰핀 데이터
		resultData.put("site_id", parameter.getParameter("SITE_ID"));
		resultData.put("no_cpn", parameter.getParameter("PIN_NUM"));
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	/**
	 * 쿠폰상태수정(Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateCouponUse(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 쿠폰핀 조회
		DataList dtData = couponDAO.getCouponPin(parameter);
		
		// 2. 조회된 쿠폰에 따른 수정
		if (0 < dtData.getRowCount()) {
			// 수정
			couponDAO.updateCouponUse(parameter);
			resultCode = ApiConstantHolder.RESULT_UPDATE_SUCCESS;
			resultMessage = "정상적으로 수정되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
			resultMessage = "수정할 정보가 존재하지 않습니다.";
		}

		// 3. 정상처리
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 쿠폰핀 데이터
		if (0 < dtData.getRowCount()) {
			resultData.put("no_pin", dtData.getString(0, "NO_PIN"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 쿠폰 상세 조회(Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result getCouponDetail(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 쿠폰 조회
		DataList dtData = couponDAO.getCoupon(parameter);
		
		// 2. 조회된 쿠폰에 따른 체크
		if (0 < dtData.getRowCount()) {
			// 3. 쿠폰 매핑 확인
			DataList dtMapping = couponDAO.getCouponMapping(parameter);
			
			// 3-1. 매핑 여부에 따른 체크
			if (0 < dtMapping.getRowCount()) {
				if (!StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
					if (!"NON".equals(parameter.getParameter("ID_MEMBER"))) {
						Parameter updateParam = DataUtil.makeParameter();
						updateParam.setParameter("NO_PIN", dtMapping.getString(0, "NO_PIN"));
						updateParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
						couponDAO.updateMemberCouponPin(updateParam);
					}
				}
				resultInfo.put("result_code", ApiConstantHolder.COUPON_SUCCESS);
				resultInfo.put("result_message", "정상적으로 조회되었습니다.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
				result.addDataList(DataUtil.makeDataList("resultData", this.commonCouponInfo(dtMapping)));
				return result;
			} else {
				// 4. 쿠폰 매핑이 안되었을경우
				// 4-1. 다우발행과 자체발행에 따른 분기 처리
				if (StringUtils.isEmpty(dtData.getString(0, "NO_REQ"))) {
					Parameter insertParam = DataUtil.makeParameter();
					insertParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));				// 회원PK
					insertParam.setParameter("TP_EXPIRY_DATE", dtData.getString(0, "TP_EXPIRY_DATE"));		// 유효기간구분
					insertParam.setParameter("DT_EXPIRY_START", dtData.getString(0, "DT_EXPIRY_START"));	// 유효기간시작일
					insertParam.setParameter("DT_EXPIRY_END", dtData.getString(0, "DT_EXPIRY_END"));		// 유효기간종료일
					insertParam.setParameter("UDID", parameter.getParameter("UDID"));						// 기기ID
					insertParam.setParameter("CD_COUPON", parameter.getParameter("CD_COUPON"));				// 쿠폰
					insertParam.setParameter("PIN_NUM", createCouponPinCode(parameter.getParameter("CD_COUPON").toString()));	// 핀코드생성
					couponDAO.insertCouponPin(insertParam);
				} else {
					couponDAO.updateCouponPin(parameter);	
				}
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.COUPON_NOT_VALID);
			resultInfo.put("result_message", "유효하지 않은 쿠폰입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}

		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.COUPON_SUCCESS);
		resultInfo.put("result_message", "정상적으로 조회되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. 쿠폰 데이터
		DataList dtData2 = couponDAO.getCouponMapping(parameter);

		if (0 < dtData2.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", this.commonCouponInfo(dtData2));
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 리워드 쿠폰 등록 (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateRewardCoupon(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 리워드 쿠폰 조회
		DataList dtData = couponDAO.getRewardCoupon(parameter);
		
		// 2. 조회된 쿠폰에 따른 수정
		if (0 < dtData.getRowCount()) {
			if (ApiConstantHolder.FLAG_Y.equals(dtData.getString(0, "FG_USE"))) {
				// 2-1. 리워드 쿠폰 변경
				couponDAO.updateRewardCoupon(parameter);
				
				// 2-2. 핀연결
				couponDAO.updateRewardCouponPin(parameter);
				
				resultCode = ApiConstantHolder.RESULT_UPDATE_SUCCESS;
				resultMessage = "정상적으로 발급되었습니다.";
			} else {
				resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
				resultMessage = "발급이 가능한 쿠폰이 아닙니다.";
			}
		} else {
			resultCode = ApiConstantHolder.RESULT_UPDATE_FAIL;
			resultMessage = "발급할 정보가 존재하지 않습니다.";
		}

		// 3. 정상처리
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 4. 쿠폰핀 데이터
		if (0 < dtData.getRowCount()) {
			resultData.put("no_pin", dtData.getString(0, "NO_PIN"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 쿠폰 사용여부 체크 (KIOSK)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkUseCoupon(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 쿠폰사용여부조회
		DataList dtData = couponDAO.getCheckUseCoupon(parameter);
		
		if (0 < dtData.getRowCount()) {
			
		} else {
			resultInfo.put("result_code", ApiConstantHolder.COUPON_NOT_VALID);
			resultInfo.put("result_message", "유효하지 않은 쿠폰입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}

		// 2. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.COUPON_SUCCESS);
		resultInfo.put("result_message", "정상적으로 조회되었습니다.");
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 3. 쿠폰핀 데이터
		if (0 < dtData.getRowCount()) {
			resultData.put("pin_num", dtData.getString(0, "PIN_NUM"));
			resultData.put("status", dtData.getString(0, "STATUS"));
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 쿠폰 제외매장 여부 조회
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkCouponStore(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 조건에 따른 제외매장 여부 확인
		String fgStoreUse = "N";
		if ("01".equals(parameter.getParameter("CD_CHNN"))) {			// POS, KIOSK
			DataList dtData = couponDAO.getCheckCouponStore(parameter);
			
			if (0 < dtData.getRowCount()) {
				fgStoreUse = "Y";
			}
		} else if ("02".equals(parameter.getParameter("CD_CHNN"))) {	// APP, WEB
			DataList dtData = couponDAO.getCheckCouponStore(parameter);
			
			if (0 < dtData.getRowCount()) {
				fgStoreUse = "Y";
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.COUPON_STORE_NON_CHNN);
			resultInfo.put("result_message", "채널정보가 유효하지 않습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}

		// 2. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.COUPON_STORE_EXCEPT);
		resultInfo.put("result_message", "정상적으로 조회되었습니다.");
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		// 3. 데이터 전달
		resultData.put("fg_store_use", fgStoreUse);
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	/**
	 * 쿠폰정보셋팅
	 * @param DataList
	 * @return Map
	 */
	private Map<String, Object> commonCouponInfo(DataList dtData) throws Exception {
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		if (0 < dtData.getRowCount()) {
			resultData.put("cd_coupon", dtData.getString(0, "CD_COUPON"));                 /* 쿠폰코드 */
			resultData.put("nm_coupon", dtData.getString(0, "NM_COUPON"));                 /* 쿠폰명 */
			resultData.put("ds_coupon", dtData.getString(0, "DS_COUPON"));                 /* 쿠폰설명 */
			resultData.put("dt_expiry_start", dtData.getString(0, "DT_EXPIRY_START"));     /* 유효기간시작일 */
			resultData.put("dt_expiry_end", dtData.getString(0, "DT_EXPIRY_END"));         /* 유효기간종료일 */
			resultData.put("cd_coupon_target", dtData.getString(0, "CD_COUPON_TARGET"));   /* 쿠폰대상(금액,상품) */
			resultData.put("cd_sale_policy", dtData.getString(0, "CD_SALE_POLICY"));       /* 할인정책 */
			resultData.put("val_sale_policy", dtData.getString(0, "VAL_SALE_POLICY"));     /* 할인금액 */
			resultData.put("val_limit_price", dtData.getString(0, "VAL_LIMIT_PRICE"));     /* 최소주문금액 */
			resultData.put("product_pk", dtData.getString(0, "PRODUCT_PK"));               /* 할인상품 */
			resultData.put("product_pk_real", dtData.getString(0, "PRODUCT_PK_REAL"));     /* 실제판매상품 */
			resultData.put("no_req", dtData.getString(0, "NO_REQ"));                       /* 다우계약번호 */
			resultData.put("no_pin", dtData.getString(0, "NO_PIN"));                       /* 핀일련번호 */
			resultData.put("id_member", dtData.getString(0, "ID_MEMBER"));                 /* 회원PK */
			resultData.put("pin_num_a", dtData.getString(0, "PIN_NUM_A"));                 /* 핀번호 - 매장, 리워드 바코드 생성시 사용 */
			resultData.put("pin_num_b", dtData.getString(0, "PIN_NUM_B"));                 /* 핀번호 - 딜리버리, 킹오더 바코드 생성시 사용 */
			resultData.put("udid", dtData.getString(0, "UDID"));                           /* 기기ID */
			resultData.put("amt_use", dtData.getString(0, "AMT_USE"));                     /* 사용금액 */
			resultData.put("amt_cancel", dtData.getString(0, "AMT_CANCEL"));               /* 취소금액 */
			resultData.put("img_app_url", dtData.getString(0, "IMG_APP_URL"));                     /* 이미지url */
			resultData.put("img_web_url", dtData.getString(0, "IMG_WEB_URL"));                     /* 이미지url */
			resultData.put("nm_cup_menu", dtData.getString(0, "NM_CUP_MENU"));             /* 쿠폰메뉴명 */
			resultData.put("real_cup_price", dtData.getString(0, "REAL_CUP_PRICE"));       /* 쿠폰실제판매금액 */
			resultData.put("sale_cup_price", dtData.getString(0, "SALE_CUP_PRICE"));       /* 쿠폰할인판매금액 */
			resultData.put("sale_cup_rate", dtData.getString(0, "SALE_CUP_RATE"));         /* 쿠폰할인률 */
			
			// 제외매장 로직 추가
			dtData.addColumns("NM_STORE_EXCEPT");
			dtData.addColumns("ID_STORE_EXCEPT");
			Parameter searchParam = DataUtil.makeParameter();
			searchParam.setParameter("CD_COUPON", dtData.getString(0, "CD_COUPON"));
			DataList dtStore = couponDAO.getCouponStoreExcept(searchParam);
			
			if (0 < dtStore.getRowCount()) {
				String nmStore = "";
				String idStore = "";
				for (int i=0; i<dtStore.getRowCount(); i++) {
					if (i == (dtStore.getRowCount() -1)) {
						nmStore += dtStore.getString(i, "NM_STORE_EXCEPT");
						idStore += dtStore.getString(i, "ID_STORE_EXCEPT");
					} else {
						nmStore += dtStore.getString(i, "NM_STORE_EXCEPT") + ", ";
						idStore += dtStore.getString(i, "ID_STORE_EXCEPT") + ", ";
					}
				}
				dtData.set(0, "NM_STORE_EXCEPT", nmStore);	
				dtData.set(0, "ID_STORE_EXCEPT", idStore);
			} else {
				dtData.set(0, "NM_STORE_EXCEPT", null);
				dtData.set(0, "ID_STORE_EXCEPT", null);
			}
			resultData.put("id_store_except", dtData.getString(0, "ID_STORE_EXCEPT"));     /* 제외매장 */
			resultData.put("nm_store_except", dtData.getString(0, "NM_STORE_EXCEPT"));     /* 제외매장 */
			
		}
		return resultData;
	}
	
	public String createCouponPinCode(String cdCoupon) {
		StringBuilder couponPinBuilder = new StringBuilder();
		couponPinBuilder.append("1");
		
		try {
  			String pkCrypt = IwtCrypt.aesEncryptHex("" + cdCoupon + System.nanoTime());
  			char[] pkCryptArr = pkCrypt.toLowerCase().toCharArray();
  			
  			for(char ch : pkCryptArr) {
  				if(ch == 'a') {
  					couponPinBuilder.append("0");
  				}
  				else if(ch == 'b') {
  					couponPinBuilder.append("1");
  				}
  				else if(ch == 'c') {
  					couponPinBuilder.append("2");
  				}
  				else if(ch == 'd') {
  					couponPinBuilder.append("3");
  				}
  				else if(ch == 'e') {
  					couponPinBuilder.append("4");
  				}
  				else if(ch == 'f') {
  					couponPinBuilder.append("5");
  				}
  				else {
  					couponPinBuilder.append(ch);
  				}
  				if(couponPinBuilder.length() == 13) {
  					break;
  				}
  			}
  		}
  		catch(Exception e) {
  			couponPinBuilder.append(StringUtils.leftPad(Long.toString(System.nanoTime()), 13, "0"));
  		}

		return couponPinBuilder.toString();
	}
	
}
