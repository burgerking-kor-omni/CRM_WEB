package com.ubone.standard.system.service.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.Random;
import java.util.Stack;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.cache.ServiceCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.framework.engine.service.ServiceRepository;
import com.ubone.framework.type.ResultStatus;
import com.ubone.framework.util.code.Code;
import com.ubone.framework.util.code.CodeRepository;
import com.ubone.standard.system.service.dao.ServiceManageInquiryDAO;


/** 
 * <pre>
 *  파 일 명 : ServiceManageSO.java
 *  설    명 : [APMD] 서비스관리 SO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class ServiceManageSO {
	
	private static final String SERVICE_ID = "SERVICE_ID";

	private static final String PROJECT_CODE = "PROJECT_CODE";

	@Resource
	private ServiceManageInquiryDAO serviceManageInquiryDAO;
	
	@Resource
	private ServiceCacheService serviceCacheService;
	
	@Resource
	private ServiceRepository serviceRepository;
	
	@Resource
	private ServletContext servletContext;
	
	@Resource
	private CodeRepository codeRepository;
	
	private Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * Service 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getListService(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return serviceManageInquiryDAO.getListService(parameter);
	}
	
	/**
	 * Service 목록 조회 함수(AutoComplete)
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getListServiceByAuto(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return serviceManageInquiryDAO.getListServiceByAuto(parameter);
	}
	
	/**
	 * Service 상세 정보 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 상세 정보 DataList
	 */
	public DataList getService(Parameter parameter){
		return serviceManageInquiryDAO.getService(parameter);
	}
	
	/**
	 * Service 등록
	 * @param parameter 파라미터 클래스
	 * @return 등록 여부
	 */
	public String registService(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return serviceManageInquiryDAO.registService(parameter);
	}
	
	/**
	 * Service 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 건수
	 */
	public int modifyService(Parameter parameter) {
		
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return serviceManageInquiryDAO.modifyService(parameter);
	}

	/**
	 * Service 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 건수
	 */
	public int removeService(Parameter parameter) {
		int result = 0;

		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		
		serviceManageInquiryDAO.removeAllServiceCode(parameter);
		serviceManageInquiryDAO.removeAllFunction(parameter);
		serviceManageInquiryDAO.removeAllServiceMask(parameter);
		serviceManageInquiryDAO.deleteAllServiceQuery(parameter);
		
		result = serviceManageInquiryDAO.removeService(parameter);
		return result;
	}
	
	/**
	 * Service Code 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getListServiceCode(Parameter parameter) {
		return serviceManageInquiryDAO.getListServiceCode(parameter);
	}
	
	/**
	 * Service Code 상세 정보 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 상세 정보 DataList
	 */
	public DataList getServiceCode(Parameter parameter){
		return serviceManageInquiryDAO.getServiceCode(parameter);
	}
	
	/**
	 * Service Code 신규 등록
	 * @param parameter 파라미터 클래스
	 * @return Code Category CD
	 */
	public String registServiceCode(Parameter parameter) {
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return serviceManageInquiryDAO.registServiceCode(parameter);
	}
	
	/**
	 * Service Code 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 건수
	 */
	public int modifyServiceCode(Parameter parameter) {
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));

		parameter = DataUtil.makeUserAddedParameter(parameter);
		return serviceManageInquiryDAO.modifyServiceCode(parameter);
	}
	
	/**
	 * Service Code 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 건수
	 */
	public int removeServiceCode(Parameter parameter) {
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		return serviceManageInquiryDAO.removeServiceCode(parameter);
	}
	
	public Result getCodeDetailList(Parameter parameter) {
		String codeType = parameter.get("CODE_TP");
		Result result = DataUtil.makeResult();
		if("DN".equals(codeType)){
			Code code = codeRepository.getTopCodeRepository().findByCategoryId( parameter.get("CODE_CATEGORY_ID"), parameter);
			result.addDataList(code.getCodes().setId("codeList"));
		}else if("ST".equals(codeType)){
			result.addDataList(serviceManageInquiryDAO.getCodeDetailList(parameter).setId("codeList"));
		}else{
			result.setServiceMessage(new ServiceMessage("조회할 수 있는 코드유형이 아닙니다.").setResultStatus(ResultStatus.Reject));
		}
		
		return result;
	}
	
	/**
	 * Code Category 목록 조회 함수 (AutoComplete)
	 * @param parameter 파라미터 클래스
	 * @return DataList 인스턴스
	 */
	public DataList getListCodeCategoryByAuto(Parameter parameter) {
		return serviceManageInquiryDAO.getListCodeCategoryByAuto(parameter);
	}
	
	/**
	 * Service Screen 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getScreenList(Parameter parameter){
		return serviceManageInquiryDAO.getScreenList(parameter);
	}
	
	/**
	 * Service 실행 에러 로그 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList 
	 */
	public DataList getListServiceError(Parameter parameter) {
		return serviceManageInquiryDAO.getListServiceError(parameter);
	}
	/**
	 * Service 마스킹 관리 목록 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getMaskingList(Parameter parameter){
		return serviceManageInquiryDAO.getMaskingList(parameter);
	}
	
	/**
	 * Service 마스킹 관리 상세 조회 함수 
	 * @param parameter 파라미터 클래스
	 * @return 상세 DataList
	 */
	public DataList getMaskingColumn(Parameter parameter){
		return serviceManageInquiryDAO.getMaskingColumn(parameter);
	}
	
	/**
	 * Service 마스킹 관리 마스킹컬럼 중복여부 조회 함수
	 * @param parameter 파라미터 클래스
	 * @return 상세 DataList
	 */
	public DataList checkMaskingColumn(Parameter parameter){
		return serviceManageInquiryDAO.checkMaskingColumn(parameter);
	}
	
	/**
	 * Service 마스킹 관리 마스킹 컬럼 등록
	 * @param parameter 파라미터 클래스
	 * @return 등록 여부
	 */
	public String insertMaskingColumn(Parameter parameter){
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return serviceManageInquiryDAO.insertMaskingColumn(parameter);
	}
	
	/**
	 * Service 마스킹 관리 마스킹 컬럼 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 여부
	 */
	public int updateMaskingColumn(Parameter parameter){
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return serviceManageInquiryDAO.updateMaskingColumn(parameter);
	}
	
	/**
	 * Service 마스킹 관리 마스킹 컬럼 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 여부
	 */
	public int deleteMaskingColumn(Parameter parameter){
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		parameter = DataUtil.makeUserAddedParameter(parameter);
		String[] maskIds = parameter.getValues("SERVICE_MASK_IDS");
		int result = 0;
		
		for(String maskId : maskIds){
			parameter.set("SERVICE_MASK_ID", maskId);
			serviceManageInquiryDAO.deleteMaskingColumn(parameter);
			result++;
		}
		
		return result;
	}
	
	public Result getDataConvertList(Parameter parameter){
		Result result = DataUtil.makeResult();
		
		result.addDataList(serviceManageInquiryDAO.getDataConvertListBefore(parameter.setParameter("POINTCUT_CD", "BS")).setId("BeforeSO"));
		result.addDataList(serviceManageInquiryDAO.getDataConvertListBefore(parameter.setParameter("POINTCUT_CD", "BD")).setId("BeforeDAO"));
		result.addDataList(serviceManageInquiryDAO.getDataConvertListAfter(parameter.setParameter("POINTCUT_CD", "AS")).setId("AfterSO"));
		result.addDataList(serviceManageInquiryDAO.getDataConvertListAfter(parameter.setParameter("POINTCUT_CD", "AD")).setId("AfterDAO"));
		
		return result;
	}
	
	public String insertDataConvertBefore(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		return serviceManageInquiryDAO.insertDataConvertBefore(parameter);
	}
	
	public String insertDataConvertAfter(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		return serviceManageInquiryDAO.insertDataConvertAfter(parameter);
	}
	
	public int deleteDataConvertBefore(Parameter parameter){
		return serviceManageInquiryDAO.deleteDataConvertBefore(parameter);
	}
	
	public int deleteDataConvertAfter(Parameter parameter){
		return serviceManageInquiryDAO.deleteDataConvertAfter(parameter);
	}
	
	
	
	
	
	/**
	 * Service 마스킹 관리 적용위치 리스트 호출
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getPointCutCodeList(Parameter parameter){
		return serviceManageInquiryDAO.getPointCutCodeList(parameter);
	}
	
	/**
	 * Service 마스킹 관리 마스킹 목록 조회 (Auto Complete)
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getMaskByAuto(Parameter parameter){
		return serviceManageInquiryDAO.getMaskByAuto(parameter);
	}
	
	/**
	 * Service 마스킹 관리 마스킹 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getMaskList(Parameter parameter){
		return serviceManageInquiryDAO.getMaskList(parameter);
	}
	
	/**
	 * Service 서비스 쿼리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getServiceQueryList(Parameter parameter){
		return serviceManageInquiryDAO.getServiceQueryList(parameter);
	}
	
	/**
	 * Service 서비스 쿼리 상세조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getServiceQueryDetail(Parameter parameter){
		return serviceManageInquiryDAO.getServiceQueryDetail(parameter);
	}
	
	/**
	 * Service 서비스 쿼리 등록
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public String insertServiceQuery(Parameter parameter){
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		return serviceManageInquiryDAO.insertServiceQuery(parameter);
	}
	
	/**
	 * Service 서비스 쿼리 수정
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public int updateServiceQuery(Parameter parameter){
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		int result = serviceManageInquiryDAO.updateServiceQuery(parameter);

		return result;
	}
	
	/**
	 * Service 서비스 쿼리 삭제
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public int deleteServiceQuery(Parameter parameter){
		serviceCacheService.remove(parameter.getValue(SERVICE_ID));
		return serviceManageInquiryDAO.deleteServiceQuery(parameter);
	}
	
	/**
	 * Service 서비스 쿼리 중복 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList isDuplicatedServiceQuery(Parameter parameter){
		return serviceManageInquiryDAO.isDuplicatedServiceQuery(parameter);
	}

	/**
	 * Service Cache 모두 제거
	 * @param parameter
	 */
	public void serviceCacheFlushAll(Parameter parameter){
		serviceCacheService.flushAll();
	}
	
	public String getXmlFileForServiceId(Parameter parameter) throws Exception{
		
		String serviceId = parameter.getValue("SERVICE_ID");
		com.ubone.framework.engine.domain.Service service = serviceRepository.findById(serviceId);
		String screenXmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SERVICE_PATH + "/" + service.getId().substring(3, 6).toLowerCase() + "/" + service.getId() + ".xml");
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(screenXmlFilePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Write the output to a file
		Calendar now = Calendar.getInstance();
		
		String dateStr = ""+now.get(Calendar.YEAR)+"-"+(now.get(Calendar.MONTH) + 1) +"-"+now.get(Calendar.DAY_OF_MONTH);
		now.add(Calendar.DATE,-1); //현재 날짜에서 일일전 날짜 가져오기
		String dateStr_D1 = ""+now.get(Calendar.YEAR)+"-"+(now.get(Calendar.MONTH) + 1) +"-"+now.get(Calendar.DAY_OF_MONTH);
		
        Random rand = new Random(System.currentTimeMillis());
        
        String randStr = ""+Math.abs(rand.nextGaussian());
        
        String path = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr + "/"  + randStr + "/";
        String path_1 = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr_D1;
        String file = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr + "/"  + randStr + "/" + serviceId + ".xml";
        String filelink = ""+ "/"  +"export"+ "/" + dateStr + "/"  + randStr + "/" + serviceId + ".xml";
        
		File wordDirectory = new File(path);
		
		if(!wordDirectory.exists()){ 
			wordDirectory.mkdirs();
		}
		
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(file);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		try {
			FileCopyUtils.copy(fis, out);
		} catch (IOException e) {
			e.printStackTrace();
		}
        try {
        	fis.close();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
        Stack<String> lifo = null;
		lifo = this.checkList(path_1 , new Stack<String>());
		this.deleteDirectory(lifo);
		
		File deleteFileDirectory = new File(path_1);
		if(deleteFileDirectory.exists()){
			deleteFileDirectory.delete();
		}
        
        return filelink;
	}
	
	/**
	 * 스택에있는 파일 및 디렉토리를 모두 삭제한다.
	 * @param lifo
	 */
	private void deleteDirectory(Stack<String> lifo) {
		while(!lifo.empty()){
			String ss = lifo.pop();
			
			File deleteFileDirectory = new File(ss);
			
			if (deleteFileDirectory.exists()) {
				boolean deleteFlag = deleteFileDirectory.delete();
				if (deleteFlag) {
					logger.info(ss + " remove success.");
				} else {
					logger.info(ss + " remove fail.");
				}
			} else {
				logger.info(ss + " is undefined.");
			}
		}
	}

	/**
	 * 파라메터 경로의 파일 및 디렉토리의 full path를 스택에 쌓아서 돌려준다.
	 * @param path
	 * @param lifo
	 * @return
	 */
	private Stack<String> checkList(String path ,Stack<String> lifo) {
		String initPath = path;
		File deleteFileDirectory = new File(initPath);
		
		if(deleteFileDirectory.exists()){
			String[] files = deleteFileDirectory.list();
			if(files != null){
				for (int i = 0; i < files.length; i++) {
					lifo.push(initPath+"/"+ files[i]); 
					lifo = this.checkList(initPath+"/"+ files[i] , lifo);
				}
			}
	    }
		return lifo;
	}
	
	/**
	 * 서비스 복사
	 * @param Service ID
	 * @return Service ID
	 */
	public String copyService(Parameter parameter){
		Parameter serviceParam = DataUtil.makeParameter();
		
		DataList service = serviceManageInquiryDAO.getService(parameter);		// 부모 Screen에 등록된 Service 조회
		serviceParam.initializeByMap(service.get(0));							// Parameter에 Service값 셋팅
		serviceParam.set("CATEGORY_CODE", parameter.get("CATEGORY_CODE"));		// 서비스 분류 코드 추가
		serviceParam = DataUtil.makeUserAddedParameter(serviceParam);
		
		serviceParam.set("SERVICE_NAME", serviceParam.get("SERVICE_NAME")+"-복사본");		// 서비스명 + 복사본으로 명시적으로 표시

		String serviceId = serviceManageInquiryDAO.registService(serviceParam);	// 서비스 등록
		copyServiceCode(parameter, serviceId);									// 서비스 Code 복사
		copyMask(parameter,serviceId);											// 서비스 Mask 복사
		return serviceId;														// 등록될 Function에 Service ID 반환
	}
	
	/**
	 * Service Code 복사
	 * @param Service ID
	 */
	private void copyServiceCode(Parameter parameter, String serviceId){
		Parameter codeParam = DataUtil.makeParameter();
		DataList codeList = serviceManageInquiryDAO.getListServiceCode(parameter);	// Service에 등록된 Code 조회
		
		for (int i = 0; i<codeList.size(); i++) {
			codeParam.initializeByMap(codeList.getRow(i));							// Code값 Parameter 셋팅
			codeParam = DataUtil.makeUserAddedParameter(codeParam);
			codeParam.set("SERVICE_ID", serviceId);									// 등록될 Service ID 셋팅
			serviceManageInquiryDAO.registServiceCode(codeParam);					// 서비스에 Code 등록
		}
	}
	
	/**
	 * Mask 복사
	 * @param parameter
	 */
	private void copyMask(Parameter parameter, String serviceId){
		DataList maskList = serviceManageInquiryDAO.getMaskingList(parameter);			// Mask 리스트 조회
		Parameter paramMask = DataUtil.makeParameter();									// 새로담을 파라미터 준비

		if(!maskList.isEmpty()){
			for(int i=0;i<maskList.getRowCount();i++){
				parameter.set("SERVICE_MASK_ID", maskList.getRow(i).get("SERVICE_MASK_ID"));// 부모 Mask Id 세팅
				
				DataList getMaskDetail=serviceManageInquiryDAO.getMaskingColumn(parameter);	// Mask 상세조회
				paramMask.initializeByMap(getMaskDetail.get(0));							// 부모 Datalist 새로운 파라미터에 세팅
				paramMask = DataUtil.makeUserAddedParameter(paramMask);
				paramMask.set("SERVICE_ID", serviceId);					// Clone (자식) Service Id 세팅	
				
				serviceManageInquiryDAO.insertMaskingColumn(paramMask);						// Mask 등록 호출
			}
		}
	}
	
}
