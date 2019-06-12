package com.ubone.standard.alimy.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.alimy.dao.AlimyManageDAO;

/** 
 * <pre>
 *  파 일 명 : AlimyManageDAOImpl.java
 *  설    명 : 알리미 관리를 위한 DAO 구현클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.07.22
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Repository
public class AlimyManageDAOImpl extends UbSqlSessionDaoSupport implements AlimyManageDAO{

	private String queryPrefix = "AlimyManage.";

	/**
	 * 알리미 대상자 리스트 조회
	 * @param parameter
	 * @return 대상자 리스트
	 */
	@Override
	public DataList getTargetList(Parameter parameter) {
		return queryForDataList(queryPrefix+"getTargetList", parameter);
	}
	
	/**
	 * 알리미 대상자 조회
	 * @param parameter
	 * @return 대상자 정보
	 */
	@Override
	public DataList getTarget(Parameter parameter) { 
		return queryForDataList(queryPrefix+"getTarget", parameter);
	}
}
