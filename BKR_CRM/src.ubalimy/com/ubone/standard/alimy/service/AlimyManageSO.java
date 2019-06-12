package com.ubone.standard.alimy.service;

import java.net.ConnectException;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ubone.alimy.domain.AlimDto;
import com.ubone.alimy.sender.AlimyMessageSender;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.standard.alimy.dao.AlimyManageDAO;

/** 
 * <pre>
 *  파 일 명 : AlimyManageSO.java
 *  설    명 : 알리미 관련 서비스를 제공하는 함수
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.07.22
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
*/
@Service
public class AlimyManageSO{
	
	private static final Log logger = LogFactory.getLog(AlimyManageSO.class);
	
	@Resource
	private AlimyManageDAO alimyManageDAO;
	
	/**
	 * 알리미 대상자 리스트 조회
	 * @param parameter
	 * @return 대상자 리스트
	 */
	public DataList getTargetList(Parameter parameter) {
		return alimyManageDAO.getTargetList(parameter);
	}
	
	/**
	 * 알리미 대상자 메시지 전송
	 * @param parameter
	 * @return 알림 성공 결과
	 */
	public Result sendAlimy(Parameter parameter) {
		
		logger.info("\n");		
		logger.info(" -----------------------------------------------------------------------------------------------------");		
		logger.info(" ----------------------------------------  알리미 전송 시작  -----------------------------------------");		
		logger.info(" -----------------------------------------------------------------------------------------------------");		
		
		Result result = DataUtil.makeResult();
		// 사용자 접속 정보를 실시간으로 가져온다 
		DataList clientInfo  = alimyManageDAO.getTarget(parameter);
		
		if ( clientInfo.getRowCount() > 0 ){ // 클라이언트가 접속 정보가 있는 경우 
			
			String contents   = parameter.getParameter("CONTENTS");    
			String title	  = parameter.getParameter("TITLE");       
			String url		  = parameter.getParameter("URL");		   
			String clientIp   = clientInfo.get("CLIENT_IP");   
			String clientPort = clientInfo.get("CLIENT_PORT"); 
			String loginToken = clientInfo.get("LOGIN_TOKEN");
			
			// This is dataTrasfer Object of alimy.  
			// -> AlimDto(type, title, contents, url, ipAddr, port, key)
			AlimDto dto = new AlimDto(   "MSG01"
										, title
										, contents
										, url
										, clientIp
										, clientPort
										, loginToken);
			
			// AlimyMessageSender transmit message by socket
			AlimyMessageSender sender = new AlimyMessageSender(dto);
			
			sender.setUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
				@Override
				public void uncaughtException(Thread t, Throwable e) {
					if(e.getCause() instanceof ConnectException){
						logger.error("Connection 1 접속 오류 입니다.", e);
					}
				}
			});
			
			sender.start();			
			
			result.setServiceMessage(new ServiceMessage("정상적으로 알림을 보냈습니다."));
			
		} else {  // 클라이언트가 접속 정보가 없는 경우 
			
			result.setServiceMessage(new ServiceMessage("클라이언트 접속 정보가 없습니다."));
		
		}
		
		logger.info("\n");		
		logger.info(" -----------------------------------------------------------------------------------------------------");		
		logger.info(" -----------------------------------     알리미 전송 프로세스 종료   ---------------------------------");		
		logger.info(" -----------------------------------------------------------------------------------------------------");		
		
		return result; 
	}
	
	
	
}