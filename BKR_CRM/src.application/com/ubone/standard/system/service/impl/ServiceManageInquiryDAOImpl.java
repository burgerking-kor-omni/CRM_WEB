package com.ubone.standard.system.service.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.service.dao.ServiceManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : ServiceManageInquiryDAOImpl.java
 *  설    명 : [APMD] 서비스관리 DAO IMPL
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class ServiceManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements ServiceManageInquiryDAO{

	private String queryPrefix = "ServiceManageInquiry.";

	@Override
	public DataList getService(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getDetail", parameter);
	}

	@Override
	public DataList getListServiceByAuto(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListServiceByAuto", parameter);
	}

	@Override
	public DataList getListService(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListService", parameter);
	}

	@Override
	public String registService(Parameter parameter) {
		return insert(this.queryPrefix + "registService", parameter);
	}

	@Override
	public int modifyService(Parameter parameter) {
		return update(this.queryPrefix + "modifyService", parameter);
	}

	@Override
	public int removeService(Parameter parameter) {
		return delete(this.queryPrefix + "removeService", parameter);
	}

	@Override
	public int removeAllServiceCode(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllServiceCode", parameter);
	}

	@Override
	public int removeAllFunction(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllFunction", parameter);
	}

	@Override
	public int removeAllServiceMask(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllServiceMask", parameter);
	}

	@Override
	public DataList getListCodeCategoryByAuto(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListCodeCategoryByAuto", parameter);
	}

	@Override
	public DataList getListServiceError(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListServiceError", parameter);
	}

	@Override
	public DataList getServiceCode(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getServiceCode", parameter);
	}

	@Override
	public DataList getListServiceCode(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getListServiceCode", parameter);
	}

	@Override
	public String registServiceCode(Parameter parameter) {
		return insert(this.queryPrefix + "registServiceCode", parameter);
	}

	@Override
	public int modifyServiceCode(Parameter parameter) {
		return update(this.queryPrefix + "modifyServiceCode", parameter);
	}

	@Override
	public int removeServiceCode(Parameter parameter) {
		return delete(this.queryPrefix + "removeServiceCode", parameter);
	}

	@Override
	public DataList getCodeDetailList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCodeDetailList", parameter);
	}

	@Override
	public DataList getScreenList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreenList", parameter);
	}

	@Override
	public DataList getMaskingList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMaskingList", parameter);
	}

	@Override
	public DataList getMaskingColumn(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMaskingColumn", parameter);
	}

	@Override
	public DataList checkMaskingColumn(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "checkMaskingColumn", parameter);
	}

	@Override
	public String insertMaskingColumn(Parameter parameter) {
		return insert(this.queryPrefix + "insertMaskingColumn", parameter);
	}

	@Override
	public int updateMaskingColumn(Parameter parameter) {
		return update(this.queryPrefix + "updateMaskingColumn", parameter);
	}

	@Override
	public int deleteMaskingColumn(Parameter parameter) {
		return delete(this.queryPrefix + "deleteMaskingColumn", parameter);
	}

	@Override
	public DataList getDataConvertListBefore(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getDataConvertListBefore", parameter);
	}

	@Override
	public DataList getDataConvertListAfter(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getDataConvertListAfter", parameter);
	}
	
	@Override
	public String insertDataConvertBefore(Parameter parameter) {
		return insert(this.queryPrefix + "insertDataConvertBefore", parameter);
	}
	
	@Override
	public String insertDataConvertAfter(Parameter parameter) {
		return insert(this.queryPrefix + "insertDataConvertAfter", parameter);
	}
	
	@Override
	public int deleteDataConvertBefore(Parameter parameter) {
		return delete(this.queryPrefix + "deleteDataConvertBefore", parameter);
	}
	
	@Override
	public int deleteDataConvertAfter(Parameter parameter) {
		return delete(this.queryPrefix + "deleteDataConvertAfter", parameter);
	}

	
	
	
	
	
	
	
	
	
	@Override
	public DataList getPointCutCodeList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getPointCutCodeList", parameter);
	}
	
	@Override
	public DataList getMaskByAuto(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMaskByAuto", parameter);
	}

	@Override
	public DataList getMaskList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMaskList", parameter);
	}

	@Override
	public DataList getServiceQueryList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getServiceQueryList", parameter);
	}

	@Override
	public DataList getServiceQueryDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getServiceQueryDetail", parameter);
	}

	@Override
	public DataList isDuplicatedServiceQuery(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "isDuplicatedServiceQuery", parameter);
	}

	@Override
	public String insertServiceQuery(Parameter parameter) {
		return insert(this.queryPrefix + "insertServiceQuery", parameter);
	}

	@Override
	public int updateServiceQuery(Parameter parameter) {
		return update(this.queryPrefix + "updateServiceQuery", parameter);
	}

	@Override
	public int deleteServiceQuery(Parameter parameter) {
		return delete(this.queryPrefix + "deleteServiceQuery", parameter);
	}
	@Override
	public int deleteAllServiceQuery(Parameter parameter) {
		return delete(this.queryPrefix + "deleteAllServiceQuery", parameter);
	}

	
	
}
