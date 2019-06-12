package com.ubone.standard.ubboard.board.base.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.ubboard.board.base.dao.BoardInfomationDAO;
import com.ubone.standard.ubboard.common.domain.Board;
import com.ubone.standard.ubboard.common.domain.BoardType;

/** 
 * <pre>
 *  파 일 명 : BoardInfomation.java
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
public class BoardInfomation {
	
	@Resource
	private BoardInfomationDAO boardInfomationDAO; 
	
	/**
	 * 게시판 정보와 유형 정보를 불러온다.
	 * @param parameter
	 * @return
	 */
	public Result getBoard(Parameter parameter){
		Result result = DataUtil.makeResult();
	
		// 게시판 정보
		Board board = new Board();
		board.setBoard(boardInfomationDAO.getBoardInfo(parameter.get("ID_BOARD")));
		
		// 게시판 유형정보
		BoardType boardType = new BoardType();
		boardType.setBoardType(boardInfomationDAO.getBoardType(board.getBoardId(), board.getBoardTypeId()));
		
		// 로그인 사용자의 게시판 관리자여부
		Boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(parameter);
		
		result.setExtendAttribute("board", board);
		result.setExtendAttribute("boardType", boardType);
		result.setExtendAttribute("hasAdmin", hasAdmin);
		
		return result;
	}
}
