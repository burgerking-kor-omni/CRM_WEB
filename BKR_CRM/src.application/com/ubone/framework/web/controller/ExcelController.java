package com.ubone.framework.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.security.util.AESUtils;

/** 
 * <pre>
 *  파 일 명 : ExcelController
 *  설    명 : 엑셀관련 컨트롤러 
 *  작 성 자 : 김태완
 *  작 성 일 : 2017.11.21
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Controller
@RequestMapping("/excel")
public class ExcelController {

	private static final Log logger = LogFactory.getLog(ExcelController.class);
	
	/**
	 * encoding char
	 */
	private String encoding;
	
	/**
	 * @param encoding
	 */
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}
	
	/**
	 * 엑셀 컨트롤러
	 * 엑셀 다운로드 링크 클릭 시 파일을 
	 * 
	 * @param encFile 암호화된 파일 풀 경로
	 * @param request 
	 * @param response
	 * @throws IOException 
	 * @throws Exception
	 */
	@RequestMapping({"/list.do", "/list.ub" })
	public final void list(@RequestParam(value="encFile", required=true) String encFile, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fileFullPath = AESUtils.decrypt(request.getSession().getId(), encFile);

		File file  = new File(ConfigHolder.UPLOAD_PATH  + fileFullPath);
		if(file.exists()) {
			response.setContentLength((int) file.length());
			try {
				response.setHeader("Content-Disposition", "attachment; fileName=\"" + java.net.URLEncoder.encode(file.getName(), encoding) + "\";");
			} catch (UnsupportedEncodingException e) {
				logger.error(e.getMessage(),e);  
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "UnsupportedEncodingException !! ");
				
			}
			
			OutputStream out = null;
			try {
				out = response.getOutputStream();
				FileCopyUtils.copy(FileCopyUtils.copyToByteArray(file), out);
				
			} catch (IOException e) {
				logger.error(e.getMessage(),e);			
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Excel File link not Found !! ");
			}finally {
				if(out!=null) {
					try {
						out.close();
					} catch (IOException e) {
						out = null;
					}
				}
			}
		}
		else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file [filepath=" + ConfigHolder.UPLOAD_PATH  + fileFullPath + "] from server");
		}
	}
}