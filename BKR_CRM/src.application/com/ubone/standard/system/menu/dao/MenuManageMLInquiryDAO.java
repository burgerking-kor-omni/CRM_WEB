package com.ubone.standard.system.menu.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : MenuManageMLInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 이창섭
 *  작 성 일 : 2016. 09. 30.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 : 다국어용
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
public interface MenuManageMLInquiryDAO {
	
	/**
	 * 메뉴 관리 목록(공통) 검색.
	 * @param parameter 
	 * @return 
	 */
	public DataList getMenuManageList(Parameter parameter);
	
	/**
	 * 메뉴 관리 목록(공통) 상세조회.
	 * @param parameter 
	 * @return 
	 */
	public DataList getMenuManageDetail(Parameter parameter);
	
	/**
	 * 메뉴 트리 조회
	 * @param parameter 
	 * @return 
	 */
	public DataList getMenuManageTree(Parameter parameter);
	
	/**
	 * 메뉴 트리 조회(Lazy 용)
	 * @param parameter 
	 * @return 
	 */
	public DataList getMenuManageTreeForLazy(Parameter parameter);
	
	/**
	 * 메뉴 관리 수정
	 * @param parameter 
	 * @return 
	 */
	public int updateMenu(Parameter parameter);
	
	/**
	 * 메뉴 관리 등록
	 * @param parameter 
	 * @return 
	 */
	public String insertMenu(Parameter parameter);	
	
	/**
	 * 메뉴 관리 삭제
	 * @param parameter 
	 * @return 
	 */
	public void deleteMenu(Parameter parameter);

	/**
	 * 메뉴 권한 삭제
	 * @param parameter 
	 * @return 
	 */
	public void deleteMenuAuth(Parameter parameter);

	/**
	 * 메뉴 연결화면 삭제
	 * @param parameter 
	 * @return 
	 */
	public void deleteMenuScreen(Parameter parameter);
}
