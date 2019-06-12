package com.ubone.standard.system.screen.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : ScreenManageInquiryDAO.java
 *  설    명 : [APMD] 화면관리 DAO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface ScreenManageInquiryDAO {
	
	public DataList getScreenList(Parameter parameter);
	
	public DataList getScreenListByAuto(Parameter parameter);
	
	public DataList getScreen(Parameter parameter);	 

	public DataList getListScreenFunc(Parameter parameter);	 
	
	public String registScreen(Parameter parameter);	 

	public String registScreenFunc(Parameter parameter);		

	public int modifyScreen(Parameter parameter);	 

	public int modifyScreenFunc(Parameter parameter);	 

	public int updateStartFuncYn(Parameter parameter);
	
	public int removeScreen(Parameter parameter);	 
	
	public int removeAllScreenFunc(Parameter parameter);
	
	public int removeAllScreenParam(Parameter parameter);
	
	public int removeAllMenuScreen(Parameter parameter);
	
	public int removeAllScreenAuth(Parameter parameter);
	
	public int updateScreenIdToNull(Parameter parameter);

	public int removeScreenFunc(Parameter parameter);	 

	public DataList getListScreenParam(Parameter parameter);	 

	public String registScreenParam(Parameter parameter);

	public int modifyScreenParam(Parameter parameter);
	
	public int removeScreenParam(Parameter parameter);
	
	public DataList isAvailableKey(Parameter parameter);
	
	public DataList isDupicatedFunction(Parameter parameter);
	
	public DataList isAvailabeAlias(Parameter parameter);
	
	public DataList isAvailabeParameterName(Parameter parameter);
	
	public DataList getProjectPath(Parameter parameter);
	
	public DataList getScreenIdAll(Parameter parameter);
	
	public DataList getMetaPageIdAll(Parameter parameter);
	
	public DataList getFuncList(Parameter parameter);
	
	public DataList getParamList(Parameter parameter);
}
