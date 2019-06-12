package com.ubone.framework.util.exporter;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Component;

/** 
 * <pre>
 *  설    명 : SXSSF workBook 을 기준으로 대용량도 메모리 문제 없도록 함.
 *         Default로 100 Row 까지는 메모리 영역을 활용하지만 100 Row 이상이면 temp Dist를 활용하여 엑셀을 만든다.
 *         
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.10.14
 *  변 경 자 : 김태완
 *  작 성 일 : 2017.11.21
 *  버    전 : 1.1
 *  기타사항 : 1.1 - SXSSFWorkSheet를 활용하도록 변경
 *              - 커스터마이즈즐 할 수 있도록 RowHandler 파라메터로 받는 추상 메소드 추가
 *                      
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
/**
 * @author tantlus
 *
 */
@Component
public class SXSSFExcelExporter extends ExcelExporterBase {
	
	public static String PETCH_INDEX = "petchIndex";
	public static String PETCH_SIZE = "petchSize";
	
	public String getFileType() {
		return "xlsx";
	}
	
	protected Workbook getWorkbook() {
		return new SXSSFWorkbook(1000);
	}

}