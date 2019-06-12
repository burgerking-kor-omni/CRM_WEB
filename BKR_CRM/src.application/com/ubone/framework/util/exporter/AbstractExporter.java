package com.ubone.framework.util.exporter;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.AgeFileFilter;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.lang.time.FastDateFormat;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.MessageSourceAccessor;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataList.Replacer;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.util.code.Code;
import com.ubone.framework.util.code.CodeRepository;

/** 
 * <pre>
 *  설    명 : Exporter Base
 *              - 설정된 페이지 사이즈로 dataList를 분할하여 실제 변환을 자식에게 넘긴다.
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
public abstract class AbstractExporter implements Exporter {
	
	private static final Log logger = LogFactory.getLog(AbstractExporter.class);
	static final String DEFAULT_EXPORT_ROOT = File.separator + "export";
	
	private final String HEADER_PREFIX = "message.export.";
	private final String CODE_PREFIX = "code:";
	
	/**
	 * 메세지
	 */
	@Resource
	private MessageSourceAccessor messageSourceAccessor;
	
	/**
	 * Code 저장소
	 */
	@Resource
	private CodeRepository codeRepository;
	
	private int defaultCountForPage = 1000;
	public void setDefaultCountForPage(int defaultCountForPage) {
		if(defaultCountForPage > 0) {
			this.defaultCountForPage = defaultCountForPage;
		}
		else {
			if(logger.isWarnEnabled()) {
				logger.warn("Exporter's countForPage value is must greater than 0; countForPage value setted default value(1000);");
			}
		}
	}
	
	private String exportPath =  DEFAULT_EXPORT_ROOT + File.separator + FastDateFormat.getInstance("yyyyMMdd").format(new Date());
	protected String getExportPath() {
		return exportPath;
	}
	protected void setExportPath(String exportPath) {
		this.exportPath = exportPath;
	}
	
	protected String getExportFilePath(String fileName) {
		fileName = fileName + '_' + System.currentTimeMillis() + "." + getFileType();
		return getExportPath() + File.separator + fileName;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.util.exporter.Exporter#export(com.ubone.framework.data.DataList)
	 */
	public String[] export(DataList dataList) {
		return export(dataList, defaultCountForPage);
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.util.exporter.Exporter#export(com.ubone.framework.data.DataList, int)
	 */
	public String[] export(DataList dataList, int countForPage) {
		if(dataList == null) {
			if(logger.isWarnEnabled()) {
				logger.warn("export target dataList is null; ");
			}
			return null;
		}
		
		Long current = System.currentTimeMillis();
		String currentTarget = DEFAULT_EXPORT_ROOT + File.separator + FastDateFormat.getInstance("yyyyMMdd").format(current);
		File targetDirectory = new File(ConfigHolder.UPLOAD_PATH + currentTarget);
		synchronized (targetDirectory) {
			if(targetDirectory.exists() == false ) {
				targetDirectory.mkdirs();
				setExportPath(currentTarget);
			}
		}

		// 임시 파일 삭제(3일 이전 생성파일만)
		deleteExportAfterFile();
		
		convertCodeDescription(dataList);
		
		String[] headerNames = dataList.getColumnNames();
		for (int i=0; i<headerNames.length; i++) {
			headerNames[i] = headerNames[i].replaceFirst(CODE_PREFIX, "");
			
			if(ConfigHolder.LOCALE_USE_MULTI_LANGUAGE) {
				headerNames[i] = messageSourceAccessor.getMessage(HEADER_PREFIX + headerNames[i], headerNames[i]);
			}
		}

		
		int totalRowCount = dataList.getRowCount();
		int pageCount = 0;
		if(totalRowCount % countForPage == 0) {
			pageCount = totalRowCount / countForPage;
		}
		else{
			pageCount = totalRowCount  / countForPage + 1;
		}

		String[] filePath = new String[pageCount];
		String pageId = dataList.getId().replaceAll("\\.", "_").toUpperCase();
		for(int i=0; i<pageCount; i++) {
			int fromIndex = i * countForPage;
			int toIndex = fromIndex + countForPage;
			if(toIndex > totalRowCount) {
				toIndex = totalRowCount;
			}
			DataList subList = DataUtil.makeDataList(pageId + "_" + i, dataList.subList(fromIndex, toIndex));
			filePath[i] = exportPage(subList, headerNames, i);
		}
		return filePath;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.util.exporter.Exporter#export(com.ubone.framework.data.DataList, int)
	 */
	public String[] export(DataList dataList, int countForPage , RowHandler rowHandler) {
		if(dataList == null) {
			if(logger.isWarnEnabled()) {
				logger.warn("export target dataList is null; ");
			}
			return null;
		}
		
		Long current = System.currentTimeMillis();
		String currentTarget = DEFAULT_EXPORT_ROOT + File.separator + FastDateFormat.getInstance("yyyyMMdd").format(current);
		File targetDirectory = new File(ConfigHolder.UPLOAD_PATH + currentTarget);
		synchronized (targetDirectory) {
			if(targetDirectory.exists() == false ) {
				targetDirectory.mkdirs();
				setExportPath(currentTarget);
			}
		}

		// 임시 파일 삭제(3일 이전 생성파일만)
		deleteExportAfterFile();
		
		convertCodeDescription(dataList);
		
		String[] headerNames = dataList.getColumnNames();
		for (int i=0; i<headerNames.length; i++) {
			headerNames[i] = headerNames[i].replaceFirst(CODE_PREFIX, "");
			
			if(ConfigHolder.LOCALE_USE_MULTI_LANGUAGE) {
				headerNames[i] = messageSourceAccessor.getMessage(HEADER_PREFIX + headerNames[i], headerNames[i]);
			}
		}

		
		int totalRowCount = dataList.getRowCount();
		int pageCount = 0;
		if(totalRowCount % countForPage == 0) {
			pageCount = totalRowCount / countForPage;
		}
		else{
			pageCount = totalRowCount  / countForPage + 1;
		}

		String[] filePath = new String[pageCount];
		String pageId = dataList.getId().replaceAll("\\.", "_").toUpperCase();
		for(int i=0; i<pageCount; i++) {
			int fromIndex = i * countForPage;
			int toIndex = fromIndex + countForPage;
			if(toIndex > totalRowCount) {
				toIndex = totalRowCount;
			}
			DataList subList = DataUtil.makeDataList(pageId + "_" + i, dataList.subList(fromIndex, toIndex));
			filePath[i] = exportPage(subList, headerNames, i , rowHandler);
		}
		return filePath;
	}

	private void convertCodeDescription(DataList dataList) {
		String[] columnNames = dataList.getColumnNames();
		for(final String columnName : columnNames) {
			if(columnName.startsWith(CODE_PREFIX)) {
				final Code code = codeRepository.findByCategoryId(columnName.replaceFirst(CODE_PREFIX, ""), null);
				if(code != null) {
					dataList.replace(new Replacer() {
						public void process(Map<String, Object> row) {
							String value = (String) row.get(columnName);
							value = code.getCodeName(value);
							if(StringUtils.isNotEmpty(value)) {
								row.put(columnName, value);
							}
						}
					});
				}
			}
		}
	}
	
	/**
	 * Export후 사용하지 않는 파일 삭제
	 *  - 3일이전 파일을 삭제처리함.
	 * @throws IOException 
	 */
	public synchronized void deleteExportAfterFile(){
		// 3일전 임시파일 삭제 처리
		File fileList = new File(ConfigHolder.UPLOAD_PATH + DEFAULT_EXPORT_ROOT);
		
		// 3일이전의 파일면 추출
		Date cutoff = DateUtils.addDays(new Date(), -3);
		FileFilter filter = new AgeFileFilter(cutoff);
		for(File file : fileList.listFiles(filter)) {
			try {
				logger.debug("- delete extract tempfile : "+file.getAbsolutePath());
				FileUtils.forceDelete(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
     * 엑셀 파일을 생성하고 파일 경로를 암호화 하여 리턴한다.
	 * @param dataList 엑셀로 변환할 대상 조회 DataList
	 * @param headerNames 해더목록
	 * @param currentPage 엑셀 파일당 row 개수
	 * @return String 암호화된 filepath 
	 */
	protected abstract String exportPage(DataList dataList, String[] headerNames, int currentPage);
	
	
	/**
	 * 엑셀 파일을 생성하고 파일 경로를 암호화 하여 리턴한다.
	 * RowHandler 구현체를  주입 가능함
	 * 
	 * @param dataList 엑셀로 변환할 대상 조회 DataList
	 * @param headerNames 해더목록
	 * @param currentPage 엑셀 파일당 row 개수
	 * @param rowHandler 엑셀 변환 시 추가 스타일  구현된 구현체
	 * @return String 암호화된 filepath
	 */
	protected abstract String exportPage(DataList dataList, String[] headerNames, int currentPage , RowHandler rowHandler);
}