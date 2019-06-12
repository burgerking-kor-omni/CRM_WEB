package com.ubone.standard.ana.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


public interface AnaInquiryDAO {
	/**
	 * 연도별 회원현황
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getYearlyAna(Parameter param);
	
	/**
	 * 월별 회원현황
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getMonthAna(Parameter param);
	
	/**
	 * 일별 회원현황
	 * @param param 검색조건
	 * @return 
	 */
	public DataList getDateAna(Parameter param);
	
	/**
	 * 등급별 회원현황 목록 조회
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getGradeAna (Parameter param);
	
	/**
	 * 성별 회원현황 목록 조회
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getGenderAna (Parameter param);
	
	/**
	 * 연령대별 회원현황 목록 조회
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getAgeAna (Parameter param);
	
	/**
	 * 월별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getMonthStamp(Parameter param);
	
	/**
	 * 일별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getDateStamp (Parameter param);
	
	/**
	 * 월별/등급별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getMonGradeStamp(Parameter param);
	
	/**
	 * 매장별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getStoreStamp (Parameter param);
	
	/**
	 * 월별 멤버십 변동현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getChangeAna (Parameter param);
	
	/**
	 * 유형-월별 VOC현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getCauseVocAna(Parameter param);
	
	/**
	 * 매장-월별 VOC현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getStoreVocAna(Parameter param);
	
	/**
	 * 고객속성별 VOC현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getCustAttrVocAna(Parameter param);
	
	/**
	 * 지역별 VOC 불만 현황
	 * @param param 검색조건
	 * @return 현황목록
	 */
	public DataList getDivVocAna(Parameter param);
	
	/**
	 * 지역별 VOC 불만 현황 Excel 다운로드
	 * @param param 검색조건
	 * @return 현황목록
	 */
	public DataList getAnaListToExcel(Parameter param);
	
	/**
	 * 지역별 voc 불만현황 기타부분
	 * @param param 검색조건
	 * @return 기타 열조회
	 */
	public DataList getDivVocEtc(Parameter param);
	
	/**
	 * 유형별-기간별 voc 통게 엑셀 다운로드
	 * @param param 검색조건
	 * @return 엑셀 다운로드
	 */
	public DataList getCauseVocExcelDown(Parameter param);
	
	/**
	 * 월별 헤더 조회
	 * @param param 기준년월
	 * @return 헤더
	 */
	public DataList getMonthHeader(Parameter param);
	
	/**
	 * 매장-월별 VOC현황 엑셀 다운로드
	 * @param param 검색조건
	 * @return 엑셀 다운로드
	 */
	public DataList getStoreVocAnaExcel(Parameter param);
	
	/**
	 * 고객속성별 VOC현황 엑셀 다운로드
	 * @param param 검색조건
	 * @return 엑셀 다운로드
	 */
	public DataList getCustAttrVocExcel(Parameter param);
}
