package com.ubone.standard.system.mask.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.mask.dao.MaskManageDAO;


/** 
 * <pre>
 *  파 일 명 : MaskManageSO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class MaskManageSO {
	
	@Resource
	private MaskManageDAO maskManageDAO;

	public DataList getMaskList(Parameter parameter){
		return maskManageDAO.getMaskList(parameter);
	}
	
	public DataList getMaskDetail(Parameter parameter){
		return maskManageDAO.getMaskDetail(parameter);
	}
	
	public int updateMask(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return maskManageDAO.updateMask(parameter);
	}
	
	public int deleteMask(Parameter parameter){
		return maskManageDAO.deleteMask(parameter);
	}
	
	public DataList getAuthByMaskId(Parameter parameter){
		return maskManageDAO.getAuthByMaskId(parameter);
	}
	
	public int updateAuthByMaskId(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		String flag = parameter.get("CHECKED");
		maskManageDAO.deleteAuthByMaskId(parameter);
		if("true".equals(flag)){
			maskManageDAO.insertAuthByMaskId(parameter);
		}		
		return 1;
	}
	
	public DataList getServiceListByMask(Parameter parameter){
		return maskManageDAO.getServiceListByMask(parameter);
	}
	
	public String insertMask(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return maskManageDAO.insertMask(parameter);
	}
	
	
}
