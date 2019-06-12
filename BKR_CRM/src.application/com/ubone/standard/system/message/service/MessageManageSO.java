package com.ubone.standard.system.message.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.message.dao.MessageDAO;

/** 
 * <pre>
 *  파 일 명 : MessageManageSO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 7. 19.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class MessageManageSO {
	
	@Resource
	private MessageDAO messageDAO;
	
	/**
	 * 메세지 Rule 관리 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메세지 Rule 관리 조회 결과
	 */
	public DataList getRuleList(Parameter parameter){
		return messageDAO.getRuleList(parameter);
	}
}
