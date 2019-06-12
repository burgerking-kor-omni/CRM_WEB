package com.ubone.framework.util.exporter;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

/** 
 * <pre>
 *  파 일 명 : RowHandler.java
 *  설    명 : 엑셀을 4개의 영역으로 구분하여 로직을 구현할 수 있도록 메소드를 정의한다.
 *         headerRow / bodyRow 는 반복 부분을 구한다.
 *  작 성 자 : 김태완
 *  작 성 일 : 2017.11.21
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface RowHandler {
	
	/**
	 * row 단위의 data 로부터 추출한 parameter 를 저장소에 저장한다.
	 * @param parameter
	 * @param isIncludeKeyColumn
	 * @param rowIndex
	 * @return fetched count
	 */
	public int header(Workbook workbook , Sheet sheet);
	public void headerRow(Workbook workbook , Sheet sheet, Row row , int columnIndex , Object value);
	public void bodyRow(Workbook workbook , Sheet sheet, Row row , int columnIndex , Object value);
	public void footer(Workbook workbook , Sheet sheet, int rowIndex);
}