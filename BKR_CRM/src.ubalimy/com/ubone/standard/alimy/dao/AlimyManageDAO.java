package com.ubone.standard.alimy.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : AlimyManageDAO.java
 *  설    명 : 알리미 관리 관련 DAO 인터페이스 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.07.22
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public interface AlimyManageDAO {
	
	/**
	 * 알리미 대상자 리스트 조회
	 * @param parameter
	 * @return 대상자 리스트
	 */
	public DataList getTargetList(Parameter parameter);
	/**
	 * 알리미 대상자 조회
	 * @param parameter
	 * @return 대상자 리스트
	 */
	public DataList getTarget(Parameter parameter);
}