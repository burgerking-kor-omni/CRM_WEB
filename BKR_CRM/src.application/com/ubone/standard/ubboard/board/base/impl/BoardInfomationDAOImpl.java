package com.ubone.standard.ubboard.board.base.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ServiceException;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.standard.ubboard.board.base.dao.BoardInfomationDAO;

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
public class BoardInfomationDAOImpl extends UbSqlSessionDaoSupport implements BoardInfomationDAO{

	private String queryPrefix = "BoardInfomation.";

	@Override
	public DataList getBoardInfo(String boardId) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("ID_BOARD", boardId);
		
		DataList dataList = queryForDataList(this.queryPrefix + "getBoardInfo", parameter);
		if(dataList.getRowCount() == 0){
			throw new ServiceException("게시판 정보가 존재하지 않습니다.", ServiceContext.getCurrentService().getId());
		}
		return dataList;
	}

	@Override
	public DataList getBoardType(String boardId, String boardTypeId) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("ID_BOARD", boardId);
		parameter.setParameter("ID_BOARD_TYPE", boardTypeId);
		return queryForDataList(this.queryPrefix + "getBoardType", parameter);
	}

	@Override
	public String getBoardTypeId(String boardId) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("ID_BOARD", boardId);
		return queryForObject(this.queryPrefix + "getBoardTypeId", parameter);
	}

	@Override
	public Boolean hasBoardAdmin(Parameter parameter) {
		Boolean result = null;
		parameter = DataUtil.makeUserAddedParameter(parameter);

		int resultCount = (Integer)queryForObject(this.queryPrefix + "hasBoardAdmin", parameter);
		
		if(resultCount > 0){
			result = true;
		}else{
			result = false;
		}
		
		return result;
	}
	
}
