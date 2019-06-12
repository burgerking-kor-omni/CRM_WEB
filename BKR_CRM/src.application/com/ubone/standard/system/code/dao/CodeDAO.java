package com.ubone.standard.system.code.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
/** 
 * <pre>
 *  파 일 명 : CodeDAO.java
 *  설    명 : 
 *  작 성 자 : 안신용
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public interface CodeDAO {
	
	//코드 유형 등록
	public String insertCodeCategory(Parameter parameter);
	//코드 유형 목록 조회
	public DataList selectCodeCategoryList(Parameter parameter);
	//코드 유형 수정
	public String updateCodeCategory(Parameter parameter);
	//코드 유형 삭제
	public String deleteCodeCategory(Parameter parameter);
	//코드 등록
	public String insertCode(Parameter parameter);
	//코드 조회
	public DataList selectCode(Parameter parameter);
	//코드 수정
	public String updateCode(Parameter parameter);
	//코드 그룹 조회
	public DataList selectCodeGroup(Parameter parameter);
	//코드 그룹 등록
	public String insertCodeGroup(Parameter parameter);
	//코드 그룹 삭제
	public String deleteCodeGroup(Parameter parameter);
	//특정 그룹의 코드 조회
	public DataList selectGroupCode(Parameter parameter);
	//코드 유형 목록(팝업) 조회
	public DataList selectCodeCategoryListPop(Parameter parameter);
	
	public DataList selectCodeCategoryDetail(Parameter parameter);
}
