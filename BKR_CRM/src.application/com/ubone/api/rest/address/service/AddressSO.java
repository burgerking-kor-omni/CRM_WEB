package com.ubone.api.rest.address.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.api.rest.address.dao.AddressDAO;
import com.ubone.api.rest.common.constant.ApiCommon;
import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.user.dao.UserDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.cust.dao.CustManageRimsDAO;

/** 
 * <pre>
 *  파 일 명  : AddressSO.java
 *  설    명   : API 회원주소용 SO
 *  작 성 자  : 
 *  작 성 일  : 2018.10.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */

@Service
public class AddressSO {
	
	@Resource
	private ApiCommon apiCommon;
	
	@Resource
	private AddressDAO addressDAO;
	
	@Resource
	private UserDAO userDAO;
	
	@Resource
	private CustManageRimsDAO custManageRimsDAO;
	
	/**
	 * 주소등록 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result insertAddress(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String idAddress = "";
		
		// 1. 회원정보 존재여부 확인
		DataList dtMember = userDAO.getMember(parameter);
		
		// 2. 저장		
		if (0 < dtMember.getRowCount()) {
			idAddress = addressDAO.insertAddress(parameter);
		} else {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_FAIL);
			resultInfo.put("result_message", "등록되지 않은 회원입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "주소가 등록되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. 등록한 주소정보 조회
		Parameter searchParam = DataUtil.makeParameter();
		searchParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
		searchParam.setParameter("NO_ADDRESS", idAddress);
		DataList dtData = addressDAO.getAddress(searchParam);
		
		// 5. 등록한 주소정보 셋팅
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", dtData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 주소삭제 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result deleteAddress(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 주소정보조회
		DataList dtAddress = addressDAO.getAddress(parameter);

		// 2. 삭제
		if (0 < dtAddress.getRowCount()) {
			addressDAO.deleteAddress(parameter);
		} else {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_DELETE_FAIL);
			resultInfo.put("result_message", "등록되지 않은 주소입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_DELETE_SUCCESS);
		resultInfo.put("result_message", "주소가 삭제되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. 등록한 주소정보 조회
		Parameter searchParam = DataUtil.makeParameter();
		searchParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
		DataList dtData = addressDAO.getAddress(searchParam);
		
		// 5. 등록한 주소정보 셋팅
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", dtData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 주소수정 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateAddress(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();

		// 1. 회원주소정보 조회
		DataList dtAddress = addressDAO.getAddress(parameter);
		
		// 2. 수정
		if (0 < dtAddress.getRowCount()) {
			if (ApiConstantHolder.FLAG_Y.equals(parameter.getParameter("YN_ADDR_BASE"))) {
				addressDAO.updateAddressBase(parameter); 
			}
			addressDAO.updateAddress(parameter); 
		} else {
			resultInfo.put("result_code", ApiConstantHolder.RESULT_UPDATE_FAIL);
			resultInfo.put("result_message", "수정할 정보가 존재하지 않습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_DELETE_SUCCESS);
		resultInfo.put("result_message", "주소가 수정되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. 등록한 주소정보 조회
		Parameter searchParam = DataUtil.makeParameter();
		searchParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));
		DataList dtData = addressDAO.getAddress(searchParam);
		
		// 5. 등록한 주소정보 셋팅
		if (0 < dtData.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", dtData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
	/**
	 * 회원 ID 찾기 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result getPosSchedule(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String resultCode = "";
		String resultMessage = "";
		
		// 1. 매장정보 조회
		DataList dtOmni = addressDAO.getOmniStorInfo(parameter);
		
		if (0 < dtOmni.getRowCount()) {
			resultData.put("STOR_CD", dtOmni.getString(0, "STOR_CD"));
			resultData.put("STOR_NM", dtOmni.getString(0, "STOR_NM"));
			resultData.put("TEL_NO", dtOmni.getString(0, "TEL_NO"));
			resultData.put("DELIVERY_TEL_NO", dtOmni.getString(0, "DELIVERY_TEL_NO"));

			DataList dtRims = custManageRimsDAO.getPosSchedule(parameter);
			
			if (0 < dtRims.getRowCount()) {
				resultData.put("STOR_TYPE", dtRims.getString(0, "STOR_TYPE"));
			} else {
				resultData.put("STOR_TYPE", "0");
			}
			resultCode = ApiConstantHolder.RESULT_SELECT_SUCCESS;
			resultMessage = "정상적으로 조회되었습니다.";
		} else {
			resultCode = ApiConstantHolder.RESULT_SELECT_FAIL;
			resultMessage = "매장정보가 존재하지 않습니다.";
		}

		Map<String, Object> resultInfo = new HashMap<String, Object>();
		resultInfo.put("result_code", resultCode);
		resultInfo.put("result_message", resultMessage);
		DataList dtResultInfo = DataUtil.makeDataList("resultInfo", resultInfo);
		result.addDataList(dtResultInfo);
		
		if (0 < dtOmni.getRowCount()) {
			DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
			result.addDataList(dtResultData);
		}
		
		return result;
	}
	
}
