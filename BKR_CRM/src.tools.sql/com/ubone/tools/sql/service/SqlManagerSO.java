package com.ubone.tools.sql.service;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.framework.web.util.XssUtils;
import com.ubone.tools.sql.dao.SqlManagerDAO;

/** 
 * <pre>
 *  파 일 명 : SqlManagerSO.java
 *  설    명 : SQL 관리자
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.12.14
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class SqlManagerSO {

	@Resource
	private SqlManagerDAO sqlManagerDAO;
	
	public Result selectQuery(Parameter parameter){
		
		String queryString = parameter.get("queryString");
		queryString = XssUtils.reconvertXss(queryString);
		parameter.set("queryString", queryString);

		queryString = queryString.toLowerCase();
		int insPos = StringUtils.indexOf(queryString, "insert");
		int updPos = StringUtils.indexOf(queryString, "update");
		int delPos = StringUtils.indexOf(queryString, "delete");
		
		Result result = DataUtil.makeResult();
		try {
			if(insPos == -1 && updPos == -1 && delPos == -1){
				result.getServiceMessage().setResultCount(-1);
				result.addDataList(sqlManagerDAO.selectQuery(parameter));	
			}else{
				int resultCount = sqlManagerDAO.updateQuery(parameter);
				result.getServiceMessage().setResultCount(resultCount);
			}
		}catch(Exception ex) {
			// 트랜잭션 강제 롤백			
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			result = DataUtil.makeFailedResult(ex.getMessage(), ServiceContext.getCurrentService().getId());
		}
		return result;
	}
}