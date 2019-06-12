package com.ubone.api.rest.voc.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.voc.dao.VocDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.sequence.BizSeqRepository;

@Repository
public class VocDAOImpl extends UbSqlSessionDaoSupport implements VocDAO  {
	
	private String queryPrefix = "ApiVoc.";
	
	@Resource
	private BizSeqRepository bizSeqRepository;
	
	@Override
	public DataList getMailSendCause(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMailSendCause", parameter);
	}
	
	@Override
	public DataList getMailData(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMailData", parameter);
	}
	
	@Override
	public DataList getMailDataFile(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMailDataFile", parameter);
	}

	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	@Override
	public String insertVoc(Parameter parameter) {
		return insert(this.queryPrefix + "insertVoc", parameter);
	}
	
	@Override
	public String insertVocFile(Parameter parameter) {
		return insert(this.queryPrefix + "insertVocFile", parameter);
	}
	
	@Override
	public int updateVoc(Parameter parameter) {
		return update(this.queryPrefix + "updateVoc", parameter);
	}
	
	@Override
	public int deleteVoc(Parameter parameter) {
		return delete(this.queryPrefix + "deleteVoc", parameter);
	}

}
