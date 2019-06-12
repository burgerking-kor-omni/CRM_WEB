package com.ubone.standard.system.auth.service;

import java.io.File;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.cache.MenuCacheService;
import com.ubone.framework.cache.ScreenCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.domain.Function;
import com.ubone.framework.engine.domain.Screen;
import com.ubone.framework.engine.screen.ScreenRepository;
import com.ubone.framework.engine.service.ServiceException;
import com.ubone.standard.system.auth.dao.AuthManageDAO;
import com.ubone.ui.tree.TreeGen;
import com.ubone.ui.tree.TreeViewConverter;

/** 
 * <pre>
 *  파 일 명 : AuthManageSO.java
 *  설    명 : 프로그램 권한 관리
 *  작 성 자 : 강영운
 *  작 성 일 : 2013. 5. 29.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
@Service
public class AuthManageSO {
	
	@Resource 
	private AuthManageDAO authManageDAO;
	
	@Resource 
	private ScreenCacheService screenCacheService;
	
	@Resource
	private MenuCacheService menuCacheService;
	
	@Resource
	private ScreenRepository screenRepository;
	
	@Resource
	private ServletContext servletContext;
	
	private Log logger = LogFactory.getLog(this.getClass());
	
	/**
	* inquire Menu List
	* @return
	*/
	public Result listMenu(Parameter parameter){
		Result result = DataUtil.makeResult();
		DataList menuList = authManageDAO.listMenu(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeRoot("ROOT", "Menu");
		treeGen.makeTreeList(menuList);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}

	/**
	* inquire SubMenu List
	* @return
	*/
	public Result listMenuSub(Parameter parameter){
		Result result = DataUtil.makeResult();
		DataList menuList = authManageDAO.listMenuSub(parameter);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeTreeList(menuList);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
	
	/**
	 * Update Menu Role
	 * @param parameter
	 * @return
	 */
	public int updateMenuRole(Parameter parameter) {
		menuCacheService.flushAll();
		return authManageDAO.updateMenuRole(parameter);
	}	
	
	/**
	 * Get screen list by the menu id
	 * @param parameter
	 * @return
	 */
	public DataList listScreenByMenuId(Parameter parameter){
		return authManageDAO.listScreenByMenuId(parameter);
	}

	/**
	 * Update Screen Role
	 * @param parameter
	 * @return
	 */
	public int updateScreenRole(Parameter parameter) {
		int result = 0;
		result = authManageDAO.updateScreenRole(parameter);
		if(result > 0){
			screenCacheService.flush(parameter.getValue("SCREEN_ID"));
			menuCacheService.flushAll();
		}
		return result;
	}	

	/**
	 * Get Function list by the Screen Id
	 * @param parameter
	 * @return
	 */
	public DataList listFunctionByScreenId(Parameter parameter){
		return authManageDAO.listFunctionByScreenId(parameter);
	}
	
	/**
	 * Update Function Role
	 * @param parameter
	 * @return
	 */
	public int updateFunctionRole(Parameter parameter) {
		int result = 0;
		result = authManageDAO.updateFunctionRole(parameter);
		if(result > 0){
			screenCacheService.flushAll();
			menuCacheService.flushAll();
		}
		return result;
	}	

	/**
	 * Search Screen for popup
	 * @param parameter
	 * @return
	 */
	public DataList searchScreenByPopup(Parameter parameter){
		return authManageDAO.searchScreenByPopup(parameter);
	}

	/**
	 * Update Screen-Menu Link info.
	 * @param parameter
	 * @return
	 */
	public int updateScreenLinkByMenu(Parameter parameter) {
		int result = 0;
		result = authManageDAO.updateScreenLinkByMenu(parameter);
		return result;
	}	

	/**
	 * Delete Screen-Menu Link info.
	 * @param parameter
	 * @return
	 */
	public int deleteScreenLink(Parameter parameter) {
		int result = 0;
		result = authManageDAO.deleteScreenLink(parameter);
		return result;
	}	
	
	/**
	 * Get screen list by the menu id For XML
	 * @param parameter
	 * @return
	 */
	public DataList listScreenByMenuIdForXml(Parameter parameter){
		DataList screenList = authManageDAO.listScreenByMenuIdForXml(parameter);
		List<Map<String, Object>> list = new LinkedList<Map<String,Object>>();
		
		for(int i = 0 ; i < screenList.size() ; i++){
			try {
				Map<String, Object> data = new HashMap<String, Object>();
				Screen screen = screenRepository.findById(screenList.getString(i, "SCREEN_ID"));
				if(screen != null){
					data.put("SCREEN_ID", screen.getId());
					data.put("CATEGORY_CODE", screen.getId().substring(0, 3));
					data.put("SCREEN_TYPE", screen.getScreenType());
					data.put("LAYOUT_TYPE", screen.getScreenLayoutType());
					data.put("SCREEN_NAME", screen.getScreenName());
					//체크유무
					data.put("CHECKED", screenList.getString(i, "CHECKED"));
				
					List<Function> functions = screen.getFunctions();
					data.put("CHK_CNT", screenList.getString(i, "FUNC_AUTH_CNT") + " / " + functions.size());
					
					list.add(data);
				}
			} catch (ServiceException ex) {
				logger.error(ex.getMessage());
			}
		}
		
		DataList returnDataList = DataUtil.makeDataList("AuthManage.listScreenByMenuIdForXml", list);
		
		return returnDataList;
	}
	
	/**
	 * Get Function list by the Screen Id For Xml
	 * @param parameter
	 * @return
	 */
	public DataList listFunctionByScreenIdForXml(Parameter parameter){
		String screenId = parameter.getValue("SCREEN_ID");
		List<Map<String, Object>> list = new LinkedList<Map<String,Object>>();
		
		if(screenId != null && !"".equals(screenId)){
			Screen screen = screenRepository.findById(screenId);
			List<Function> functions = screen.getFunctions();
			DataList functionAuthList = authManageDAO.listFunctionAuthByScreenIdForXml(parameter);
			
			for(int i = 0 ; i < functions.size() ; i++){
				Map<String, Object> data = new HashMap<String, Object>();
				Function function = functions.get(i);
				data.put("FUNCTION_ID", function.getId());
				data.put("FUNCTION_ALIAS_ID", function.getAlias());
				data.put("FUNCTION_NAME", function.getFunctionName());
				
				//체크유무
				String isChecked = "N";
				for(int j = 0 ; j < functionAuthList.size() ; j++){
					if(function.getId().equals(functionAuthList.get(j, "FUNCTION_ID"))){
						isChecked = "Y";
						data.put("RETRIVE_LEVEL", functionAuthList.get(j, "RETRIVE_LEVEL"));
						break;
					}
				}
				data.put("CHECKED", isChecked);
				
				list.add(data);
			}
		}
		
		DataList returnDataList = DataUtil.makeDataList("listFunctionByScreenIdForXml", list);
		
		return returnDataList;
	}
	
	/**
	 * Search Screen for XML Pop
	 * @param parameter
	 * @return
	 */
	public Result searchScreenByPopupForXml(Parameter parameter){
		Result result = DataUtil.makeResult();

		List<Map<String, Object>> list = new LinkedList<Map<String,Object>>();
		String xmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SCREEN_PATH);
		File repository = new File(xmlFilePath);
		
		for(int i = 0 ; i < repository.listFiles().length ; i++){
			File subFile = repository.listFiles()[i];
			
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("ID", subFile.getName());
			data.put("TITLE", subFile.getName());
			data.put("DATA_KEY", subFile.getName());
			data.put("TOOL_TIP", subFile.getName());
			data.put("PARENT_ID", "ROOT");
			data.put("SORT_ORDER", i);
			data.put("DEPTH", "1");
			
			if(subFile.isDirectory()){
				data.put("FOLDER_YN", "Y");
			}else{
				data.put("FOLDER_YN", "N");
			}
			
			list.add(data);
		}
		
		DataList treeDataList = DataUtil.makeDataList("treeDataList", list);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeRoot("ROOT", "화면");
		treeGen.makeTreeList(treeDataList);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
	
	/**
	 * Search Screen Lazy for XML Pop
	 * @param parameter
	 * @return
	 */
	public Result searchScreenByPopupLazyForXml(Parameter parameter){
		Result result = DataUtil.makeResult();
		String lazyKey = parameter.getValue("LAZY_KEY");
		
		List<Map<String, Object>> list = new LinkedList<Map<String,Object>>();
		String xmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SCREEN_PATH + "/" + lazyKey);
		File repository = new File(xmlFilePath);
		
		// 메뉴에 등록된 화면리스트 조회
		Parameter param = DataUtil.makeParameter();
		param.set("CATEGORY_CODE", lazyKey);
		DataList registedScreenList = authManageDAO.registedListScreenByMenu(param);
		
		for(int i = 0 ; i < repository.listFiles().length ; i++){
			File subFile = repository.listFiles()[i];
			
			String screenId = subFile.getName().replaceAll(".xml", "");
			
			// 이미 메뉴에 등록된 화면이면 나타내지 않음
			Boolean flag = true;
			for(int j = 0 ; j < registedScreenList.size() ; j++){
				if(registedScreenList.getString(j, "SCREEN_ID").equals(screenId)){
					flag = false;
				}
			}
			
			if(flag){
				Screen screen = screenRepository.findById(screenId);
				
				Map<String, Object> data = new HashMap<String, Object>();
				data.put("ID", screen.getId());
				data.put("TITLE", "[" + screen.getId() + "] " + screen.getScreenName());
				data.put("DATA_KEY", screen.getId());
				data.put("TOOL_TIP", screen.getScreenName());
				data.put("PARENT_ID", repository.getName());
				data.put("SORT_ORDER", i);
				data.put("DEPTH", "2");
				
				if(subFile.isDirectory()){
					data.put("FOLDER_YN", "Y");
				}else{
					data.put("FOLDER_YN", "N");
				}
				
				list.add(data);
			}	
		}
		
		DataList treeDataList = DataUtil.makeDataList("treeDataList", list);
		
		TreeGen treeGen = new TreeGen(true);
		treeGen.makeTreeList(treeDataList);
		
		result.setTreeList(treeGen.getTreeListModel());
		result.setViewConverterId(TreeViewConverter.VIEW_NAME);
		return result;
	}
}
