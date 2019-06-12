package com.ubone.framework.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.ubone.framework.ConfigHolder;
import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.FileInfo;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.file.FilePolicyRepository;
import com.ubone.framework.util.file.FileRepository;
import com.ubone.framework.web.util.HttpUtils;

/** 
 * <pre>
 *  파 일 명 : FileController.java
 *  설    명 : 프레임웍 첨부파일 컨트롤러
 *             - 첨부파일 업로드/다운로드 제어
 *  작 성 자 : 임경철
 *  작 성 일 : 2009.07.01
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 *      - 1.5.10 : 2015-09-01 : 첨부파일 업로드의 용량 제한 처리 오류 보정
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Controller
@RequestMapping("/file")
public class FileController extends BaseFileController {

	/**
	 * logger
	 */
	private static final Log logger = LogFactory.getLog(FileController.class);
	
	/**
	 * SWFUpload Header User-Agent 정보
	 */
	private static final String SWFUPLOAD_HEADER = "Shockwave Flash";

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
	
	@Resource
	private FilePolicyRepository filePolicyRepository;
	
	/**
	 * file download
	 * @param fileId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping({"/download.do", "/download.ub" })
	public final void download(@RequestParam(value="fileId", required=true) String fileId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		FileInfo fileInfo = fileRepository.findByFileId(fileId);
		if(fileInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + fileId + "] from file Information Repository");
			return;
		}
		if(logger.isDebugEnabled()) {
			logger.debug("file download[file id=" + fileId + "]; " + fileInfo + ";");
		}
		
		if("LINKURL".equals(fileInfo.getContentType())) {
			response.sendRedirect(fileInfo.getPath());
		}
		else {
			
			try {
				response.setContentType("application/octet-stream");
				response.setContentLength((int) fileInfo.getSize());
				response.setHeader("Content-Transfer-Encoding", "binary");
				response.setHeader("Content-Disposition", "attachment; fileName=\"" + java.net.URLEncoder.encode(fileInfo.getFileName(), encoding) + "\";");

				writeFileToStream(fileInfo, response.getOutputStream());
				
			}catch(Exception ex){
				logger.error("File Download Error !!"+ex.getMessage(), ex);
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + fileId + "] from file Information Repository");
			}
		}
	}
	
	/**
	 * file remove
	 * @param fileId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping({ "/remove.do", "/remove.ub" })
	public final void remove(@RequestParam(value="fileId", required=true) String fileId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// TODO : 파일ID의 첨부파일이 첨부파일 링크 정보가 존재하는 파일인지여부를 체크하여, 존재시 삭제불가 기능 추가
		FileInfo fileInfo = fileRepository.findByFileId(fileId);
		if(fileInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + fileId + "] from file Information Repository");
			return;
		}
		if(logger.isDebugEnabled()) {
			logger.debug("file remove[file id=" + fileId + "]; " + fileInfo + ";");
		}
		
		fileRepository.remove(fileId);
		
		if(!fileInfo.isBlob()){
			File file = fileInfo.asFile();
			file.delete();
		}
	}
	
	/**
	 * file upload
	 * 
	 * 2014.12.16 : 파일 확장자 체크후 블랙/화이트 리스트 체크 로직 추가
	 * 
	 * @param resultMap
	 * @param request
	 * @param response
	 * @return viewer name
	 * @throws Exception
	 */
	@RequestMapping(method=RequestMethod.POST, value={ "/upload.do", "/upload.ub" })
	public final String upload(Map<String, Object> resultMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			// 파라미터 추출
			// 용량의 제한은 HttpUtils.getParameter 내부의 함수에서 체크되어 IOException이 발생함.
			// try... catch 영역 박으로 이동하지 말것.
			Parameter parameter = HttpUtils.getParameter(request);

			// 파일 저장
			for(FileInfo fileInfo : parameter.getFileInfos()) {
				
				// 2019.01.18
				// 쿠폰관련 첨부파일 예외 처리
				if ("IMG_APP".equals(fileInfo.getAttachType())
						|| "IMG_WEB".equals(fileInfo.getAttachType())
						|| "IMG_REWARD".equals(fileInfo.getAttachType())) {
					String bucket = "";
					String accesskey = "";
					String secretkey = "";
					
					String path = fileInfo.getPath();
					String key = path.substring(path.lastIndexOf("/") + 1);
					
					if ("real".equals(ConfigHolder.APPLICATION_MODE)) {	// 운영모드
						bucket = ConfigHolder.get("amazonaws.real.s3.bucket");
						accesskey = ConfigHolder.get("amazonaws.real.s3.accesskey");;
						secretkey = ConfigHolder.get("amazonaws.real.s3.secretkey");;
					} else {
						bucket = ConfigHolder.get("amazonaws.dev.s3.bucket");
						accesskey = ConfigHolder.get("amazonaws.dev.s3.accesskey");;
						secretkey = ConfigHolder.get("amazonaws.dev.s3.secretkey");;
					}
					
			        BasicAWSCredentials awsCreds = new BasicAWSCredentials(accesskey, secretkey);
			        AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
							.withRegion(Regions.fromName("ap-northeast-2"))
	                        .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
	                        .build();
			        
			        PutObjectRequest putObjectRequest = new PutObjectRequest(bucket, "images/coupon/" + key, new FileInputStream(path), new ObjectMetadata());
			        putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
			        s3Client.putObject(putObjectRequest);
				}
				
				// 파일 정책 적용 (필수)
				super.applyFilePolicy(request, fileInfo);
				fileRepository.save(fileInfo);
				
				if(logger.isDebugEnabled()) {
					logger.debug("file uploaded[file id=" + fileInfo.getId() + "]; " + fileInfo + ";");
				}

				// SWFUpload에서 업로드 처리후 화면에 표시될 파일명 인코딩 처리
				if(SWFUPLOAD_HEADER.equals(HttpUtils.getBrowser(request))){
					fileInfo.setFileName(URLEncoder.encode(fileInfo.getFileName(), "UTF-8"));
				}
			}
			
			DataList dataList = DataUtil.makeFileDataList(parameter.getFileInfos());
			resultMap.put(ConstantHolder.KEY_SERVICE_RESULT,  DataUtil.makeResult().addDataList(dataList));
		} catch (IOException ex) {
			int fileSize = ConfigHolder.UPLOAD_SIZE_LIMIT / (1024 * 1024);
			String errMsg = fileSize + "MB이상 파일은 업로드 할 수 없습니다.";
			resultMap.put(ConstantHolder.KEY_SERVICE_RESULT,  DataUtil.makeFailedResult(errMsg, ""));
		} catch (Exception ex) {
			String errMsg = ex.getMessage();
			if("LIMIT_FILE_EXT".equals(errMsg)){
				resultMap.put(ConstantHolder.KEY_SERVICE_RESULT,  DataUtil.makeFailedResult("허용되지 않는 파일 확장자입니다. 확인후 다시 실행해 주십시오.", ""));
			}else{
				resultMap.put(ConstantHolder.KEY_SERVICE_RESULT,  DataUtil.makeFailedResult("정의되지 않은 오류가 발생하였습니다.", ""));
			}
		}
		
		return ConfigHolder.RESULT_FORMAT;
	}
	
	/**
	 * file 정보 조회
	 * @param fileId
	 * @param resultMap
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method=RequestMethod.POST, value={"/query.do", "/query.ub" })
	public final String query(@RequestParam(value="fileId", required=true) String fileId, Map<String, Object> resultMap, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		FileInfo fileInfo = fileRepository.findByFileId(fileId);
		
		DataList dataList = DataUtil.makeFileDataList(new FileInfo[] {fileInfo});
		resultMap.put(ConstantHolder.KEY_SERVICE_RESULT,  DataUtil.makeResult().addDataList(dataList));
		
		return ConfigHolder.RESULT_FORMAT;
	}
	
	/**
	 * file image
	 * @param imageId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping({"/image.do", "/image.ub" })
	public final void image(@RequestParam(value="imageId", required=true) String imageId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		FileInfo fileInfo = fileRepository.findByFileId(imageId);
		if(fileInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + imageId + "] from file Information Repository");
			return;
		}
		if(logger.isDebugEnabled()) {
			logger.debug("file download[file id=" + imageId + "]; " + fileInfo + ";");
		}
		
		try{
			response.setContentLength((int) fileInfo.getSize());
			response.setHeader("Content-Disposition", fileInfo.getContentType()+"; name=\"" + java.net.URLEncoder.encode(fileInfo.getFileName(), encoding) + "\";");
			
			writeFileToStream(fileInfo, response.getOutputStream());
			
		}catch(Exception ex){
			logger.error("File Download Error !!"+ex.getMessage(), ex);
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + imageId + "] from file Information Repository");
		}
	}
	
	private void writeFileToStream(FileInfo fileInfo, OutputStream out) throws Exception{
		if(fileInfo.isBlob()){
			FileCopyUtils.copy(fileInfo.getContent(), out);
		}else{
			File file = fileInfo.asFile();
			if(file.exists()){
				FileCopyUtils.copy(FileCopyUtils.copyToByteArray(file), out);
			}else{
				logger.error("Does not found File !! :: "+file.getAbsolutePath());
			}
		}
	}
	
	/**
	 * file viewer
	 * @param imageId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping({"/view.do", "/view.ub" })
	public final void view(@RequestParam(value="filePath", required=true) String filePath, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		
		// TODO : 2015-11-10 : kang0252 : 보안성강화로 경로를 직접 전달하는 기능은 사용할 수 없음. (개선사항)
		if(filePath.indexOf("..") > -1){
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file [filepath=" + filePath + "] from server");
			return;
		}
		
		File file  = new File(ConfigHolder.UPLOAD_PATH  + filePath);
		if(file.exists()) {
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + java.net.URLEncoder.encode(file.getName(), encoding) + "\";");
			
			OutputStream out = response.getOutputStream();
			FileCopyUtils.copy(FileCopyUtils.copyToByteArray(file), out);
		}
		else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file [filepath=" + ConfigHolder.UPLOAD_PATH  + filePath + "] from server");	
		}
	}
	
	/**
	 * BKR 파일다운로드
	 * @param 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping({"/bkrDown.do", "/bkrDown.ub" })
	public final void bkrFileDown(@RequestParam(value="fileId", required=true) String fileId, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		
		
		String bucket = "";
		String accesskey = "";
		String secretkey = "";
		
		if ("real".equals(ConfigHolder.APPLICATION_MODE)) {	// 운영모드
			bucket = ConfigHolder.get("amazonaws.real.s3.bucket");
			accesskey = ConfigHolder.get("amazonaws.real.s3.accesskey");
			secretkey = ConfigHolder.get("amazonaws.real.s3.secretkey");
		} else {
			bucket = ConfigHolder.get("amazonaws.dev.s3.bucket");
			accesskey = ConfigHolder.get("amazonaws.dev.s3.accesskey");
			secretkey = ConfigHolder.get("amazonaws.dev.s3.secretkey");
		}
		
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(accesskey, secretkey);
		AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
								.withRegion(Regions.fromName("ap-northeast-2"))
		                        .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
		                        .build();
		
		String fileName  = fileId.substring(fileId.lastIndexOf("/") + 1);
		
		try {
			S3Object s3Object = s3Client.getObject(bucket, fileId);
			byte[] resultFile = IOUtils.toByteArray(s3Object.getObjectContent());
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + java.net.URLEncoder.encode(fileName, encoding) + "\";");

			FileCopyUtils.copy(resultFile, response.getOutputStream());
			
		}catch(Exception ex){
			logger.error("File Download Error !!"+ex.getMessage(), ex);
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Can't find file information[id=" + fileId + "] from file Information Repository");
		}
	}
	
}