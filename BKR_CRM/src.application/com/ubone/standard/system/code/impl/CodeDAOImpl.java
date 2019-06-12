package com.ubone.standard.system.code.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.code.dao.CodeDAO;

@Repository
public class CodeDAOImpl extends UbSqlSessionDaoSupport implements CodeDAO{
	
	private String queryPrefix ="Code.";
	//코드 유형 등록
	public String insertCodeCategory(Parameter parameter) {
		return queryForObject(this.queryPrefix + "insertCodeCategory", parameter);
	}
	//코드 유형 목록 조회
	public DataList selectCodeCategoryList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "selectCodeCategoryList", parameter);
	}
	//코드 유형 수정
	public String updateCodeCategory(Parameter parameter) {
		return queryForObject(this.queryPrefix + "updateCodeCategory", parameter);
	}
	//코드 유형 삭제
	public String deleteCodeCategory(Parameter parameter){
		return queryForObject(this.queryPrefix + "deleteCodeCategory", parameter);
	}
	//코드 등록
	public String insertCode(Parameter parameter) {
		return queryForObject(this.queryPrefix + "insertCode", parameter);
	}
	//코드 조회
	public DataList selectCode(Parameter parameter){
		return queryForDataList(this.queryPrefix + "selectCode", parameter);
	}
	//코드 수정
	public String updateCode(Parameter parameter){
		return queryForObject(this.queryPrefix + "updateCode", parameter);
	}
	//코드 그룹 조회
	public DataList selectCodeGroup(Parameter parameter){
		return queryForDataList(this.queryPrefix + "selectCodeGroup", parameter);
	}
	//코드 그룹 등록
	public String insertCodeGroup(Parameter parameter){
		return queryForObject(this.queryPrefix + "insertCodeGroup", parameter);
	}
	//코드 그룹 삭제
	public String deleteCodeGroup(Parameter parameter){
		return queryForObject(this.queryPrefix + "deleteCodeGroup", parameter);
	}
	//특정 그룹의 코드 조회
	public DataList selectGroupCode(Parameter parameter){
		return queryForDataList(this.queryPrefix + "selectGroupCode", parameter);
	}
	//코드 유형 목록(팝업) 조회
	public DataList selectCodeCategoryListPop(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "selectCodeCategoryListPop", parameter);
	}
	
	public DataList selectCodeCategoryDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "selectCodeCategoryDetail", parameter);
	}
}
