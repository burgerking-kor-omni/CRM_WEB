package com.ubone.standard.system.code.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
/** 
 * <pre>
 *  파 일 명 : CodeGropDAO.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public interface CodeFilterDAO {
	
	//코드필터 조회
	public DataList getCodeFilterList(Parameter parameter);
	
	//코드필터 조회 (다이나믹코드의 경우 사용함)
	public DataList getCodeFilterListDn(Parameter parameter);
		
		//코드필터 등록
	public void insertCodeFiler(Parameter parameter);
	
	//코드 유형 목록 조회
    public DataList selectCodeCategory(Parameter parameter);
		
    //코드 필터 삭제
	public void delete(Parameter parameter);
	
	
	
}
