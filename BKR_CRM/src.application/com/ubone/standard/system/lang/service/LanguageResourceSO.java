package com.ubone.standard.system.lang.service;

import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.framework.message.MessageService;
import com.ubone.framework.type.ResultStatus;
import com.ubone.standard.system.lang.dao.LanguageResourceDAO;

/** 
 * <pre>
 *  파 일 명 : LanguageResourceSO.java
 *  설    명 : 다국어 리소스 SO
 *  작 성 자 : 이창섭
 *  작 성 일 : 2016. 09. 23.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
@Service
public class LanguageResourceSO {
	@Resource
	private LanguageResourceDAO languageResourceDAO;
	@Resource
	private MessageService messageService;
	
	
	/**
	 * 다국어 리소스 등록
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public Result insertLanguageResource(Parameter parameter) {
		Result result = DataUtil.makeResult();
		
		String resTp = parameter.getParameter("RES_TP");
		String resId;
		
		if ("T".equals(resTp)) {
			resId = UUID.randomUUID().toString().replaceAll("-", "");
		} else {
			resId = parameter.getParameter("RES_ID");
		}
		
		// RES_ID 중복여부 확인
		Parameter checkParam = DataUtil.makeParameter();
		checkParam.set("RES_ID", resId);
		DataList checkDt = this.getLanguageResourceDetail(checkParam);
		
		if (checkDt.getRowCount() > 0) {
			result.setServiceMessage(new ServiceMessage("중복된 리소스ID가 존재합니다.").setResultStatus(ResultStatus.Fail));
		} else {
			// SYS_RESOURCE 테이블 삽입
			Parameter masterParam = DataUtil.makeParameter();
			masterParam.set("RES_ID", resId);
			masterParam.set("RES_NM", parameter.getParameter("RES_NM"));
			masterParam.set("TABLE_NM", parameter.getParameter("TABLE_NM"));
			masterParam.set("COLUMN_NM", parameter.getParameter("COLUMN_NM"));
			
			if ("T".equals(resTp)) {
				masterParam.set("RES_TP", "T");
			} else {
				masterParam.set("RES_TP", "U");
			}
			languageResourceDAO.insertSysResource(masterParam);
			
			// SYS_RESOURCE_DTL 테이블 삽입
			String[] listLang = ConfigHolder.LOCALE_USE_LANGUAGE_CODE;
			for (int i = 0; i < listLang.length; i++) {
				Parameter detailParam = DataUtil.makeParameter();
				detailParam.set("RES_ID", resId);
				detailParam.set("LANG_TP", listLang[i]);
				detailParam.set("RES_NM", parameter.getParameter("RES_NM_" + listLang[i]));
				languageResourceDAO.insertSysResourceDtl(detailParam);
			}
			
			result.setServiceMessage(new ServiceMessage().setResultStatus(ResultStatus.Success).setResultKey(resId));
		}
		
		return result;
	}
	
	/**
	 * 다국어 리소스 수정
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int updateLanguageResource(Parameter parameter) {
		
		// SYS_RESOURCE 테이블 수정
		Parameter masterParam = DataUtil.makeParameter();
		masterParam.set("RES_ID", parameter.getParameter("RES_ID"));
		masterParam.set("RES_NM", parameter.getParameter("RES_NM"));
		masterParam.set("TABLE_NM", parameter.getParameter("TABLE_NM"));
		masterParam.set("COLUMN_NM", parameter.getParameter("COLUMN_NM"));
		
		int resultCnt = languageResourceDAO.updateSysResource(masterParam);
		
		// SYS_RESOURCE_DTL 테이블 삭제
		languageResourceDAO.deleteSysResourceDtl(masterParam);
		
		// SYS_RESOURCE_DTL 테이블 삽입
		String[] listLang = ConfigHolder.LOCALE_USE_LANGUAGE_CODE;
		for (int i = 0; i < listLang.length; i++) {
			Parameter detailParam = DataUtil.makeParameter();
			detailParam.set("RES_ID", parameter.getParameter("RES_ID"));
			detailParam.set("LANG_TP", listLang[i]);
			detailParam.set("RES_NM", parameter.getParameter("RES_NM_" + listLang[i]));
			languageResourceDAO.insertSysResourceDtl(detailParam);
		}
		
		// 이미 로드된 메세지 삭제
		messageService.removeMessage(parameter.getValue("RES_ID"));
		return resultCnt;
	}
	
	/**
	 * 다국어 리소스 상세 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 다국어 리소스 상세 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public DataList getLanguageResourceDetail(Parameter parameter) {
		return languageResourceDAO.getLanguageResourceDetail(parameter);
	}
	
	/**
	 * 다국어 리소스 삭제
	 * @param parameter HTTP 요청 파라미터 
	 * @return 삭제 성공한 SYS_RESOURCE 테이블 row 갯수
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int deleteLanguageResource(Parameter parameter) {
		languageResourceDAO.deleteSysResourceDtl(parameter);
		int cnt = languageResourceDAO.deleteSysResource(parameter);
		
		// 이미 로드된 메세지 삭제
		messageService.removeMessage(parameter.getValue("RES_ID"));
		
		return cnt;
	}
	
	/**
	 * 다국어 리소스 목록 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-09-28
	 */
	public DataList getLanguageResourceList(Parameter parameter) {
		return languageResourceDAO.getLanguageResourceList(parameter);
	}
	
}