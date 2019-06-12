package com.ubone.standard.ubboard.common.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : BoardPushDAO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface BoardPushDAO {
	
	DataList getPushTarget(Parameter parameter);
	
	DataList getMessageInfo(Parameter parameter);
	
	DataList getArticleRegistUserId(Parameter parameter);
}
