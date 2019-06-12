package com.ubone.standard.system.function.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.function.dao.FunctionManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : FunctionManageInquiryDAOImpl.java
 *  설    명 : [APMD] 기능관리 DAO IMPL
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class FunctionManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements FunctionManageInquiryDAO{

	private String queryPrefix = "FunctionManageInquiry.";

	@Override
	public DataList getFunc(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getFunc", parameter);
	}

	@Override
	public DataList getListFuncByAuto(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListFuncByAuto", parameter);
	}

	@Override
	public DataList getListFunc(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListFunc", parameter);
	}

	@Override
	public String registFunc(Parameter parameter) {
		return insert(this.queryPrefix + "registFunc", parameter);
	}

	@Override
	public int modifyFunc(Parameter parameter) {
		return update(this.queryPrefix + "modifyFunc", parameter);
	}

	@Override
	public int removeFunc(Parameter parameter) {
		return delete(this.queryPrefix + "removeFunc", parameter);
	}

	@Override
	public int removeAllScreenFuncAuth(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllScreenFuncAuth", parameter);
	}

	@Override
	public int removeAllScreenFunc(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllScreenFunc", parameter);
	}

	@Override
	public DataList getFuncAlias(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getFuncAlias", parameter);
	}

	@Override
	public DataList getListFuncAlias(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListFuncAlias", parameter);
	}

	@Override
	public String registFuncAlias(Parameter parameter) {
		return insert(this.queryPrefix + "registFuncAlias", parameter);
	}

	@Override
	public int modifyFuncAlias(Parameter parameter) {
		return update(this.queryPrefix + "modifyFuncAlias", parameter);
	}

	@Override
	public int removeFuncAlias(Parameter parameter) {
		return delete(this.queryPrefix + "removeFuncAlias", parameter);
	}

	@Override
	public DataList getFuncAliasCount(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getFuncAliasCount", parameter);
	}

	@Override
	public DataList getLinkScreenList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getLinkScreenList", parameter);
	}

	@Override
	public int removeFunctionScreenLink(Parameter parameter) {
		return delete(this.queryPrefix + "removeFunctionScreenLink", parameter);
	}

	
	
}
