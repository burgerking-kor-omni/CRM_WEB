package com.ubone.standard.ubboard.common.domain;


public enum BoardScreenInfomation {

	/**
	 * DEFAULT
	 */
	DEFAULT("default", "UBD1001", "UBD1002", "UBD1003", "UBD1004", "UBD1005", "UBD1006")

	/**
	 * NOTICE
	 */
	, NOTICE("notice", "UBD2001", "UBD2002", "UBD2003", "UBD2004", "UBD2005", "UBD2006")
	
	/**
	 * UNDEFINED
	 */
	, UNDEFINED("Undefined", "UBD1001", "UBD1002", "UBD1003", "UBD1004", "UBD1005", "UBD1006");
	
	private String boardType;
	private String listScreenId;
	private String registScreenId;
	private String detailScreenId;
	private String modifyScreenId;
	private String answerRegistScreenId;
	private String answerModifyScreenId;	
	
	private BoardScreenInfomation(String boardType
								, String listScreenId
								, String registScreenId
								, String detailScreenId
								, String modifyScreenId
								, String answerRegistScreenId
								, String answerModifyScreenId) {
		this.boardType = boardType;
		this.listScreenId = listScreenId;
		this.registScreenId = registScreenId;
		this.detailScreenId = detailScreenId;
		this.modifyScreenId = modifyScreenId;
		this.answerRegistScreenId = answerRegistScreenId;
		this.answerModifyScreenId = answerModifyScreenId;
	}
	
	public String getBoardType() {
		return boardType;
	}

	public String getListScreenId() {
		return listScreenId;
	}

	public String getRegistScreenId() {
		return registScreenId;
	}

	public String getDetailScreenId() {
		return detailScreenId;
	}

	public String getModifyScreenId() {
		return modifyScreenId;
	}

	public String getAnswerRegistScreenId() {
		return answerRegistScreenId;
	}

	public String getAnswerModifyScreenId() {
		return answerModifyScreenId;
	}
	
	public static BoardScreenInfomation valueOfName(String name){
		for(BoardScreenInfomation element : BoardScreenInfomation.values()) {
			if(name.equals(element.getBoardType())) {
				return element;
			}
		}
		return BoardScreenInfomation.UNDEFINED;
	}
	
}
