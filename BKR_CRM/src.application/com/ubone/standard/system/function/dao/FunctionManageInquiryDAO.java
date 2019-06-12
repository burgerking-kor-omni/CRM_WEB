package com.ubone.standard.system.function.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : FunctionManageInquiryDAO.java
 *  설    명 : [APMD] 기능관리 DAO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface FunctionManageInquiryDAO {
	
	DataList getFunc(Parameter parameter);

	DataList getListFuncByAuto(Parameter parameter);

	DataList getListFunc(Parameter parameter);

	String registFunc(Parameter parameter);

	int modifyFunc(Parameter parameter);

	int removeFunc(Parameter parameter);

	int removeAllScreenFuncAuth(Parameter parameter);
	
	int removeAllScreenFunc(Parameter parameter);
	
	DataList getFuncAlias(Parameter parameter);

	DataList getListFuncAlias(Parameter parameter);

	String registFuncAlias(Parameter parameter);

	int modifyFuncAlias(Parameter parameter);

	int removeFuncAlias(Parameter parameter);

	DataList getFuncAliasCount(Parameter parameter);
	
	DataList getLinkScreenList(Parameter parameter);
	
	int removeFunctionScreenLink(Parameter parameter);
}
