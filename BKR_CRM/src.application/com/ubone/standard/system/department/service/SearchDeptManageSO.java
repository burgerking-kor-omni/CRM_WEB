package com.ubone.standard.system.department.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.KeyParameter;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.standard.system.department.dao.SearchDeptManageDAO;
import com.ubone.ui.tree.TreeGen;
import com.ubone.ui.tree.TreeViewConverter;

/** 
 * <pre>
 *  파 일 명 : SearchDeptManageSO.java
 *  설    명 : 
 *  작 성 자 : 이동엽
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class SearchDeptManageSO {
	
	@Resource
	private SearchDeptManageDAO searchDeptManageDAO;
	
	/**
	 * 부서 목록(공통)을 가져옵니다.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 부서 목록(공통) 조회 결과
	 */
	public DataList getDeptList(Parameter parameter){
		return searchDeptManageDAO.getDeptList(parameter);
	}
	
	public DataList getDetail(@KeyParameter(name="DEPT_ID", required=true) String deptId) {
		return searchDeptManageDAO.getDetail(deptId);
	}
	
	/**
	 * 직원검색 부서트리 (공통)
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 트리 조회 결과
	 */
	public Result getDeptTree(Parameter parameter){
		
		Result result = DataUtil.makeResult();

		DataList deptManageTree = searchDeptManageDAO.getDeptTree(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeRoot("ROOT", "부서");
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
	public Result getDeptTreeLazy(Parameter parameter){
		
		Result result = DataUtil.makeResult();

		DataList deptManageTree = searchDeptManageDAO.getDeptTreeLazy(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeTreeList(deptManageTree);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
	
	public String insertDept(Parameter parameter) {
		
		searchDeptManageDAO.insertDept(DataUtil.makeUserAddedParameter(parameter));
		
		return parameter.getValue("DEPT_ID");
	}
	
	
	public String update(Parameter parameter) {
		searchDeptManageDAO.update(DataUtil.makeUserAddedParameter(parameter));
		return ResultUtils.makeResultForKey(parameter.getValue("DEPT_ID")); 
	}
	
	/**
	 * 삭제
	 * @param parameter
	 * @return
	 */
	public int remove(Parameter parameter){
		return searchDeptManageDAO.delete(DataUtil.makeUserAddedParameter(parameter));
	}
	
	/**
	 * 부서별 사용자 목록
	 * @param parameter
	 * @return
	 */
	public DataList getDeptEmpList(@KeyParameter(name="DEPT_ID", required=true) String deptId) {
		return searchDeptManageDAO.getDeptEmpList(deptId);
	}
	
	/**
	 * 부서 ID 중복 체크
	 * @param parameter
	 * @return
	 */
	public DataList checkDeptId(Parameter parameter){
		return searchDeptManageDAO.checkDeptId(parameter);
	}
	
}
