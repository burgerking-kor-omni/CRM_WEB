package com.ubone.framework.util.exporter;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFSheet;

import com.ubone.framework.util.ConverterUtil;

/** 
 * <pre>
 *  설    명 : 각 영역별 처리 로직을 구현하여 엑셀 변환 시 주입할 수 있도록 구현한 기본 구현 클래스
 *         커스터마이징 할 때 상위 클래스 역할을 한다.
 *  작 성 자 : 김태완
 *  작 성 일 : 2017.11.21
 *  변 경 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  기타사항 : 
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
/**
 * @author tantlus
 *
 */
/**
 * @author tantlus
 *
 */
public class DefaultRowHandler implements RowHandler {
	
	/* (non-Javadoc)
	 * 해더 영역 
	 * return int 해더영역에서 생성한 row 개수로 headerRow 영역의 첫번째 row를 생성할 때 필요함.
	 * @see com.ubone.framework.util.exporter.RowHandler#header(org.apache.poi.ss.usermodel.Workbook, org.apache.poi.ss.usermodel.Sheet)
	 */
	@Override
	public int header(Workbook workBook , Sheet sheet) {
		sheet.createFreezePane(0, 1); //첫행 틀고정
		int rowIndex = 0;
        return rowIndex;
	}
	/* (non-Javadoc)
	 * 반복 Row 의 title 영역
	 * @see com.ubone.framework.util.exporter.RowHandler#headerRow(org.apache.poi.ss.usermodel.Workbook, org.apache.poi.ss.usermodel.Sheet, org.apache.poi.ss.usermodel.Row, int, java.lang.Object)
	 */
	@Override
	public void headerRow(Workbook workBook , Sheet sheet, Row row, int columnIndex, Object value) {
		Cell cell = row.createCell(columnIndex);
        cell.setCellValue(ConverterUtil.stringOf(value));
	}
	
	/* (non-Javadoc)
	 * 반복 Row 의 영역  실제 데이터가 뿌려지는 영역
	 * @see com.ubone.framework.util.exporter.RowHandler#bodyRow(org.apache.poi.ss.usermodel.Workbook, org.apache.poi.ss.usermodel.Sheet, org.apache.poi.ss.usermodel.Row, int, java.lang.Object)
	 */
	@Override
	public void bodyRow(Workbook workBook, Sheet sheet, Row row, int columnIndex, Object value) {
		Cell cell = row.createCell(columnIndex);
        cell.setCellValue(ConverterUtil.stringOf(value));
	}

	/* (non-Javadoc)
	 * footer 영역으로 기본적으로 마지막 열의 넚이를 기준으로 자동으로 Cell 넓이를 맞춘다.
	 * 
	 * @see com.ubone.framework.util.exporter.RowHandler#footer(org.apache.poi.ss.usermodel.Workbook, org.apache.poi.ss.usermodel.Sheet, int)
	 */
	@Override
	public void footer(Workbook workbook, Sheet sheet, int rowIndex) {
		//마지막 row의  column size에 맞춰 column 사이즈를 자동으로 맞춤  
		((SXSSFSheet) sheet).trackAllColumnsForAutoSizing();
		short colsize = sheet.getRow(sheet.getLastRowNum()).getLastCellNum();
		for (int colnum = 0; colnum <= colsize; colnum++) {
			sheet.autoSizeColumn(colnum);
		}
	}
}
