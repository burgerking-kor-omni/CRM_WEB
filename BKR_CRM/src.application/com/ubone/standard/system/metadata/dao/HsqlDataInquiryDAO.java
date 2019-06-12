package com.ubone.standard.system.metadata.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : HsqlDataInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface HsqlDataInquiryDAO {
	DataList getCategoryCodeList(Parameter parameter);
	
	DataList getScreenList(Parameter parameter);
	
	DataList getPidDetail(Parameter parameter);
	
	DataList getScreenName(Parameter parameter);
	
}
