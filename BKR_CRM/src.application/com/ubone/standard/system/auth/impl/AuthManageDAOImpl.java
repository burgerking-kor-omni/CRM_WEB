package com.ubone.standard.system.auth.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.auth.dao.AuthManageDAO;

@Repository
public class AuthManageDAOImpl extends UbSqlSessionDaoSupport implements AuthManageDAO {
	
	private static final String checked = "CHECKED";
	private final String PREFIX = "AuthManage.";
	
	/**
	 * Menu Tree
	 * @param parameter
	 * @return
	 */
	public DataList listMenu(Parameter parameter){
		return queryForDataList(PREFIX + "listMenu", parameter);
	}

	public DataList listMenuSub(Parameter parameter){
		return queryForDataList(PREFIX+"listMenuSub",parameter);
	}

	public DataList listScreenByMenuId(Parameter parameter) {
		return queryForDataList(PREFIX+"listScreenByMenuId",parameter);
	}

	public DataList listFunctionByScreenId(Parameter parameter) {
		return queryForDataList(PREFIX+"listFunctionByScreenId",parameter);
	}

	public int updateMenuRole(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		String flag = parameter.get(checked);

		delete(PREFIX+"deleteMenuRole", parameter);
		if("true".equals(flag)){
			insert(PREFIX+"insertMenuRole", parameter);
		}
		return 1;
	}

	public int updateScreenRole(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		String flag = parameter.get(checked);

		delete(PREFIX+"deleteScreenRole", parameter);
		if("true".equals(flag)){
			insert(PREFIX+"insertScreenRole", parameter);
		}
		return 1;
	}

	public int updateFunctionRole(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);

		String flag = parameter.get(checked);
		delete(PREFIX+"deleteFunctionRole", parameter);
		if("true".equals(flag)){
			insert(PREFIX+"insertFunctionRole", parameter);
		}
		return 1;
	}

	/**
	 * 화면 검색 팝업용 조회
	 */
	public DataList searchScreenByPopup(Parameter parameter) {
		return queryForDataList(PREFIX + "searchScreenByPopup", parameter);
	}

	/**
	 * 메뉴 스크린 정보 갱신
	 */
	public int updateScreenLinkByMenu(Parameter parameter) {
		int rtnValue = 0;
		String MENU_ID      = parameter.getValue("MENU_ID");
		String SCREEN_IDS   = parameter.getValue("SCREEN_IDS");
		String[] SCREEN_LIST= SCREEN_IDS.split(","); 
		
		for(int i=0; i<SCREEN_LIST.length; i++){
			if(!StringUtils.isEmpty(SCREEN_LIST[i])){
				Parameter newParam = DataUtil.makeUserAddedParameter();
				newParam.set("MENU_ID", MENU_ID);
				newParam.set("SCREEN_ID", SCREEN_LIST[i]);

				DataList list = queryForDataList(PREFIX+"checkMenuScreen", newParam);
				if(list.getRowCount() == 0){
					insert(PREFIX+"insertMenuScreen", newParam);
					rtnValue++;
				}
			}
		}
		return rtnValue;
	}

	/**
	 * 메뉴 스크린 정보 삭제
	 */
	public int deleteScreenLink(Parameter parameter) {
		delete(PREFIX+"deleteScreenRoleByScreenId", parameter);
		return delete(PREFIX+"deleteScreenLink", parameter);
	}

	/**
	 * 메뉴에 등록되어 있는 화면 리스트 조회 (xml용)
	 */
	public DataList registedListScreenByMenu(Parameter parameter) {
		return queryForDataList(this.PREFIX + "registedListScreenByMenu", parameter);
	}

	/**
	 * 메뉴 스크린 정보 조회 (xml용)
	 */
	public DataList listScreenByMenuIdForXml(Parameter parameter) {
		return queryForDataList(this.PREFIX + "listScreenByMenuIdForXml", parameter);
	}

	/**
	 * 스크린 기능 권한 정보 조회 (xml용)
	 */
	public DataList listFunctionAuthByScreenIdForXml(Parameter parameter) {
		return queryForDataList(this.PREFIX + "listFunctionAuthByScreenIdForXml", parameter);
	}

}
