package com.ubone.standard.system.camel.service;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.KeyParameter;
import com.ubone.standard.system.camel.dao.CamelColumnsDAO;

/** 
 * <pre>
 *  파 일 명 : CamelColumnsSO.java
 *  설    명 : Camel Service SO
 *  작 성 자 : 강영운
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class CamelColumnsSO {
	@Resource
	private CamelColumnsDAO camelColumnDao;
	
	public DataList listColumns(@KeyParameter(name="tableName",required=false)String tableName){
		if(StringUtils.isEmpty(tableName)){
			tableName = "";
		}
		return camelColumnDao.listColumns(tableName).setId("columnList");
	}
	
	public DataList listAutocompleate(@KeyParameter(name="tableName",required=false)String tableName){
		return camelColumnDao.listAutocompleate(tableName);
	}
}
