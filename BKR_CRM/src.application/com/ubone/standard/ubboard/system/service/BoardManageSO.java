package com.ubone.standard.ubboard.system.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.framework.security.jcryption.utils.JCryptionUtil;
import com.ubone.standard.ubboard.common.domain.BoardScreenInfomation;
import com.ubone.standard.ubboard.system.dao.BoardManageDAO;


/** 
 * <pre>
 *  파 일 명 : BoardManageSO.java
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
public class BoardManageSO {
	
	@Resource
	private BoardManageDAO boardManageDAO;
	
	/**
	 * 게시판 리스트 조회
	 * @param parameter
	 * @return
	 */
	public DataList getList(Parameter parameter){
		JCryptionUtil.decrypt(parameter, new String[]{"ID_BOARD"});
		return boardManageDAO.getList(parameter);
	}
	
	/**
	 * 게시판 복제
	 * @param parameter
	 * @return
	 */
	public String boardClone(Parameter parameter){
		String result = null;
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		// 게시판 기본정보 복제
		result = boardManageDAO.boardClone(parameter);
		
		if(result != null && !"".equals(result)){
			// 게시판 유형정보 복제
			boardManageDAO.boardTypeClone(parameter);
			// 게시판 관리자정보 복제
			boardManageDAO.boardAdminClone(parameter);
			// 게시판 시퀀스 등록
			boardManageDAO.createSequence(parameter.get("NEW_ID_BOARD"));
		}
		
		return result;
	}
	
	/**
	 * 게시판 신규 등록
	 * @param parameter
	 * @return
	 */
	public String regist(Parameter parameter){
		String result = null;
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		// 게시판 기본정보 등록
		result = boardManageDAO.regist(parameter);
		
		if(result != null && !"".equals(result)){
			// 게시판 유형정보 등록
			boardManageDAO.registType(parameter);
			
			// 게시판 시퀀스 생성
			boardManageDAO.createSequence(parameter.get("ID_BOARD"));
		}
		
		return result;
	}
	
	/**
	 * 게시판 상세정보 조회
	 * @param parameter
	 * @return
	 */
	public DataList getDetail(Parameter parameter){
		DataList returnDt = boardManageDAO.getDetail(parameter);
		return returnDt;
	}
	
	/**
	 * 게시판 유형정보 조회
	 * @param parameter
	 * @return
	 */
	public DataList getTypeDetail(Parameter parameter){
		return boardManageDAO.getTypeDetail(parameter);
	}
	
	/**
	 * 게시판 상세정보 수정
	 * @param parameter
	 * @return
	 */
	public int modify(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return boardManageDAO.modify(parameter);
	}
	
	/**
	 * 게시판 삭제
	 * @param parameter
	 * @return
	 */
	public int remove(Parameter parameter){
		int result = 0;
		
		result = boardManageDAO.remove(parameter);
				
		return result;
	}
	
	/**
	 * 게시판 유형정보 수정
	 * @param parameter
	 * @return
	 */
	public int modifyType(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return boardManageDAO.modifyType(parameter);
	}
	
	/**
	 * 게시판 관리자 목록 조회
	 * @param parameter
	 * @return
	 */
	public DataList getAdminList(Parameter parameter){
		return boardManageDAO.getAdminList(parameter);
	}
	
	/**
	 * 게시판 관리자 정보 추가
	 * @param parameter
	 * @return
	 */
	public String registAdmin(Parameter parameter){
		DataList adminList = this.getAdminList(parameter);
		for(int i = 0 ; i < adminList.getRowCount() ; i++){
			if(parameter.get("ADMIN_VALUE").equals(adminList.get(i, "ADMIN_VALUE"))
					&& parameter.get("ADMIN_TYPE").equals(adminList.get(i, "ADMIN_TYPE"))){
				return ResultUtils.makeResultForMessage("중복된 관리자 구성 입니다.");
			}
		}
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return boardManageDAO.registAdmin(parameter);
	}
	
	/**
	 * 게시판 관리자 정보 삭제
	 * @param parameter
	 * @return
	 */
	public int removeAdmin(Parameter parameter){
		int result = 0;
		String[] adminValues = parameter.getValues("ADMIN_VALUES");
		for (int i = 0; i < adminValues.length; i++) {			
			parameter.setParameter("ADMIN_VALUE", adminValues[i]);
			//체크된 갯수대로 삭제를 수행
			result += boardManageDAO.removeAdmin(parameter);
		}
		return result;
	}
	
	/**
	 * 게시판 연결화면정보 조회
	 * @param parameter
	 * @return
	 */
	public DataList getBoardLinkURL(Parameter parameter){
		String boardType = parameter.get("ID_BOARD_TYPE");
		
		BoardScreenInfomation boardScreenInfo = BoardScreenInfomation.valueOfName(boardType);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("LIST_SCREEN_ID", boardScreenInfo.getListScreenId());
		map.put("REGIST_SCREEN_ID", boardScreenInfo.getRegistScreenId());
		map.put("DETAIL_SCREEN_ID", boardScreenInfo.getDetailScreenId());
		map.put("MODIFY_SCREEN_ID", boardScreenInfo.getModifyScreenId());
		map.put("ANSWER_REGIST_SCREEN_ID", boardScreenInfo.getAnswerRegistScreenId());
		map.put("ANSWER_MODIFY_SCREEN_ID", boardScreenInfo.getAnswerModifyScreenId());
				
		DataList urlInfo = DataUtil.makeDataList("urlInfo", map);
		
		return urlInfo;
	}
	
	/**
	 * 게시판 접근권한 활성화여부 수정
	 * @param parameter
	 * @return
	 */
	public int updateBoardAuthActive(Parameter parameter){
		return boardManageDAO.updateBoardAuthActive(parameter);
	}
	
	public DataList getBoardAuthList(Parameter parameter){
		return boardManageDAO.getBoardAuthList(parameter);
	}
	
	/**
	 * 게시판 권한 정보 추가
	 * @param parameter
	 * @return
	 */
	public String registRole(Parameter parameter){
		DataList roleList = this.getBoardAuthList(parameter);
		for(int i = 0 ; i < roleList.getRowCount() ; i++){
			if(parameter.get("ID_ROLE").equals(roleList.get(i, "ID_ROLE"))){
				return ResultUtils.makeResultForMessage("중복된 권한정보 입니다.");
			}
		}
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return boardManageDAO.registRole(parameter);
	}
	
	/**
	 * 게시판 권한 정보 삭제
	 * @param parameter
	 * @return
	 */
	public int removeRole(Parameter parameter){
		int result = 0;
		String[] roleValues = parameter.getValues("ROLE_VALUES");
		for (int i = 0; i < roleValues.length; i++) {			
			parameter.setParameter("ID_ROLE", roleValues[i]);
			//체크된 갯수대로 삭제를 수행
			result += boardManageDAO.removeRole(parameter);
		}
		return result;
	}
	
	/**
	 * 게시판 알림메세지 정보 조회
	 * @param parameter
	 * @return
	 */
	public DataList getMessageInfo(Parameter parameter){
		return boardManageDAO.getMessageInfo(parameter);
	}
	
	/**
	 * 게시판 알림메세지 정보 등록
	 * @param parameter
	 * @return
	 */
	public int updateMessageInfo(Parameter parameter){
		int result = 0;
		
		boardManageDAO.removeMessageInfo(parameter);
		String boardId = parameter.getValue("ID_BOARD");
		result += registMessageInfo(boardId, "ARTICLE", parameter.getValue("DS_ARTICLE"), parameter.getValue("TP_ARTICLE"));
		result += registMessageInfo(boardId, "REPLY", parameter.getValue("DS_REPLY"), parameter.getValue("TP_REPLY"));
		result += registMessageInfo(boardId, "ANSWER", parameter.getValue("DS_ANSWER"), parameter.getValue("TP_ANSWER"));
		result += registMessageInfo(boardId, "NOTICE", parameter.getValue("DS_NOTICE"), parameter.getValue("TP_NOTICE"));
		
		return result;
	}
	
	private int registMessageInfo(String boardId, String messageType, String message, String useFlag){
		Parameter param = DataUtil.makeUserAddedParameter();
		int result = 0;
		
		if(useFlag == null || "".equals(useFlag)){
			useFlag = "N";
		}
		param.setParameter("ID_BOARD", boardId);
		param.setParameter("TP_MESSAGE", messageType);
		param.setParameter("DS_MESSAGE", message);
		param.setParameter("FG_USE", useFlag);
		
		String resultKey = boardManageDAO.registMessageInfo(param);
		if(resultKey != null && !"".equals(resultKey)){
			result++;
		}
		
		return result;
	}
}
