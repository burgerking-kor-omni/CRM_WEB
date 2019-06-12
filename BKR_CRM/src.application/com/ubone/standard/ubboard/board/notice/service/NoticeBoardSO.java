package com.ubone.standard.ubboard.board.notice.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.ubboard.board.base.service.BoardSO;
import com.ubone.standard.ubboard.board.notice.dao.NoticeBoardDAO;

/** 
 * <pre>
 *  파 일 명 : NoticeBoardSO.java
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
public class NoticeBoardSO extends BoardSO{
	
	@Resource
	private NoticeBoardDAO noticeBoardDAO;

	@Override
	public String[] insertBoardArticle(Parameter parameter){
		String[] result = null;
		boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(DataUtil.makeUserAddedParameter(parameter));
		
		if(hasAdmin){
			result = super.insertBoardArticle(parameter);
		}
		
		return result;
	}
}
