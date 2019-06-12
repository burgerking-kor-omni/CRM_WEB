package com.ubone.standard.system.code.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.ubone.framework.cache.CodeMappCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.code.Code;
import com.ubone.framework.util.code.CodeRepository;
import com.ubone.standard.system.code.dao.CodeFilterDAO;


@Service
public class CodeFilterSO {
	private static final String FILTER_CODE = "FILTER_CODE";

	private static final String TP_FILTER = "TP_FILTER";

	private static final String CODE = "CODE";

	private static final String M_CODE = "M_CODE";

	private static final String CODE_COLUMN_ID = "CODE_COLUMN_ID";

	private static final String TABLE_ID = "TABLE_ID";

	private static final String CODE_TP = "CODE_TP";

	private static final String CODE_CATEGORY_ID = "CODE_CATEGORY_ID";

	@Resource
	private CodeFilterDAO codeFilterDAO;
	
	@Resource
	private CodeMappCacheService codeMappCacheService;

	@Resource
	private CodeRepository codeRepository;
	
	/**
	 * 코드 필터 목록 조회
	 * @param parameter
	 * @return 코드 필터 목록 조회
	 */
	public DataList getCodeFilterList(Parameter parameter){
		
		//코드카테고리정보 조회
		DataList selectCodeCategory = codeFilterDAO.selectCodeCategory(parameter);
		
		Map<String, Object> row = selectCodeCategory.getRow(0);
		
		DataList checkedCodes = codeFilterDAO.getCodeFilterListDn(parameter);
		
		Code dnCodes = codeRepository.getTopCodeRepository().findByCategoryId( (String) row.get(CODE_CATEGORY_ID), parameter);
		
		String checkedCodeValue = "";
		String codeValue = "";
		
		DataList codes = dnCodes.getCodes();
		
		for (int i = 0; i < codes.getRowCount() ; i++) {
			codeValue = (String)codes.get(i, CODE);
			
			codes.getRow(i).put(CODE_TP, dnCodes.getCodeDefinition().getCodeType());
			codes.getRow(i).put(TABLE_ID, dnCodes.getCodeDefinition().getMappingTableId());
			codes.getRow(i).put(CODE_COLUMN_ID, dnCodes.getCodeDefinition().getMappingCodeColumnId());
			
			for (Map<String, Object> checkedCode : checkedCodes) {
				checkedCodeValue = (String) checkedCode.get(M_CODE);

				if(codeValue.equals(checkedCodeValue)){
					codes.getRow(i).put(M_CODE, checkedCodeValue);
					break;
				}
			}
		}
		
		
		
		return codes;
			
	}
	
	
	/**
	 * 코드 필터 등록
	 * @param parameter
	 * @return 코드 필터 등록
	 */
	public void insertCodeFiler(Parameter parameter){
		
		//코드카테고리정보 조회
		DataList selectCodeCategory = codeFilterDAO.selectCodeCategory(parameter);
		
		Map<String, Object> row = selectCodeCategory.getRow(0);
		
		String[] codes = (String[])parameter.getValues(CODE);
		
		Parameter makeUserAddedParameter = DataUtil.makeUserAddedParameter();
		
		//해당되는 코드필터 삭제
		codeFilterDAO.delete(parameter);
		
		//코드필터 등록
		for (int i = 0; i < codes.length; i++) {
			makeUserAddedParameter.setParameter(TP_FILTER        , parameter.getParameter(TP_FILTER));
            makeUserAddedParameter.setParameter(FILTER_CODE      , parameter.getParameter(FILTER_CODE));
            makeUserAddedParameter.setParameter(CODE_TP          , (String)row.get(CODE_TP));
            makeUserAddedParameter.setParameter(TABLE_ID         , StringUtils.isEmpty((String)row.get(TABLE_ID))?"-":(String)row.get(TABLE_ID) );
            makeUserAddedParameter.setParameter(CODE_COLUMN_ID   , StringUtils.isEmpty((String)row.get(CODE_COLUMN_ID))?"-":(String)row.get(CODE_COLUMN_ID) );
            makeUserAddedParameter.setParameter(CODE_CATEGORY_ID , parameter.getParameter(CODE_CATEGORY_ID));
            makeUserAddedParameter.setParameter(CODE, codes[i]);
            codeFilterDAO.insertCodeFiler(DataUtil.makeUserAddedParameter(makeUserAddedParameter));
            
            
            //코드매핑캐쉬를 초기화 한다.
            codeMappCacheService.flushAll(); 
		}
		
	}
	
}
