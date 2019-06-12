package com.ubone.standard.system.metadata.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataListFilter;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.standard.system.function.dao.FunctionManageInquiryDAO;
import com.ubone.standard.system.metadata.dao.HsqlDataInquiryDAO;
import com.ubone.standard.system.screen.dao.ScreenManageInquiryDAO;
import com.ubone.standard.system.screen.service.ScreenManageSO;
import com.ubone.standard.system.service.service.ServiceManageSO;

/** 
 * <pre>
 *  파 일 명 : HsqlDataInquirySO.java
 *  설    명 : APMD 화면에서 HSQL DB의 메타정보를 불러오는 SERVICE
 *  작 성 자 : 유기태
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class HsqlDataInquirySO {
	
	private static final String PROJECT_CODE = "PROJECT_CODE";

	@Resource
	private HsqlDataInquiryDAO hsqlDataInquiryDAO;
	
	@Resource
	private ScreenManageInquiryDAO screenManageInquiryDAO;
	
	/**
	 * 카테고리 코드 리스트 조회
	 * @param parameter
	 * @return
	 */
	public Result getCategoryCodeList(Parameter parameter){
		Result result = DataUtil.makeResult();
		result.addDataList(hsqlDataInquiryDAO.getCategoryCodeList(parameter));
		return result;
	}
	
	/**
	 * 메타화면 리스트 조회
	 * @param parameter
	 * @return
	 */
	public Result getPidList(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		final DataList screenList = screenManageInquiryDAO.getScreenList(parameter);
		DataList metaPageList = hsqlDataInquiryDAO.getScreenList(parameter);
		Result result = DataUtil.makeResult();
		
		// 등록되어있는 메타화면 필터링
		if(screenList == null || screenList.getRowCount() == 0) {
			return result.addDataList(metaPageList);
		}else {
			DataListFilter filter = new DataListFilter() {
				public boolean doFilter(Map<String, Object> map) {
					for(Map<String, Object> row : screenList.getRows()) {
						String pid = (String) map.get("PID");
						String screenId = (String) row.get("SCREEN_ID");
						if(pid.startsWith(screenId)) {
							return false;
						}
					}					
					return true;
				}
			};
			return result.addDataList(metaPageList.filter(filter));
		}
	}
	
	/**
	 * 화면 상세페이지의 메타화면 리스트 조회
	 * @param parameter
	 * @return
	 */
	public Result getPidListDetail(Parameter parameter){
		Result result = DataUtil.makeResult();
//		result.addDataList(hsqlDataInquiryDAO.getPidDetail(parameter));  2015.03.13 상세페이지에서도 모든 메타화면 호출로 변경
		
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		final DataList screenList = screenManageInquiryDAO.getScreenList(parameter);
		DataList metaPageList = hsqlDataInquiryDAO.getScreenList(parameter);
		final String currentScreenId = parameter.get("CURRENT_SCREEN_ID");
		// 등록되어있는 메타화면 필터링
		if(screenList == null || screenList.getRowCount() == 0) {
			return result.addDataList(metaPageList);
		}else {
			DataListFilter filter = new DataListFilter() {
				public boolean doFilter(Map<String, Object> map) {
					for(Map<String, Object> row : screenList.getRows()) {
						String pid = (String) map.get("PID");
						String screenId = (String) row.get("SCREEN_ID");
						if(pid.startsWith(screenId)) {
							if(screenId.equals(currentScreenId)){
								return true;
							}else{
								return false;
							}
						}
					}					
					return true;
				}
			};
			return result.addDataList(metaPageList.filter(filter));
		}
	}
	
	/**
	 * 화면이름 조회
	 * @param parameter
	 * @return
	 */
	public Result getScreenName(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		Result result = DataUtil.makeResult();
		
		result.addDataList(hsqlDataInquiryDAO.getScreenName(parameter));
		
		return result; 
	}
	
	/**
	 * 메타 스크린 즉시 등록
	 * @param parameter
	 * @return
	 */
	public int registScreenPages(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		String[] pageIds = parameter.getValues("CHECKED_DATAS");
		int result = 0;
		
		DataList projectPathDt = screenManageInquiryDAO.getProjectPath(parameter);
		String projectPath = (String) projectPathDt.getRow(0).get("CODE_NAME");
		
		for(String pageId : pageIds){
			parameter.set("SELECT_VALUE", pageId);
			DataList detailPid = hsqlDataInquiryDAO.getPidDetail(parameter);
			
			parameter.set("scrnId", pageId.substring(0, 7));
			parameter.set("scrnDscp", detailPid.get("DESCRIPTION"));
			parameter.set("CATEGORY_CODE", detailPid.get("PCLASS"));
			parameter.set("scrnTpCd", "D");
			parameter.set("scrnViewTpCd", "M");
			parameter.set("scrnLaytTpCd", "Default");
			parameter.set("scrnNm", detailPid.get("DESCRIPTION"));
			parameter.set("filePathNm", "/"+projectPath+"/"+detailPid.get("PCLASS").toString().toLowerCase()+"/");
			parameter.set("fileNm", pageId.substring(0, 7));
			parameter.set("metaPageId", pageId);
			parameter.set("loginChkYn", "Y");
			screenManageInquiryDAO.registScreen(parameter);
			result++;
		}
		
		return result;
	}
	
	public Result getPidListByAuto(Parameter parameter){
		Result result = DataUtil.makeResult();
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		
		result.addDataList(hsqlDataInquiryDAO.getPidDetail(parameter));
		
		return result;
	}
}
