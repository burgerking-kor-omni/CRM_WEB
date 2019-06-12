package com.ubone.standard.ana.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
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

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.ana.dao.AnaInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : AnaInquirySO.java
 *  설    명 : 
 *  작 성 자 : 강현준
 *  작 성 일 : 2018. 12. 24
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class AnaInquirySO {

	private static final Log logger = LogFactory.getLog(AnaInquirySO.class);
	
	@Resource
	private AnaInquiryDAO anaDAO;
	
	/**
	 * 연도별 회원현황
	 * @param param 연도
	 * @return 회원현황 정보
	 */
	public DataList getYearlyAna (Parameter param){
		DataList result = anaDAO.getYearlyAna(param);
		int rowCnt = result.getRowCount();
		if(rowCnt >= 1){
			for(int i = 0; i < rowCnt; i++){
				result.set(i, "BB", String.format("%,d", Integer.parseInt(result.get(i, "BB").toString())));
				result.set(i, "CC", String.format("%+,d", Integer.parseInt(result.get(i, "CC").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "CC").toString())));
				result.set(i, "DD", String.format("%,d", Integer.parseInt(result.get(i, "DD").toString())));
				result.set(i, "EE", String.format("%+,d", Integer.parseInt(result.get(i, "EE").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "EE").toString())));
				result.set(i, "FF", String.format("%,d", Integer.parseInt(result.get(i, "FF").toString())));
				result.set(i, "GG", String.format("%+,d", Integer.parseInt(result.get(i, "GG").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "GG").toString())));
				result.set(i, "HH", String.format("%,d", Integer.parseInt(result.get(i, "HH").toString())));
				result.set(i, "II", String.format("%+,d", Integer.parseInt(result.get(i, "II").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "II").toString())));
				result.set(i, "JJ", String.format("%,d", Integer.parseInt(result.get(i, "JJ").toString())));
				result.set(i, "KK", String.format("%+,d", Integer.parseInt(result.get(i, "KK").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "KK").toString())));
				result.set(i, "LL", String.format("%,d", Integer.parseInt(result.get(i, "LL").toString())));
				result.set(i, "MM", String.format("%+,d", Integer.parseInt(result.get(i, "MM").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "MM").toString())));
				result.set(i, "NN", String.format("%,d", Integer.parseInt(result.get(i, "NN").toString())));
				result.set(i, "OO", String.format("%+,d", Integer.parseInt(result.get(i, "OO").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "OO").toString())));
				result.set(i, "PP", String.format("%,d", Integer.parseInt(result.get(i, "PP").toString())));
				result.set(i, "QQ", String.format("%+,d", Integer.parseInt(result.get(i, "QQ").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "QQ").toString())));
				result.set(i, "RR", String.format("%,d", Integer.parseInt(result.get(i, "RR").toString())));
				result.set(i, "SS", String.format("%+,d", Integer.parseInt(result.get(i, "SS").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "SS").toString())));
				result.set(i, "TT", String.format("%,d", Integer.parseInt(result.get(i, "TT").toString())));
				result.set(i, "UU", String.format("%+,d", Integer.parseInt(result.get(i, "UU").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "UU").toString())));
				result.set(i, "VV", String.format("%,d", Integer.parseInt(result.get(i, "VV").toString())));
				result.set(i, "WW", String.format("%+,d", Integer.parseInt(result.get(i, "WW").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "WW").toString())));
				result.set(i, "XX", String.format("%,d", Integer.parseInt(result.get(i, "XX").toString())));
				result.set(i, "YY", String.format("%+,d", Integer.parseInt(result.get(i, "YY").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "YY").toString())));
				result.set(i, "ZZ", String.format("%,d", Integer.parseInt(result.get(i, "ZZ").toString())));
				result.set(i, "AAA", String.format("%+,d", Integer.parseInt(result.get(i, "AAA").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "AAA").toString())));
			}
		}
		return result;
	}
	
	
	/**
	 * 월별 회원현황
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getMonthAna (Parameter param){
		DataList result = anaDAO.getMonthAna(param);
		int rowCnt = result.getRowCount();
		if(rowCnt > 0){
			for(int i = 0; i < rowCnt; i++){
				result.set(i, "BB", String.format("%,d", Integer.parseInt(result.get(i, "BB").toString())));
				result.set(i, "CC", String.format("%+,d", Integer.parseInt(result.get(i, "CC").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "CC").toString())));
				result.set(i, "DD", String.format("%,d", Integer.parseInt(result.get(i, "DD").toString())));
				result.set(i, "EE", String.format("%+,d", Integer.parseInt(result.get(i, "EE").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "EE").toString())));
				result.set(i, "FF", String.format("%,d", Integer.parseInt(result.get(i, "FF").toString())));
				result.set(i, "GG", String.format("%+,d", Integer.parseInt(result.get(i, "GG").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "GG").toString())));
				result.set(i, "HH", String.format("%,d", Integer.parseInt(result.get(i, "HH").toString())));
				result.set(i, "II", String.format("%+,d", Integer.parseInt(result.get(i, "II").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "II").toString())));
				result.set(i, "JJ", String.format("%,d", Integer.parseInt(result.get(i, "JJ").toString())));
				result.set(i, "KK", String.format("%+,d", Integer.parseInt(result.get(i, "KK").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "KK").toString())));
				result.set(i, "LL", String.format("%,d", Integer.parseInt(result.get(i, "LL").toString())));
				result.set(i, "MM", String.format("%+,d", Integer.parseInt(result.get(i, "MM").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "MM").toString())));
				result.set(i, "NN", String.format("%,d", Integer.parseInt(result.get(i, "NN").toString())));
				result.set(i, "OO", String.format("%+,d", Integer.parseInt(result.get(i, "OO").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "OO").toString())));
				result.set(i, "PP", String.format("%,d", Integer.parseInt(result.get(i, "PP").toString())));
				result.set(i, "QQ", String.format("%+,d", Integer.parseInt(result.get(i, "QQ").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "QQ").toString())));
				result.set(i, "RR", String.format("%,d", Integer.parseInt(result.get(i, "RR").toString())));
				result.set(i, "SS", String.format("%+,d", Integer.parseInt(result.get(i, "SS").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "SS").toString())));
				result.set(i, "TT", String.format("%,d", Integer.parseInt(result.get(i, "TT").toString())));
				result.set(i, "UU", String.format("%+,d", Integer.parseInt(result.get(i, "UU").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "UU").toString())));
				result.set(i, "VV", String.format("%,d", Integer.parseInt(result.get(i, "VV").toString())));
				result.set(i, "WW", String.format("%+,d", Integer.parseInt(result.get(i, "WW").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "WW").toString())));
				result.set(i, "XX", String.format("%,d", Integer.parseInt(result.get(i, "XX").toString())));
				result.set(i, "YY", String.format("%+,d", Integer.parseInt(result.get(i, "YY").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "YY").toString())));
				result.set(i, "ZZ", String.format("%,d", Integer.parseInt(result.get(i, "ZZ").toString())));
				result.set(i, "AAA", String.format("%+,d", Integer.parseInt(result.get(i, "AAA").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "AAA").toString())));
			}
		}
		return result;
	}
	
	
	/**
	 * 일별 회원현황
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getDateAna (Parameter param){
		DataList result = anaDAO.getDateAna(param);
		int rowCnt = result.getRowCount();
		if(rowCnt > 0){
			for(int i = 0; i < rowCnt; i++){
				result.set(i, "BB", String.format("%,d", Integer.parseInt(result.get(i, "BB").toString())));
				result.set(i, "CC", String.format("%+,d", Integer.parseInt(result.get(i, "CC").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "CC").toString())));
				result.set(i, "DD", String.format("%,d", Integer.parseInt(result.get(i, "DD").toString())));
				result.set(i, "EE", String.format("%+,d", Integer.parseInt(result.get(i, "EE").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "EE").toString())));
				result.set(i, "FF", String.format("%,d", Integer.parseInt(result.get(i, "FF").toString())));
				result.set(i, "GG", String.format("%+,d", Integer.parseInt(result.get(i, "GG").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "GG").toString())));
				result.set(i, "HH", String.format("%,d", Integer.parseInt(result.get(i, "HH").toString())));
				result.set(i, "II", String.format("%+,d", Integer.parseInt(result.get(i, "II").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "II").toString())));
				result.set(i, "JJ", String.format("%,d", Integer.parseInt(result.get(i, "JJ").toString())));
				result.set(i, "KK", String.format("%+,d", Integer.parseInt(result.get(i, "KK").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "KK").toString())));
				result.set(i, "LL", String.format("%,d", Integer.parseInt(result.get(i, "LL").toString())));
				result.set(i, "MM", String.format("%+,d", Integer.parseInt(result.get(i, "MM").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "MM").toString())));
				result.set(i, "NN", String.format("%,d", Integer.parseInt(result.get(i, "NN").toString())));
				result.set(i, "OO", String.format("%+,d", Integer.parseInt(result.get(i, "OO").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "OO").toString())));
				result.set(i, "PP", String.format("%,d", Integer.parseInt(result.get(i, "PP").toString())));
				result.set(i, "QQ", String.format("%+,d", Integer.parseInt(result.get(i, "QQ").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "QQ").toString())));
				result.set(i, "RR", String.format("%,d", Integer.parseInt(result.get(i, "RR").toString())));
				result.set(i, "SS", String.format("%+,d", Integer.parseInt(result.get(i, "SS").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "SS").toString())));
				result.set(i, "TT", String.format("%,d", Integer.parseInt(result.get(i, "TT").toString())));
				result.set(i, "UU", String.format("%+,d", Integer.parseInt(result.get(i, "UU").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "UU").toString())));
				result.set(i, "VV", String.format("%,d", Integer.parseInt(result.get(i, "VV").toString())));
				result.set(i, "WW", String.format("%+,d", Integer.parseInt(result.get(i, "WW").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "WW").toString())));
				result.set(i, "XX", String.format("%,d", Integer.parseInt(result.get(i, "XX").toString())));
				result.set(i, "YY", String.format("%+,d", Integer.parseInt(result.get(i, "YY").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "YY").toString())));
				result.set(i, "ZZ", String.format("%,d", Integer.parseInt(result.get(i, "ZZ").toString())));
				result.set(i, "AAA", String.format("%+,d", Integer.parseInt(result.get(i, "AAA").toString())).equals("+0")?"0":String.format("%+,d", Integer.parseInt(result.get(i, "AAA").toString())));
			}
		}
		return result;
	}

	/**
	 * 등급별 회원현황 목록 조회
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getGradeAna (Parameter param){
		DataList result = anaDAO.getGradeAna(param);
		return result;
	}
	
	/**
	 * 성별 회원현황 목록 조회
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getGenderAna (Parameter param){
		return anaDAO.getGenderAna(param);
	}
	
	/**
	 * 연령대별 회원현황 목록 조회
	 * @param param 검색조건
	 * @return 회원현황 목록
	 */
	public DataList getAgeAna (Parameter param){
		return anaDAO.getAgeAna(param);
	}
	
	/**
	 * 월별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getMonthStamp(Parameter param){
		return anaDAO.getMonthStamp(param);
	}
	
	/**
	 * 일별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getDateStamp (Parameter param){
		return anaDAO.getDateStamp(param);
	}

	/**
	 * 월별/등급별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getMonGradeStamp (Parameter param){
		return anaDAO.getMonGradeStamp(param);
	}
	
	/**
	 * 매장별 스탬프 적립 현황목록 조회
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getStoreStamp(Parameter param){
		return anaDAO.getStoreStamp(param);
	}
	
	/**
	 * 월별 멤버십 변동현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getChangeAna (Parameter param){
		return anaDAO.getChangeAna(param);
	}
	
	/**
	 * 유형-월별 VOC현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getCauseVocAna(Parameter param){
		return anaDAO.getCauseVocAna(param);
	}
	
	/**
	 * 매장-월별 VOC현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getStoreVocAna(Parameter param){
		return anaDAO.getStoreVocAna(param);
	}
	
	/**
	 * 고객속성별 VOC현황 목록  조회 
	 * @param param 검색조건
	 * @return 현황 목록
	 */
	public DataList getCustAttrVocAna(Parameter param){
		return anaDAO.getCustAttrVocAna(param);
	}
	
	public Result getDivVocAna (Parameter param){
		Result result = DataUtil.makeResult();
		String [] cdDiv = param.getValues("CD_DIVISION");
		String [] cdDivParam = new String[11];
		int idx = 0;
		if(cdDiv.length > 1){
			for(int i = 0; i < cdDiv.length; i++){
				switch (cdDiv[i]) {
				case "01":
					cdDivParam[idx++] = "02001";
					break;
				case "02":
					cdDivParam[idx++] = "02002";
					cdDivParam[idx++] = "02003";
					cdDivParam[idx++] = "02004";
					cdDivParam[idx++] = "02005";
					cdDivParam[idx++] = "02010";
					break;
				case "03":
					cdDivParam[idx++]= "02006";
					cdDivParam[idx++]= "02007";
					cdDivParam[idx++]= "02009";
					break;
				case "04":
					cdDivParam[idx++]= "02008";
					break;
				case "05":
					cdDivParam[idx++]= "02011";
					param.set("FLAG_ETC", "00");
					break;
				}
			}
		}else if(cdDiv.length == 1){
			switch (cdDiv[0]) {
			case "01":
				cdDivParam[idx++] =  "02001";
				break;
			case "02":
				cdDivParam[idx++] =  "02002";
				cdDivParam[idx++] =  "02003";
				cdDivParam[idx++] =  "02004";
				cdDivParam[idx++] =  "02005";
				cdDivParam[idx++] =  "02010";
				break;
			case "03":
				cdDivParam[idx++] =  "02006";
				cdDivParam[idx++] =  "02007";
				cdDivParam[idx++] =  "02009";
				break;
			case "04":
				cdDivParam[idx++] =  "02008";
				break;
			case "05":
				cdDivParam[idx++] =  "02011";
				param.set("FLAG_ETC", "00");
				break;
			}
		}
		
		// 분류별 CD_VOC_CAUSE 
		param.set("CD_DIV_STR", cdDivParam);
		result.addDataList(anaDAO.getDivVocAna(param));
		
		result.addDataList(anaDAO.getDivVocEtc(param));
		return result;
	}
	
	
	/**
	 * VOC 목록 엑셀 다운로드
	 * @param param
	 * @return
	 */
	public String getVocListExcelDown(Parameter param){
		
		String key = "";
		
		String [] cdDiv = param.getValues("CD_DIVISION");
		String [] cdDivParam = new String[11];
		int idx = 0;
		if(cdDiv.length > 1){
			for(int i = 0; i < cdDiv.length; i++){
				switch (cdDiv[i]) {
				case "01":
					cdDivParam[idx++] = "02001";
					break;
				case "02":
					cdDivParam[idx++] = "02002";
					cdDivParam[idx++] = "02003";
					cdDivParam[idx++] = "02004";
					cdDivParam[idx++] = "02005";
					cdDivParam[idx++] = "02010";
					break;
				case "03":
					cdDivParam[idx++]= "02006";
					cdDivParam[idx++]= "02007";
					cdDivParam[idx++]= "02009";
					break;
				case "04":
					cdDivParam[idx++]= "02008";
					break;
				case "05":
					cdDivParam[idx++]= "02011";
					param.set("FLAG_ETC", "00");
					break;
				}
			}
		}else if(cdDiv.length == 1){
			switch (cdDiv[0]) {
			case "01":
				cdDivParam[idx++] =  "02001";
				break;
			case "02":
				cdDivParam[idx++] =  "02002";
				cdDivParam[idx++] =  "02003";
				cdDivParam[idx++] =  "02004";
				cdDivParam[idx++] =  "02005";
				cdDivParam[idx++] =  "02010";
				break;
			case "03":
				cdDivParam[idx++] =  "02006";
				cdDivParam[idx++] =  "02007";
				cdDivParam[idx++] =  "02009";
				break;
			case "04":
				cdDivParam[idx++] =  "02008";
				break;
			case "05":
				cdDivParam[idx++] =  "02011";
				param.set("FLAG_ETC", "00");
				break;
			}
		}
		
		// 분류별 CD_VOC_CAUSE 
		param.set("CD_DIV_STR", cdDivParam);
		
		DataList list = anaDAO.getAnaListToExcel(param);
		DataList etcList = anaDAO.getDivVocEtc(param);
		
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
    		
    		hCellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
    		hCellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
    		hCellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
    		hCellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
    		
    		hCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
    		hCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    		
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
    		
    		cellStyle1.setTopBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle1.setBottomBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle1.setLeftBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle1.setRightBorderColor(IndexedColors.BLACK.getIndex());
    		
    		cellStyle1.setAlignment(CellStyle.ALIGN_CENTER);           
    		cellStyle1.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    		
    		
    		cellStyle2.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
    		cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
    		
    		cellStyle2.setBorderTop(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderBottom(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderLeft(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderRight(CellStyle.BORDER_THIN);
    		
    		cellStyle2.setTopBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle2.setBottomBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle2.setLeftBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle2.setRightBorderColor(IndexedColors.BLACK.getIndex());
    		
    		cellStyle2.setAlignment(CellStyle.ALIGN_CENTER);           
    		cellStyle2.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    		
    		HSSFSheet sheet = wb.createSheet();
    		
    		HSSFRow headerRow1 = sheet.createRow(0);
    		HSSFRow headerRow2 = sheet.createRow(1);
    		HSSFRow headerRow3 = sheet.createRow(2);
    		
    		// 헤더 생성
    		for(int i = 1; i < 3; i++){
    			HSSFRow headerRow = sheet.createRow(i);
    			for(int j = 0; j < 2; j++){
    				HSSFCell hSub = headerRow.createCell(j);
        			hSub.setCellStyle(hCellStyle);	
    			}
    		}
    		HSSFCell hCell = headerRow1.createCell(0);
    		hCell.setCellValue("지역명");
    		hCell.setCellStyle(hCellStyle);
	        // 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		2, //last row  (0-based)
                    0, //first column (0-based)
                    0  //last column  (0-based)
            ));
    		
    		hCell = headerRow1.createCell(1);
    		hCell.setCellValue("AS");
    		hCell.setCellStyle(hCellStyle);
    		
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		2, //last row  (0-based)
                    1, //first column (0-based)
                    1  //last column  (0-based)
            ));
	        
	        // 엑셀 헤더 설정
			String [] strDiv = param.getValues("CD_DIVISION");
			int colIdx = 2;
			
			hCell = headerRow1.createCell(colIdx);
			for(int i = 0; i < strDiv.length; i++){
				if(strDiv[i].equals("01")){
					hCell = headerRow1.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("S분류");
					headerRow1.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		0, //first row (0-based)
		            		0, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("이물질");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;

				}else if(strDiv[i].equals("02")){
					hCell = headerRow1.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("1분류");
					for(int h = 1; h < 8; h++){
						headerRow1.createCell(colIdx+h).setCellStyle(hCellStyle);						
					}
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		0, //first row (0-based)
		            		0, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+7  //last column  (0-based)
		            ));
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("Critical");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("제품");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("미스패킹");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("서비스/불친절");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;
					
				}else if(strDiv[i].equals("03")){
					
					hCell = headerRow1.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("2분류");
					for(int h = 1; h < 4; h++){
						headerRow1.createCell(colIdx+h).setCellStyle(hCellStyle);
					}
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		0, //first row (0-based)
		            		0, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+3  //last column  (0-based)
		            ));
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("SOS");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("청결");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;

				}else if(strDiv[i].equals("04")){
					
					hCell = headerRow1.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("3분류");
					headerRow1.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		0, //first row (0-based)
		            		0, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					
					hCell = headerRow2.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("매장이용불편");
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		1, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;
					
				}else{
					
					hCell = headerRow1.createCell(colIdx);
					hCell.setCellStyle(hCellStyle);
					hCell.setCellValue("기타");
					headerRow1.createCell(colIdx+1).setCellStyle(hCellStyle);
					headerRow2.createCell(colIdx).setCellStyle(hCellStyle);
					headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
					// 셀 병합
		    		sheet.addMergedRegion(new CellRangeAddress(
		            		0, //first row (0-based)
		            		1, //last row  (0-based)
		            		colIdx, //first column (0-based)
		            		colIdx+1  //last column  (0-based)
		            ));
					colIdx += 2;

				}
			}
			
			hCell = headerRow1.createCell(colIdx);
			hCell.setCellStyle(hCellStyle);
			hCell.setCellValue("소계");
			headerRow1.createCell(colIdx+1).setCellStyle(hCellStyle);
			headerRow2.createCell(colIdx).setCellStyle(hCellStyle);
			headerRow2.createCell(colIdx+1).setCellStyle(hCellStyle);
			// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		1, //last row  (0-based)
            		colIdx, //first column (0-based)
            		colIdx+1  //last column  (0-based)
            ));
			colIdx += 2;

			// 직/가맹 헤더 추가
			for(int i = 2; i < colIdx; i++){
				hCell = headerRow3.createCell(i);
				hCell.setCellStyle(hCellStyle);
				if( i % 2 == 0){
					hCell.setCellValue("직영");
				}else{
					hCell.setCellValue("가맹");
				}
			}

			hCell = headerRow1.createCell(colIdx);
			hCell.setCellStyle(hCellStyle);
			hCell.setCellValue("합계");
			headerRow2.createCell(colIdx).setCellStyle(hCellStyle);
			headerRow3.createCell(colIdx).setCellStyle(hCellStyle);
			// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		2, //last row  (0-based)
            		colIdx, //first column (0-based)
            		colIdx  //last column  (0-based)
            ));

	        // 엑셀 틀 고정
	        sheet.createFreezePane(0, 3);

	        HSSFRow row;
	        HSSFCell cell;
	        int rownum = 3;
	        
	        
	        int repeatCount = 0;
			if( ( page*rowCountPerPage ) <= totalRowCount){
				repeatCount = rowCountPerPage;
			}else if((page*rowCountPerPage -rowCountPerPage) < totalRowCount){
				repeatCount = totalRowCount % rowCountPerPage ;
			}else{
				repeatCount = 0;
			}
			
			int rCnt = repeatCount+(page*rowCountPerPage)-rowCountPerPage;
			int [] divSum = new int[((colIdx-3)/2)+1];		// 구분계
			int allSum = 0;			// 합계
			
			// row 생성 시작
			for (int i = (page*rowCountPerPage)-rowCountPerPage ; 
					 i < rCnt;
					 i++ ,rownum++) {
				row = sheet.createRow(rownum);
	            
	        	if(list.getRow(i) == null) continue;
	        	
	        	// 지역명 , 소계 설정		===============================================================
	        	String divNm1 = ""+list.getRow(i).get("DISTRCT_NM_1");
            	String divNm2 = ""+list.getRow(i).get("DISTRCT_NM_2");
            	
            	String strValue = "";
            	HSSFCellStyle cellStyle = cellStyle2;
            	
                if("null".equals(divNm2) || "NULL".equals(divNm2) ){
                	strValue = "";
                }else if(divNm1.equals("ALLSUM")){
                	strValue = "소계";
                	cell = row.createCell(0);
                	cell.setCellStyle(cellStyle);
                	cell.setCellValue(strValue);
                	row.createCell(1).setCellStyle(cellStyle);
                	sheet.addMergedRegion(new CellRangeAddress(
                			rownum, //first row (0-based)
                			rownum, //last row  (0-based)
                    		0, //first column (0-based)
                    		1  //last column  (0-based)
                    ));
                	
                }else if(divNm2.equals("SUM")){
                	strValue = divNm1+"계";
                	cell = row.createCell(0);
                	cell.setCellStyle(cellStyle);
                	cell.setCellValue(strValue);
                	row.createCell(1).setCellStyle(cellStyle);
                	sheet.addMergedRegion(new CellRangeAddress(
                			rownum, //first row (0-based)
                			rownum, //last row  (0-based)
                    		0, //first column (0-based)
                    		1  //last column  (0-based)
                    ));
                	
                }else{
                	cellStyle = cellStyle1;
                	strValue = "" + divNm2;
                	cell = row.createCell(0);
                	cell.setCellStyle(cellStyle1);
                	cell.setCellValue(strValue);
                }
                
            	// 지역명 , 소계 설정 end		===============================================================
            	
            	// AS 컬럼
            	cell = row.createCell(1);
            	cell.setCellStyle(cellStyle1);
            	cell.setCellValue("");
				
            	
	        	// 통계 데이터 생성	===============================================================
            	int colNum = 2;
        		for(int z = 0; z < strDiv.length; z++){
        			// S분류
    				if(strDiv[z].equals("01")){
    					for (int j = 2; j < 4; j++) {
    						String colNm = list.getColumnNames()[j];
    						cell = row.createCell(colNum++);
        	                String value = ""+list.getRow(i).get(colNm);
        	                if("null".equals(value) || "NULL".equals(value) ){
        	                	value = "";
        	                }
                        	cell.setCellStyle(cellStyle);
        					cell.setCellValue(value);
    					}
    				}else if(strDiv[z].equals("02")){
    					for (int j = 4; j < 12; j++) {
    						String colNm = list.getColumnNames()[j];
    						cell = row.createCell(colNum++);
        	                String value = ""+list.getRow(i).get(colNm);
        	                if("null".equals(value) || "NULL".equals(value) ){
        	                	value = "";
        	                }
                        	cell.setCellStyle(cellStyle);
        					cell.setCellValue(value);
    					}
    				}else if(strDiv[z].equals("03")){
    					for (int j = 12; j < 16; j++) {
    						String colNm = list.getColumnNames()[j];
    						cell = row.createCell(colNum++);
        	                String value = ""+list.getRow(i).get(colNm);
        	                if("null".equals(value) || "NULL".equals(value) ){
        	                	value = "";
        	                }
                        	cell.setCellStyle(cellStyle);
        					cell.setCellValue(value);
    					}
    				}else if(strDiv[z].equals("04")){
    					for (int j = 16; j < 18; j++) {
    						String colNm = list.getColumnNames()[j];
    						cell = row.createCell(colNum++);
        	                String value = ""+list.getRow(i).get(colNm);
        	                if("null".equals(value) || "NULL".equals(value) ){
        	                	value = "";
        	                }
                        	cell.setCellStyle(cellStyle);
        					cell.setCellValue(value);
    					}
    				}else{
    					for (int j = 18; j < 20; j++) {
    						String colNm = list.getColumnNames()[j];
    						cell = row.createCell(colNum++);
        	                String value = ""+list.getRow(i).get(colNm);
        	                if("null".equals(value) || "NULL".equals(value) ){
        	                	value = "";
        	                }
                        	cell.setCellStyle(cellStyle);
        					cell.setCellValue(value);
    					}
    				}
    			}
        		
        		// 소계 & 합계 셀 생성
        		for (int j = 20; j < 23; j++) {
        			String colNm = list.getColumnNames()[j];
					cell = row.createCell(colNum);
	                String value = ""+list.getRow(i).get(colNm);
	                if("null".equals(value) || "NULL".equals(value) ){
	                	value = "";
	                }
                	cell.setCellStyle(cellStyle);
					cell.setCellValue(value);
					// 맨 마지막 열
        			if(i == rCnt-1){
        				// 총합
        				allSum = Integer.parseInt(list.getRow(i).get("DATA21").toString());
        				allSum += Integer.parseInt(etcList.getString(0, "DATA10"));

        				if(j == 22){
        					cell.setCellValue(allSum);
        					for(int h = rownum+1; h < rownum+5; h++){
        						row = sheet.createRow(h);
        						row.createCell(colNum).setCellStyle(cellStyle2);
        					}
        					sheet.addMergedRegion(new CellRangeAddress(
                        			rownum, //first row (0-based)
                        			rownum+4, //last row  (0-based)
                        			colNum, //first column (0-based)
                        			colNum  //last column  (0-based)
                            ));
        				}
        			}
        			colNum++;
				}
        		
        		// 구분계 계산
    			// 마지막 열 일 때의 소계를 가지고 계산
        		if(i == rCnt-1){
        			int z = 0;
        			int value = 0;
        			for(int zz = 0; zz < strDiv.length; zz++){
        				switch (strDiv[zz]) {
    					case "01":
    						for(int j = 2; j < 4; j++){
    	        				String colNm = list.getColumnNames()[j];
    	        				if(j%2 == 1){
    	        					value += Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        					divSum[z] = value;
    	        					z++;
    	        				}else{
    	        					value  = Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        				}
    	        			}
    						break;
    					case "02":
    						for(int j = 4; j < 12; j++){
    	        				String colNm = list.getColumnNames()[j];
    	        				if(j%2 == 1){
    	        					value += Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        					divSum[z] = value;
    	        					z++;
    	        				}else{
    	        					value  = Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        				}
    	        			}
    						break;
    					case "03":
    						for(int j = 12; j < 16; j++){
    	        				String colNm = list.getColumnNames()[j];
    	        				if(j%2 == 1){
    	        					value += Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        					divSum[z] = value;
    	        					z++;
    	        				}else{
    	        					value  = Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        				}
    	        			}
    						break;
    					case "04":
    						for(int j = 16; j < 18; j++){
    	        				String colNm = list.getColumnNames()[j];
    	        				if(j%2 == 1){
    	        					value += Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        					divSum[z] = value;
    	        					z++;
    	        				}else{
    	        					value  = Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        				}
    	        			}
    						break;
    					case "05":
    						for(int j = 18; j < 20; j++){
    	        				String colNm = list.getColumnNames()[j];
    	        				if(j%2 == 1){
    	        					value += Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        					divSum[z] = value;
    	        					z++;
    	        				}else{
    	        					value  = Integer.parseInt(list.getRow(i).get(colNm).toString());
    	        				}
    	        			}
    						break;
    					}
        			}
        			
        			
        		}
	        }
			
			// 기타 로우 생성
			row = sheet.createRow(rownum);
    		cell = row.createCell(0);
    		cell.setCellValue("기타");
    		cell.setCellStyle(cellStyle2);
    		row.createCell(1).setCellStyle(cellStyle2);
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
    				rownum, //first row (0-based)
    				rownum, //last row  (0-based)
                    0, //first column (0-based)
                    1  //last column  (0-based)
            ));
			colIdx = 2;
			int divSumIdx = 0;
			for(int i = 0; i < strDiv.length; i++){
				switch (strDiv[i]) {
					case "01":
						cell = row.createCell(colIdx);
			        	cell.setCellStyle(cellStyle2);
			        	cell.setCellValue(etcList.getString(0, etcList.getColumnNames()[0]));
			        	divSum[divSumIdx] += Integer.parseInt(etcList.getString(0, etcList.getColumnNames()[0]));
						row.createCell(colIdx+1).setCellStyle(cellStyle2);
						
						sheet.addMergedRegion(new CellRangeAddress(
		            			rownum, //first row (0-based)
		            			rownum, //last row  (0-based)
		            			colIdx, //first column (0-based)
		            			colIdx+1  //last column  (0-based)
		                ));
						colIdx += 2;
						divSumIdx++;
						break;
					case "02":
						for(int j = 1; j < 5; j++,colIdx += 2,divSumIdx++){
							cell = row.createCell(colIdx);
				        	cell.setCellStyle(cellStyle2);
				        	cell.setCellValue(etcList.getString(0, etcList.getColumnNames()[j]));
							row.createCell(colIdx+1).setCellStyle(cellStyle2);
							divSum[divSumIdx] += Integer.parseInt(etcList.getString(0, etcList.getColumnNames()[j]));
							
							sheet.addMergedRegion(new CellRangeAddress(
			            			rownum, //first row (0-based)
			            			rownum, //last row  (0-based)
			            			colIdx, //first column (0-based)
			            			colIdx+1  //last column  (0-based)
			                ));
						}
						break;
					case "03":
						for(int j = 5; j < 7; j++,colIdx += 2,divSumIdx++){
							cell = row.createCell(colIdx);
				        	cell.setCellStyle(cellStyle2);
				        	cell.setCellValue(etcList.getString(0, etcList.getColumnNames()[j]));
							row.createCell(colIdx+1).setCellStyle(cellStyle2);
							divSum[divSumIdx] += Integer.parseInt(etcList.getString(0, etcList.getColumnNames()[j]));
							
							sheet.addMergedRegion(new CellRangeAddress(
			            			rownum, //first row (0-based)
			            			rownum, //last row  (0-based)
			            			colIdx, //first column (0-based)
			            			colIdx+1  //last column  (0-based)
			                ));
						}
						break;
					case "04":
						cell = row.createCell(colIdx);
			        	cell.setCellStyle(cellStyle2);
			        	cell.setCellValue(etcList.getString(0, etcList.getColumnNames()[7]));
						row.createCell(colIdx+1).setCellStyle(cellStyle2);
						divSum[divSumIdx] += Integer.parseInt(etcList.getString(0, etcList.getColumnNames()[7]));
						
						sheet.addMergedRegion(new CellRangeAddress(
		            			rownum, //first row (0-based)
		            			rownum, //last row  (0-based)
		            			colIdx, //first column (0-based)
		            			colIdx+1  //last column  (0-based)
		                ));
						colIdx += 2;
						divSumIdx++;
						break;
					case "05":
						cell = row.createCell(colIdx);
			        	cell.setCellStyle(cellStyle2);
			        	cell.setCellValue(etcList.getString(0, etcList.getColumnNames()[8]));
						row.createCell(colIdx+1).setCellStyle(cellStyle2);
						divSum[divSumIdx] += Integer.parseInt(etcList.getString(0, etcList.getColumnNames()[8]));
						
						sheet.addMergedRegion(new CellRangeAddress(
		            			rownum, //first row (0-based)
		            			rownum, //last row  (0-based)
		            			colIdx, //first column (0-based)
		            			colIdx+1  //last column  (0-based)
		                ));
						colIdx += 2;
						divSumIdx++;
						break;
				}
			}
			cell = row.createCell(colIdx);
        	cell.setCellStyle(cellStyle2);
        	cell.setCellValue(etcList.getString(0, "DATA10"));
			row.createCell(colIdx+1).setCellStyle(cellStyle2);

			sheet.addMergedRegion(new CellRangeAddress(
        			rownum, //first row (0-based)
        			rownum, //last row  (0-based)
        			colIdx, //first column (0-based)
        			colIdx+1  //last column  (0-based)
            ));
			rownum++;

			
    		
    		// 구분계 로우 생성
			row = sheet.createRow(rownum);
    		cell = row.createCell(0);
    		cell.setCellValue("구분계");
    		cell.setCellStyle(cellStyle2);
    		row.createCell(1).setCellStyle(cellStyle2);
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
    				rownum, //first row (0-based)
    				rownum, //last row  (0-based)
                    0, //first column (0-based)
                    1  //last column  (0-based)
            ));
			colIdx = 2;
			for(int i = 0; i < divSum.length;i++,colIdx += 2){
				cell = row.createCell(colIdx);
	        	cell.setCellStyle(cellStyle2);
	        	cell.setCellValue(divSum[i]);
	        	if(i == divSum.length-1){
	        		cell.setCellValue(allSum);
        			row.createCell(colIdx+1).setCellStyle(cellStyle2);
        			row.createCell(colIdx+2).setCellStyle(cellStyle2);
					sheet.addMergedRegion(new CellRangeAddress(
	            			rownum, //first row (0-based)
	            			rownum+2, //last row  (0-based)
	            			colIdx, //first column (0-based)
	            			colIdx+1  //last column  (0-based)
	                ));
				}else{
					row.createCell(colIdx+1).setCellStyle(cellStyle2);
					sheet.addMergedRegion(new CellRangeAddress(
	            			rownum, //first row (0-based)
	            			rownum, //last row  (0-based)
	            			colIdx, //first column (0-based)
	            			colIdx+1  //last column  (0-based)
	                ));
				}
			}
			rownum++;
			
			//분류계 로우 생성
			row = sheet.createRow(rownum);
    		cell = row.createCell(0);
    		cell.setCellValue("분류계");
    		cell.setCellStyle(cellStyle2);
    		row.createCell(1).setCellStyle(cellStyle2);
    		sheet.addMergedRegion(new CellRangeAddress(
        			rownum, //first row (0-based)
        			rownum, //last row  (0-based)
        			0, //first column (0-based)
        			1  //last column  (0-based)
            ));
			int divIdx = 0;
			int classColIdx = 2;
			int classSum = 0;
			for(int i = 0; i < strDiv.length; i++){
				switch (strDiv[i]) {
				case "01":
					classSum = divSum[0];						
					cell = row.createCell(classColIdx);
		    		cell.setCellValue(classSum);
		    		cell.setCellStyle(cellStyle2);
		    		row.createCell(classColIdx+1).setCellStyle(cellStyle2);
		    		//분류계 셀 병합
					sheet.addMergedRegion(new CellRangeAddress(
		        			rownum, //first row (0-based)
		        			rownum, //last row  (0-based)
		        			2, //first column (0-based)
		        			3  //last column  (0-based)
		            ));
		    		classColIdx += 2;
		    		divIdx++;
					break;
				case "02":
					classSum = 0;
					for(int j = divIdx; j < divIdx+4; j++){
						classSum += divSum[j];
					}
					cell = row.createCell(classColIdx);
		    		cell.setCellValue(classSum);
		    		cell.setCellStyle(cellStyle2);
		    		for(int h=1; h < 8; h++){
		    			row.createCell(classColIdx+h).setCellStyle(cellStyle2);
		    		}
		    		//분류계 로우 생성
					sheet.addMergedRegion(new CellRangeAddress(
		        			rownum, //first row (0-based)
		        			rownum, //last row  (0-based)
		        			classColIdx, //first column (0-based)
		        			classColIdx+7  //last column  (0-based)
		            ));
		    		classColIdx += 8;
		    		divIdx += 4;
					break;
				case "03":
					classSum = 0;
					for(int j = divIdx; j < divIdx+2; j++){
						classSum += divSum[j];
					}
					cell = row.createCell(classColIdx);
		    		cell.setCellValue(classSum);
		    		cell.setCellStyle(cellStyle2);
		    		for(int h = 1; h < 4; h++){
		    			row.createCell(classColIdx+h).setCellStyle(cellStyle2);
		    		}
		    		//분류계 로우 생성
					sheet.addMergedRegion(new CellRangeAddress(
		        			rownum, //first row (0-based)
		        			rownum, //last row  (0-based)
		        			classColIdx, //first column (0-based)
		        			classColIdx+3  //last column  (0-based)
		            ));
		    		classColIdx += 4;
		    		divIdx += 2;
					break;
				case "04":
					classSum = divSum[divIdx];
					cell = row.createCell(classColIdx);
		    		cell.setCellValue(classSum);
		    		cell.setCellStyle(cellStyle2);
		    		row.createCell(classColIdx+1).setCellStyle(cellStyle2);
		    		//분류계 로우 생성
					sheet.addMergedRegion(new CellRangeAddress(
		        			rownum, //first row (0-based)
		        			rownum, //last row  (0-based)
		        			classColIdx, //first column (0-based)
		        			classColIdx+1  //last column  (0-based)
		            ));
		    		classColIdx += 2;
		    		divIdx++;
					break;
				case "05":
					classSum = divSum[divIdx];
					cell = row.createCell(classColIdx);
		    		cell.setCellValue(classSum);
		    		cell.setCellStyle(cellStyle2);
		    		row.createCell(classColIdx+1).setCellStyle(cellStyle2);
		    		//분류계 로우 생성
					sheet.addMergedRegion(new CellRangeAddress(
		        			rownum, //first row (0-based)
		        			rownum, //last row  (0-based)
		        			classColIdx, //first column (0-based)
		        			classColIdx+1  //last column  (0-based)
		            ));
		    		classColIdx += 2;
		    		divIdx++;
					break;
				}
			}
			
			row.createCell(classColIdx).setCellStyle(cellStyle2);
			row.createCell(classColIdx+1).setCellStyle(cellStyle2);
			row.createCell(classColIdx+2).setCellStyle(cellStyle2);
			rownum++;

    		// 합계 로우 생성			
			row = sheet.createRow(rownum);
    		cell = row.createCell(0);
    		cell.setCellValue("합계");
    		cell.setCellStyle(cellStyle2);
    		row.createCell(1).setCellStyle(cellStyle2);
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
    				rownum, //first row (0-based)
    				rownum, //last row  (0-based)
                    0, //first column (0-based)
                    1  //last column  (0-based)
            ));
    		cell = row.createCell(2);
    		cell.setCellValue(allSum);
    		cell.setCellStyle(cellStyle2);
    		for(int h=1; h < colIdx-1; h++){
    			row.createCell(2+h).setCellStyle(cellStyle2);
    		}
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
    				rownum, //first row (0-based)
    				rownum, //last row  (0-based)
                    2, //first column (0-based)
                    colIdx-3  //last column  (0-based)
            ));
			// row 생성 end ======================================================================================================


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
	 * 유형-기간별 VOC 통계 엑셀 다운로드
	 * @param param 검색조건
	 * @return 엑셀 다운로드
	 */
	public String getCauseVocExcelDown(Parameter param) throws Exception{

		String key = "";

		DataList list = anaDAO.getCauseVocExcelDown(param);
		
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
    		
    		hCellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
    		hCellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
    		hCellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
    		hCellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
    		
    		hCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
    		hCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    		
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
    		
    		cellStyle1.setTopBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle1.setBottomBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle1.setLeftBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle1.setRightBorderColor(IndexedColors.BLACK.getIndex());
    		
    		cellStyle1.setAlignment(CellStyle.ALIGN_CENTER);           
    		cellStyle1.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    		
    		
    		cellStyle2.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
    		cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
    		
    		cellStyle2.setBorderTop(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderBottom(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderLeft(CellStyle.BORDER_THIN);
    		cellStyle2.setBorderRight(CellStyle.BORDER_THIN);
    		
    		cellStyle2.setTopBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle2.setBottomBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle2.setLeftBorderColor(IndexedColors.BLACK.getIndex());
    		cellStyle2.setRightBorderColor(IndexedColors.BLACK.getIndex());
    		
    		cellStyle2.setAlignment(CellStyle.ALIGN_CENTER);           
    		cellStyle2.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
    		
    		HSSFSheet sheet = wb.createSheet();
    		
    		HSSFRow headerRow = sheet.createRow(0);
    		String[] titles = list.getColumnNames();
    		
    		DataList headerList = anaDAO.getMonthHeader(param);
    		String yymm = "";
    		
    		for (int i = 0; i < 3; i++) {
	        	HSSFCell cell = headerRow.createCell(i);
            	cell = headerRow.createCell(i);
            	cell.setCellStyle(hCellStyle);
	            cell.setCellValue(titles[i]);
	        }
    		
            
    		for (int i = 0; i < 12; i++) {
    			HSSFCell cell = headerRow.createCell(i+3);
    			sheet.setColumnWidth((short)(i+3), (short)3500);
            	cell.setCellStyle(hCellStyle);
            	yymm = headerList.get(0, i).toString();
	            cell.setCellValue(yymm.substring(0, 4)+"년 "+ yymm.substring(4,6)+"월");
	        }
			
	        // 엑셀 틀 고정
	        sheet.createFreezePane(0, 1);
	        sheet.setColumnWidth((short)1, (short)5000);

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
			
			int rCnt = repeatCount+(page*rowCountPerPage)-rowCountPerPage;
			
			String flag = "Y";
			
			// row 생성 시작
			for (int i = (page*rowCountPerPage)-rowCountPerPage ; 
					 i < rCnt;
					 i++ ,rownum++) {
				
				flag = "Y";

				if("전체".equals(list.getRow(i).get("유형"))){
	        		row = sheet.createRow(1);
	        	}else{
	        		row = sheet.createRow(rownum);
	        	}
				
	        	if(list.getRow(i) == null) continue;
	        	
	        	for (int j = 0; j < list.getRow(i).size(); j++) {
	                cell = row.createCell(j);
	                String value = ""+list.getRow(i).get(titles[j]);
	                if("null".equals(value) || "NULL".equals(value) ){
	                	value = "";
	                }
	                
	                
	                if("소계".equals(value)||flag == "N"){
	                	cell.setCellStyle(cellStyle2);
	                	flag = "N";
	                }else if("전체".equals(value)){
	                	flag = "N";
	                	cell.setCellStyle(cellStyle2);
	                	// 셀 병합
	            		sheet.addMergedRegion(new CellRangeAddress(
	                    		1, //first row (0-based)
	                    		1, //last row  (0-based)
	                            0, //first column (0-based)
	                            1  //last column  (0-based)
	                    ));
	                }else if(flag.equals("Y")){
	                	cell.setCellStyle(cellStyle1);
	                }
					cell.setCellValue(value);
	            }
	        }
			
			// row 생성 end ======================================================================================================


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
	 * 매장-월별 VOC현황 엑셀 다운로드
	 * @param param 검색조건
	 * @return 엑셀 다운로드
	 */
	public String getStoreVocAnaExcel(Parameter param) throws Exception{
		
		String key = "";
		
		DataList list = anaDAO.getStoreVocAnaExcel(param);
		
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
			
			hCellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
			hCellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			hCellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			hCellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
			
			hCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
			hCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
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
			
			cellStyle1.setTopBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle1.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle1.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle1.setRightBorderColor(IndexedColors.BLACK.getIndex());
			
			cellStyle1.setAlignment(CellStyle.ALIGN_CENTER);           
			cellStyle1.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			
			cellStyle2.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
			cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
			
			cellStyle2.setBorderTop(CellStyle.BORDER_THIN);
			cellStyle2.setBorderBottom(CellStyle.BORDER_THIN);
			cellStyle2.setBorderLeft(CellStyle.BORDER_THIN);
			cellStyle2.setBorderRight(CellStyle.BORDER_THIN);
			
			cellStyle2.setTopBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle2.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle2.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle2.setRightBorderColor(IndexedColors.BLACK.getIndex());
			
			cellStyle2.setAlignment(CellStyle.ALIGN_CENTER);           
			cellStyle2.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			HSSFSheet sheet = wb.createSheet();
			
			HSSFRow headerRow = sheet.createRow(0);
			String[] titles = list.getColumnNames();
			
			DataList headerList = anaDAO.getMonthHeader(param);
			String yymm = "";
			
			for (int i = 0; i < 2; i++) {
				HSSFCell cell = headerRow.createCell(i);
				cell = headerRow.createCell(i);
				cell.setCellStyle(hCellStyle);
				cell.setCellValue(titles[i]);
			}
			
			
			for (int i = 0; i < 12; i++) {
				HSSFCell cell = headerRow.createCell(i+2);
				sheet.setColumnWidth((short)(i+2), (short)3500);
				cell.setCellStyle(hCellStyle);
				yymm = headerList.get(0, i).toString();
				cell.setCellValue(yymm.substring(0, 4)+"년 "+ yymm.substring(4,6)+"월");
			}
			
			// 엑셀 틀 고정
			sheet.createFreezePane(0, 1);
			sheet.setColumnWidth(0, 5000);
			
			HSSFRow row;
			HSSFCell cell;
			int rownum = 1;
			
			int repeatCount = 0;
			if( ( page*rowCountPerPage ) <= totalRowCount){
				repeatCount = rowCountPerPage;
			}else if((page*rowCountPerPage -rowCountPerPage) < totalRowCount){
				repeatCount = totalRowCount % rowCountPerPage ;
			}else{
				repeatCount = 0;
			}
			
			int rCnt = repeatCount+(page*rowCountPerPage)-rowCountPerPage;
			
			String flag = "Y";
			
			// row 생성 시작
			for (int i = (page*rowCountPerPage)-rowCountPerPage ; 
					i < rCnt;
					i++ ,rownum++) {
				
				flag = "Y";
				
				row = sheet.createRow(rownum);
				
				if(list.getRow(i) == null) continue;
				
				for (int j = 0; j < list.getRow(i).size(); j++) {
					cell = row.createCell(j);
					String value = ""+list.getRow(i).get(titles[j]);
					if("null".equals(value) || "NULL".equals(value) ){
						value = "";
					}
					
					if("SUM".equals(value)){
						cell.setCellStyle(cellStyle2);
						cell.setCellValue("전체");
						flag = "N";

					}else if(flag == "N" || titles[j].equals("전체")){
						cell.setCellStyle(cellStyle2);
						cell.setCellValue(value);

					}else if(flag.equals("Y")){
						cell.setCellStyle(cellStyle1);
						cell.setCellValue(value);

					}
				}
			}
			
			// row 생성 end ======================================================================================================
			
			
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
	 * 고객속성별 VOC현황 엑셀 다운로드
	 * @param param 검색조건
	 * @return 엑셀 다운로드
	 */
	public String getCustAttrVocExcel(Parameter param) throws Exception{
		
		String key = "";
		
		DataList list = anaDAO.getCustAttrVocExcel(param);
		
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
			
			hCellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
			hCellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			hCellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			hCellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
			
			hCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
			hCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
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
			
			cellStyle1.setTopBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle1.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle1.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle1.setRightBorderColor(IndexedColors.BLACK.getIndex());
			
			cellStyle1.setAlignment(CellStyle.ALIGN_CENTER);           
			cellStyle1.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			
			cellStyle2.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
			cellStyle2.setFillPattern(CellStyle.SOLID_FOREGROUND);
			
			cellStyle2.setBorderTop(CellStyle.BORDER_THIN);
			cellStyle2.setBorderBottom(CellStyle.BORDER_THIN);
			cellStyle2.setBorderLeft(CellStyle.BORDER_THIN);
			cellStyle2.setBorderRight(CellStyle.BORDER_THIN);
			
			cellStyle2.setTopBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle2.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle2.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			cellStyle2.setRightBorderColor(IndexedColors.BLACK.getIndex());
			
			cellStyle2.setAlignment(CellStyle.ALIGN_CENTER);           
			cellStyle2.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

			HSSFSheet sheet = wb.createSheet();

			// 헤더 설정 start *************************************************
			
			HSSFRow headerRow1 = sheet.createRow(0);
    		HSSFRow headerRow2 = sheet.createRow(1);
			String[] titles = list.getColumnNames();
			
			for (int i = 0; i < 3; i++) {

				HSSFCell cell = headerRow1.createCell(i);
				cell = headerRow1.createCell(i);
				cell.setCellStyle(hCellStyle);
				cell.setCellValue(titles[i]);
				
				// 셀 병합
	    		sheet.addMergedRegion(new CellRangeAddress(
	            		0, //first row (0-based)
	            		1, //last row  (0-based)
	                    i, //first column (0-based)
	                    i  //last column  (0-based)
	            ));
			}
			
			for(int i = 3; i < 6; i++){
    			HSSFCell cell = headerRow1.createCell(i);
    			cell = headerRow1.createCell(i);
    			cell.setCellStyle(hCellStyle);
    			cell.setCellValue("멤버십");
    		}
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		0, //last row  (0-based)
                    3, //first column (0-based)
                    5  //last column  (0-based)
            ));
    		
    		
    		for(int i = 6; i < 8; i++){
    			HSSFCell cell = headerRow1.createCell(i);
    			cell = headerRow1.createCell(i);
    			cell.setCellStyle(hCellStyle);
    			cell.setCellValue("성별");
    		}
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		0, //last row  (0-based)
                    6, //first column (0-based)
                    7  //last column  (0-based)
            ));
    		
    		for(int i = 8; i < 14; i++){
    			HSSFCell cell = headerRow1.createCell(i);
    			cell = headerRow1.createCell(i);
    			cell.setCellStyle(hCellStyle);
    			cell.setCellValue("연령대");
    		}
    		// 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		0, //first row (0-based)
            		0, //last row  (0-based)
                    8, //first column (0-based)
                    13  //last column  (0-based)
            ));
			
			for(int i = 3; i < titles.length; i++){
				HSSFCell cell = headerRow2.createCell(i);
				cell = headerRow2.createCell(i);
				cell.setCellStyle(hCellStyle);
				cell.setCellValue(titles[i]);
			}
			// 헤더 설정 end *************************************************
			
			// 엑셀 틀 고정
			sheet.createFreezePane(0, 2);
			sheet.setColumnWidth(1, 5000);
			
			HSSFRow row;
			HSSFCell cell;
			int rownum = 3;
			
			int repeatCount = 0;
			if( ( page*rowCountPerPage ) <= totalRowCount){
				repeatCount = rowCountPerPage;
			}else if((page*rowCountPerPage -rowCountPerPage) < totalRowCount){
				repeatCount = totalRowCount % rowCountPerPage ;
			}else{
				repeatCount = 0;
			}
			
			int rCnt = repeatCount+(page*rowCountPerPage)-rowCountPerPage;
			
			String flag = "Y";
			
			// row 생성 시작
			for (int i = (page*rowCountPerPage)-rowCountPerPage ; 
					i < rCnt;
					i++ ,rownum++) {
				
				flag = "Y";
				
				if("전체".equals(list.getRow(i).get("구분"))){
					row = sheet.createRow(2);
				}else{
					row = sheet.createRow(rownum);					
				}
				
				
				if(list.getRow(i) == null) continue;
				
				for (int j = 0; j < list.getRow(i).size(); j++) {
					cell = row.createCell(j);
					String value = ""+list.getRow(i).get(titles[j]);
					if("null".equals(value) || "NULL".equals(value) ){
						value = "";
					}
					
					if(flag == "N" || value.equals("소계") || value.equals("전체")){
						cell.setCellStyle(cellStyle2);
						cell.setCellValue(value);
						flag = "N";

					}else if(flag.equals("Y")){
						cell.setCellStyle(cellStyle1);
						cell.setCellValue(value);

					}
				}
			}
			// '전체' 셀 병합
    		sheet.addMergedRegion(new CellRangeAddress(
            		2, //first row (0-based)
            		2, //last row  (0-based)
                    0, //first column (0-based)
                    1  //last column  (0-based)
            ));
			// row 생성 end ======================================================================================================
			
			
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
	
	
	
	
	
	
	
	


// ******************************************* 엑셀 다운로드에 필요한 함수
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
//	******************************************* 엑셀 다운로드에 필요한 함수	
}


