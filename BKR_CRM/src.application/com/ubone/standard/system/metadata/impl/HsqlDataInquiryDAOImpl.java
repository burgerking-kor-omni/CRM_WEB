package com.ubone.standard.system.metadata.impl;

import javax.annotation.PostConstruct;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.metadata.dao.HsqlDataInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : HsqlDataInquiryDAOImpl.java
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
public class HsqlDataInquiryDAOImpl extends UbSqlSessionDaoSupport implements HsqlDataInquiryDAO{

	private String queryPrefix = "HsqlDataInquiry.";
    private SqlSessionTemplate sqlSessionTemplate;
	
	// 클래스 생성시 생성자 실행후 @PostConstruct 지정된 함수 실행하여 지정한 SessionTemplate으로 변경
	@PostConstruct                                       
    public void init(){
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

	@Override
	public DataList getCategoryCodeList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCategoryCodeList", parameter);
	}

	@Override
	public DataList getScreenList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreenList", parameter);
	}

	@Override
	public DataList getPidDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getPidDetail", parameter);
	}

	@Override
	public DataList getScreenName(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getScreenName", parameter);
	}
}
