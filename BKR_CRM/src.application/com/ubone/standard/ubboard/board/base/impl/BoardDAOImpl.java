package com.ubone.standard.ubboard.board.base.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ServiceLogicError;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.standard.ubboard.board.base.dao.BoardDAO;

/** 
 * <pre>
 *  파 일 명 : BoardDAOImpl.java
 *  설    명 : UB-Board DB접근을 위한 DAO 구현체
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class BoardDAOImpl extends UbSqlSessionDaoSupport implements BoardDAO{

	private String queryPrefix = "BoardDAO.";

	@Override
	public DataList getBoardInfo(String boardId) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("boardId", boardId);
		return queryForDataList(this.queryPrefix + "getBoardInfo", parameter);
	}

	@Override
	public DataList getBoardType(String boardTypeId) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("ID_BOARD_TYPE", boardTypeId);
		return queryForDataList(this.queryPrefix + "getBoardType", parameter);
	}

	@Override
	public DataList getBoardList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getBoardList", parameter);
	}

	@Override
	public DataList getBoardNoticeList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getBoardNoticeList", parameter);
	}

	@Override
	public DataList getBoardTitle(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getBoardTitle", parameter);
	}

	@Override
	public String insertBoardArticle(Parameter parameter) {
		insert(this.queryPrefix + "insertBoardArticle", parameter);
		return parameter.getParameter("SEQ_ID_ARTICLE");
	}

	@Override
	public DataList getArticleDetail(Parameter parameter) {
		DataList dataList = queryForDataList(this.queryPrefix + "getArticleDetail", parameter);
		if(dataList.getRowCount() ==0){
			throw new ServiceLogicError("해당 게시물이 존재하지 않습니다.", ServiceContext.getCurrentService().getId());
		}
		return dataList;
	}

	@Override
	public DataList getPreArticle(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getPreArticle", parameter);
	}

	@Override
	public DataList getNextArticle(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getNextArticle", parameter);
	}

	@Override
	public int getArticleReplyCount(Parameter parameter) {
		return (Integer)queryForObject(this.queryPrefix + "getArticleReplyCount", parameter);
	}

	@Override
	public DataList getArticleReply(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getArticleReply", parameter);
	}

	@Override
	public DataList getArticleReplyFiles(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getArticleReplyFiles", parameter);
	}

	@Override
	public DataList getReplyDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getReplyDetail", parameter);
	}

	@Override
	public String insertReply(Parameter parameter) {
		insert(this.queryPrefix + "insertReply", parameter);
		return parameter.get("SEQ_ID_REPLY");
	}

	@Override
	public int updateReply(Parameter parameter) {
		return update(this.queryPrefix + "updateReply", parameter);
	}

	@Override
	public int increasedHitCount(Parameter parameter) {
		return update(this.queryPrefix + "increasedHitCount", parameter);
	}

	@Override
	public int deleteArticle(Parameter parameter) {
		return delete(this.queryPrefix + "deleteArticle", parameter);
	}

	@Override
	public int deleteAllArticle(Parameter parameter) {
		return delete(this.queryPrefix + "deleteAllArticle", parameter);
	}

	@Override
	public int deleteReply(Parameter parameter) {
		return update(this.queryPrefix + "deleteReply", parameter);
	}

	@Override
	public int deleteAllReply(Parameter parameter) {
		return update(this.queryPrefix + "deleteAllReply", parameter);
	}

	@Override
	public int hideAnswer(Parameter parameter) {
		return update(this.queryPrefix + "hideAnswer", parameter);
	}

	@Override
	public int checkEvaluation(Parameter parameter) {
		return (Integer)queryForObject(this.queryPrefix + "checkEvaluation", parameter);
	}

	@Override
	public String evaluationArticle(Parameter parameter) {
		return insert(this.queryPrefix + "evaluationArticle", parameter);
	}

	@Override
	public int updateArticleGoodBad(Parameter parameter) {
		return update(this.queryPrefix + "updateArticleGoodBad", parameter);
	}

	@Override
	public int updateArticle(Parameter parameter) {
		return update(this.queryPrefix + "updateArticle", parameter);
	}

	@Override
	public int resortArticleOrder(Parameter parameter) {
		return update(this.queryPrefix + "resortArticleOrder", parameter);
	}

	@Override
	public int resortReplyOrder(Parameter parameter) {
		return update(this.queryPrefix + "resortReplyOrder", parameter);
	}

	@Override
	public String insertAnswer(Parameter parameter) {
		insert(this.queryPrefix + "insertAnswer", parameter);
		return parameter.getParameter("SEQ_ID_ARTICLE");
	}

	@Override
	public DataList getAnswerList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getAnswerList", parameter);
	}

	@Override
	public int checkCountInquiryHistory(Parameter parameter) {
		return (Integer)queryForObject(this.queryPrefix + "checkCountInquiryHistory", parameter);
	}

	@Override
	public String insertInquiryHistory(Parameter parameter) {
		return insert(this.queryPrefix + "insertInquiryHistory", parameter);
	}

	@Override
	public DataList getInquiryHistoryList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getInquiryHistoryList", parameter);
	}

	@Override
	public int getInquiryCount(Parameter parameter) {
		return (Integer)queryForObject(this.queryPrefix + "getInquiryCount", parameter);
	}

	@Override
	public DataList getSharedArticleList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getSharedArticleList", parameter);
	}

	@Override
	public String insertPushTargetByBoard(Parameter parameter) {
		return insert(this.queryPrefix + "insertPushTargetByBoard", parameter); 
	}

	@Override
	public int removePushTargetByBoard(Parameter parameter) {
		return delete(this.queryPrefix + "removePushTargetByBoard", parameter);
	}

	@Override
	public DataList listAdditionalInfo(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "listAdditionalInfo", parameter);
	}

	@Override
	public String insertBoardArticleShare(Parameter parameter) {
		return insert(this.queryPrefix + "insertBoardArticleShare", parameter);
	}

	@Override
	public int removeAllBoardArticleShare(Parameter parameter) {
		return delete(this.queryPrefix + "removeAllBoardArticleShare", parameter);
	}

	@Override
	public DataList getArticleShareList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getArticleShareList", parameter);
	}

	
	
}
