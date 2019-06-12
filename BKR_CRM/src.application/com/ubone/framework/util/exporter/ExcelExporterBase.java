package com.ubone.framework.util.exporter;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.security.util.AESUtils;
import com.ubone.framework.util.ConverterUtil;
import com.ubone.framework.web.util.ContextHolder;

/** 
 * <pre>
 *  설    명 : Excel format Exporter Base
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.10.14
 *  변 경 자 : 김태완
 *  변 경 일 : 2017.11.21
 *  버    전 : 1.1
 *  기타사항 : - SXSSFWorkSheet를 활용하도록 변경
 *          - 주입 받은 RowHandler 구현체를 활용하여 엑셀 생성한다. 
 *          - AES 암호화 로직으로 생성된 엑셀 파일을 fullpath 를 암호화 하여 return 한다. 
 *   
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public abstract class ExcelExporterBase extends AbstractExporter {
	
	private static final Log logger = LogFactory.getLog(ExcelExporterBase.class);
	
	protected abstract Workbook getWorkbook();
	
	/* (non-Javadoc)
	 * dataList 를 기준으로 엑셀을 생성한다.
	 * return String 암호화 된 엑셀파일 fullpath
	 * 
	 * @see com.ubone.framework.util.exporter.AbstractExporter#exportPage(com.ubone.framework.data.DataList, java.lang.String[], int)
	 */
	@Override
	protected String exportPage(DataList dataList, String[] headerNames, int currentPage) {
		Workbook workbook = getWorkbook();
		Sheet sheet = workbook.createSheet();
        sheet.createFreezePane(0, 1);

        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headerNames.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headerNames[i]);
        }
        
        int i = 1;
		for(Map<String, Object> map : dataList.getRows()) {
			Row row = sheet.createRow(i);
			int j = 0;
			for(Object value : map.values()) {
                Cell cell = row.createCell(j);
                cell.setCellValue(ConverterUtil.stringOf(value));
                j++;
			}
			i++;
        }
		
        return writeToFile(workbook, dataList.getId());
	}
	
	/* (non-Javadoc)
	 * dataList 를 기준으로 RowHandler를 활요하여  엑셀을 생성한다.
	 * return String 암호화 된 엑셀파일 fullpath
	 * 
	 * @see com.ubone.framework.util.exporter.AbstractExporter#exportPage(com.ubone.framework.data.DataList, java.lang.String[], int, com.ubone.framework.util.exporter.RowHandler)
	 */
	@Override
	protected String exportPage(DataList dataList, String[] headerNames, int currentPage, RowHandler rowHandler) {
		
		Workbook workbook = getWorkbook();
		Sheet sheet = workbook.createSheet();
		
		int rowIndex = rowHandler.header(workbook , sheet);
        
        Row headerRow = sheet.createRow(rowIndex++);
        
        for (int columnIndex = 0; columnIndex < headerNames.length; columnIndex++) {
        	rowHandler.headerRow(workbook , sheet , headerRow, columnIndex , headerNames[columnIndex]);
        }
        
		for(Map<String, Object> map : dataList.getRows()) {
			Row row = sheet.createRow(rowIndex++);
			
			int columnIndex = 0;
			for(Object value : map.values()) {
				rowHandler.bodyRow(workbook , sheet, row, columnIndex++ , value);
			}
        }
		

		rowHandler.footer(workbook, sheet, rowIndex);
		
        return writeToFile(workbook, dataList.getId());
	}

	/**
	 *  workbook 기준으로 엑셀을 파일로 생성한다.
	 * @param workbook 
	 * @param name 파일명
	 * @return Stirng AES 암호화 로직으로 생성된 엑셀 파일을 fullpath 를 암호화
	 */
	private String writeToFile(Workbook workbook, String name) {
		String filePath = getExportFilePath(name);
		FileOutputStream out = null;
		try {
			out = new FileOutputStream(ConfigHolder.UPLOAD_PATH + filePath);
	        try {
	        	workbook.write(out);
	        }
	        catch(IOException e) {
				throw new ExportException("error ocured when workbook object writing to file; ", e);
	        } finally {
	        	logger.info("getFileType() : " + getFileType());
	        	if("xlsx".equals(getFileType())){
	        		
	        		// 디스크 적었던 임시파일을 제거합니다.	
		        	((SXSSFWorkbook) workbook).dispose();
					try {
						workbook.close();
					} catch (Exception ignore) {
					}
	        	}
			}
		}
		catch (FileNotFoundException e) {
			throw new ExportException("file[paht=" + ConfigHolder.UPLOAD_PATH + filePath + "] is cannot be created, or cannot be opened for any other reason; ", e);
		}
		finally {
			try { if(out != null) {
					out.close();
				}
			}
			catch (IOException e) {
			}
		}
		
		return AESUtils.encrypt(ContextHolder.getRequest().getSession().getId(), filePath);
	}
}