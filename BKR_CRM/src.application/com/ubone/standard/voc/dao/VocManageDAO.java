package com.ubone.standard.voc.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

public interface VocManageDAO {

	/**
	 * VOC 목록 조회
	 * @param param 검색조건
	 * @return 목록 정보
	 */
	public DataList getVocList (Parameter param);
	
	/**
	 * VOC 상세 조회
	 * @param param 
	 * @return
	 */
	public DataList getVocDetail (Parameter param);
	
	/**
	 * VOC 상세 첨부파일 조회
	 * @param param 
	 * @return
	 */
	public DataList getVocFileList (Parameter param);
	
	/**
	 * VOC 상세 처리내용 저장
	 * @param param ID_VOC
	 */
	public void updateVocDetail(Parameter param);
	
	/**
	 * VOC 삭제처리
	 * @param param ID_VOC
	 */
	public void deleteVoc (Parameter param);
	
	/**
	 * 문의/클레임 주문,회원 정보조회
	 * @param param 주문번호
	 * @return 주문정보,회원정보
	 */
	public DataList getOrderInfo(Parameter param);
	
	/**
	 * VOC 유형 자동완성
	 * @param param 
	 * @return
	 */
	public DataList getVocAutoComplete (Parameter param);
	
	/**
	 * VOC 등록 처리
	 * @param param VOC정보
	 */
	public void insertVoc (Parameter param);
	
	/**
	 * 매장찾기 목록 조회
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getStoreList (Parameter param);
	
	/**
	 * 매장명 자동완성 조회
	 * @param param 검색어
	 * @return 매장명
	 */
	public DataList getStoreAutoComplete(Parameter param);
	
	/**
	 * 사용자명 자동완성 조회
	 * @param param 검색어
	 * @return 사용자 정보
	 */
	public DataList getUserAutoComplete (Parameter param);
	
	/**
	 * VOC 목록 엑셀 다운로드 조회
	 * @param param 검색조건
	 * @return VOC목록
	 */
	public DataList getVocListToExcel (Parameter param);

}
