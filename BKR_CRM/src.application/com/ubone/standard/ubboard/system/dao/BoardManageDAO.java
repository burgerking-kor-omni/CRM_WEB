package com.ubone.standard.ubboard.system.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;



/** 
 * <pre>
 *  파 일 명 : BoardManageDAO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface BoardManageDAO {
	
	/**
	 * 게시판 리스트를 조회한다.
	 * @param parameter 파라미터 클래스
	 * @return 게시판 리스트
	 */
	DataList getList(Parameter parameter);
	
	/**
	 * 게시판을 복제한다.
	 * @param parameter 파라미터 클래스
	 * @return 복제된 게시판 ID
	 */
	String boardClone(Parameter parameter);
	
	/**
	 * 게시판 유형을 복제한다.
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	String boardTypeClone(Parameter parameter);
	
	/**
	 * 게시판 관리자를 복제한다.
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	String boardAdminClone(Parameter parameter);
	
	/**
	 * 게시판을 신규 등록한다.
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	String regist(Parameter parameter);
	
	/**
	 * 게시판 유형을 신규 등록한다.
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	String registType(Parameter parameter);
	
	/**
	 * 게시판용 시퀀스를 생성한다.
	 * @param sequenceId
	 * @return
	 */
	String createSequence(String boardId);
	
	/**
	 * 게시판 상세정보를 불러온다.
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	DataList getDetail(Parameter parameter);
	
	/**
	 * 게시판 유형정보를 불러온다.
	 * @param parameter 파라미터 클래스
	 * @return
	 */
	DataList getTypeDetail(Parameter parameter);
	
	/**
	 * 게시판 상세정보를 수정한다.
	 * @param parameter
	 * @return
	 */
	int modify(Parameter parameter);
	
	/**
	 * 게시판을 삭제한다.
	 * @param parameter
	 * @return
	 */
	int remove(Parameter parameter);
	
	/**
	 * 게시판 유형정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int removeType(Parameter parameter);
	
	/**
	 * 게시판 관리자정보를 전체 삭제한다.
	 * @param parameter
	 * @return
	 */
	int removeAdminAll(Parameter parameter);
	
	/**
	 * 게시판 유형정보를 수정한다.
	 * @param parameter
	 * @return
	 */
	int modifyType(Parameter parameter);
	
	/**
	 * 게시판 관리자 목록을 가져온다.
	 * @param parameter
	 * @return
	 */
	DataList getAdminList(Parameter parameter);
	
	/**
	 * 게시판 관리자 정보를 등록한다.
	 * @param parameter
	 * @return
	 */
	String registAdmin(Parameter parameter);
	
	/**
	 * 게시판 관리자 정보를 삭제한다.
	 * @param parameter
	 * @return
	 */
	int removeAdmin(Parameter parameter);
	
	/**
	 * 게시판 접근권한 사용여부를 수정한다.
	 * @param parameter
	 * @return
	 */
	int updateBoardAuthActive(Parameter parameter);
	
	DataList getBoardAuthList(Parameter parameter);
	
	String registRole(Parameter parameter);
	
	int removeRole(Parameter parameter);
	
	DataList getMessageInfo(Parameter parameter);
	
	String registMessageInfo(Parameter parameter);
	
	int removeMessageInfo(Parameter parameter);
}
