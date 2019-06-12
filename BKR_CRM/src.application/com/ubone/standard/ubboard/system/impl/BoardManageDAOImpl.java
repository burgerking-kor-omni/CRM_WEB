package com.ubone.standard.ubboard.system.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.ubboard.system.dao.BoardManageDAO;

/** 
 * <pre>
 *  파 일 명 : BoardManageDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class BoardManageDAOImpl extends UbSqlSessionDaoSupport implements BoardManageDAO{

	private String queryPrefix = "BoardManage.";

	@Override
	public DataList getList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getList", parameter);
	}

	@Override
	public String boardClone(Parameter parameter) {
		insert(this.queryPrefix + "boardClone", parameter);
		return parameter.getValue("NEW_ID_BOARD");
	}

	@Override
	public String boardTypeClone(Parameter parameter) {
		return insert(this.queryPrefix + "boardTypeClone", parameter);
	}

	@Override
	public String boardAdminClone(Parameter parameter) {
		return insert(this.queryPrefix + "boardAdminClone", parameter);
	}

	@Override
	public String regist(Parameter parameter) {
		insert(this.queryPrefix + "regist", parameter);
		return parameter.getValue("ID_BOARD");
	}

	@Override
	public String registType(Parameter parameter) {
		return insert(this.queryPrefix + "registType", parameter);
	}

	@Override
	public String createSequence(String boardId) {
		String result = null;
		Parameter parameter = DataUtil.makeParameter();
		
		parameter.setParameter("SEQ_ID" , "SEQ_SYS_BOARD_ARTICLE_" + boardId);
		result = insert(this.queryPrefix + "registSequence", parameter);
		
		if(result != null && !"".equals(result)){
			parameter.setParameter("SEQ_ID", "SEQ_SYS_BOARD_REPLY_" + boardId);
			insert(this.queryPrefix + "registSequence", parameter);
		}
		
		return result;
	}

	@Override
	public DataList getDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getDetail", parameter);
	}

	@Override
	public DataList getTypeDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getTypeDetail", parameter);
	}

	@Override
	public int modify(Parameter parameter) {
		return update(this.queryPrefix + "modify", parameter);
	}

	@Override
	public int remove(Parameter parameter) {
		return update(this.queryPrefix + "remove", parameter);
	}

	@Override
	public int removeType(Parameter parameter) {
		return delete(this.queryPrefix + "removeType", parameter);
	}

	@Override
	public int removeAdminAll(Parameter parameter) {
		return delete(this.queryPrefix + "removeAdminAll", parameter);
	}

	@Override
	public int modifyType(Parameter parameter) {
		return update(this.queryPrefix + "modifyType", parameter);
	}

	@Override
	public DataList getAdminList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getAdminList", parameter);
	}

	@Override
	public String registAdmin(Parameter parameter) {
		return insert(this.queryPrefix + "registAdmin", parameter);
	}

	@Override
	public int removeAdmin(Parameter parameter) {
		return delete(this.queryPrefix + "removeAdmin", parameter);
	}

	@Override
	public int updateBoardAuthActive(Parameter parameter) {
		return update(this.queryPrefix + "updateBoardAuthActive", parameter);
	}

	@Override
	public DataList getBoardAuthList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getBoardAuthList", parameter);
	}

	@Override
	public String registRole(Parameter parameter) {
		return insert(this.queryPrefix + "registRole", parameter);
	}

	@Override
	public int removeRole(Parameter parameter) {
		return delete(this.queryPrefix + "removeRole", parameter);
	}

	@Override
	public DataList getMessageInfo(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMessageInfo", parameter);
	}

	@Override
	public String registMessageInfo(Parameter parameter) {
		insert(this.queryPrefix + "registMessageInfo", parameter);
		return parameter.getParameter("ID_BOARD");
	}

	@Override
	public int removeMessageInfo(Parameter parameter) {
		return delete(this.queryPrefix + "removeMessageInfo", parameter);
	}

	
	
	
}
