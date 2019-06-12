package com.ubone.example.faq;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.example.faq.dao.FaqManageInquiryDAO;
import com.ubone.example.tbs_bulletin.dao.TbsBulletinDAO;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.KeyParameter;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.framework.util.file.FileSupport;
import com.ubone.framework.util.file.FileSupport.FileMethodType;
import com.ubone.framework.util.sequence.SequenceRepository;

/** 
 * <pre>
 *  파 일 명 : FaqManageSO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2015.03.06
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class FaqManageSO {

	@Resource
	private FaqManageInquiryDAO faqManageInquiryDAO;
	@Resource
	private TbsBulletinDAO tbsBulletinDAO;
	@Resource
    private SequenceRepository sequenceRepository;

	
	/**
	 * FAQ 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
//	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.CREATE)
	public String createFaq(Parameter parameter){
//		parameter.set("ID_BULLETIN", sequenceRepository.nextVal("SEQ_TBS_BULLETIN"));
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return ResultUtils.makeResultForKey(this.tbsBulletinDAO.insertFaq(parameter));
	}
	
	/**
	 * FAQ 목록 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return FAQ 목록 조회 결과
	 */
	public Result getFaqList(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return faqManageInquiryDAO.getFaqList(parameter);
	}
	
	/**
	 * FAQ 상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
//	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.READ)
	public Result getFaqDetail(@KeyParameter(name="ID_BULLETIN", required=true) Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return faqManageInquiryDAO.getFaqDetail(parameter);
	}
	
	/**
	 * FAQ 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
//	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.UPDATE)
	public int updateFaq(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return tbsBulletinDAO.updateFaq(parameter);
	}
	
	/**
	 * FAQ 삭제.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
//	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.DELETE)
	public int deleteFaq(@KeyParameter(name="ID_BULLETIN", required=true) Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return tbsBulletinDAO.deleteFaq(parameter);
	}
	

}
