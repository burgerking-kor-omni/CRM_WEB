package com.ubone.standard.ubboard.common.domain;

import java.util.HashMap;
import java.util.Map;

import com.ubone.framework.data.DataList;

public class BoardType {
	private String boardTypeId;
	
	private boolean dataItemYn;
	
	private boolean dataItemNew, dataItemFile, dataItemReply;
	
	private boolean noticeYn;
	
	private int noticeCount;
	
	private boolean fileYn;
	
	private String fileVolume;//
	
	private String[] fileExtension;//
	
	private int maxFileCount;//
	
	private boolean replyYn;
	
	private boolean answerYn;
	
	private boolean preNextYn;
	
	private boolean goodBadYn;
	
	private boolean excelDownYn;
	
	private boolean textEditorYn;
	
	private boolean inquiryHistoryYn;

	public void setBoardType(DataList boardType){
		Map<String, Object> boardTp = boardType.get(0);
		
		this.setBoardTypeId((String)boardTp.get("ID_BOARD_TYPE"));
		this.setDataItemYn(("Y".equals((String)boardTp.get("FG_DATA_ITEM")))?true:false);
		this.setDataItemNew(("Y".equals((String)boardTp.get("FG_DATA_ITEM_NEW")))?true:false);
		this.setDataItemFile(("Y".equals((String)boardTp.get("FG_DATA_ITEM_FILE")))?true:false);
		this.setDataItemReply(("Y".equals((String)boardTp.get("FG_DATA_ITEM_REPLY")))?true:false);
		this.setNoticeYn(("Y".equals((String)boardTp.get("FG_NOTICE")))?true:false);
		
		String noticeCnt = (String)boardTp.get("CNT_NOTICE");
		if(noticeCnt != null && !"".equals(noticeCnt)){
			this.setNoticeCount(Integer.parseInt((String)boardTp.get("CNT_NOTICE")));
		}
		
		this.setFileYn(("Y".equals((String)boardTp.get("FG_FILE")))?true:false);

		String extension = (String)boardTp.get("DS_FILE_EXTENSION");
		if(extension != null && !"".equals(extension)){
			if(extension.indexOf("|") >= 0){
				this.setFileExtension(extension.split("[|]"));
			}else{
				this.setFileExtension(new String[]{extension});
			}
		}
		
		this.setFileVolume((String)boardTp.get("DS_FILE_VOLUME"));
		if((String)boardTp.get("CNT_MAX_FILE") != null && !"".equals((String)boardTp.get("CNT_MAX_FILE"))){
			this.setMaxFileCount(Integer.parseInt((String)boardTp.get("CNT_MAX_FILE")));
		}

		this.setReplyYn(("Y".equals((String)boardTp.get("FG_REPLY")))?true:false);
		this.setAnswerYn(("Y".equals((String)boardTp.get("FG_ANSWER")))?true:false);
		this.setPreNextYn(("Y".equals((String)boardTp.get("FG_PRE_NEXT")))?true:false);
		this.setGoodBadYn(("Y".equals((String)boardTp.get("FG_GOOD_BAD")))?true:false);
		this.setExcelDownYn(("Y".equals((String)boardTp.get("FG_EXCEL_DOWN")))?true:false);
		this.setTextEditorYn(("Y".equals((String)boardTp.get("FG_TEXT_EDITOR")))?true:false);
		this.setInquiryHistoryYn(("Y".equals((String)boardTp.get("FG_INQUIRY_HISTORY")))?true:false);
	}
	
	public Map<String, Object> getBoardTypeMap(){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("boardTypeId", this.getBoardTypeId());
		map.put("dataItemYn", this.isDataItemYn());
		map.put("dataItemNew", this.isDataItemNew());
		map.put("dataItemFile", this.isDataItemFile());
		map.put("dataItemReply", this.isDataItemReply());
		map.put("noticeYn", this.isNoticeYn());
		map.put("noticeCount", this.getNoticeCount());
		map.put("fileYn", this.isFileYn());
		map.put("fileVolume", this.getFileVolume());
		map.put("fileExtension", this.getFileExtension());
		map.put("maxFileCount", this.getMaxFileCount());
		map.put("replyYn", this.isReplyYn());
		map.put("answerYn", this.isAnswerYn());
		map.put("preNextYn", this.isPreNextYn());
		map.put("goodBadYn", this.isGoodBadYn());
		map.put("excelDownYn", this.isExcelDownYn());
		map.put("textEditorYn", this.isTextEditorYn());
		map.put("inquiryHistoryYn", this.isInquiryHistoryYn());

		return map;
	}
	
	public String getBoardTypeId() {
		return boardTypeId;
	}

	public void setBoardTypeId(String boardTypeId) {
		this.boardTypeId = boardTypeId;
	}
	
	public boolean isDataItemYn() {
		return dataItemYn;
	}

	public void setDataItemYn(boolean dataItemYn) {
		this.dataItemYn = dataItemYn;
	}

	public boolean isDataItemNew() {
		return dataItemNew;
	}

	public void setDataItemNew(boolean dataItemNew) {
		this.dataItemNew = dataItemNew;
	}

	public boolean isDataItemFile() {
		return dataItemFile;
	}

	public void setDataItemFile(boolean dataItemFile) {
		this.dataItemFile = dataItemFile;
	}

	public boolean isDataItemReply() {
		return dataItemReply;
	}

	public void setDataItemReply(boolean dataItemReply) {
		this.dataItemReply = dataItemReply;
	}

	public boolean isNoticeYn() {
		return noticeYn;
	}

	public void setNoticeYn(boolean noticeYn) {
		this.noticeYn = noticeYn;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

	public boolean isFileYn() {
		return fileYn;
	}

	public void setFileYn(boolean fileYn) {
		this.fileYn = fileYn;
	}

	public String[] getFileExtension() {
		return fileExtension;
	}

	public void setFileExtension(String[] fileExtension) {
		this.fileExtension = fileExtension;
	}

	public String getFileVolume() {
		return fileVolume;
	}

	public void setFileVolume(String fileVolume) {
		this.fileVolume = fileVolume;
	}

	public int getMaxFileCount() {
		return maxFileCount;
	}

	public void setMaxFileCount(int maxFileCount) {
		this.maxFileCount = maxFileCount;
	}

	public boolean isReplyYn() {
		return replyYn;
	}

	public void setReplyYn(boolean replyYn) {
		this.replyYn = replyYn;
	}

	public boolean isAnswerYn() {
		return answerYn;
	}

	public void setAnswerYn(boolean answerYn) {
		this.answerYn = answerYn;
	}

	public boolean isPreNextYn() {
		return preNextYn;
	}

	public void setPreNextYn(boolean preNextYn) {
		this.preNextYn = preNextYn;
	}

	public boolean isGoodBadYn() {
		return goodBadYn;
	}

	public void setGoodBadYn(boolean goodBadYn) {
		this.goodBadYn = goodBadYn;
	}

	public boolean isExcelDownYn() {
		return excelDownYn;
	}

	public void setExcelDownYn(boolean excelDownYn) {
		this.excelDownYn = excelDownYn;
	}

	public boolean isTextEditorYn() {
		return textEditorYn;
	}

	public void setTextEditorYn(boolean textEditorYn) {
		this.textEditorYn = textEditorYn;
	}

	public boolean isInquiryHistoryYn() {
		return inquiryHistoryYn;
	}

	public void setInquiryHistoryYn(boolean inquiryHistoryYn) {
		this.inquiryHistoryYn = inquiryHistoryYn;
	}
	
	
}
