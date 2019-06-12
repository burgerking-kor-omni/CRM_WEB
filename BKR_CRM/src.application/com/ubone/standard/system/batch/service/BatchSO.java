package com.ubone.standard.system.batch.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.batch.dao.BatchDAO;

/** 
 * <pre>
 *  파 일 명 : BatchSO.java
 *  설    명 : 
 *  작 성 자 : 안신용
 *  작 성 일 : 2013. 5. 22.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
@Service
public class BatchSO {
	
	@Resource
	private BatchDAO batchDAO;
	
	/**
	 * 배치 목록 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectBatchList(Parameter parameter){
		return batchDAO.selectBatchList(parameter);
	}
	
	/**
	 * 배치 등록
	 * @param parameter
	 * @return 
	 */
	public String insertBatch(Parameter parameter){
		return batchDAO.insertBatch(parameter);
	}
	
	/**
	 * 배치 상태 수정
	 * @param parameter
	 * @return 
	 */
	public int updateBatchStatus(Parameter parameter){
		return batchDAO.updateBatchStatus(parameter);
	}
	
	/**
	 * 배치 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectBatch(Parameter parameter){
		return batchDAO.selectBatch(parameter);
	}
	
	/**
	 * 배치 수정
	 * @param parameter
	 * @return 
	 */
	public int updateBatch(Parameter parameter){
		return batchDAO.updateBatch(parameter);
	}
	
	/**
	 * 배치 삭제
	 * @param parameter
	 * @return 
	 */
	public int deleteBatch(Parameter parameter){
		return batchDAO.deleteBatch(parameter);
	}
	
	/**
	 * 배치 기록 목록 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectBatchLogList(Parameter parameter){
		return batchDAO.selectBatchLogList(parameter);
	}
	
	/**
	 * 배치 자동완성 목록 조회
	 * @param parameter
	 * @return 
	 */
	public DataList getListForAutocomplete(Parameter parameter){
		return batchDAO.getListForAutocomplete(parameter);
	}
}