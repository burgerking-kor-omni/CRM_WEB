package com.ubone.standard.system.screen.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;
import java.util.Stack;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.cache.ScreenCacheService;
import com.ubone.framework.cache.ServiceCacheService;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.Function;
import com.ubone.framework.engine.domain.Screen;
import com.ubone.framework.engine.screen.ScreenRepository;
import com.ubone.framework.engine.screen.support.meta.MetaPageException;
import com.ubone.framework.engine.screen.support.meta.MetaScreenGenerator;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.framework.engine.service.ServiceException;
import com.ubone.framework.engine.service.ServiceRepository;
import com.ubone.standard.system.function.dao.FunctionManageInquiryDAO;
import com.ubone.standard.system.screen.dao.ScreenManageInquiryDAO;
import com.ubone.standard.system.service.service.ServiceManageSO;


/** 
 * <pre>
 *  파 일 명 : ScreenManageSO.java
 *  설    명 : [APMD] 화면관리 SO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class ScreenManageSO {
	
	private static final String SCREEN_ID = "SCREEN_ID";

	private static final String PROJECT_CODE = "PROJECT_CODE";

	@Resource
	private ScreenManageInquiryDAO screenManageInquiryDAO;
	
	@Resource
	private ScreenCacheService screenCacheService;
	
	@Resource
	private ServiceCacheService serviceCacheService;
	
	@Resource
	private MetaScreenGenerator metaScreenGenerator;
	
	@Resource
	private ScreenRepository screenRepository;
	
	@Resource
	private ServiceRepository serviceRepository;
	
	@Resource
	private ServletContext servletContext;
	
	@Resource
	private ServiceManageSO serviceManageSO;
	
	@Resource
	private FunctionManageInquiryDAO functionManageInquiryDAO;

	private Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * Screen 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getScreenList(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return screenManageInquiryDAO.getScreenList(parameter);
	}
	
	/**
	 * Screen 목록 조회 함수 (AutoComplete)
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getScreenListByAuto(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return screenManageInquiryDAO.getScreenListByAuto(parameter);
	}

	/**
	 * Screen 상세 조회
	 * @param parameter 파라미터 클래스
	 * @return 상세 내용 DataList
	 */
	 
	public DataList getScreen(Parameter parameter) {
		return  screenManageInquiryDAO.getScreen(parameter);
	}
	
	/**
	 * Screen 기능 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 기능 목록 DataList
	 */
	public DataList getListScreenFunc(Parameter parameter){
		return screenManageInquiryDAO.getListScreenFunc(parameter);
	}

	/**
	 * Screen 파라미터 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 파라미터 목록 DataList
	 */
	public DataList getListScreenParam(Parameter parameter){
		return screenManageInquiryDAO.getListScreenParam(parameter);
	}
	
	/**
	 * Screen 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 건수
	 */
	public int modifyScreen(Parameter parameter){
		screenCacheService.remove(parameter.getValue(SCREEN_ID));
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return screenManageInquiryDAO.modifyScreen(parameter);
	}
	
	/**
	 * Screen 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 건수
	 */
	public int removeScreen(Parameter parameter){
		String screenId = parameter.getValue("SCREEN_ID");
		screenCacheService.remove(screenId);

		int result = 0;
		
		screenManageInquiryDAO.removeAllScreenFunc(parameter);
		screenManageInquiryDAO.removeAllScreenParam(parameter);
		screenManageInquiryDAO.removeAllMenuScreen(parameter);
		screenManageInquiryDAO.removeAllScreenAuth(parameter);
		screenManageInquiryDAO.updateScreenIdToNull(parameter);
		
		result = screenManageInquiryDAO.removeScreen(parameter);
		
		//Screen이 삭제될 때 xml파일이 따로 존재하는지 체크하여 지워준다.
		if(result > 0){
			Screen screen = screenRepository.findById(screenId);
			String screenXmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SCREEN_PATH + "/" + screen.getId().substring(0, 3).toLowerCase() + "/" + screen.getId() + ".xml");
			this.fileDelete(screenXmlFilePath);
		}
		
		return result;
	}
	
	/**
	 * Screen Function 신규 등록
	 * @param parameter 파라미터 클래스
	 * @return String Function ID
	 */
	public String registScreenFunc(Parameter parameter){
		screenCacheService.remove(parameter.getValue(SCREEN_ID));

		parameter = DataUtil.makeUserAddedParameter(parameter);
		return screenManageInquiryDAO.registScreenFunc(parameter);
	}
	
	/**
	 * Screen Function 신규 등록(Multi)
	 * @param parameter 파라미터 클래스
	 * @return int 등록 건수
	 */
	public int registScreenFuncs(Parameter parameter) {
		screenCacheService.remove(parameter.getValue(SCREEN_ID));

		parameter = DataUtil.makeUserAddedParameter(parameter);
		String[] funcIds = parameter.getValues("FUNCTION_IDS");
		int result = 0;
		
		for(String funcId : funcIds){
			parameter.set("FUNCTION_ID", funcId);
			screenManageInquiryDAO.registScreenFunc(parameter);
			result++;
		}
		
		return result;
	}
	
	/**
	 * Screen 등록
	 * @param parameter 파라미터 클래스
	 * @return 
	 */
	public String registScreen(Parameter parameter){
		String screenId = parameter.getParameter("SCREEN_ID");
		parameter = DataUtil.makeUserAddedParameter(parameter);
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		screenManageInquiryDAO.registScreen(parameter);
		return screenId;
	}
	
	public String readScreen(Parameter parameter){
		//화면정보를 한 차례 
		String screenId = parameter.getParameter("SCREEN_ID");
		Screen screen = screenRepository.findById(screenId);
		return screen.getId();
	}
	
	/**
	 * Screen Function 삭제
	 * @param parameter 파라미터 클래스
	 * @return 삭제 건수
	 */
	public int removeScreenFunc(Parameter parameter) {
		screenCacheService.remove(parameter.getValue(SCREEN_ID));
		return screenManageInquiryDAO.removeScreenFunc(parameter);
	}
	
	/**
	 * Screen Function 정보 수정
	 * @param parameter 파라미터 클래스
	 * @return 수정 건수
	 */
	public int modifyScreenFunc(Parameter parameter) {
		screenCacheService.remove(parameter.getValue(SCREEN_ID));

		parameter = DataUtil.makeUserAddedParameter(parameter);
		/*String strtFuncYn = parameter.get("START_FUNCTION_YN");
		
		if ("Y".equals(strtFuncYn)) {
			// 기존 Screen Function StartFunctionYn value 'N'으로 초기화 
			Parameter updateParam = DataUtil.makeUserAddedParameter();
			updateParam.set("SCREEN_ID", parameter.get("SCREEN_ID"));
			updateParam.set("FUNCTION_ID", parameter.get("FUNCTION_ID"));
			updateParam.set("START_FUNCTION_YN", "N");
			screenManageInquiryDAO.updateStartFuncYn(updateParam);
		}*/
		
		return screenManageInquiryDAO.modifyScreenFunc(parameter);
	}
	
	/**
	 * Screen Parameter 정보 등록
	 * @param parameter 파라미터
	 * @return String prmtNm
	 */
	public String registScreenParam(Parameter parameter) {
		screenCacheService.remove(parameter.getValue(SCREEN_ID));

		parameter = DataUtil.makeUserAddedParameter(parameter);
		return screenManageInquiryDAO.registScreenParam(parameter);
	}
	
	/**
	 * Screen Parameter 정보를 수정
	 * @param parameter 파라미터
	 * @return 수정 건수
	 */
	public int modifyScreenParam(Parameter parameter) {
		screenCacheService.remove(parameter.getValue(SCREEN_ID));

		parameter = DataUtil.makeUserAddedParameter(parameter);
		return screenManageInquiryDAO.modifyScreenParam(parameter);
	}
	
	/**
	 * Screen Parameter 정보를 삭제
	 * @param parameter 파라미터
	 * @return 삭제 건수
	 */
	public int removeScreenParam(Parameter parameter) {
		screenCacheService.remove(parameter.getValue(SCREEN_ID));

		return screenManageInquiryDAO.removeScreenParam(parameter);
	}
	
	/**
	 * Project 경로 조회
	 * @param parameter
	 * @return 
	 */
	public DataList getProjectPath(Parameter parameter){
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		return screenManageInquiryDAO.getProjectPath(parameter);
	}
	
	/**
	 * Screen Cache 모두 제거
	 * @param parameter
	 */
	public void screenCacheFlushAll(Parameter parameter){
		screenCacheService.flushAll();
	}
	
	/**
	 * 전체 스크린 정보를 Xml로 생성하는 함수
	 * @param parameter 파라미터 클래스
	 * @return 생성건수
	 */
	public int buildXmlAll(Parameter parameter){
		screenCacheService.flushAll();
		serviceCacheService.flushAll();
		int cnt = 0;
		
		// Repository 파일 삭제
		// DB상의 데이터가 아닌 기존XML파일들이 재생성되지 않으므로 삭제하지 않고 덮어씌워지는 형태로
//		deleteAllXmlFiles(parameter);
		
		DataList list = screenManageInquiryDAO.getScreenIdAll(parameter);
		
		for(int i = 0 ; i<list.getRowCount(); i++){
			String screenId = list.getString(i, "SCREEN_ID");
			logger.info("---------------------------------------------------------------------------------");
			logger.info("["+(i+1)+"/"+list.getRowCount()+"] Build Screen Xml File : "+screenId);
			logger.info("---------------------------------------------------------------------------------");
			cnt = buildXmlByScreenId(screenId);
		}
		
		return cnt;
	}
	
	/**
	 * 전체 메타 페이지를 JSP로 재생성하는 함수
	 * @param parameter 파라미터 클래스
	 * @return 생성건수
	 */
	public int buildJspAll(Parameter parameter){
		int succCnt = 0;
		int failCnt = 0;
		
		ArrayList<String> errList = new ArrayList<String>();
		
		// MetaFile 삭제
		deleteMetaFile(parameter);
		
		DataList list = screenManageInquiryDAO.getMetaPageIdAll(parameter);
		
		for(int i = 0 ; i<list.getRowCount(); i++){
			boolean isSuccess = false;
			String metaPageId = list.getString(i, "META_PAGE_ID");
			
			logger.info("------------------------------------------------------------------------------------");
			logger.info("["+(i+1)+"/"+list.getRowCount()+"] Build Meta Page Jsp File : "+metaPageId);
			logger.info("------------------------------------------------------------------------------------");
			
			try {
				metaScreenGenerator.generate(metaPageId);
				isSuccess = true;
			} catch (EmptyResultDataAccessException ex) {
				logger.error("#########     Meta DB에 존재하지 않는 페이지 입니다.     #########");
			} catch (MetaPageException ex) {
				logger.error("#########     Meta Page 생성시 비정상적으로 저장된 데이터로 생성이 불가능합니다. 페이지를 재확인 하세요.     #########");
			} catch (ServiceException ex) {
				logger.error(ex.getMessage());
			}
			
			if(isSuccess){
				succCnt++;
			}else{
				failCnt++;
				errList.add(metaPageId);
			}
		}
		logger.info("####################################################################################");
		logger.info(" Build Result :: Total : " +list.getRowCount()+". Success : "+succCnt+". Fail : "+failCnt);
		if(errList.size() > 0){
			logger.info("[ERROR PAGE LIST]---------------------------");
			for(int i = 0; i<errList.size(); i++){
				logger.info(" - "+errList.get(i));
			}
		}
		logger.info("####################################################################################");
		
		return succCnt;
	}
	
	/**
	 * ScreenId에 해당하는 Screen/Service Xml 파일을 생성하는 함수
	 * @param screenId 스크린ID
	 * @return 생성건수
	 */
	private int buildXmlByScreenId(String screenId){
		Screen screen = screenRepository.findById(screenId);
		if(screen != null){
			for(Function function : screen.getFunctions()){
				if(function.getServiceId() != null){
					com.ubone.framework.engine.domain.Service service = serviceRepository.findById(function.getServiceId());
					if(service == null){
						logger.error("Does not found service info. (functionAlias="+function.getAlias()+", serviceId="+function.getServiceId()+"]");
					}
				}
			}
			return 1;
		}else{
			return 0;
		}
	}
	
	/**
	 * 전체 메타 파일을 제거하는 함수
	 * @param parameter 파라미터 클래스
	 * @return 제거수
	 */
	public int deleteMetaFile(Parameter parameter){
		int cnt = 0;
		String path = servletContext.getRealPath(ConfigHolder.VIEW_JSP_ROOT + ConfigHolder.META_FILE_PATH);
		
		cnt = fileDelete(path);
		
		return cnt;
	}
	
	/**
	 * 전체 Repository 파일을 제거하는 함수
	 * @param parameter 파라미터 클래스
	 * @return 제거수
	 */
//	public int deleteAllXmlFiles(Parameter parameter){
//		int result = 0;
//		
//		String screenXmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SCREEN_PATH);
//		String serviceXmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SERVICE_PATH);
//		
//		result = fileDelete(screenXmlFilePath);
//		
//		if(result != 0){
//			result = result + fileDelete(serviceXmlFilePath);
//		}
//		
//		return result;
//	}
		
	private int fileDelete(String path){
		int result = 0;
	
		File file = new File(path);

		file = new File(path);
		if(file != null && file.exists()){
			result = removeFile(file);
		}

		return result;
	}
	
	
	private int removeFile(File file) {
		int result = 0;
		if(file.isDirectory()){
			for(File subFile : file.listFiles()){
				result = result + removeFile(subFile);
			}
		}
		
		boolean flag = file.delete();
		if(flag) result++;
		
		logger.info("---------------------------------------------------------------------------------");
		logger.info("[Success] Delete File : "+file.getName());
		logger.info("---------------------------------------------------------------------------------");
		
		return result;
	}
	
	public String getXmlFileForScreenId(Parameter parameter) throws Exception{
		
		String screenId = parameter.getValue("SCREEN_ID");
		Screen screen = screenRepository.findById(screenId);
		String screenXmlFilePath = servletContext.getRealPath(ConfigHolder.REPOSITORY_SCREEN_PATH + "/" + screen.getId().substring(0, 3).toLowerCase() + "/" + screen.getId() + ".xml");
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
        String file = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr + "/"  + randStr + "/" + screenId + ".xml";
        String filelink = ""+ "/"  +"export"+ "/" + dateStr + "/"  + randStr + "/" + screenId + ".xml";
        
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
	 * 스크린 복사 등록
	 * @param parameter
	 * @return
	 * @throws Exception 
	 */
	public String screenCopy(Parameter parameter) throws Exception{
		parameter = DataUtil.makeUserAddedParameter(parameter);
		parameter.set(PROJECT_CODE, ConfigHolder.APPLICATION_ID);
		String screenId = registScreen(parameter);		// 화면 등록 서비스 호출
		copyFunction(parameter);										// 화면 Function 복사
		copyParameter(parameter);										// 화면 Parameter 복사
		return ResultUtils.makeResultForKey(screenId);					// 화면 ID 반환
	}
	
	/**
	 * 스크린 Function 복사 등록
	 * @param parameter
	 */
	private void copyFunction(Parameter parameter){
		DataList funcList=screenManageInquiryDAO.getFuncList(parameter);					// 부모 Screen에 등록된 Function 조회
		Parameter parameter_apFunc = DataUtil.makeParameter();
		for(int i=0;i<funcList.getRowCount();i++){
			parameter_apFunc.initializeByMap(funcList.get(i));								// 부모 Datalist 세팅
			parameter_apFunc = DataUtil.makeUserAddedParameter(parameter_apFunc);
			
			parameter_apFunc.set("CATEGORY_CODE", parameter.get("CATEGORY_CODE"));			// 분류 코드 입력
			String serviceId = serviceManageSO.copyService(parameter_apFunc);				// 서비스 복사 호출
			parameter_apFunc.set("SERVICE_ID", serviceId);									// Service ID 입력
			parameter_apFunc.set("SCREEN_ID", parameter.get("SCREEN_ID"));					// Screen ID 입력
			
			parameter_apFunc.set("FUNCTION_NAME", parameter_apFunc.get("FUNCTION_NAME")+"-복사본");		// Service ID 입력

			String functionId = functionManageInquiryDAO.registFunc(parameter_apFunc);		// Function 등록 서비스 호출
			parameter_apFunc.set("FUNCTION_ID", functionId);								// Function ID 입력
			functionManageInquiryDAO.removeAllScreenFunc(parameter_apFunc);					// 미사용중인 Function 삭제
			screenManageInquiryDAO.registScreenFunc(parameter_apFunc);						// 복사할 Screen에 Function 등록
		}
	}
	
	/**
	 * 스크린 Parameter 복사 등록
	 * @param parameter
	 */
	private void copyParameter(Parameter parameter){
		DataList paramList=screenManageInquiryDAO.getParamList(parameter);		// 부모 Screen에 등록된 Parameter 조회
		
		for(int i=0;i<paramList.getRowCount();i++){
			parameter.set("PARAMETER_NAME", paramList.getRow(i).get("PARAMETER_NAME"));
			parameter.set("DEFAULT_VALUE", paramList.getRow(i).get("DEFAULT_VALUE"));
			screenManageInquiryDAO.registScreenParam(parameter);				// 복사할 Screen에 Parameter 등록
		}
	}
}
