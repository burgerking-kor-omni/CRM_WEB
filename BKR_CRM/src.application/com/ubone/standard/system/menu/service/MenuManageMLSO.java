package com.ubone.standard.system.menu.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import com.ubone.framework.cache.MenuCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.message.MessageService;
import com.ubone.framework.util.StringUtils;
import com.ubone.standard.system.lang.dao.LanguageResourceDAO;
import com.ubone.standard.system.menu.dao.MenuManageMLInquiryDAO;
import com.ubone.ui.tree.TreeGen;
import com.ubone.ui.tree.TreeViewConverter;

/** 
 * <pre>
 *  파 일 명 : MenuManageMLSO.java
 *  설    명 : 
 *  작 성 자 : 이창섭
 *  작 성 일 : 2016. 09. 30.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 : 다국어용
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
@Service
public class MenuManageMLSO {
	
	@Resource
	private MenuManageMLInquiryDAO menuManageMLInquiryDAO;
	
	@Resource
	private MenuCacheService menuCacheService;
	
	@Resource
	private LanguageResourceDAO languageResourceDAO;
	
	@Resource
	private MessageService messageService;
	
	/**
	 * 메뉴 관리 목록(공통)을 가져옵니다.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 목록(공통) 조회 결과
	 */
	public DataList getMenuManageList(Parameter parameter){
		return menuManageMLInquiryDAO.getMenuManageList(parameter);
	}
	
	/**
	 * 메뉴 관리 목록(공통) 상세조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 목록(공통) 상세조회 결과
	 */
	public DataList getMenuManageDetail(Parameter parameter){
		return menuManageMLInquiryDAO.getMenuManageDetail(parameter);
	}
	
	/**
	 * 메뉴 관리 트리 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메뉴 관리 트리 조회 결과
	 */
	public Result getMenuManageTree(Parameter parameter){
		Result result = DataUtil.makeResult();
		DataList menuList = menuManageMLInquiryDAO.getMenuManageTree(parameter);
		
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
		DataList menuList = menuManageMLInquiryDAO.getMenuManageTreeForLazy(parameter);
		
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
		return  menuManageMLInquiryDAO.updateMenu(parameter); 
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
		return 	menuManageMLInquiryDAO.insertMenu(parameter); 
	}
	
	/**
	 * 메뉴 삭제
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public void deletetMenu(Parameter parameter){
		menuCacheService.flushAll();
		// 메뉴 삭제
		menuManageMLInquiryDAO.deleteMenu(parameter); 		
		// 권한 삭제
		menuManageMLInquiryDAO.deleteMenuAuth(parameter); 	
		// 연결화면 삭제
		menuManageMLInquiryDAO.deleteMenuScreen(parameter);

		// 다국어 리소스 삭제
		String resId = parameter.getParameter("MENU_NAME_RES_ID");
		
		if (StringUtils.isNotEmpty(resId)) {
			Parameter langParam = DataUtil.makeParameter();
			
			langParam.setParameter("RES_ID", resId);
			
			languageResourceDAO.deleteSysResourceDtl(langParam);
			languageResourceDAO.deleteSysResource(langParam);
			
			// 이미 로드된 메세지 삭제
			messageService.removeMessage(resId);
		}
	}
}