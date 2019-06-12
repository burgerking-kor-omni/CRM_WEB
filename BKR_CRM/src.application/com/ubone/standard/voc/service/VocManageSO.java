package com.ubone.standard.voc.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Stack;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.framework.type.ResultStatus;
import com.ubone.framework.util.sequence.BizSeqRepository;
import com.ubone.standard.common.dispatch.dao.DispatchDAO;
import com.ubone.standard.common.encrypto.IwtCrypt;
import com.ubone.standard.voc.dao.VocManageDAO;

@Service
public class VocManageSO {
	
	@Resource
	private VocManageDAO vmDAO;
	
	@Resource
	private DispatchDAO dispatchDAO;
	
	@Resource
	private BizSeqRepository bizSeqRepository;
	
	Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * VOC 목록 조회
	 * @param param 검색조건
	 * @return
	 */
	public DataList getVocList(Parameter param) throws Exception{
		
		String [] bizChnn = param.getValues("CD_BIZ_CHNN");
		String checkbox = "";
		for (int i = 0; i < bizChnn.length; i++) {
			checkbox += bizChnn[i] + "/";
		}
		checkbox = checkbox.substring(0,checkbox.length()-1);
		param.set("strChk", checkbox);
		
		DataList result = DataUtil.makeDataList("");

		// 이름,연락처 암호화
		if(param.get("NM_MEMBER_SEARCH").toString() != ""){
			param.set("NM_MEMBER", IwtCrypt.aesEncryptHex(param.get("NM_MEMBER_SEARCH").toString()) );
		}
		if(param.get("NO_PHONE_SEARCH").toString() != ""){
			param.set("NO_PHONE", IwtCrypt.aesEncryptHex(param.get("NO_PHONE_SEARCH").toString().replaceAll("-", "")) );
		}
		
		result = vmDAO.getVocList(param);
		for(int i = 0; i < result.getRowCount(); i++){
			// 이름,연락처 복호화
			if(result.get(i, "NM_CUST") != null && result.get(i, "NM_CUST").toString().length() == 32){
				result.set(i, "NM_CUST", IwtCrypt.aesDecryptHex(result.get(i, "NM_CUST").toString()) );				
			}

			String src = result.get(i, "NO_PHONE");
			if(src != null && src.length() == 32){
				src = IwtCrypt.aesDecryptHex(src);
			}
			if(src != null){
				if (src.length() == 8) {
					src = src.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2");
			    } else if (src.length() == 12) {
			    	src = src.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
			    }else{
			    	src = src.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
			    }
				result.set(i, "NO_PHONE", src );
			}
		}
		return result;
	}
	
	/**
	 * VOC 상세 조회
	 * @param param
	 * @return
	 */
	public DataList getVocDetail(Parameter param) throws Exception{
		
		DataList result = vmDAO.getVocDetail(DataUtil.makeUserAddedParameter(param));
		
		if(result.get(0, "NM_CUST") != null && result.get(0, "NM_CUST").toString().length() == 32){
			result.set(0, "NM_CUST", IwtCrypt.aesDecryptHex(result.get(0, "NM_CUST").toString()) );
		}
		
		String src = result.get(0, "NO_PHONE");
		if(src != null){
			if(result.get(0, "NO_PHONE").toString().length() == 32){
				src = IwtCrypt.aesDecryptHex(src);
			}
			
			if (src.length() == 8) {
				src = src.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2");
		    } else if (src.length() == 12) {
		    	src = src.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
		    }else{
		    	src = src.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
		    }
			result.set(0, "NO_PHONE", src );
		}
		
		return result;
	}
	
	/**
	 * VOC 상세 첨부파일 조회
	 * @param param
	 * @return
	 */
	public DataList getVocFileList(Parameter param) throws Exception{
		DataList vocFileList = vmDAO.getVocFileList(param);
		return vocFileList;
	}
	
	public Result getVocFileDown(Parameter param) throws IOException {
		
		Result result = DataUtil.makeResult();
		
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
		String key = param.getParameter("FILE_KEY").toString();
		String fileName  = key.substring(key.lastIndexOf("/") + 1);
		
		try {
		    S3Object s3Object = s3Client.getObject(bucket, key);
		    S3ObjectInputStream s3ObjectInputStream = s3Object.getObjectContent();

		    OutputStream outputStream = new BufferedOutputStream(new FileOutputStream("/data/webapps/files/voc/" + fileName));
		    byte[] bytesArray = new byte[4096];
		    int bytesRead = -1;
		    while ((bytesRead = s3ObjectInputStream.read(bytesArray)) != -1) {
		        outputStream.write(bytesArray, 0, bytesRead);
		    }
		    outputStream.close();
		    s3ObjectInputStream.close();
		    result.setServiceMessage(new ServiceMessage("파일 다운로드에 성공했습니다.").setResultStatus(ResultStatus.Success));
		} catch (AmazonS3Exception e) {
			result.setServiceMessage(new ServiceMessage("파일 다운로드에 실패했습니다.").setResultStatus(ResultStatus.Fail));
			logger.error("File Download Error !!"+e.getMessage(), e);
		} catch(SdkClientException e) {
			result.setServiceMessage(new ServiceMessage("파일 다운로드에 실패했습니다.").setResultStatus(ResultStatus.Fail));
			logger.error("File Download Error !!"+e.getMessage(), e);
		}
        return result;
	}
	
	/**
	 * VOC 상세 수정
	 * @param param VOC 상세 정보
	 */
	public void updateVocDetail(Parameter param){
		
		if(param.get("CD_VOC_STATUS").equals("02") && param.get("FG_SEND").equals("Y")){
			// voc 완료 시 통보 메일 발송
			// 1. 통보실행이력 저장
			Parameter disParam = DataUtil.makeParameter();
			disParam.setParameter("TP_BIZ", "VOC");								 // 업무구분
			disParam.setParameter("ID_BIZ_KEY", param.get("ID_VOC").toString()); // 업무별ID
			disParam.setParameter("DS_TITLE_DISPATCH", "고객님의 고객의 소리가 처리되었습니다.");	 // 통보제목

			String html = "";
			
			html +="<table style=\"width:738px; margin:0 auto; font-size:15px; font-family:'Malgun Gothic', '맑은 고딕', dotum, '돋움',sans-serif; line-height:167%; border:1px solid #c5c5c5; border-collapse:collapse;\">";
			html +="		<tbody>";
			html +="		<tr>";
			html +="			<td style=\"padding:0; border:none;\"><img src=\"http://13.209.180.127/mail/mail_top02.gif\" alt=\"BURGER KING\"></td>";
			html +="		</tr>";
			html +="		<tr>";
			html +="			<td style=\"padding:0; border:none;\">";
			html +="				<div style=\"padding:10px 32px;\">";
			html +="					<p style=\"margin:0;\">안녕하세요. <strong>"+param.get("NM_CUST")+"</strong> 회원님<br>입력하신 고객의 소리에 대한 답변 메일입니다.<br>항상 보다 나은 서비스로 보답하기 위해 노력하겠습니다.</p>";
			html +="					<table style=\"width:100%; margin:20px 0; font-size:14px; border-top:1px solid #999; border-collapse:collapse;\">";
			html +="						<tbody>";
			html +="						<tr>";
			html +="							<th scope=\"row\" width=\"135\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">답변내용</th>";
			html +="							<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + param.get("DS_DISPATCH_CONT").replaceAll("\n", "<br />") + "</td>";
			html +="						</tr>";
			html +="						</tbody>";
			html +="					</table>";
			html +="					<p style=\"margin:0; font-size:13px;\">본 메일은 관련법령에 따른 정보통신서비스 제공자의 고지의무 준수를 위하여 회원님의 E-mail 광고성 정보 수신동의 여부에 관계없이 발송 되었습니다.</p>";
			html +="					<div style=\"margin:50px 0; text-align:center\">";
			html +="						<a href=\"https://burgerking.co.kr\"><img src=\"http://13.209.180.127/mail/btn_gobkr.gif\" alt=\"버거킹 방문하기\"></a>";
			html +="					</div>";
			html +="				</div>";
			html +="			</td>";
			html +="		</tr>";
			html +="		<tr>";
			html +="			<td style=\"padding:0; border:none;\">";
			html +="				<div style=\"padding:20px 32px; font-size:13px; line-height:170%; background:#eee;\">";
			html +="					<p style=\"margin:0;\">본 메일은 버거킹에서 발송한 메일이며 발신전용 메일입니다.<br>관련 문의사항은 고객센터(02-6331-8282)로 연락주시기 바랍니다.</p>";
			html +="				</div>";
			html +="			</td>";
			html +="		</tr>";
			html +="		<tr>";
			html +="			<td style=\"padding:0; border:none;\">";
			html +="				<div style=\"padding:31px 32px 20px; font-size:12px; color:#818181; line-height:167%; background:#292929;\">";
			html +="					<div style=\"margin-bottom:5px;\"><img src=\"http://13.209.180.127/mail/logo.gif\" alt=\"버거킹 logo\"></div>";
			html +="					<p style=\"margin:0;\">서울 종로구 삼봉로 71 G 타워 2층  주식회사 비케이알 │ TEL 02-6331-8282  FAX 02-3775-4325</p>";
			html +="					<p style=\"margin:0;\">사업자 등록번호 101-86-76277 │ (주)BKR 대표이사 문영주</p>";
			html +="					<p style=\"margin:0;\">Copyright 2018 BKR Co., Ltd. All right Reserved</p>";
			html +="					<div class=\"btn_list03\">";
			html +="						<a href=\"https://www.facebook.com/burgerkingkorea\" style=\"margin-right:5px;\"><img src=\"http://13.209.180.127/mail/btn_sns_facebook.gif\" alt=\"페이스북\"></a>";
			html +="						<a href=\"https://www.instagram.com/burgerkingkorea\" style=\"margin-right:5px;\"><img src=\"http://13.209.180.127/mail/btn_sns_insta.gif\" alt=\"인스타그램\"></a>";
			html +="						<a href=\"https://www.youtube.com/channel/UCEKRI0fipK4LEgV98nI2CQA/featured\" style=\"margin-right:5px;\"><img src=\"http://13.209.180.127/mail/btn_sns_youtube.gif\" alt=\"유튜브\"></a>";
			html +="					</div>";
			html +="				</div>";
			html +="			</td>";
			html +="		</tr>";
			html +="	</tbody>";
			html +="</table>";
			disParam.setParameter("DS_DISPATCH", html); // 통보내용
			
			String idDispatch = dispatchDAO.insertDispatchRun(disParam);
			
			// 2. 통보대상자  저장
			Parameter targetParam = DataUtil.makeParameter();
			targetParam.setParameter("ID_DISPATCH_RUN", idDispatch);// 통보실행ID
			targetParam.setParameter("TP_DISPATCH_TARGET", "01");	// 통보대상자구분
			targetParam.setParameter("FG_REFERENCES", "N");	 		// 참조대상 여부
			if("real".equals(ConfigHolder.APPLICATION_MODE)){
				targetParam.setParameter("DS_EMAIL_RECV", param.get("DS_EMAIL").toString()); // 받는메일	
			}else{
				targetParam.setParameter("DS_EMAIL_RECV", "adx8@ubqone.com"); // 받는메일
			}
			dispatchDAO.insertDispatchRunTarget(targetParam);
		}
		
		vmDAO.updateVocDetail(DataUtil.makeUserAddedParameter(param));
	}
	
	/**
	 * VOC 삭제처리
	 * @param param ID_VOC
	 */
	public void deleteVoc (Parameter param){
		vmDAO.deleteVoc(DataUtil.makeUserAddedParameter(param));
	}

	/**
	 * VOC 등록 주문,회원 정보조회
	 * @param param 주문번호
	 * @return 주문정보,회원정보
	 * @throws Exception 
	 */
	public DataList getOrderInfo(Parameter param) throws Exception{
		DataList orderInfo = vmDAO.getOrderInfo(param);
		
		
		if(orderInfo.get(0, "NM_MEMBER") != null && orderInfo.get(0, "NM_MEMBER").toString().length() == 32){
			orderInfo.set(0, "NM_MEMBER", IwtCrypt.aesDecryptHex(orderInfo.getString(0, "NM_MEMBER")));
		}
		
		String src = orderInfo.getString(0, "NO_PHONE");
		if(src != null){
			if(orderInfo.getString(0, "NO_PHONE").length() == 32){
				src = IwtCrypt.aesDecryptHex(orderInfo.getString(0, "NO_PHONE"));
			}
			if (src.length() == 8) {
				src = src.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2");
		    } else if (src.length() == 12) {
		    	src = src.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
		    }
			src = src.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
			
			orderInfo.set(0, "NO_PHONE", src);
		}
		
		return orderInfo;
	}
	
	/**
	 * 매장찾기 목록 조회
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getStoreList (Parameter param){
		return vmDAO.getStoreList(param);
	}
	
	/**
	 * VOC 유형 자동완성
	 * @param param 
	 * @return
	 */
	public DataList getVocAutoComplete (Parameter param){
		return vmDAO.getVocAutoComplete(param);
	}
	
	/**
	 * VOC 등록
	 * @param param
	 */
	public void insertVoc (Parameter param) throws Exception{
		
		param.set("NM_CUST", IwtCrypt.aesEncryptHex(param.get("NM_CUST").toString()) );
		param.set("NO_PHONE", IwtCrypt.aesEncryptHex(param.get("NO_PHONE").toString().replaceAll("-", "")) );
		
		
		//현재 날짜 구하기
		SimpleDateFormat fm1 = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
		String date = fm1.format(new Date());
		
		//현재 날짜별 순번 생성하기
		String key = bizSeqRepository.nextVal("VOC", date);
		
		//채널 앞에서 1자리 + 오늘날짜 + 순번 4자리
		key = "VOC" + date + String.format("%04d", Integer.parseInt(key));
		param.setParameter("ID_VOC", key);
		
		vmDAO.insertVoc(DataUtil.makeUserAddedParameter(param));
	}
	
	/**
	 * 매장명 자동완성 조회
	 * @param param 검색어
	 * @return 매장명,CODE
	 */
	public DataList getStoreAutoComplete(Parameter param){
		return vmDAO.getStoreAutoComplete(param);
	}
	
	/**
	 * 사용자명 자동완성 조회
	 * @param param 검색어
	 * @return 사용자 정보
	 */
	public DataList getUserAutoComplete (Parameter param){
		return vmDAO.getUserAutoComplete(param);
	}
	
	
	/**
	 * VOC 목록 엑셀 다운로드
	 * @param param
	 * @return
	 */
	public String getVocListExcelDown(Parameter param){
		
		String key = "";
		
		DataList list = vmDAO.getVocListToExcel(param);
		
		// 페이지당 제한 로우개수
		int rowCountPerPage = 99999999;
		
		// 총 로우 수
		int totalRowCount = list.getRowCount();
		int page = 1;
		
		int fileCount = 0;
		if(totalRowCount%rowCountPerPage==0){
			fileCount = totalRowCount/rowCountPerPage;
		}else{
			fileCount = totalRowCount/rowCountPerPage+1;
		}
		
		String[] filelink =new String[fileCount];
		
		for (int fileIdx = 0; fileIdx < fileCount; fileIdx++ , page++) {
			
			HSSFWorkbook wb = new HSSFWorkbook();
        	HSSFCellStyle hCellStyle = wb.createCellStyle();
    		HSSFCellStyle cellStyle1 = wb.createCellStyle();
    		HSSFCellStyle cellStyle2 = wb.createCellStyle();
    		
    		hCellStyle.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
    		hCellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
    		
    		hCellStyle.setBorderTop(CellStyle.BORDER_THIN);
    		hCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
    		hCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
    		hCellStyle.setBorderRight(CellStyle.BORDER_THIN);
    		
    		hCellStyle.setTopBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		hCellStyle.setBottomBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		hCellStyle.setLeftBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		hCellStyle.setRightBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		
    		HSSFFont font = wb.createFont();
            font.setColor(HSSFColor.BLACK.index);
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            hCellStyle.setFont(font);
            hCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
            hCellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

            
            cellStyle1.setFillForegroundColor(HSSFColor.WHITE.index);
    		cellStyle1.setFillPattern(CellStyle.SOLID_FOREGROUND);
    		
    		cellStyle1.setBorderTop(CellStyle.BORDER_THIN);
    		cellStyle1.setBorderBottom(CellStyle.BORDER_THIN);
    		cellStyle1.setBorderLeft(CellStyle.BORDER_THIN);
    		cellStyle1.setBorderRight(CellStyle.BORDER_THIN);
    		
    		cellStyle1.setTopBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		cellStyle1.setBottomBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		cellStyle1.setLeftBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		cellStyle1.setRightBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		
    		cellStyle2.setFillForegroundColor(HSSFColor.WHITE.index);
    		cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
    		
    		cellStyle2.setBorderTop(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderBottom(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderLeft(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderRight(CellStyle.BORDER_THIN);
    		cellStyle2.setTopBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		cellStyle2.setBottomBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		cellStyle2.setLeftBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		cellStyle2.setRightBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
    		HSSFSheet sheet = wb.createSheet();
    		
    		HSSFRow headerRow1 = sheet.createRow(0);
    		HSSFCell hCell1 = headerRow1.createCell(5);
    		HSSFCell hCell12 = headerRow1.createCell(10);
    		
    		HSSFRow headerRow = sheet.createRow(1);
	        String[] titles = list.getColumnNames();
	        
	        for (int i = 0; i < titles.length; i++) {
	        	HSSFCell cell = headerRow1.createCell(i);
	            
	            if(i == 5|| i == 6||i == 7||i == 10||i == 11||i == 12){
	            	cell = headerRow.createCell(i);
	            	cell.setCellStyle(hCellStyle);
		            cell.setCellValue(titles[i]);
	            }else{
	            	// 셀 병합
	        		sheet.addMergedRegion(new CellRangeAddress(
	                		0, //first row (0-based)
	                		1, //last row  (0-based)
	                        i, //first column (0-based)
	                        i //last column  (0-based)
	                ));
	        		cell.setCellStyle(hCellStyle);
		            cell.setCellValue(titles[i]);
	            }
	        }
	        
	     // 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		0, //last row  (0-based)
                    5, //first column (0-based)
                    7  //last column  (0-based)
            ));
    		hCell1.setCellValue("매장정보");
    		hCell1.setCellStyle(hCellStyle);
	        
	        
	        // 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		0, //last row  (0-based)
                    10, //first column (0-based)
                    12  //last column  (0-based)
            ));
    		hCell12.setCellValue("고객정보");
    		hCell12.setCellStyle(hCellStyle);
	        
	        // 엑셀 틀 고정
	        sheet.createFreezePane(0, 2);
	        
	        // 열 너비  설정
//	        sheet.autoSizeColumn(1);
	        sheet.setColumnWidth(1, 3500);
	        sheet.setColumnWidth(5, 5300);
	        sheet.setColumnWidth(9, 6800);
	        sheet.setColumnWidth(11, 4500);
	        sheet.setColumnWidth(12, 6000);
	        sheet.setColumnWidth(13, 6000);
	        sheet.setColumnWidth(14, 6000);
	        sheet.setColumnWidth(15, 12000);

	        HSSFRow row;
	        HSSFCell cell;
	        int rownum = 2;
	        
	        
	        int repeatCount = 0;
			if( ( page*rowCountPerPage ) <= totalRowCount){
				repeatCount = rowCountPerPage;
			}else if((page*rowCountPerPage -rowCountPerPage) < totalRowCount){
				repeatCount = totalRowCount % rowCountPerPage ;
			}else{
				repeatCount = 0;
			}
			
			for (int i = (page*rowCountPerPage)-rowCountPerPage ; i < repeatCount+(page*rowCountPerPage)-rowCountPerPage ; i++ ,rownum++) {
				row = sheet.createRow(rownum);
	            
	        	if(list.getRow(i) == null) continue;

	        	for (int j = 0; j < list.getRow(i).size(); j++) {

	                cell = row.createCell(j);
	                String value = ""+list.getRow(i).get(titles[j]);
	                
	                if("null".equals(value) || "NULL".equals(value) ){
	                	value = "";
	                }else if(j == 0){
	                	// 순번
	                	value = ""+(i+1);
	                }else if(j == 10 || j == 11){
	                	// 고객 정보 복호화
	                	try {
							value = IwtCrypt.aesDecryptHex(value);
							if(j == 11){
								// 연락처 포멧팅 및 열 너비 설정
								if (value.length() == 8) {
									value = value.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2");
							    } else if (value.length() == 12) {
							    	value = value.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
							    }else{
							    	value = value.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
							    }
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
	                }else{
	                	// 기타 특수문자 변환
	                	value = value.replaceAll("&amp;", "&");
	            		value = value.replaceAll("&apos;", "'");
	            		value = value.replaceAll("&quot;", "\"");
	            		value = value.replaceAll("&lt;", "<");
	            		value = value.replaceAll("&gt;", ">");
	            		value = value.replaceAll("&#39;", "'");
	                }
	                
	                if(i%2==1){
	                	cell.setCellStyle(cellStyle2);	
	                }else{
	                	cell.setCellStyle(cellStyle1);
	                }
					
					cell.setCellValue(""+ value);
	            } 
	        }
			
	        // Write the output to a file
			Calendar now = Calendar.getInstance();
			
			String dateStr = ""+now.get(Calendar.YEAR)+"-"+(now.get(Calendar.MONTH) + 1) +"-"+now.get(Calendar.DAY_OF_MONTH);
			now.add(Calendar.DATE,-1); //현재 날짜에서 일일전 날짜 가져오기
			String dateStr_D1 = ""+now.get(Calendar.YEAR)+"-"+(now.get(Calendar.MONTH) + 1) +"-"+now.get(Calendar.DAY_OF_MONTH);
			
	        String fileNm = UUID.randomUUID().toString().replaceAll("-", "");
	        
	        String path = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr + "/";
	        String path_1 = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr_D1;
	        String file = ConfigHolder.UPLOAD_PATH  + "/"  +"export"+ "/" + dateStr + "/" + fileNm + ".xls";
	        
			filelink[page-1] = ""+ "/"  +"export"+ "/" + dateStr + "/" + fileNm + ".xls";
			
			File excelDirectory = new File(path);
			
			if(!excelDirectory.exists()){ 
				excelDirectory.mkdirs();
			}
			
			FileOutputStream out = null;
			try {
				out = new FileOutputStream(file);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
	        try {
				wb.write(out);
			} catch (IOException e) {
				e.printStackTrace();
			}
	        try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
	        
	        // ============================= S3 파일 업로드 Start
	        String bucket = "";
			String accesskey = "";
			String secretkey = "";
			
			key = file.substring(file.lastIndexOf("/") + 1);
			
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
	        
			try {
				PutObjectRequest putObjectRequest = new PutObjectRequest(bucket, "images/voc/" + key, new FileInputStream(file), new ObjectMetadata());
		        putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
		        s3Client.putObject(putObjectRequest);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
	        // ============================= S3 파일 업로드 End
			
			Stack<String> lifo = null;
			lifo = this.checkList(path_1 , new Stack<String>());
			this.deleteDirectory(lifo);
			
			File deleteExcelDirectory = new File(path_1);
			if(deleteExcelDirectory.exists()){
				deleteExcelDirectory.delete();
			}
		}
		return "images/voc/" + key;

	}
	
	/**
	 * 스택에있는 파일 및 디렉토리를 모두 삭제한다.
	 * @param lifo
	 */
	private void deleteDirectory(Stack<String> lifo) {
		while(!lifo.empty()){
			String ss = lifo.pop();
			
			File deleteExcelDirectory = new File(ss);
			
			if (deleteExcelDirectory.exists()) {
				boolean deleteFlag = deleteExcelDirectory.delete();
				if (deleteFlag) {
					System.out.println(ss + " 삭제 성공함");
				} else {
					System.out.println(ss + " 삭제 실패함");
				}
			} else {
				System.out.println(ss + " 가 존재하지 않습니다.");
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
		
		File deleteExcelDirectory = new File(initPath);
		
		if(deleteExcelDirectory.exists())
	    {
			String[] files = deleteExcelDirectory.list();
			
			if(files != null){
				for (int i = 0; i < files.length; i++) {
					
					lifo.push(initPath+"/"+ files[i]); 
					lifo = this.checkList(initPath+"/"+ files[i] , lifo);
				}
			}
	    }
		return lifo;
	}

}
