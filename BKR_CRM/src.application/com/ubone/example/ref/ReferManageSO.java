package com.ubone.example.ref;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.example.ref.dao.ReferManageInquiryDAO;
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
 *  파 일 명 : ReferManageSO.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 6. 3.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class ReferManageSO {
	@Resource 
	private ReferManageInquiryDAO referManageInquiryDAO;
	@Resource
	private TbsBulletinDAO tbsBulletinDAO;
    @Resource
    private SequenceRepository sequenceRepository;
	
	/**
	 * 자료실 목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 목록 조회 결과
	 */
	public Result getRefList(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return referManageInquiryDAO.getRefList(parameter);
	}
	
	/**
	 * 자료실 상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.READ)
	public Result getRefDetail(@KeyParameter(name="ID_BULLETIN", required=true) Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		Result   rs = referManageInquiryDAO.getRefDetail(parameter);
		return rs;
	}
	
	/**
	 * 자료실 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.CREATE)
	public String createRef(Parameter parameter){
		//시퀀스
		//parameter.set("ID_BULLETIN", sequenceRepository.nextVal("SEQ_TBS_BULLETIN"));
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return ResultUtils.makeResultForKey(this.tbsBulletinDAO.insertRef(parameter));
	}
	
	/**
	 * 자료실 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.UPDATE)
	public int updateRef(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return tbsBulletinDAO.updateRef(parameter);
	}
	
	/**
	 * 자료실 삭제.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	@FileSupport(primaryKeyFieldNames="ID_BULLETIN", methodType=FileMethodType.DELETE)
	public int deleteRef(@KeyParameter(name="ID_BULLETIN", required=true) Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return tbsBulletinDAO.deleteRef(parameter);
	}
}
