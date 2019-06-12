package com.ubone.api.rest.voc.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


public interface VocDAO {
	
	/**
	 * 메일전송용 정보조회
	 * @param param
	 * @return  
	 */
	public DataList getMailSendCause(Parameter parameter);
	
	/**
	 * 메일 템플릿 데이터 조회
	 * @param param
	 * @return  
	 */
	public DataList getMailData(Parameter parameter);
	
	/**
	 * 메일 템플릿 파일 데이터 조회
	 * @param param
	 * @return  
	 */
	public DataList getMailDataFile(Parameter parameter);
	
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	/**
	 * 문의/클레임 등록 - (Web & APP & CallCenter)
	 * @param param
	 * @return  
	 */
	public String insertVoc(Parameter parameter);
	
	/**
	 * 문의/클레임 파일 등록 - (Web & APP)
	 * @param param
	 * @return  
	 */
	public String insertVocFile(Parameter parameter);
	
	/**
	 * 문의/클레임 수정 - (Web & APP & CallCenter)
	 * @param param
	 * @return  
	 */
	public int updateVoc(Parameter parameter);
	
	/**
	 * 문의/클레임 삭제 - (Web & APP & CallCenter)
	 * @param param
	 * @return  
	 */
	public int deleteVoc(Parameter parameter);
	
}
