package com.ubone.example.tbs_bulletin.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.tbs_bulletin.dao.TbsBulletinDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : TbsBulletinDAOImpl.java
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
public class TbsBulletinDAOImpl extends UbSqlSessionDaoSupport implements TbsBulletinDAO{

	private String queryPrefix = "TbsBulletin.";
	
	public String insertFaq(Parameter parameter) {
		return insert(this.queryPrefix + "insertFaq", parameter);
	}

	public int updateFaq(Parameter parameter) {
		return update(this.queryPrefix + "updateFaq", parameter);
	}

	public int deleteFaq(Parameter parameter) {
		return delete(this.queryPrefix + "deleteFaq", parameter);
	}
	
	public String insertRef(Parameter parameter) {
		return insert(this.queryPrefix + "insertRef", parameter);
	}
	
	public int updateRef(Parameter parameter) {
		return update(this.queryPrefix + "updateRef", parameter);
	}

	public int deleteRef(Parameter parameter) {
		return delete(this.queryPrefix + "deleteRef", parameter);
	}

}
