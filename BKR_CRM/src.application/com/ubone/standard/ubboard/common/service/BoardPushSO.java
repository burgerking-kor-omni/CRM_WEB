package com.ubone.standard.ubboard.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.message.ChannelType;
import com.ubone.standard.system.message.RecipientType;
import com.ubone.standard.system.message.dao.MessageDAO;
import com.ubone.standard.ubboard.common.dao.BoardPushDAO;

/** 
 * <pre>
 *  파 일 명 : BoardPushSO.java
 *  설    명 : 게시판 알림메세지 작동 Service
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class BoardPushSO{
	
	@Resource
	private BoardPushDAO boardPushDAO;

	@Resource
	private MessageDAO messageDAO;
	
	/**
	 * 해당 게시판에 PUSH 알림을 켜둔 대상들에게 메세지알림
	 * @param boardId
	 * @param bizKey
	 * @param subId
	 * @param messageType
	 * @return 통보ID
	 */
	public String sendPushForAll(String boardId, String bizKey, String subId, String messageType){
		String dispatchId = null;
		Parameter param = DataUtil.makeParameter();
		param.setParameter("ID_BOARD", boardId)
			 .setParameter("ID_SUB", subId)
			 .setParameter("ID_BIZ_KEY", bizKey)
			 .setParameter("TP_MESSAGE", messageType);
		
		DataList messageInfo = boardPushDAO.getMessageInfo(param);
		
		if(messageInfo.getRowCount() > 0){
			if("Y".equals(messageInfo.get(0, "FG_USE"))){
				DataList pushTargets = boardPushDAO.getPushTarget(param);
				
				param.setParameter("DS_MSG_CONTENTS", messageInfo.get(0, "DS_MESSAGE"));
				param.setParameter("TP_BIZ", param.getValue("ID_BOARD"));
//				param.setParameter("TP_SEND", ChannelType.Push.getCode());
				
//				dispatchId = this.insertPush(pushTargets, param);
			}
		}
		
		return dispatchId;
	}
	
	/**
	 * 해당 게시물의 작성자가 PUSH 알림을 켜둔 상태일 경우 메세지 알림
	 * @param boardId
	 * @param articleId
	 * @param replyId
	 * @param subId
	 * @param messageType
	 * @return 통보ID
	 */
	public String sendPushForOne(String boardId, String articleId, String replyId, String subId, String messageType){
		String dispatchId = null;
		Parameter param = DataUtil.makeParameter();
		param.setParameter("ID_BOARD", boardId)
			 .setParameter("ID_SUB", subId)
			 .setParameter("ID_ARTICLE", articleId)
			 .setParameter("ID_BIZ_KEY", replyId)
			 .setParameter("TP_MESSAGE", messageType);
		
		DataList messageInfo = boardPushDAO.getMessageInfo(param);
		
		if(messageInfo.getRowCount() > 0){
			if("Y".equals(messageInfo.get(0, "FG_USE"))){
				
				DataList registUserDt = boardPushDAO.getArticleRegistUserId(param);
				if(registUserDt.getRowCount() > 0){	
					param.setParameter("ID_USER", registUserDt.getString(0, "ID_REG_EMP"));
					DataList pushTargets = boardPushDAO.getPushTarget(param);
					
					param.setParameter("DS_MSG_CONTENTS", messageInfo.get(0, "DS_MESSAGE"));
					param.setParameter("TP_BIZ", param.getValue("ID_BOARD"));
//					param.setParameter("TP_SEND", ChannelType.Push.getCode());
					
//					dispatchId = this.insertPush(pushTargets, param);
				}
			}
		}
		
		return dispatchId;
	}
	
	/**
	 * 통보테이블에 데이터 적재
	 * @param pushTargets
	 * @param param
	 * @return
	 */
	private String insertPush(DataList pushTargets, Parameter param){
		String dispatchId = null;
		if(pushTargets.getRowCount() > 0){
			dispatchId = messageDAO.insert(param);
			
			if(dispatchId != null && !"".equals(dispatchId)){
				param.setParameter("ID_DISPATCH", dispatchId);
				
				for(int i = 0 ; i < pushTargets.getRowCount() ; i++){
					param.setParameter("NM_TARGET", pushTargets.get(i, "NM_TARGET"))
						 .setParameter("DS_TELNO", pushTargets.get(i, "DS_TELNO"))
						 .setParameter("DS_EMAIL", pushTargets.get(i, "DS_EMAIL"))
						 .setParameter("ID_PUSH", pushTargets.get(i, "ID_PUSH"))
						 .setParameter("TP_OS", pushTargets.get(i, "TP_OS"))
						 .setParameter("TP_TARGET", RecipientType.Employee.getCode());
					messageDAO.insertTarget(param);
				}
			}
		}
		
		return dispatchId;
	}
}
