package com.ubone.standard.ubboard.board.base.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.KeyParameter;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.service.ServiceException;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.framework.type.ResultStatus;
import com.ubone.framework.util.UUIDUtil;
import com.ubone.framework.util.UserUtil;
import com.ubone.framework.util.sequence.SequenceRepository;
import com.ubone.standard.ubboard.board.base.dao.BoardDAO;
import com.ubone.standard.ubboard.board.base.dao.BoardInfomationDAO;
import com.ubone.standard.ubboard.common.domain.Board;
import com.ubone.standard.ubboard.common.domain.BoardType;
import com.ubone.standard.ubboard.common.service.BoardPushSO;


/** 
 * <pre>
 *  파 일 명 : BoardSO.java
 *  설    명 : ub-board 기본기능 Service
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class BoardSO {
	
	@Resource
	protected BoardDAO boardDAO; 
	
	@Resource
	protected BoardInfomationDAO boardInfomationDAO;
	
	@Resource
	protected BoardPushSO boardPushSO;
	
	@Resource
	protected SequenceRepository sequenceRepository;
		
	/**
	 * 게시판 목록의 데이터를 불러온다. 
	 * @param parameter
	 * @return
	 */
	public Result getBoardList(Parameter parameter){
		Result result = DataUtil.makeResult();
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		// 일반게시물 리스트
		DataList boardList = boardDAO.getBoardList(parameter).setId("boardList");
		
		result.addDataList(boardList);
		result.addDataList(boardDAO.listAdditionalInfo(parameter).setId("listAdditionalInfo"));
		
		return result; 
	}
	
	/**
	 * 게시판 공지글 목록의 데이터를 불러온다. 
	 * @param parameter
	 * @return
	 */
	public DataList getNoticeList(Parameter parameter){
		// 게시판 정보
		Board boardInfo = new Board();
		boardInfo.setBoard(boardInfomationDAO.getBoardInfo(parameter.get("ID_BOARD")));
		
		// 게시판 유형정보
		BoardType boardTypeInfo = new BoardType();
		boardTypeInfo.setBoardType(boardInfomationDAO.getBoardType(boardInfo.getBoardId(), boardInfo.getBoardTypeId()));
		
		// 공지사항 데이터 불러오기
		parameter.setParameter("CNT_NOTICE", boardTypeInfo.getNoticeCount());
		DataList noticeList = boardDAO.getBoardNoticeList(parameter);
		return noticeList;
	}
	
	/**
	 * 게시물을 등록한다.
	 * @param parameter
	 * @return
	 */
	public String[] insertBoardArticle(Parameter parameter){
		String[] result = new String[3];
		
		parameter = this.javaScriptRemove(parameter);
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		//게시물ID 채번(보안상 UUID 사용)
		String articleId = UUIDUtil.simpleId();
		parameter.setParameter("SEQ_ID_ARTICLE", articleId);

        //게시물표시번호 시퀀스로 사용(보드ID에 따라 따로 관리됨)
		String newArticleNo = sequenceRepository.nextVal("SEQ_SYS_BOARD_ARTICLE_" + parameter.get("ID_BOARD"));
        parameter.setParameter("NO_ARTICLE", newArticleNo);

        //그룹번호는 댓글과의 묶음을 위한 그룹번호
        parameter.setParameter("NO_GROUP"  , newArticleNo);

		String targets = parameter.getValue("ID_SHARE_TARGETS");
		String targetTypes = parameter.getValue("TP_SHARE_TARGETS");
		if(targets != null && !"".equals(targets)){
			String[] shareTargetIds = targets.split("[|]");		
			String[] shareTargetTps = targetTypes.split("[|]");
			if(shareTargetIds.length != 0){
				//공유대상있는 글			
				parameter.setParameter("ID_ARTICLE", articleId);
				for(int i = 0 ; i < shareTargetIds.length ; i++){
					String targetId = shareTargetIds[i];
					String targetTp = shareTargetTps[i];
					String targetNm = null;
					if("CL".equals(targetTp)){
//						VocUser user = (VocUser) UserUtil.getLoginUser();
					}
					parameter.setParameter("ID_SHARE_TARGET", targetId);
					parameter.setParameter("TP_SHARE_TARGET", targetTp);
					parameter.setParameter("NM_SHARE_TARGET", targetNm);
					boardDAO.insertBoardArticleShare(parameter);
				}
			}
		}
		
		boardDAO.insertBoardArticle(parameter);
		result[0] = parameter.getValue("ID_BOARD");
		result[1] = articleId;
		result[2] = parameter.getValue("ID_SUB");
		
		if(ConfigHolder.getBoolean("push.message.enabled")){
			if("Y".equals(parameter.getValue("FG_NOTICE"))){
				//공지글 등록 푸시
				boardPushSO.sendPushForAll(parameter.getValue("ID_BOARD"), parameter.getValue("SEQ_ID_ARTICLE"), parameter.getValue("ID_SUB"), "NOTICE");
			}else{
				//게시물 등록 푸시
				boardPushSO.sendPushForAll(parameter.getValue("ID_BOARD"), parameter.getValue("SEQ_ID_ARTICLE"), parameter.getValue("ID_SUB"), "ARTICLE");
			}
		}
		
		return result;
	}

	/**
	 * 게시판의 수정화면에서 게시물의 상세정보를 불러오는 함수로
	 * 일반적인 상세정보화면과 게시물의 수정권한을 체크한다.
	 *  - 수정권한 :
	 *    1) 게시판 관리자
	 *    2) 본인의 게시물
	 * @param parameter
	 * @return
	 */
	public Result getArticleDetailForUpdate(Parameter parameter){
		
		// 일반 상세정보 조회
		Result result = getArticleDetail(parameter);
		
		boolean hasAdmin = (Boolean)result.getExtendAttribute("hasAdmin");
		boolean isAuthor = (Boolean)result.getExtendAttribute("isAuthor");
		
		if(!hasAdmin && !isAuthor){
			throw new ServiceException("해당 게시물에 대한 수정권한이 없습니다.", ServiceContext.getCurrentService().getId());
		}
		
		return result;
	}
	
	/**
	 * 게시물 상세 정보를 불러온다.
	 * @param parameter
	 * @return
	 */
	public Result getArticleDetail(Parameter parameter){
		Result result = DataUtil.makeResult();

		//게시판 정보
		Board board = new Board();
		board.setBoard(boardInfomationDAO.getBoardInfo(parameter.get("ID_BOARD")));
		//게시판 유형정보
		BoardType boardType = new BoardType();
		boardType.setBoardType(boardInfomationDAO.getBoardType(board.getBoardId(), board.getBoardTypeId()));
		// 로그인 사용자의 게시판 관리자여부
		Boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(parameter);
		
		// 게시글 조회
		DataList articleDt = boardDAO.getArticleDetail(parameter);

		parameter = DataUtil.makeUserAddedParameter(parameter);
		User loginUser = UserUtil.getLoginUser();

		//게시물조회이력 저장
		if(boardType.isInquiryHistoryYn()){
			// 무조건 조회 건수 증가 처리
//			if(!hasAdmin && !articleDt.getString(0, "REG_USER_ID").equals(loginUser.getLoginId())){
				int checkCount = boardDAO.checkCountInquiryHistory(parameter);
				if(checkCount == 0){
					parameter.setParameter("SEQ_SYS_BOARD_INQUIRY_HISTORY", sequenceRepository.nextVal("SEQ_SYS_BOARD_INQUIRY_HISTORY"));
					boardDAO.insertInquiryHistory(parameter);
				}
//			}
			int hitCount = boardDAO.getInquiryCount(parameter);
			articleDt.set(0, "CNT_HIT", hitCount);
		}
		
		result.setExtendAttribute("board", board);
		result.setExtendAttribute("boardType", boardType);
		result.setExtendAttribute("hasAdmin", hasAdmin);
		result.setExtendAttribute("isAuthor", articleDt.getString(0, "REG_USER_ID").equals(loginUser.getId()));
		result.addDataList(articleDt.setId("articleDetail"));
	
		// 게시물번호 설정
		parameter.set("NO_ARTICLE", articleDt.getString(0, "NO_ARTICLE"));
		result.addDataList(boardDAO.getPreArticle(parameter).setId("prevInfo"));		// 이전 뉴스의 상세 정보
		result.addDataList(boardDAO.getNextArticle(parameter).setId("nextInfo"));		// 다음 뉴스의 상세 정보
		
		return result;
	}
	
	/**
	 * 게시물의 조회수를 증가시킨다.
	 * @param parameter
	 * @return
	 */
	public int increasedHitCount(Parameter parameter){
		//조회수 증가
		return boardDAO.increasedHitCount(parameter);
	}
	
	/**
	 * 게시물 첨부파일을 조회한다.
	 * @param parameter
	 * @return
	 */
	public Result getArticleFileInfo(@KeyParameter(name="ID_ARTICLE", required=true) Parameter parameter){
		return DataUtil.makeResult();
	}
	
	/**
	 * 이전 게시물 ID를 조회한다.
	 * @param parameter
	 * @return
	 */
	public DataList getPreArticle(Parameter parameter){
		return boardDAO.getPreArticle(parameter);
	}
	
	/**
	 * 다음 게시물 ID를 조회한다.
	 * @param parameter
	 * @return
	 */
	public DataList getNextArticle(Parameter parameter){
		return boardDAO.getNextArticle(parameter);
	}
	
	/**
	 * 게시물의 댓글 정보를 불러온다.
	 * @param parameter
	 * @return
	 */
	public Result getArticleReply(Parameter parameter){
		Result result = DataUtil.makeResult();
		int maxRowSeq = 0;
		int minRowSeq = 0;
		
		if(parameter.get("ROW_SEQ") != null && !"".equals(parameter.get("ROW_SEQ"))){
			maxRowSeq = parameter.getInt("ROW_SEQ");
			minRowSeq = maxRowSeq - 20;
			parameter.setParameter("MAX_ROW_SEQ", maxRowSeq);
			parameter.setParameter("MIN_ROW_SEQ", minRowSeq);
		}
		
		//댓글정보
		DataList replyDt = boardDAO.getArticleReply(parameter);
		
		ArrayList<String> fileIdList = new ArrayList<String>();
		for(int i=0; i<replyDt.getRowCount(); i++) {
			fileIdList.add(replyDt.getString(i, "FILES"));
		}
	
		// 댓글 파일리스트 조회
		if(fileIdList.size() > 0) {
			parameter.setParameter("REPLY_FILES", fileIdList.toArray(new String[0]));
			DataList replyFileDt = boardDAO.getArticleReplyFiles(parameter);
			result.addDataList(replyFileDt.setId("replyFileList"));
		}
		
		// 댓글정보 DataList에 댓글 총 개수 추가  
		Map<String, Object> replyInfoMap = new HashMap<String, Object>();
		replyInfoMap.put("MAX_COUNT", this.boardDAO.getArticleReplyCount(parameter));
		DataList replyInfoDt = DataUtil.makeDataList("replyInfo", replyInfoMap);
		
		result.addDataList(replyInfoDt);
		result.addDataList(replyDt.setId("replyList"));
		
		return result;
	}
	
	/**
	 * 댓글을 등록한다.
	 * @param parameter
	 * @return
	 */
	public String[] insertReply(Parameter parameter){
		String[] resultKey = new String[5];
		
		parameter = this.javaScriptRemove(parameter);
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		String[] fileIds = parameter.getValues("file_info.id");
		parameter.set("FILES", StringUtils.join(fileIds, "|"));
		
		String replyId = UUIDUtil.simpleId();
		parameter.set("SEQ_ID_REPLY", replyId);

		String parentReplyId = parameter.get("ID_PARENT_REPLY");
		if(parentReplyId != null && !"".equals(parentReplyId)){
			//대댓글
			Parameter param = DataUtil.makeParameter();
			param.setParameter("ID_ARTICLE", parameter.getParameter("ID_ARTICLE"));
			param.setParameter("ID_BOARD", parameter.getParameter("ID_BOARD"));
			param.setParameter("ID_REPLY", parameter.getParameter("ID_PARENT_REPLY"));
			param.setParameter("ID_SUB", parameter.getParameter("ID_SUB"));
			DataList parentDt = boardDAO.getReplyDetail(param);
			
			// SEQ_ORDER 재정렬
			param.setParameter("NO_GROUP", parentDt.getString(0, "NO_GROUP"));
			param.setParameter("SEQ_ORDER", parentDt.getString(0, "SEQ_ORDER"));
			param.setParameter("DEPTH", parentDt.getString(0, "DEPTH"));
			boardDAO.resortReplyOrder(param);
			
			parameter.setParameter("NO_GROUP", parentDt.getString(0, "NO_GROUP"));
			parameter.setParameter("DEPTH", Integer.parseInt(parentDt.getString(0, "DEPTH"))+1);
			parameter.setParameter("SEQ_ORDER", Integer.parseInt(parentDt.getString(0, "SEQ_ORDER"))+1);
		}else{
	        // 그룹번호는 시퀀스로 사용
	        String groupNo   = sequenceRepository.nextVal("SEQ_SYS_BOARD_REPLY_" + parameter.get("ID_BOARD"));

		    //기본댓글
			parameter.setParameter("NO_GROUP", groupNo);
			parameter.setParameter("DEPTH", 0);
			parameter.setParameter("SEQ_ORDER", 0);
		}
		
		boardDAO.insertReply(parameter);
		resultKey[0] = parameter.getParameter("ID_BOARD");
		resultKey[1] = parameter.getParameter("ID_ARTICLE");
		resultKey[2] = replyId;
		resultKey[3] = parameter.get("ID_SUB");
		resultKey[4] = parameter.get("DS_CONTENT_REPLY");
		
		if(ConfigHolder.getBoolean("push.message.enabled")){
			//댓글 등록 푸시
			boardPushSO.sendPushForOne(
					  parameter.getValue("ID_BOARD")
					, parameter.getValue("ID_ARTICLE")
					, parameter.getValue("SEQ_ID_REPLY")
					, parameter.getValue("ID_SUB")
					, "REPLY"
			);
		}
		
		return resultKey;
	}
	
	/**
	 * 댓글 상세정보를 불러온다.
	 * @param parameter
	 * @return
	 */
	public DataList getReplyDetail(Parameter parameter){
		return boardDAO.getReplyDetail(parameter).setId("replyDetail");
	}
	
	/**
	 * 댓글을 수정한다.
	 * @param parameter
	 * @return
	 */
	public String[] updateReply(Parameter parameter){
		String[] resultKey = new String[1];
		
		parameter = this.javaScriptRemove(parameter);
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		checkWriteAuthForReply(parameter);
		
		String[] fileIds = parameter.getValues("file_info.id");
		String[] fileDelYns = parameter.getValues("file_info.delYn");
		StringBuffer sb = new StringBuffer();
		
		for(int i = 0 ; i < fileIds.length ; i++){
			if("N".equals(fileDelYns[i])){
				if(sb.toString().length() != 0){
					sb.append("|");
				}
				sb.append(fileIds[i]);
			}
		}
		parameter.set("FILES", sb.toString());
		
		boardDAO.updateReply(parameter);
		
		resultKey[0] = parameter.get("DS_CONTENT_REPLY");
		return resultKey;
	}
	
	/**
	 * 게시물을 삭제한다. (해당 게시물의 삭제여부 컬럼 'Y')
	 * @param parameter
	 * @return
	 */
	public int deleteArticle(Parameter parameter){
		checkWriteAuthForArticle(parameter);
		
//		int result = boardDAO.deleteArticle(parameter);
		int result = boardDAO.deleteAllArticle(parameter);
	
		return result;
	}
	
	/**
	 * 게시물을 수정한다.
	 * @param parameter
	 * @return
	 */
	public int updateArticle(Parameter parameter){
		int result = 0;
		parameter = this.javaScriptRemove(parameter);
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		checkWriteAuthForArticle(parameter);
		
		//현재 자신의 글
//		parameter.setParameter("ID_SUB", new String[]{parameter.get("ID_SUB")});
		result = boardDAO.updateArticle(parameter);
		
		//공유대상이 있는 글
		String targets = parameter.getValue("ID_SHARE_TARGETS");
		String targetTypes = parameter.getValue("TP_SHARE_TARGETS");
		if(targets != null && !"".equals(targets)){
			String[] shareTargetIds = targets.split("[|]");		
			String[] shareTargetTps = targetTypes.split("[|]");
			if(shareTargetIds.length != 0){
				boardDAO.removeAllBoardArticleShare(parameter);
				for(int i = 0 ; i < shareTargetIds.length ; i++){
					String targetId = shareTargetIds[i];
					String targetTp = shareTargetTps[i];
					String targetNm = null;
					if("CL".equals(targetTp)){
//						VocUser user = (VocUser) UserUtil.getLoginUser();
					}
					parameter.setParameter("ID_SHARE_TARGET", targetId);
					parameter.setParameter("TP_SHARE_TARGET", targetTp);
					parameter.setParameter("NM_SHARE_TARGET", targetNm);
					boardDAO.insertBoardArticleShare(parameter);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 게시물을 평가한다. (추천/반대)
	 * @param parameter
	 * @return
	 */
	public Result evaluationArticle(Parameter parameter){
		Result result = DataUtil.makeResult();
		String evaluationCode = parameter.get("CD_EVALUATION");
		final String evaluationGood = "01";
		final String evaluationBad  = "02";
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		int checkOverlap = boardDAO.checkEvaluation(parameter);
		
		if(checkOverlap != 0){
			String message = "";
			if(evaluationGood.equals(evaluationCode)){
				message = "이미 추천하셨습니다.";
			}else if(evaluationBad.equals(evaluationCode)){
				message = "이미 반대하셨습니다.";
			}
			
			result.setServiceMessage(new ServiceMessage(message).setResultStatus(ResultStatus.Reject));
		}else{
		    // 추천/반대 정보 등록
			boardDAO.evaluationArticle(parameter);
			// 게시글 추천/반대 정보 업데이트
			boardDAO.updateArticleGoodBad(parameter);

			DataList detailDt = boardDAO.getArticleDetail(parameter);
			result.addDataList(detailDt);
		}
		
		return result;
	}
	
	/**
	 * 답변글을 등록한다.
	 * @param parameter
	 * @return
	 */
	public String[] insertAnswer(Parameter parameter){
		String[] result = new String[3];
		parameter = this.javaScriptRemove(parameter);
		parameter = DataUtil.makeUserAddedParameter(parameter);

		Parameter parentParam = DataUtil.makeParameter();
		parentParam.set("ID_BOARD", parameter.get("ID_BOARD"));
		parentParam.set("ID_ARTICLE", parameter.get("ID_PARENT_ARTICLE"));
		parentParam.set("ID_SUB", parameter.get("ID_SUB"));
		// 부모의 정보
		DataList parentDetail = boardDAO.getArticleDetail(parentParam);

		// SEQ_ORDER 재정렬
		parameter.setParameter("NO_GROUP", parentDetail.getString(0, "NO_GROUP"));
		parameter.setParameter("SEQ_ORDER", parentDetail.getString(0, "SEQ_ORDER"));
		parameter.setParameter("DEPTH", parentDetail.getString(0, "DEPTH"));
		boardDAO.resortArticleOrder(parameter);
		
		String articleId = UUIDUtil.simpleId();
		parameter.setParameter("SEQ_ID_ARTICLE", articleId);

        //게시물표시번호 시퀀스로 사용(보드ID에 따라 따로 관리됨)
        String newArticleNo = sequenceRepository.nextVal("SEQ_SYS_BOARD_ARTICLE_" + parameter.get("ID_BOARD"));
        parameter.setParameter("NO_ARTICLE", newArticleNo);
		
		boardDAO.insertAnswer(parameter);
		//자기는 부모DEPTH+1, 부모SEQ_ORDER+1
		result[0] = parameter.getValue("ID_BOARD");
		result[1] = articleId;
		result[2] = parameter.get("ID_SUB");
		
		if(ConfigHolder.getBoolean("push.message.enabled")){
			//답변글 등록 푸시
			boardPushSO.sendPushForOne(
					  parameter.getValue("ID_BOARD")
					, parentParam.get("ID_ARTICLE")
					, parameter.getValue("SEQ_ID_ARTICLE")
					, parameter.getValue("ID_SUB")
					, "ANSWER");
		}
		
		return result;
	}
	
	/**
	 * 댓글을 삭제한다.
	 * @param parameter
	 * @return
	 */
	public Result deleteReply(Parameter parameter){
		Result result = DataUtil.makeResult();
		
		checkWriteAuthForReply(parameter);
		
		boardDAO.deleteReply(parameter);
		
		return result;
	}
	
	/**
	 * 답변 목록 데이터를 불러온다.
	 * @param parameter
	 * @return
	 */
	public DataList getAnswerList(Parameter parameter){
		return boardDAO.getAnswerList(parameter);
	}
	
	/**
	 * 게시판의 유형 정보를 불러온다. 
	 * @param parameter
	 * @return
	 */
	public Result getBoardInfo(Parameter parameter){
		Result result = DataUtil.makeResult();
		
		//게시판 정보
		Board board = new Board();
		board.setBoard(boardInfomationDAO.getBoardInfo(parameter.get("ID_BOARD")));
		DataList boardDt = DataUtil.makeDataList("board", board.getBoardMap());
		
		//게시판 유형정보
		BoardType boardType = new BoardType();
		boardType.setBoardType(boardInfomationDAO.getBoardType(board.getBoardId(), board.getBoardTypeId()));
		DataList boardTypeDt = DataUtil.makeDataList("boardType", boardType.getBoardTypeMap());
		
		// 로그인 사용자의 게시판 관리자여부
		Boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(parameter);
		
		result.addDataList(boardDt.setId("board"));
		result.addDataList(boardTypeDt.setId("boardType"));
		result.setExtendAttribute("hasAdmin", hasAdmin);
		
		return result;
	}
	
	/**
	 * 조회이력 목록 조회 (관리자기능)
	 * @param parameter
	 * @return
	 */
	public Result getInquiryHistoryList(Parameter parameter){
		Result result = DataUtil.makeResult();
		parameter = DataUtil.makeUserAddedParameter(parameter);
		Boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(parameter);
		
		if(!hasAdmin){
			result.setServiceMessage(new ServiceMessage("게시판 관리자만 조회할 수 있습니다.").setResultStatus(ResultStatus.Reject));
			return result;
		}
		
		result.addDataList(boardDAO.getInquiryHistoryList(parameter));
		return result;
	}
	
	/**
	 * 게시판 푸시대상 사용자 설정
	 * @param parameter
	 * @return
	 */
	public String insertPushTargetByBoard(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return boardDAO.insertPushTargetByBoard(parameter);
	}
	
	/**
	 * 게시판 푸시대상 사용자 삭제
	 * @param parameter
	 * @return
	 */
	public int removePushTargetByBoard(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return boardDAO.removePushTargetByBoard(parameter);
	}
	
	/**
	 * 게시물 공유대상 리스트 조회
	 * @param parameter
	 * @return
	 */
	public DataList getArticleShareList(Parameter parameter){
		return boardDAO.getArticleShareList(parameter);
	}
	
	/**
	 * 스크립트 제거
	 * @param parameter
	 * @return
	 */
	public Parameter javaScriptRemove(Parameter parameter){
		String[] parameterKey = parameter.getKeys();
		for(int i = 0 ; i < parameterKey.length ; i++){
			String key = parameterKey[i];
			Object object = parameter.asMap().get(key);
			if(object instanceof String[]){
				String[] values = parameter.getValues(key);
				for(int j=0; j<values.length; j++){
					parameter.getValues(key)[j] = processXSS(values[j]);
				}
			}else if(object instanceof String){
				parameter.set(key, processXSS((String)object));
			}
		}
		
		return parameter;
	}
	
	private String processXSS(String orgStr){
		orgStr = orgStr.replaceAll("<", "&lt;");
		orgStr = orgStr.replaceAll(">", "&gt;");
		return orgStr;
	}

	/**
	 * 게시판 수정권한 체크 함수
	 * @param parameter ID_BOARD, ID_ARTICLE, ID_SUB 값은 필수로 존재해야함.
	 */
	public void checkWriteAuthForArticle(Parameter parameter){
		// 로그인 사용자의 게시판 관리자 여부
		boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(parameter);

		DataList articleDt = boardDAO.getArticleDetail(parameter);
		User loginUser = UserUtil.getLoginUser();
		
		boolean isAuthor = articleDt.getString(0, "REG_USER_ID").equals(loginUser.getId());

		if(!hasAdmin && !isAuthor){
			throw new ServiceException("해당 게시물에 대한 수정권한이 없습니다.", ServiceContext.getCurrentService().getId());
		}
	}

	/**
	 * 게시판 댓글 수정권한 체크 함수
	 * @param parameter ID_BOARD, ID_ARTICLE, ID_SUB 값은 필수로 존재해야함.
	 */
	public void checkWriteAuthForReply(Parameter parameter){
		// 로그인 사용자의 게시판 관리자 여부
		boolean hasAdmin = boardInfomationDAO.hasBoardAdmin(parameter);

		DataList replyDt = boardDAO.getReplyDetail(parameter);
		User loginUser = UserUtil.getLoginUser();
		
		boolean isAuthor = replyDt.getString(0, "REG_USER_ID").equals(loginUser.getId());

		if(!hasAdmin && !isAuthor){
			throw new ServiceException("해당 댓글에 대한 수정권한이 없습니다.", ServiceContext.getCurrentService().getId());
		}
	}
}
