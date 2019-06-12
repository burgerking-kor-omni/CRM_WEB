package com.ubone.standard.system.code.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.code.dao.CodeFilterDAO;

@Repository
public class CodeFilterDAOImpl extends UbSqlSessionDaoSupport implements CodeFilterDAO{
	
	private String queryPrefix ="CodeFilter.";

	//코드 필터 조회
	public DataList getCodeFilterList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCodeFilterList", parameter);
	}
	
	//코드 필터 조회(다이나믹)
	public DataList getCodeFilterListDn(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCodeFilterList_dn", parameter);
	}
	
	//코드 유형 등록
	public void insertCodeFiler(Parameter parameter) {
		insert(this.queryPrefix + "insertCodeFiler", parameter);
	}
	
	//코드 유형 목록 조회
	public DataList selectCodeCategory(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "selectCodeCategory", parameter);
	}
		
	//코드 필터 삭제
	public void delete(Parameter parameter){
		delete(this.queryPrefix + "delete", parameter);
	}
	
}
