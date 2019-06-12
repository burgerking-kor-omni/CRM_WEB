package com.ubone.example.pivotgrid.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.example.pivotgrid.dao.PivotGridExampleDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : PivotGridExampleSO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class PivotGridExampleSO {
	@Resource 
	private PivotGridExampleDAO pivotGridExampleDAO;
	
	public DataList getGridData(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return pivotGridExampleDAO.getGridData(parameter);
	}
	
	public DataList getGridDataAll(Parameter parameter){
		return pivotGridExampleDAO.getGridDataAll(parameter);
	}
	
}
