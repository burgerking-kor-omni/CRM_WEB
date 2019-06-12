package com.ubone.standard.ubboard.board.base.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : BoardDAO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface BoardDAO {
	
	DataList getBoardInfo(String boardId);
	
	DataList getBoardType(String boardTypeId);
	
	DataList getBoardList(Parameter parameter);
	
	DataList getBoardNoticeList(Parameter parameter);

	DataList getBoardTitle(Parameter parameter);
	
	String insertBoardArticle(Parameter parameter);
	
	DataList getArticleDetail(Parameter parameter);
	
	DataList getPreArticle(Parameter parameter);
	
	DataList getNextArticle(Parameter parameter);
	
	int getArticleReplyCount(Parameter parameter);
	
	DataList getArticleReply(Parameter parameter);
	
	DataList getArticleReplyFiles(Parameter parameter);
	
	DataList getReplyDetail(Parameter parameter);
	
	String insertReply(Parameter parameter);
	
	int updateReply(Parameter parameter);
	
	int increasedHitCount(Parameter parameter);
	
	int deleteArticle(Parameter parameter);
	
	int deleteAllArticle(Parameter parameter);
	
	int deleteReply(Parameter parameter);
	
	int deleteAllReply(Parameter parameter);
	
	int hideAnswer(Parameter parameter);
	
	int checkEvaluation(Parameter parameter);
	
	String evaluationArticle(Parameter parameter);
	
	int updateArticleGoodBad(Parameter parameter);
	
	int updateArticle(Parameter parameter);
	
	int resortArticleOrder(Parameter parameter);
	
	int resortReplyOrder(Parameter parameter);
	
	String insertAnswer(Parameter parameter);
	
	DataList getAnswerList(Parameter parameter);
	
	int checkCountInquiryHistory(Parameter parameter);
	
	String insertInquiryHistory(Parameter parameter);
	
	DataList getInquiryHistoryList(Parameter parameter);
	
	int getInquiryCount(Parameter parameter);
	
	DataList getSharedArticleList(Parameter parameter);
	
	String insertPushTargetByBoard(Parameter parameter);
	
	int removePushTargetByBoard(Parameter parameter);
	
	DataList listAdditionalInfo(Parameter parameter);
	
	String insertBoardArticleShare(Parameter parameter);
	
	int removeAllBoardArticleShare(Parameter parameter);
	
	DataList getArticleShareList(Parameter parameter);
}
