package com.ubone.standard.ubboard.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.ubboard.common.dao.BoardCommonDAO;

/** 
 * <pre>
 *  파 일 명 : BoardCommonSO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class BoardCommonSO{
	
	@Resource
	private BoardCommonDAO boardCommonDAO;

	public DataList getBoardUserInfo(Parameter parameter){
		return boardCommonDAO.getBoardUserInfo(parameter).setId("userInfo");
	}
}
