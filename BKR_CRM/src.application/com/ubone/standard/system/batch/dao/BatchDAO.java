package com.ubone.standard.system.batch.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : BatchDAO.java
 *  설    명 : 
 *  작 성 자 : 안신용
 *  작 성 일 : 2013. 5. 22.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public interface BatchDAO {
	
	//배치 목록 조회
	public DataList selectBatchList(Parameter parameter);
	//배치 상태 수정
	public int updateBatchStatus(Parameter parameter);
	//배치 등록
	public String insertBatch(Parameter parameter);
	//배치 조회
	public DataList selectBatch(Parameter parameter);
	//배치 수정
	public int updateBatch(Parameter parameter);
	//배치 삭제
	public int deleteBatch(Parameter parameter);
	//배치 기록 목록 조회
	public DataList selectBatchLogList(Parameter parameter);
	//배치 자동완성기능
	public DataList getListForAutocomplete(Parameter parameter);
	//배치 상태 및 사영여부 수정
	public int updateBatchStatusRe(Parameter parameter);
}
