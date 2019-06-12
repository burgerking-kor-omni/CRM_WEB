package com.ubone.standard.system.mask.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.mask.dao.MaskManageDAO;

/** 
 * <pre>
 *  파 일 명 : MaskManageDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class MaskManageDAOImpl extends UbSqlSessionDaoSupport implements MaskManageDAO{

	private String queryPrefix = "MaskManage.";

	@Override
	public DataList getMaskList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMaskList", parameter);
	}

	@Override
	public DataList getMaskDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMaskDetail", parameter);
	}

	@Override
	public int updateMask(Parameter parameter) {
		return update(this.queryPrefix + "updateMask", parameter);
	}

	@Override
	public int deleteMask(Parameter parameter) {
		return delete(this.queryPrefix + "deleteMask", parameter);
	}

	@Override
	public DataList getAuthByMaskId(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getAuthByMaskId", parameter);
	}

	@Override
	public int deleteAuthByMaskId(Parameter parameter) {
		return delete(this.queryPrefix + "deleteAuthByMaskId", parameter);
	}

	@Override
	public String insertAuthByMaskId(Parameter parameter) {
		return insert(this.queryPrefix + "insertAuthByMaskId", parameter);
	}
	
	@Override
	public DataList getServiceListByMask(Parameter parameter){
		return queryForDataList(this.queryPrefix + "getServiceListByMask", parameter);
	}

	@Override
	public String insertMask(Parameter parameter) {
		return insert(this.queryPrefix + "insertMask", parameter);
	}

	
	
}
