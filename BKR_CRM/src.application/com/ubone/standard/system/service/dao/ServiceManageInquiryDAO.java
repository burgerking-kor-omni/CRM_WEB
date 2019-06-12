package com.ubone.standard.system.service.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : ServiceManageInquiryDAO.java
 *  설    명 : [APMD] 서비스관리 DAO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface ServiceManageInquiryDAO {
	
	DataList getService(Parameter parameter);

	DataList getListServiceByAuto(Parameter parameter);

	DataList getListService(Parameter parameter);

	String registService(Parameter parameter);

	int modifyService(Parameter parameter);

	int removeService(Parameter parameter);

	int removeAllServiceCode(Parameter parameter);
	
	int removeAllFunction(Parameter parameter);
	
	int removeAllServiceMask(Parameter parameter);

	DataList getListCodeCategoryByAuto(Parameter parameter);

	DataList getListServiceError(Parameter parameter);
	
	DataList getServiceCode(Parameter parameter);

	DataList getListServiceCode(Parameter parameter);

	String registServiceCode(Parameter parameter);

	int modifyServiceCode(Parameter parameter);

	int removeServiceCode(Parameter parameter);
	
	DataList getCodeDetailList(Parameter parameter);
	
	DataList getScreenList(Parameter parameter);
	
	DataList getMaskingList(Parameter parameter);
	
	DataList getMaskingColumn(Parameter parameter);
	
	DataList checkMaskingColumn(Parameter parameter);
	
	String insertMaskingColumn(Parameter parameter);
	
	int updateMaskingColumn(Parameter parameter);
	
	int deleteMaskingColumn(Parameter parameter);
	
	DataList getDataConvertListBefore(Parameter parameter);
	
	DataList getDataConvertListAfter(Parameter parameter);
	
	String insertDataConvertBefore(Parameter parameter);
	
	String insertDataConvertAfter(Parameter parameter);
	
	int deleteDataConvertBefore(Parameter parameter);
	
	int deleteDataConvertAfter(Parameter parameter);
	
	
	
	DataList getPointCutCodeList(Parameter parameter);
	
	DataList getMaskByAuto(Parameter parameter);
	
	DataList getMaskList(Parameter parameter);
	
	DataList getServiceQueryList(Parameter parameter);
	
	DataList getServiceQueryDetail(Parameter parameter);
	
	DataList isDuplicatedServiceQuery(Parameter parameter);
	
	String insertServiceQuery(Parameter parameter);
	
	int updateServiceQuery(Parameter parameter);
	
	int deleteServiceQuery(Parameter parameter);
	
	int deleteAllServiceQuery(Parameter parameter);
}
