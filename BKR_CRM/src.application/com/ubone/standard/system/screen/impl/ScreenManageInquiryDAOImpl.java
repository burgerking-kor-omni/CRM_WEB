package com.ubone.standard.system.screen.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.screen.dao.ScreenManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : ScreenManageInquiryDAOImpl.java
 *  설    명 : [APMD] 화면관리 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class ScreenManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements ScreenManageInquiryDAO{

	private String queryPrefix = "ScreenManageInquiry.";

	@Override
	public DataList getScreenList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreenList", parameter);
	}

	@Override
	public DataList getScreenListByAuto(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreenListByAuto", parameter);
	}

	@Override
	public DataList getScreen(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreen", parameter);
	}

	@Override
	public DataList getListScreenFunc(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListScreenFunc", parameter);
	}

	@Override
	public String registScreen(Parameter parameter) {
		return insert(this.queryPrefix + "registScreen", parameter);
	}

	@Override
	public String registScreenFunc(Parameter parameter) {
		return insert(this.queryPrefix + "registScreenFunc", parameter);
	}

	@Override
	public int modifyScreen(Parameter parameter) {
		return update(this.queryPrefix + "modifyScreen", parameter);
	}

	@Override
	public int modifyScreenFunc(Parameter parameter) {
		return update(this.queryPrefix + "modifyScreenFunc", parameter);
	}
	
	@Override
	public int updateStartFuncYn(Parameter parameter) {
		return update(this.queryPrefix + "updateStartFuncYn", parameter);
	}

	@Override
	public int removeScreen(Parameter parameter) {
		return delete(this.queryPrefix + "removeScreen", parameter);
	}

	@Override
	public int removeAllScreenFunc(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllScreenFunc", parameter);
	}

	@Override
	public int removeAllScreenParam(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllScreenParam", parameter);
	}

	@Override
	public int removeAllMenuScreen(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllMenuScreen", parameter);
	}

	@Override
	public int removeAllScreenAuth(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllScreenAuth", parameter);
	}
	
	@Override
	public int updateScreenIdToNull(Parameter parameter) {
		return update(this.queryPrefix + "updateScreenIdToNull", parameter);
	}

	@Override
	public int removeScreenFunc(Parameter parameter) {
		return delete(this.queryPrefix + "removeScreenFunc", parameter);
	}

	@Override
	public DataList getListScreenParam(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListScreenParam", parameter);
	}

	@Override
	public String registScreenParam(Parameter parameter) {
		return insert(this.queryPrefix + "registScreenParam", parameter);
	}

	@Override
	public int modifyScreenParam(Parameter parameter) {
		return update(this.queryPrefix + "modifyScreenParam", parameter);
	}

	@Override
	public int removeScreenParam(Parameter parameter) {
		return delete(this.queryPrefix + "removeScreenParam", parameter);
	}

	@Override
	public DataList isAvailableKey(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "isAvailableKey", parameter);
	}

	@Override
	public DataList isDupicatedFunction(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "isDupicatedFunction", parameter);
	}

	@Override
	public DataList isAvailabeAlias(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "isAvailabeAlias", parameter);
	}

	@Override
	public DataList isAvailabeParameterName(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "isAvailabeParameterName", parameter);
	}

	@Override
	public DataList getProjectPath(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getProjectPath", parameter);
	}

	@Override
	public DataList getScreenIdAll(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreenIdAll", parameter);
	}

	@Override
	public DataList getMetaPageIdAll(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMetaPageIdAll", parameter);
	}

	@Override
	public DataList getFuncList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getFuncList", parameter);
	}
	
	@Override
	public DataList getParamList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getParamList", parameter);
	}
	
	
}
