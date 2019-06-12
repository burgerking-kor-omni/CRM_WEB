package com.ubone.standard.system.auth.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

public interface AuthManageMLDAO {
	
	/**
	 * Inquiry Menu Tree
	 * @param parameter
	 * @return
	 */
	public DataList listMenu(Parameter parameter);

	/**
	* Inquiry MENU SUB LIST
	* @param parameter
	* @return
	*/
	public DataList listMenuSub(Parameter parameter);

	/**
	* Inquiry Screen List by Menu Id
	* @param parameter
	* @return
	*/
	public DataList listScreenByMenuId(Parameter parameter);

	/**
	 * Inquiry Function List by Screen Id
	 * @param parameter
	 * @return
	 */
	public DataList listFunctionByScreenId(Parameter parameter);
	
	/**
	 * Update Menu Role
	 * @param parameter
	 * @return
	 */
	public int updateMenuRole(Parameter parameter);

	/**
	 * Update Screen Role
	 * @param parameter
	 * @return
	 */
	public int updateScreenRole(Parameter parameter);

	/**
	 * Update Function Role
	 * @param parameter
	 * @return
	 */
	public int updateFunctionRole(Parameter parameter);

	/**
	 * Search Screen for Popup
	 * @param parameter
	 * @return
	 */
	public DataList searchScreenByPopup(Parameter parameter);

	/**
	 * Update Screen-Menu link info.
	 * @param parameter
	 * @return
	 */
	public int updateScreenLinkByMenu(Parameter parameter);

	/**
	 * Delete Screen-Menu link info.
	 * @param parameter
	 * @return
	 */
	public int deleteScreenLink(Parameter parameter);
	
	/**
	 * Registed Screen List By Menu
	 * @param parameter
	 * @return
	 */
	public DataList registedListScreenByMenu(Parameter parameter);
	
	/**
	* Inquiry Screen List by Menu Id For Xml
	* @param parameter
	* @return
	*/
	public DataList listScreenByMenuIdForXml(Parameter parameter);
	
	/**
	* Inquiry Function Auth List by Screen Id For Xml
	* @param parameter
	* @return
	*/
	public DataList listFunctionAuthByScreenIdForXml(Parameter parameter);
	
}
