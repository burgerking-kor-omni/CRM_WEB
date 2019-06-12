package com.ubone.standard.system.code.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.cache.CodeCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.code.Code;
import com.ubone.framework.util.code.CodeRepository;
import com.ubone.standard.system.code.dao.CodeDAO;

/** 
 * <pre>
 *  파 일 명 : CodeSO.java
 *  설    명 : 
 *  작 성 자 : 안신용
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
@Service
public class CodeSO {
	
	@Resource
	private CodeDAO codeDAO;
	
	@Resource
	private CodeRepository codeRepository;
	
	@Resource
	private CodeCacheService codeCacheService;
	
	/**
	 * 코드 유형 등록
	 * @param parameter
	 * @return 
	 */
	public String insertCodeCategory(Parameter parameter){
		return codeDAO.insertCodeCategory(DataUtil.makeUserAddedParameter(parameter));
	}
	
	/**
	 * 코드 유형 목록 조회
	 * @param parameter   
	 * @return 
	 */
	public DataList selectCodeCategoryList(Parameter parameter){
		return codeDAO.selectCodeCategoryList(parameter);
	}
	
	/**
	 * 코드 유형 수정
	 * @param parameter
	 * @return 
	 */
	public String updateCodeCategory(Parameter parameter){
		codeCacheService.flushAll();
		return codeDAO.updateCodeCategory(parameter);
	}
	
	/**
	 * 코드 유형 삭제
	 * @param parameter
	 * @return 
	 */
	public String deleteCodeCategory(Parameter parameter){
		return codeDAO.deleteCodeCategory(parameter);
	}
	
	/**
	 * 코드 등록
	 * @param parameter
	 * @return 
	 */
	public String insertCode(Parameter parameter){
		codeCacheService.flushAll();
		return codeDAO.insertCode(DataUtil.makeUserAddedParameter(parameter));
	}
	
	/**
	 * 코드 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectCode(Parameter parameter){
		 return codeDAO.selectCode(parameter); 
	}
	
	/**
	 * 코드 수정
	 * @param parameter
	 * @return 
	 */
	public String updateCode(Parameter parameter){
		codeCacheService.flushAll();
		return codeDAO.updateCode(parameter);
	}
	
	/**
	 * Dynamic 코드 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectDynamicCode(Parameter parameter){
		 Code code = codeRepository.getTopCodeRepository().findByCategoryId( parameter.get("CODE_CATEGORY_ID"), parameter);
		 
		 /**
		  * 데이터가 없는경우 빈데이터 리스트를 새로 만들어서 리턴하고, 존재하는 경우에는 코드데이터를 리턴한다.
		  */
		 if(code == null) {
			 return DataUtil.makeDataList("code.selectDynamicCode");
		 }else {
			 return code.getCodes().setId("code.selectDynamicCode");
		 }
	}
	
	/**
	 * 코드 그룹 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectCodeGroup(Parameter parameter){
		return codeDAO.selectCodeGroup(parameter);
	}
	
	/**
	 * 코드 그룹 등록
	 * @param parameter
	 * @return 
	 */
	public String insertCodeGroup(Parameter parameter){
		codeCacheService.flushAll();

		parameter.set("GROUP_ID", parameter.get("CODE_GROUP_ID"));
		codeDAO.deleteCodeGroup(parameter);
		codeDAO.insertCodeGroup(parameter);
		return "";
	}
	
	/**
	 * 코드 그룹 삭제
	 * @param parameter
	 * @return 
	 */
	public String deleteCodeGroup(Parameter parameter){
		codeCacheService.flushAll();
		return codeDAO.deleteCodeGroup(parameter);
	}
	
	/**
	 * 특정 그룹의 코드 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectGroupCode(Parameter parameter){
		return codeDAO.selectGroupCode(parameter);
	}
	
	/**
	 * 코드 유형 목록(팝업) 조회
	 * @param parameter   
	 * @return 
	 */
	public DataList selectCodeCategoryListPop(Parameter parameter){
		return codeDAO.selectCodeCategoryListPop(parameter);
	}
	
	/**
	 * 코드카테고리 상세
	 * @param parameter
	 * @return
	 */
	public DataList selectCodeCategoryDetail(Parameter parameter){
		return codeDAO.selectCodeCategoryDetail(parameter);
	}
	
	/**
	 * 코드 캐쉬 초기화
	 * @param parameter
	 */
	public void codeCacheFlushAll(Parameter parameter){
		codeCacheService.flushAll();
	}
	
}