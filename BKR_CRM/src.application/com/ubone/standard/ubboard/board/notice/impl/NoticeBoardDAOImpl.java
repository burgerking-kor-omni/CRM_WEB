package com.ubone.standard.ubboard.board.notice.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.standard.ubboard.board.notice.dao.NoticeBoardDAO;

/** 
 * <pre>
 *  파 일 명 : NoticeBoardDAOImpl.java
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
public class NoticeBoardDAOImpl extends UbSqlSessionDaoSupport implements NoticeBoardDAO{

	private String queryPrefix = "NoticeBoardDAO.";

	
	
}
