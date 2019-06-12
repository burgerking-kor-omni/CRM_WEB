package com.ubone.example.excel.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.example.excel.dao.ExcelDataDAO;
import com.ubone.example.excel.impl.CustomRowHandler;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.exporter.DefaultRowHandler;
import com.ubone.framework.util.exporter.SXSSFExcelExporter;

/** 
 * <pre>
 *  파 일 명 : ExcelManageSO.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2017. 11. 16.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class ExcelManageSO {
	
	@Resource 
	SXSSFExcelExporter sxssfExcelExporter; 
	@Resource
	private ExcelDataDAO excelDataDAO;
	
	/**
	 * 기본 엑셀파일로 내려받기
	 * @param parameter 조회조건
	 * @return 엑셀 파일 호출 링크
	 */
	public String[] getDefaultExcel(Parameter parameter) {
		
		DataList excelList = excelDataDAO.getExcel(parameter);
		String[] doExport = sxssfExcelExporter.export(excelList, 20000 , new DefaultRowHandler());
		
		return doExport;
	}
	
	/**
	 * 엑셀 추가 기능 구현 필요 시
	 * @param parameter 조회조건
	 * @return 엑셀 파일 호출 링크
	 */
	public String[] getStyleExcel(Parameter parameter) {
		DataList excelList = excelDataDAO.getExcel(parameter);
		String[] doExport = sxssfExcelExporter.export(excelList, 20000 , new CustomRowHandler());
		return doExport;
	}
	/**
	 * 대용량 엑셀파일로 내려받기(petch)
	 * petchSize 만큼만 조회해서 엑셀을 만들기를 반복해서 하는경우 
	 * 주의사항 ## petchSize 만큼을 하나의 엑셀 파일로 만들도록 되어있음 
	 * @param parameter 조회조건
	 * @return 엑셀 파일 호출 링크
	 */
	public String[] getLargeCapacityExcel_petch(Parameter parameter) {
		
		int size = 20000;
		DataList dataList = null;
		parameter.setParameter(SXSSFExcelExporter.PETCH_SIZE, size);
		ArrayList<String> exportList = new ArrayList<String>();
		
		for (int i = 0;; i++) {
			parameter.setParameter(SXSSFExcelExporter.PETCH_INDEX, i);
			dataList = excelDataDAO.getLargeCapacityExcel_petch(parameter);
			exportList.add(sxssfExcelExporter.export(dataList, size , new DefaultRowHandler())[0]);
			if(dataList==null || dataList.size() == 0 || size != dataList.size()) {
				break;
			}
		}
		return exportList.toArray(new String[0]);
	}
	
	/**
	 * 대용량 엑셀파일로 내려받기(몽땅)
	 * @param parameter 조회조건
	 * @return 엑셀 파일 호출 링크
	 */
	public String[] getLargeCapacityExcel(Parameter parameter) {
		DataList excelList = excelDataDAO.getLargeCapacityExcel(parameter);
		
		int countForPage = 20000; //엑셀파일당 row 갯수
		String[] doExport = sxssfExcelExporter.export(excelList, countForPage , new DefaultRowHandler());

		return doExport;
	}
}