package com.ubone.standard.email.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

public interface EmailTargetManageDAO {

	/**
	 * VOC유형 별 이메일 발송 대상 목록 조회
	 * @param param 검색조건
	 * @return 목록 정보
	 */
	public DataList getEmailTargetList (Parameter param);

	/**
	 * VOC유형 별 이메일 발송 대상 상세 목록
	 * @param param ID_TARGET
	 * @return 목록 정보
	 */
	public DataList getEmailTargetDetailList (Parameter param);

	/**
	 * 이메일 발송 대상 등록
	 * @param param 발송 대상자 정보
	 */
	public String insertVocDispatch (Parameter param);

	/**
	 * 이메일 발송 대상 상세 유형 등록
	 * @param param 발송 대상자 상세 정보
	 */
	public String insertVocDispatchCategory (Parameter param);

	/**
	 * 이메일 발송 대상 수정
	 * @param param 발송 대상자 정보
	 */
	public int updateVocDispatch(Parameter param);

	/**
	 * 이메일 발송 대상 상세 유형 수정
	 * @param param 발송 대상자 상세 정보
	 */
	public int updateVocDispatchCategory(Parameter param);

	/**
	 * 이메일 발송 대상 유형 삭제
	 * @param param ID_TARGET
	 */
	public int deleteVocDispatch (Parameter param);

	/**
	 * 이메일 발송 대상 상세 유형 삭제
	 * @param param ID_TARGET
	 */
	public int deleteVocDispatchCategory (Parameter param);

}
