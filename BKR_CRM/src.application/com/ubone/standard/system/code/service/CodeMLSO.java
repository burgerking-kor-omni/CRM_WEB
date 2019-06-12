package com.ubone.standard.system.code.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.cache.CodeCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.message.MessageService;
import com.ubone.framework.util.code.Code;
import com.ubone.framework.util.code.CodeRepository;
import com.ubone.standard.system.code.dao.CodeMLDAO;
import com.ubone.standard.system.lang.dao.LanguageResourceDAO;

/** 
 * <pre>
 *  파 일 명 : CodeMLSO.java
 *  설    명 : 
 *  작 성 자 : 김병기
 *  작 성 일 : 2016. 9. 30.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
@Service
public class CodeMLSO {
	
	@Resource
	private CodeMLDAO codeMLDAO;
	
	@Resource
	private CodeRepository codeRepository;
	
	@Resource
	private CodeCacheService codeCacheService;
	
	@Resource
	private LanguageResourceDAO languageResourceDAO;
	
	@Resource
	private MessageService messageService;
	
	/**
	 * 코드 유형 등록
	 * @param parameter
	 * @return 
	 */
	public String insertCodeCategory(Parameter parameter){
		return codeMLDAO.insertCodeCategory(DataUtil.makeUserAddedParameter(parameter));
	}
	
	/**
	 * 코드 유형 목록 조회
	 * @param parameter   
	 * @return 
	 */
	public DataList selectCodeCategoryList(Parameter parameter){
		return codeMLDAO.selectCodeCategoryList(parameter);
	}
	
	/**
	 * 코드 유형 수정
	 * @param parameter
	 * @return 
	 */
	public String updateCodeCategory(Parameter parameter){
		codeCacheService.flushAll();
		return codeMLDAO.updateCodeCategory(parameter);
	}
	
	/**
	 * 코드 유형 삭제
	 * @param parameter
	 * @return 
	 */
	public String deleteCodeCategory(Parameter parameter){
		// 코드 삭제
		String resultStr = codeMLDAO.deleteCodeCategory(parameter);
		
		// 코드와 연결된 다국어 리소스 삭제
		DataList dt = languageResourceDAO.getResIdByCode(parameter);
		
		ArrayList<String> resIds = new ArrayList<String>();
		
		for (int i = 0; i < dt.getRowCount(); i++) {
			resIds.add(dt.get(i).get("RES_ID").toString());
		}
		
		for (int i = 0; i < resIds.size(); i++) {
			Parameter langParam = DataUtil.makeParameter();
			langParam.set("RES_ID", resIds.get(i));
			
			languageResourceDAO.deleteSysResourceDtl(langParam);
			languageResourceDAO.deleteSysResource(langParam);
			
			// 이미 로드된 메세지 삭제
			messageService.removeMessage(resIds.get(i));
		}
		
		return resultStr;
	}
	
	/**
	 * 코드 등록
	 * @param parameter
	 * @return 
	 */
	public String insertCode(Parameter parameter){
		codeCacheService.flushAll();
		return codeMLDAO.insertCode(DataUtil.makeUserAddedParameter(parameter));
	}
	
	/**
	 * 코드 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectCode(Parameter parameter){
		 return codeMLDAO.selectCode(parameter); 
	}
	
	/**
	 * 코드 수정
	 * @param parameter
	 * @return 
	 */
	public String updateCode(Parameter parameter){
		codeCacheService.flushAll();
		return codeMLDAO.updateCode(parameter);
	}
	
	/**
	 * Dynamic 코드 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectDynamicCode(Parameter parameter){
		 Code code = codeRepository.getTopCodeRepository().findByCategoryId( parameter.get("CODE_CATEGORY_ID"), parameter);
		 return code.getCodes().setId("code.selectDynamicCode");
	}
	
	/**
	 * 코드 그룹 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectCodeGroup(Parameter parameter){
		return codeMLDAO.selectCodeGroup(parameter);
	}
	
	/**
	 * 코드 그룹 등록
	 * @param parameter
	 * @return 
	 */
	public String insertCodeGroup(Parameter parameter){
		codeCacheService.flushAll();

		parameter.set("GROUP_ID", parameter.get("CODE_GROUP_ID"));
		codeMLDAO.deleteCodeGroup(parameter);
		codeMLDAO.insertCodeGroup(parameter);
		return "";
	}
	
	/**
	 * 코드 그룹 삭제
	 * @param parameter
	 * @return 
	 */
	public String deleteCodeGroup(Parameter parameter){
		codeCacheService.flushAll();
		return codeMLDAO.deleteCodeGroup(parameter);
	}
	
	/**
	 * 특정 그룹의 코드 조회
	 * @param parameter
	 * @return 
	 */
	public DataList selectGroupCode(Parameter parameter){
		return codeMLDAO.selectGroupCode(parameter);
	}
	
	/**
	 * 코드 유형 목록(팝업) 조회
	 * @param parameter   
	 * @return 
	 */
	public DataList selectCodeCategoryListPop(Parameter parameter){
		return codeMLDAO.selectCodeCategoryListPop(parameter);
	}
	
	/**
	 * 코드카테고리 상세
	 * @param parameter
	 * @return
	 */
	public DataList selectCodeCategoryDetail(Parameter parameter){
		return codeMLDAO.selectCodeCategoryDetail(parameter);
	}
	
	/**
	 * 코드 캐쉬 초기화
	 * @param parameter
	 */
	public void codeCacheFlushAll(Parameter parameter){
		codeCacheService.flushAll();
	}
	
}