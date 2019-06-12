package com.ubone.standard.ubboard.common.domain;

import java.util.HashMap;
import java.util.Map;

import com.ubone.framework.data.DataList;

public class Board {
	
	private String boardId;
	
	private String boardTypeId;
	
	private String subId;
	
	private String boardTitle;
	
	private String boardTheme;
	
	private String[] boardCategory;
	
	private String partitionType;
	
	private boolean authActiveYn;
	
	private String regDate;
	
	private String regUserId;
	
	private String updDate;
	
	private String updUserId;

	public void setBoard(DataList board){
		Map<String, Object> boardInfo = board.get(0);
		
		this.setBoardId((String)boardInfo.get("ID_BOARD"));
		this.setBoardTypeId((String)boardInfo.get("ID_BOARD_TYPE"));
		this.setBoardTitle((String)boardInfo.get("DS_TITLE"));
		this.setBoardTheme((String)boardInfo.get("TP_THEME"));
		
		String category = (String)boardInfo.get("CD_CATEGORY");
		if(!"".equals(category) && category != null){
			if(category.indexOf("|") >= 0){
				this.setBoardCategory(category.split("[|]"));
			}else{
				this.setBoardCategory(new String[]{category});
			}
		}
		
		this.setPartitionType((String)boardInfo.get("TP_PARTITION"));
		this.setAuthActiveYn(("Y".equals((String)boardInfo.get("FG_AUTH_ACTIVE")))?true:false);
		this.setRegDate((String)boardInfo.get("REG_DATETIME"));
		this.setRegUserId((String)boardInfo.get("REG_USER_ID"));
		this.setUpdDate((String)boardInfo.get("UPD_DATETIME"));
		this.setUpdUserId((String)boardInfo.get("UPD_USER_ID"));
		
	}
	
	public Map<String, Object> getBoardMap(){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("boardId", this.getBoardId());
		map.put("boardTypeId", this.getBoardTypeId());
		map.put("subId", this.getSubId());
		map.put("boardTitle", this.getBoardTitle());
		map.put("boardTheme", this.getBoardTheme());
		map.put("boardCategory", this.getBoardCategory());
		map.put("partitionType", this.getPartitionType());
		map.put("authActiveYn", this.isAuthActiveYn());
			
		return map;
	}
	
	public String getBoardId() {
		return boardId;
	}

	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	public String getBoardTypeId() {
		return boardTypeId;
	}

	public void setBoardTypeId(String boardTypeId) {
		this.boardTypeId = boardTypeId;
	}

	public String getSubId() {
		return subId;
	}

	public void setSubId(String subId) {
		this.subId = subId;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardTheme() {
		return boardTheme;
	}

	public void setBoardTheme(String boardTheme) {
		this.boardTheme = boardTheme;
	}

	public String[] getBoardCategory() {
		return boardCategory;
	}

	public void setBoardCategory(String[] boardCategory) {
		this.boardCategory = boardCategory;
	}

	public String getPartitionType() {
		return partitionType;
	}

	public void setPartitionType(String partitionType) {
		this.partitionType = partitionType;
	}

	public boolean isAuthActiveYn() {
		return authActiveYn;
	}

	public void setAuthActiveYn(boolean authActiveYn) {
		this.authActiveYn = authActiveYn;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegUserId() {
		return regUserId;
	}

	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	public String getUpdUserId() {
		return updUserId;
	}

	public void setUpdUserId(String updUserId) {
		this.updUserId = updUserId;
	}
	
}
