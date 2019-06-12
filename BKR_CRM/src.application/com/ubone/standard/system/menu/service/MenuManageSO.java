package com.ubone.standard.system.menu.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.cache.MenuCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.system.menu.dao.MenuManageInquiryDAO;
import com.ubone.ui.tree.TreeGen;
import com.ubone.ui.tree.TreeViewConverter;

/** 
 * <pre>
 *  파 일 명 : MenuManageSO.java
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
public class MenuManageSO {
	
	@Resource
	private MenuManageInquiryDAO menuManageInquiryDAO;
	
	@Resource
	private MenuCacheService menuCacheService;
	
	/**
	 * 메뉴 관리 목록(공통)을 가져옵니다.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 목록(공통) 조회 결과
	 */
	public DataList getMenuManageList(Parameter parameter){
		return menuManageInquiryDAO.getMenuManageList(parameter);
	}
	
	/**
	 * 메뉴 관리 목록(공통) 상세조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 목록(공통) 상세조회 결과
	 */
	public DataList getMenuManageDetail(Parameter parameter){
		return menuManageInquiryDAO.getMenuManageDetail(parameter);
	}
	
	/**
	 * 메뉴 관리 트리 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 트리 조회 결과
	 */
	public Result getMenuManageTree(Parameter parameter){
		Result result = DataUtil.makeResult();
		DataList menuList = menuManageInquiryDAO.getMenuManageTree(parameter);
		
//		String menuStructure = parameter.getParameter("MENU_STRUCTURE");
//		treeGen.makeRoot(menuStructure, "Menu");
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeRoot("ROOT", "Menu");
		treeGen.makeTreeList(menuList);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}

	/**
	 * 메뉴 관리 트리 조회(Lazy 용)
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 트리 조회 결과
	 */
	public Result getMenuManageTreeForLazy(Parameter parameter){
		Result result = DataUtil.makeResult();
		DataList menuList = menuManageInquiryDAO.getMenuManageTreeForLazy(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeTreeList(menuList);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
	
	/**
	 * 수정 
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public int updateMenu(Parameter parameter){
		menuCacheService.flushAll();
		parameter = DataUtil.makeUserAddedParameter(parameter);
		//수정
		return  menuManageInquiryDAO.updateMenu(parameter); 
	}
	
	/**
	 * 메뉴 등록 
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public String insertMenu(Parameter parameter){
		menuCacheService.flushAll();
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		//Web 메뉴에서 최상위 메뉴는 null의 부모메뉴ID를 가진다.
		String menuStructure = parameter.getParameter("MENU_STRUCTURE");
		String parentMenuId = parameter.getParameter("PARENT_MENU_ID");
		if("ROOT".equals(parentMenuId)){
			if("WEB".equals(menuStructure)){
				parameter.setParameter("PARENT_MENU_ID", null);
			}else{
				parameter.setParameter("PARENT_MENU_ID", menuStructure);
			}
		}
		
		//등록
		return 	menuManageInquiryDAO.insertMenu(parameter); 
	}
	
	/**
	 * 메뉴 삭제
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public void deletetMenu(Parameter parameter){
		menuCacheService.flushAll();
		// 메뉴 삭제
		menuManageInquiryDAO.deleteMenu(parameter); 		
		// 권한 삭제
		menuManageInquiryDAO.deleteMenuAuth(parameter); 	
		// 연결화면 삭제
		menuManageInquiryDAO.deleteMenuScreen(parameter); 	
	}
}
