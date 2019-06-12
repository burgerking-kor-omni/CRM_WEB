package com.ubone.standard.ubboard.common.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleOp;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.FileInfo;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.file.FilePolicy;
import com.ubone.framework.util.file.FilePolicyRepository;
import com.ubone.framework.util.file.FileRepository;


/** 
 * <pre>
 *  파 일 명 : BoardFileController.java
 *  설    명 : UB-Board 첨부파일 컨트롤러
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Controller
public class BoardFileController {

	/**
	 * logger
	 */
	private static final Log logger = LogFactory.getLog(BoardFileController.class);
	
	private static final String FILE_COMMAND = "/boardfile";
	private static final String THUMBNAIL_COMMAND = FILE_COMMAND + "/thumbnail";
	
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
	 * file 저장소
	 */
	@Resource
	private FileRepository fileRepository;
	
	/**
	 * file 정책 저장소
	 */
	@Resource
	private FilePolicyRepository filePolicyRepository;
	
	/**
	 * file image 썸네일
	 * @param imageId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping({ THUMBNAIL_COMMAND + ".do", THUMBNAIL_COMMAND + ".ub" })
	public final void thumbnail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Parameter parameter = DataUtil.makeParameter(request.getParameterMap());
		
		String imageId = parameter.getValue("imageId");
		String wSize   = parameter.getValue("wSize");
		String hSize   = parameter.getValue("hSize");
		
		FileInfo fileInfo = fileRepository.findByFileId(imageId);
		if(fileInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + imageId + "] from file Information Repository");
			return;
		}
		
		logger.info("file thumbnail[file id=" + imageId + "]; " + fileInfo + ";");
		
		//썸네일 정책
		FilePolicy filePolicy = filePolicyRepository.getFilePolicyByAttachType("thumbnail");
		//썸네일 생성 경로
		String thumbnailPath = filePolicy.getBaseDir();
		//썸네일 파일명 설정
		String thumbnailFile = fileInfo.getId(); 
		String thumbnailExt = fileInfo.getFileName().substring(fileInfo.getFileName().lastIndexOf(".")+1);
		
		//가로값이 넘어오지 않은경우는 무조건 가로사이즈 300으로 고정
		if(StringUtils.isEmpty(wSize)){
			wSize = "300";
		}

		if(!StringUtils.isNumeric(wSize)){
			throw new Exception("wSize값이 올바르지 않습니다. 숫자값을 입력해 하세요.");
		}

		if(!StringUtils.isNumeric(hSize)){
			throw new Exception("hSize값이 올바르지 않습니다. 숫자값을 입력해 하세요.");
		}
		
		if(wSize != null && !"".equals(wSize)){
			if(hSize != null && !"".equals(hSize)){
				thumbnailFile += "_" + wSize + "x" + hSize;
			}else{
				thumbnailFile += "_" + wSize + "xAuto";
			}
		}else if(hSize != null && !"".equals(hSize)){
			thumbnailFile += "_Autox" + hSize;
		}else{
//			response.sendRedirect("/file/image.ub?imageId=" + imageId);
//			return;
		}
		
		//썸네일 폴더 미존재시 폴더 생성
		File path  = new File(thumbnailPath);
		if(!path.exists()){
			path.mkdirs();
		}
		
		File file  = new File(thumbnailPath + "/" + thumbnailFile + "." + thumbnailExt);
		if(file.exists()){
			//썸네일 파일이 존재하는 경우
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", fileInfo.getContentType()+"; name=\"" + java.net.URLEncoder.encode(fileInfo.getFileName(), encoding) + "\";");
			
			OutputStream out = response.getOutputStream();
			FileInputStream fis = null;
			
			try {
				fis = new FileInputStream(file);
				FileCopyUtils.copy(fis, out);
			}
			catch(IOException ex) {
				if("org.apache.catalina.connector.ClientAbortException".equals(ex.getClass().getName())) {
					if(logger.isDebugEnabled()) {
						logger.debug("Client abrorting transfer.");  
					}
				}
				else {
					if(logger.isWarnEnabled()) {
						logger.warn("Error occurred when image file [id=" + imageId + ", name=" + fileInfo.getFileName() + "] from server", ex);
					}
				}
			}
			finally {
				if(fis != null) fis.close();
			}
		}else{
			
			makeThumbnail2(imageId, wSize, hSize, thumbnailPath, thumbnailFile, thumbnailExt, request, response);

		}
	}

	
	private final synchronized void makeThumbnail2(
			  String imageId
			, String wSize
			, String hSize
			, String thumbnailPath
			, String thumbnailFile
			, String thumbnailExt
			, HttpServletRequest request
			, HttpServletResponse response) throws Exception {
		
		FileInfo fileInfo = fileRepository.findByFileId(imageId);
		if(fileInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + imageId + "] from file Information Repository");
			return;
		}

		logger.info("file thumbnail[file id=" + imageId + "]; " + fileInfo + ";");
		
		//썸네일 파일이 존재하지 않는 경우
		File asFile = fileInfo.asFile();
		if(asFile.exists()){
			BufferedImage srcImage = ImageIO.read(asFile);
	
			float width = srcImage.getWidth();
			float height = srcImage.getHeight();
			float wSizef = 0;
			float hSizef = 0;
			if (wSize != null) {
				if (hSize != null) { // wSize와 hSize의 값이 둘다 넘어왔을 경우 양쪽의 사이즈를 넘지않는 한도내에서 비율유지하여 크롭한다.
					float maxWidth = Integer.parseInt(wSize);
					float maxHeight = Integer.parseInt(hSize);
					float reductionRatio = (maxWidth / width);
	
					if (reductionRatio > 1)
						reductionRatio = 1;
					hSizef = height * reductionRatio;
					if (hSizef > maxHeight) {
						reductionRatio = (maxHeight / height);
						if (reductionRatio > 1)
							reductionRatio = 1;
						wSizef = width * reductionRatio;
						hSizef = height * reductionRatio;
					} else {
						wSizef = width * reductionRatio;
					}
				} else { // wSize의 값만 넘어온 경우 width값으로 비율을 조절하여 크롭한다.
					wSizef = Integer.parseInt(wSize);
					float reductionRatio = (wSizef / width);
					if (reductionRatio > 1) {
						wSizef = width;
						reductionRatio = 1;
					}
					hSizef = height * reductionRatio;
				}
			} else if (hSize != null) { // hSize의 값만 넘어온 경우 height값으로 비율을 조절하여 크롭한다.
				hSizef = Integer.parseInt(hSize);
				float reductionRatio = (hSizef / height);
				if (reductionRatio > 1) {
					hSizef = height;
					reductionRatio = 1;
				}
				wSizef = width * reductionRatio;
			} else { // 아무 사이즈의 값이 넘어오지 않은 경우 원본사이즈로 리턴한다.
				wSizef = width;
				hSizef = height;
			}
			logger.info(":::::::::::: [File Thumbnail Size] : fileId = "
					+ imageId + ", size = " + wSizef + "x" + hSizef);
			OutputStream out = response.getOutputStream();
			Builder<BufferedImage> bi = Thumbnails.of(srcImage)
					.size((int) wSizef, (int) hSizef)
					.outputFormat(thumbnailExt);
			bi.toOutputStream(out);
			bi.toFile(thumbnailPath + "/" + thumbnailFile);
		}else{
			logger.warn("Does not found file." + fileInfo + ";");
		}
	}
	
	
	public final void makeThumbnail(
			  @RequestParam(value="imageId", required=true) String imageId
			, @RequestParam(value="wSize", required=false) String wSize
			, @RequestParam(value="hSize", required=false) String hSize
			, HttpServletRequest request
			, HttpServletResponse response) throws Exception {
		FileInfo fileInfo = fileRepository.findByFileId(imageId);
		if(fileInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + imageId + "] from file Information Repository");
			return;
		}

		logger.info("file thumbnail[file id=" + imageId + "]; " + fileInfo + ";");
		
		File asFile = fileInfo.asFile();
		BufferedImage srcImage = ImageIO.read(asFile);
		
		float width = srcImage.getWidth();
		float height = srcImage.getHeight();
		float wSizef = 0;
		float hSizef = 0;
		
		if(wSize != null){
			if(hSize != null){	// wSize와 hSize의 값이 둘다 넘어왔을 경우 양쪽의 사이즈를 넘지않는 한도내에서 비율유지하여 크롭한다.
				float maxWidth = Integer.parseInt(wSize);
				float maxHeight = Integer.parseInt(hSize);
				float reductionRatio = (maxWidth / width);
				
				if(reductionRatio > 1) reductionRatio = 1;
				hSizef = height * reductionRatio;
				if(hSizef > maxHeight){
					reductionRatio = (maxHeight / height);
					if(reductionRatio > 1) reductionRatio = 1;
					wSizef = width * reductionRatio;
					hSizef = height * reductionRatio;
				}else{
					wSizef = width * reductionRatio;
				}
			}else{	// wSize의 값만 넘어온 경우 width값으로 비율을 조절하여 크롭한다.
				wSizef = Integer.parseInt(wSize);
				float reductionRatio = (wSizef / width);
				if(reductionRatio > 1){
					wSizef = width;
					reductionRatio = 1;
				}
				hSizef = height * reductionRatio;
			}
		}else if(hSize != null){	// hSize의 값만 넘어온 경우 height값으로 비율을 조절하여 크롭한다.
			hSizef = Integer.parseInt(hSize);
			float reductionRatio = (hSizef / height);
			if(reductionRatio > 1){
				hSizef = height;
				reductionRatio = 1;
			}
			wSizef = width * reductionRatio;
		}else{	// 아무 사이즈의 값이 넘어오지 않은 경우 원본사이즈로 리턴한다.
			wSizef = width;
			hSizef = height;
		}
		
		ResampleOp resampleOp = new ResampleOp((int) wSizef, (int) hSizef);
		resampleOp.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);
		
		BufferedImage rescaledImage =  resampleOp.filter(srcImage, null);
		String contentsType = fileInfo.getContentType().split("[/]")[1];
		OutputStream out = response.getOutputStream();
		
		ImageIO.write(rescaledImage, contentsType, out);
	}
	

}