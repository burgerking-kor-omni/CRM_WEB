package com.ubone.standard.system.menu.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.menu.dao.MenuManageMLInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : MenuManageMLInquiryImpl.java
 *  설    명 : 
 *  작 성 자 : 이창섭
 *  작 성 일 : 2016. 09. 30.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 : 다국어용
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
@Repository
public class MenuManageMLInquiryDAOImpl extends UbSqlSessionDaoSupport implements MenuManageMLInquiryDAO{

	private String queryPrefix = "MenuManageMLInquiry.";
	
	public DataList getMenuManageList(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getMenuManageList", parameter);
	}

	public DataList getMenuManageDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getMenuManageDetail", parameter);
	}
	
	/**
	 * 메뉴 트리 조회
	 * @param parameter 
	 * @return 
	 */
	public DataList getMenuManageTree(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getMenuManageTree", parameter);
	}

	/**
	 * 메뉴 트리 조회(Lazy 용)
	 * @param parameter 
	 * @return 
	 */
	public DataList getMenuManageTreeForLazy(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getMenuManageTreeForLazy", parameter);
	}
	
	/**
	 * 메뉴 수정
	 */
	public int updateMenu(Parameter parameter) {
		return update(this.queryPrefix + "updateMenu", parameter); 
	}
	
	/**
	 * 메뉴 등록
	 */
	public String insertMenu(Parameter parameter) {
		return insert(this.queryPrefix + "insertMenu", parameter); 
	}
	
	/**
	 * 메뉴 삭제
	 */
	public void deleteMenu(Parameter parameter) {
		delete(this.queryPrefix + "deleteMenu", parameter); 
	}

	/**
	 * 메뉴 권한 삭제
	 */
	public void deleteMenuAuth(Parameter parameter) {
		delete(this.queryPrefix + "deleteMenuAuth", parameter); 
	}

	/**
	 * 메뉴 연결화면 삭제
	 */
	public void deleteMenuScreen(Parameter parameter) {
		delete(this.queryPrefix + "deleteMenuScreen", parameter); 
	}
}
