package com.ubone.standard.system.mask.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : MaskManageDAO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface MaskManageDAO {
	
	DataList getMaskList(Parameter parameter);
	
	DataList getMaskDetail(Parameter parameter);
	
	int updateMask(Parameter parameter);
	
	int deleteMask(Parameter parameter);
	
	DataList getAuthByMaskId(Parameter parameter);
	
	int deleteAuthByMaskId(Parameter parameter);
	
	String insertAuthByMaskId(Parameter parameter);
	
	DataList getServiceListByMask(Parameter parameter);
	
	String insertMask(Parameter parameter);
}
