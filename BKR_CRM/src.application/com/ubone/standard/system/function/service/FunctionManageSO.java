package com.ubone.standard.system.function.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ServiceException;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.standard.system.function.dao.FunctionManageInquiryDAO;


/** 
 * <pre>
 *  파 일 명 : FunctionManageSO.java
 *  설    명 : [APMD] 기능관리 SO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class FunctionManageSO {
	
	private static final String PROJECT_CODE = "PROJECT_CODE";
	@Resource
	private FunctionManageInquiryDAO functionManageInquiryDAO;
		
	/**
	 * Function 상세 정보 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 상세 정보 DataList
	 */
	public DataList getFunc(Parameter parameter){
		return functionManageInquiryDAO.getFunc(parameter);
	}

	/**
	 * Function 목록 조회 함수(AutoComplete)
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getListFuncByAuto(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return functionManageInquiryDAO.getListFuncByAuto(parameter);
	}

	/**
	 * Function 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getListFunc(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return functionManageInquiryDAO.getListFunc(parameter);
	}
	
	/**
	 * Function 신규 등록
	 * @param parameter 파라미터 클래스
	 * @return Function ID
	 */
	public String registFunc(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return functionManageInquiryDAO.registFunc(parameter);
	}

	/**
	 * Function 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 건수
	 */
	public int modifyFunc(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return functionManageInquiryDAO.modifyFunc(parameter);
		
	}

	/**
	 * Function 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 건수
	 */
	public int removeFunc(Parameter parameter) {
		int result = 0;
		
		functionManageInquiryDAO.removeAllScreenFunc(parameter);
		functionManageInquiryDAO.removeAllScreenFuncAuth(parameter);
		
		result = functionManageInquiryDAO.removeFunc(parameter);
		
		return result;
	}

	/**
	 * Function Alias 상세 정보 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 상세 정보 DataList
	 */
	public DataList getFuncAlias(Parameter parameter){
		return functionManageInquiryDAO.getFuncAlias(parameter);
	}

	/**
	 * Function Alias 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getListFuncAlias(Parameter parameter){
		return functionManageInquiryDAO.getListFuncAlias(parameter);
	}
	
	/**
	 * Function Alias 신규 등록
	 * @param parameter 파라미터 클래스
	 * @return Function Alias ID
	 */
	public String registFuncAlias(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return functionManageInquiryDAO.registFuncAlias(parameter);
	}

	/**
	 * Function Alias 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 건수
	 */
	public int modifyFuncAlias(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return functionManageInquiryDAO.modifyFuncAlias(parameter);
	}

	/**
	 * Function Alias 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 건수
	 */
	public int removeFuncAlias(Parameter parameter) {
		DataList functionAliasCount = functionManageInquiryDAO.getFuncAliasCount(parameter);
		String scrnCount = functionAliasCount.getString(0, "SCREEN_COUNT");
		
		if (Integer.parseInt(scrnCount) == 0) {
			return functionManageInquiryDAO.removeFuncAlias(parameter);	
		} else {
			throw new ServiceException("There exist screens that use this function alias.", ServiceContext.getCurrentService().getId());
		}
	}
	
	/**
	 * Function 연결화면 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	public DataList getLinkScreenList(Parameter parameter){
		return functionManageInquiryDAO.getLinkScreenList(parameter);
	}
	
	/**
	 * Function 화면링크 정보 삭제
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	public int removeFunctionScreenLink(Parameter parameter){
		return functionManageInquiryDAO.removeFunctionScreenLink(parameter);
	}

}
