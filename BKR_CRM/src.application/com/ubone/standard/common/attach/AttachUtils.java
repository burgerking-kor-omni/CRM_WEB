package com.ubone.standard.common.attach;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;

import com.ubone.ApplicationWorkCategory;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.FileInfo;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.util.file.FileRepository;
import com.ubone.framework.web.util.ContextHolder;
import com.ubone.standard.approval.service.ApprovalInquirySO;

/** 
 * <pre>
 *  파 일 명 : AttachUtils.java
 *  설    명 : 첨부파일 예외 케이스 접근 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2013.06.30
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public class AttachUtils {

	private static final Log logger = LogFactory.getLog(AttachUtils.class);
	 
	public static void insertAttachMultiple(Parameter parameter, WorkCategory workCategory, String masterId, String[] subId){
		for (int i = 0; i < subId.length; i++) {
			insertAttach(parameter, workCategory, new String[]{masterId, subId[i]});
		}
	}
	
	public static void insertAttach(Parameter parameter, WorkCategory workCategory, String[] bizKeys){
		FileRepository fileRepository = (FileRepository)ContextHolder.getBean(FileRepository.class);
		
		List<Parameter> inputFilelist = DataUtil.getFileParmeterList(parameter);
		for(Parameter fileParameter : inputFilelist) {
			if("N".equals(fileParameter.get("delYn"))){
				fileRepository.saveFileLink(fileParameter.get("id"), workCategory.getCode(), bizKeys);
			}
		}
		
	}
	
	// sys_attach, sys_attach_link 저장
	public static void insertSysAttach(Parameter parameter){
		
		FileRepository fileRepository = (FileRepository)ContextHolder.getBean(FileRepository.class);
		
		// 파일 저장
		FileInfo fileInfo = new FileInfo();
		
		fileInfo.setFileName(parameter.get("FILE_NM"));
		fileInfo.setPath(parameter.get("FILE_PATH"));
		fileInfo.setSize(Long.parseLong(parameter.get("FILE_SIZE")));
		fileInfo.setContentType(parameter.get("CONTENT_TYPE"));
        fileInfo.setAttachType(parameter.get("ATTACH_TYPE"));
        fileInfo.setAttachSubType(parameter.get("ATTACH_SUB_TYPE"));
        
        
        //logger.debug("=======================start file save================================");
        System.out.println("=======================start file save================================");
        fileRepository.save(fileInfo);
        System.out.println("=======================end file save================================");
        //logger.debug("=======================END file save================================");
        
        fileRepository.saveFileLink(fileInfo.getId(), ApplicationWorkCategory.VOC.getCode() , new String[]{(String)parameter.getParameter("ID_VOC"), parameter.getParameter("ID_SUB_VOC")});
		
	}
	
		
}
