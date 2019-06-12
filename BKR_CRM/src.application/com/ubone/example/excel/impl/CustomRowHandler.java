package com.ubone.example.excel.impl;

import java.util.Date;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.BuiltinFormats;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFCreationHelper;
import org.apache.poi.xssf.usermodel.XSSFFont;

import com.ubone.framework.util.ConverterUtil;
import com.ubone.framework.util.exporter.DefaultRowHandler;

public class CustomRowHandler extends DefaultRowHandler {
	
	@Override
	public int header(Workbook workBook , Sheet sheet) {
		
		Cell cell = null;
		Row row = null;
		CellStyle style = null;
		XSSFFont font = null;
		
		sheet.createFreezePane(0, 3);
		
		int rowIndex = 0;
		int columnIndex = 0 ;
		row = sheet.createRow(rowIndex++);
		
		cell = row.createCell(columnIndex++);
		
		style = workBook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setWrapText(false);
        style.setDataFormat((short) BuiltinFormats.getBuiltinFormat("text") );
        
        font = (XSSFFont)workBook.createFont();
        font.setFontHeightInPoints((short)18);
        font.setFontName("Arial");
        font.setColor(IndexedColors.BLACK.getIndex());
        font.setBold(true);
        font.setItalic(false);
        style.setFont(font);
        cell.setCellStyle(style);
        cell.setCellValue("sample");
        
        cell = row.createCell(columnIndex++);
		cell = row.createCell(columnIndex++);
        cell = row.createCell(columnIndex++);
        cell = row.createCell(columnIndex++);

        sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, 4));
		
        columnIndex = 0 ;
        row = sheet.createRow(rowIndex++);
        cell = row.createCell(columnIndex++);
		cell = row.createCell(columnIndex++);
        cell = row.createCell(columnIndex++);
        cell = row.createCell(columnIndex++);
		cell = row.createCell(columnIndex++);
		style = workBook.createCellStyle();
		SXSSFCreationHelper creationHelper = (SXSSFCreationHelper)workBook.getCreationHelper();
		style.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-mm-dd hh:mm:ss"));
		
		font = (XSSFFont)workBook.createFont();
        font.setFontHeightInPoints((short)10);
        font.setFontName("Arial");
        font.setColor(IndexedColors.BLACK.getIndex());
        font.setBold(true);
        font.setItalic(true);
        style.setFont(font);
		
		cell.setCellValue(new Date());
		cell.setCellStyle(style);
        
		return rowIndex;
	}
	
	@Override
	public void headerRow(Workbook workBook, Sheet sheet, Row row, int columnIndex, Object value) {
		
		switch (columnIndex) {
		case 0:
			sheet.setColumnWidth(columnIndex, 10000);
			break;
		case 1:
			sheet.setColumnWidth(columnIndex, 5000);
			break;
		case 2:
			sheet.setColumnWidth(columnIndex, 15000);
			break;
		case 3:
			sheet.setColumnWidth(columnIndex, 5000);
			break;
		case 4:
			sheet.setColumnWidth(columnIndex, 20000);
			break;
		default:
			sheet.setColumnWidth(columnIndex, 10000);
		}
		
		CellStyle style = workBook.createCellStyle();
		
        XSSFFont font = (XSSFFont)workBook.createFont();
        font.setFontHeightInPoints((short)10);
        font.setFontName("Arial");
        font.setColor(IndexedColors.BLACK.getIndex());
        font.setBold(true);
        font.setItalic(false);
        style.setFont(font);
        
        style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(BorderStyle.THIN);

		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(BorderStyle.THIN);
        
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(BorderStyle.THIN);
        
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderRight(BorderStyle.THIN);
        
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setWrapText(false);
        style.setDataFormat((short) BuiltinFormats.getBuiltinFormat("text") );
		
		Cell cell = row.createCell(columnIndex);
        cell.setCellValue(ConverterUtil.stringOf(value));
        cell.setCellStyle(style);
	
	}
	
	@Override
	public void footer(Workbook workbook, Sheet sheet, int rowIndex) {
	}
}
