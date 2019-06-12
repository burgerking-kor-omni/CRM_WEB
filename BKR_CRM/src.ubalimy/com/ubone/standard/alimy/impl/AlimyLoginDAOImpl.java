package com.ubone.standard.alimy.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.alimy.dao.AlimyLoginDAO;

/** 
 * <pre>
 *  파 일 명 : AlimyLoginDAOImpl.java
 *  설    명 : 알리미 Login 처리를 위한 DAO 구현클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.04.22
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Repository
public class AlimyLoginDAOImpl extends UbSqlSessionDaoSupport implements AlimyLoginDAO {

	private String queryPrefix = "AlimyLogin.";
	Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * 알리미 로그인 정보 저장함수
	 */
	@Override
	public void saveAlimyLoginInfo(Parameter parameter) {
		// 1. 로그인ID에 해당하는 알리마 정보가 있는지 체크
		DataList dataList = queryForDataList(queryPrefix+"selectAlimyLoginInfo", parameter);
		
		// 2. 데이터가 존재하면 Update, 없으면 Insert 처리
		if(dataList.getRowCount() == 0){
			insert(queryPrefix+"insertAlimyLoginInfo", parameter);
		}else{
			update(queryPrefix+"updateAlimyLoginInfo", parameter);
		}
	}
}
