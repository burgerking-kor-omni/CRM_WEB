package com.ubone.standard.ana.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.ana.dao.AnaInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : AnaInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 강현준
 *  작 성 일 : 2018. 12.24.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class AnaInquiryDAOImpl extends UbSqlSessionDaoSupport implements AnaInquiryDAO{
	
	private String queryPrefix = "AnaInquiry.";

	@Override
	public DataList getYearlyAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getYearlyAna", param);
	}	
	
	@Override
	public DataList getMonthAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getMonthAna", param);
	}
	
	@Override
	public DataList getDateAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getDateAna", param);
	}
	
	@Override
	public DataList getGradeAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getGradeAna", param);
	}
	
	@Override
	public DataList getGenderAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getGenderAna",param);
	}
	
	@Override
	public DataList getAgeAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getAgeAna",param);
	}
	
	@Override
	public DataList getMonthStamp(Parameter param) {
		return queryForDataList(this.queryPrefix+"getMonthStamp", param);
	}
	
	@Override
	public DataList getDateStamp(Parameter param) {
		return queryForDataList(this.queryPrefix+"getDateStamp", param);
	}
	
	@Override
	public DataList getMonGradeStamp(Parameter param) {
		return queryForDataList(this.queryPrefix+"getMonGradeStamp", param);
	}
	
	@Override
	public DataList getStoreStamp(Parameter param) {
		return queryForDataList(this.queryPrefix+"getStoreStamp", param);
	}
	
	@Override
	public DataList getChangeAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getChangeAna", param);
	}
	
	@Override
	public DataList getCauseVocAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getCauseVocAna", param);
	}
	
	@Override
	public DataList getStoreVocAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getStoreVocAna", param);
	}
	
	@Override
	public DataList getCustAttrVocAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getCustAttrVocAna", param);
	}
	
	@Override
	public DataList getDivVocAna(Parameter param) {
		return queryForDataList(this.queryPrefix+"getDivVocAna", param);
	}
	
	@Override
	public DataList getAnaListToExcel(Parameter param) {
		return queryForDataList(this.queryPrefix+"getAnaListToExcel", param);
	}
	
	@Override
	public DataList getDivVocEtc(Parameter param) {
		return queryForDataList(this.queryPrefix+"getDivVocEtc", param);
	}
	
	@Override
	public DataList getCauseVocExcelDown(Parameter param) {
		return queryForDataList(this.queryPrefix+"getCauseVocExcelDown", param);
	}
	
	@Override
	public DataList getMonthHeader(Parameter param) {
		return queryForDataList(this.queryPrefix+"getMonthHeader", param);
	}
	
	@Override
	public DataList getStoreVocAnaExcel(Parameter param) {
		return queryForDataList(this.queryPrefix+"getStoreVocAnaExcel", param);
	}
	
	@Override
	public DataList getCustAttrVocExcel(Parameter param) {
		return queryForDataList(this.queryPrefix+"getCustAttrVocExcel", param);
	}
} 