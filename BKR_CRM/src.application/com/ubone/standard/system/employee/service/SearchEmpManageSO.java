package com.ubone.standard.system.employee.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.system.employee.dao.SearchEmpManageDAO;
import com.ubone.ui.tree.TreeGen;
import com.ubone.ui.tree.TreeViewConverter;

/** 
 * <pre>
 *  파 일 명 : SearchEmpManageSO.java
 *  설    명 : 
 *  작 성 자 : 이동엽
 *  작 성 일 : 2013. 5. 6.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class SearchEmpManageSO {
	
	@Resource
	private SearchEmpManageDAO searchEmpManageDAO;
	
	/**
	 * 부서트리 (node선택 시) 직원 목록 호출
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 목록(공통) 상세조회 결과
	 */
	public DataList getUserList(Parameter parameter){
		return searchEmpManageDAO.getUserList(parameter);
	}
	
	/**
	 * 직원검색 부서트리 (공통)
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 트리 조회 결과
	 */
	public Result getEmptList(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		Result result = DataUtil.makeResult();

		DataList deptManageTree = searchEmpManageDAO.getEmpList(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeTreeList(deptManageTree);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
	
	/**
	 * 직원검색 부서트리 (Lazy용)
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 트리 조회 결과
	 */
	public Result getEmptListForLazy(Parameter parameter){
		
		Result result = DataUtil.makeResult();

		DataList deptManageTree = searchEmpManageDAO.getEmpListForLazy(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeTreeList(deptManageTree);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
}
