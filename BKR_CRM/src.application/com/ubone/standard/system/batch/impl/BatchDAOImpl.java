package com.ubone.standard.system.batch.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.batch.dao.BatchDAO;

@Repository
public class BatchDAOImpl extends UbSqlSessionDaoSupport implements BatchDAO{
	
	private String queryPrefix ="Batch.";

	//배치 목록 조회
	public DataList selectBatchList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "selectBatchList", parameter);
	}
	
	//배치 상태 수정
	public int updateBatchStatus(Parameter parameter){
		return update(this.queryPrefix + "updateBatchStatus", parameter);
	}
	
	//배치 등록
	public String insertBatch(Parameter parameter){
		return insert(this.queryPrefix + "insertBatch", parameter);
	}
	
	//배치 조회
	public DataList selectBatch(Parameter parameter){
		return queryForDataList(this.queryPrefix + "selectBatch", parameter);
	}
	
	//배치 수정
	public int updateBatch(Parameter parameter){
		return update(this.queryPrefix + "updateBatch", parameter);
	}
	
	//배치 삭제
	public int deleteBatch(Parameter parameter){
		return delete(this.queryPrefix + "deleteBatch", parameter);
	}
	
	//배치 기록 목록 조회
	public DataList selectBatchLogList(Parameter parameter){
		return queryForDataList(this.queryPrefix + "selectBatchLogList", parameter);
	}

	//배치 자동완성 기능
	public DataList getListForAutocomplete(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListForAutocomplete", parameter);
	}
	
	//배치 자동완성 기능
		public int updateBatchStatusRe(Parameter parameter) {
			return update(this.queryPrefix + "updateBatchStatusRe", parameter);
		}
}
