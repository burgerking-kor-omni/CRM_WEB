package com.ubone.example.notice.service;

import javax.annotation.Resource;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Service;

import com.ubone.example.notice.dao.NoticeManageInquiryDAO;
import com.ubone.example.notice.dao.TbsNoticeDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.KeyParameter;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.framework.security.jcryption.utils.JCryptionUtil;
import com.ubone.framework.util.ConverterUtil;
import com.ubone.framework.util.exporter.DefaultRowHandler;
import com.ubone.framework.util.exporter.RowHandler;
import com.ubone.framework.util.exporter.SXSSFExcelExporter;
import com.ubone.framework.util.file.FileSupport;
import com.ubone.framework.util.file.FileSupport.FileMethodType;

/** 
 * <pre>
 *  파 일 명 : NoticeManageSO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class NoticeManageSO {
	
	@Resource 
	SXSSFExcelExporter sxssfExcelExporter; 
	@Resource 
	private NoticeManageInquiryDAO noticeManageInquiryDAO;
	@Resource
	private TbsNoticeDAO tbsNoticeDAO;
	
	/**
	 * 공지사항 목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 목록 조회 결과
	 */
	public DataList getNoticeList(Parameter parameter){
		
		// 암호화 대상컬럼을 복호화 처리
		JCryptionUtil.decrypt(parameter, new String[]{"DS_TITLE"});
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return noticeManageInquiryDAO.getNoticeList(parameter);
	}
	
	/**
	 * 공지사항 상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	@FileSupport(primaryKeyFieldNames="ID_NOTICE", methodType=FileMethodType.READ)
	public Result getNoticeDetail(@KeyParameter(name="ID_NOTICE", required=true) Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		Result   rs = noticeManageInquiryDAO.getNoticeDetail(parameter);
		return rs;
	}
	
	/**
	 * 공지사항 상세 다음글 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	public Result getNoticeNextDetail(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return noticeManageInquiryDAO.getNoticeNextDetail(parameter);
	}
	
	/**
	 * 공지사항 상세 이전글 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	public Result getNoticePrevDetail(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return noticeManageInquiryDAO.getNoticePrevDetail(parameter);
	}
	
	/**
	 * 공지사항 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	@FileSupport(primaryKeyFieldNames="ID_NOTICE", methodType=FileMethodType.CREATE)
	public String createNotice(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return ResultUtils.makeResultForKey(this.tbsNoticeDAO.insertNotice(parameter));
	}
	
	/**
	 * 공지사항 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	@FileSupport(primaryKeyFieldNames="ID_NOTICE", methodType=FileMethodType.UPDATE)
	public int updateNotice(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return tbsNoticeDAO.updateNotice(parameter);
	}
	
	/**
	 * 공지사항 삭제.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	@FileSupport(primaryKeyFieldNames="ID_NOTICE", methodType=FileMethodType.DELETE)
	public int deleteNotice(@KeyParameter(name="ID_NOTICE", required=true) Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return tbsNoticeDAO.deleteNotice(parameter);
	}
	
	/**
	 * 로그인화면 공지사항 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public Result getNoticeListLogin(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		Result result = DataUtil.makeResult();
		
		result.addDataList(noticeManageInquiryDAO.getNoticeListLogin(parameter).setId("NoticeManageInquiry.getNoticeListLogin"));
		
		return result;
	}
	
	/**
	 * 공지사항 조회 데이터 엑셀파일로 내려받기
	 * @param parameter 조회조건
	 * @return 엑셀 파일 호출 링크
	 */
	public String[] getNoticeListExcel(Parameter parameter) {
		
		parameter = DataUtil.makeUserAddedParameter(parameter);
		DataList excelList = noticeManageInquiryDAO.getExcelList(parameter);
		
		String[] doExport = sxssfExcelExporter.export(excelList, 20000 , new DefaultRowHandler());
		
		return doExport;
	}
}
