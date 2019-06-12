package com.ubone.standard.system.user.service;

public enum CustomerColumn {
	ID_CUST("고객ID"),
	NM_CUST("고객명"),
	TP_CUST("고객구분"),
	ID_RESIDENT("주민등록번호"),
	ID_BIZ("사업자등록번호"),
	ID_ZIP("우편번호"),
	DS_ADDR("주소"),
	DS_DTL_ADDR("상세주소"),
	ID_PHONE("전화번호"),
	ID_PHONE_MOBILE("휴대폰번호"),
	EMAIL("이메일주소"),
	DS_EMAIL("이메일주소");
	
	private String comment = "";
	private CustomerColumn(String comment) {
		this.comment = comment;
	}
	
	public String getComment() {
		return comment;
	}
}