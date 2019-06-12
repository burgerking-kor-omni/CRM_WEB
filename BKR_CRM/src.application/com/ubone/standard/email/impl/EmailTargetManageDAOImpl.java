package com.ubone.standard.email.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.email.dao.EmailTargetManageDAO;

@Repository
public class EmailTargetManageDAOImpl extends UbSqlSessionDaoSupport implements EmailTargetManageDAO {

	private String prefix = "EmailTargetManage.";

	@Override
	public DataList getEmailTargetList (Parameter param){
		return queryForDataList(this.prefix+"getEmailTargetList", param);
	}
	@Override
	public DataList getEmailTargetDetailList (Parameter param){
		return queryForDataList(this.prefix+"getEmailTargetDetailList", param);
	}
	@Override
	public String insertVocDispatch (Parameter param){
		return insert(this.prefix+"insertVocDispatch", param);
	}
	@Override
	public String insertVocDispatchCategory (Parameter param){
		return insert(this.prefix+"insertVocDispatchCategory", param);
	}
	@Override
	public int updateVocDispatch(Parameter param){
		return update(this.prefix+"updateVocDispatch", param);
	}
	@Override
	public int updateVocDispatchCategory(Parameter param){
		return update(this.prefix+"updateVocDispatchCategory", param);
	}
	@Override
	public int deleteVocDispatch (Parameter param){
		return delete(this.prefix+"deleteVocDispatch", param);
	}
	@Override
	public int deleteVocDispatchCategory (Parameter param){
		return delete(this.prefix+"deleteVocDispatchCategory", param);
	}

}
