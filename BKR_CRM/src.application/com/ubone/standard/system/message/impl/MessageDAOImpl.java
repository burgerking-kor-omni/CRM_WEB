package com.ubone.standard.system.message.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.engine.WorkflowActivity;
import com.ubone.standard.system.message.dao.MessageDAO;


/** 
 * <pre>
 *  설    명 : Message DAO ibatis sqlmap 구현
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.15
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class MessageDAOImpl extends UbSqlSessionDaoSupport implements MessageDAO {
	
	private static final String queryPrefix = "Message.";
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.dao.MessageDAO#insert(com.ubone.framework.data.Parameter)
	 */
	public String insert(Parameter parameter) {
		return insert(queryPrefix + "insert", DataUtil.makeUserAddedParameter(parameter));
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.support.message.dao.MessageDAO#insertTarget(com.ubone.framework.data.Parameter)
	 */
	public void insertTarget(Parameter parameter) {
		insert(queryPrefix + "insertTarget", DataUtil.makeUserAddedParameter(parameter));
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.voc.message.dao.MessageRuleDAO#findBy(com.ubone.framework.engine.WorkCategory, com.ubone.framework.engine.WorkflowActivity)
	 */
	public DataList findRuleBy(WorkCategory workCategory, WorkflowActivity workflowActivity) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.set("TP_BIZ", workCategory.getCode());
		parameter.set("TP_EVENT", workflowActivity.getCode());
		parameter.set("FG_USE", "Y");
		return this.queryForDataList(queryPrefix + "getRuleList", parameter);
	}

	public DataList getRuleList(Parameter parameter) {
		return this.queryForDataList(queryPrefix + "getMessageRuleList", parameter);
	}
}