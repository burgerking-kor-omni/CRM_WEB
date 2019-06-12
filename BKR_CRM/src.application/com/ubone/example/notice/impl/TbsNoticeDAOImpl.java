package com.ubone.example.notice.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.notice.dao.TbsNoticeDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : TbsNoticeDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 9.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class TbsNoticeDAOImpl extends UbSqlSessionDaoSupport implements TbsNoticeDAO{

	private String queryPrefix = "TbsNotice.";

	public String insertNotice(Parameter parameter) {
		return insert(this.queryPrefix + "insertNotice", parameter);
	}

	public int updateNotice(Parameter parameter) {
		return update(this.queryPrefix + "updateNotice", parameter);
	}

	public int deleteNotice(Parameter parameter) {
		return delete(this.queryPrefix + "deleteNotice", parameter);
	}
}
