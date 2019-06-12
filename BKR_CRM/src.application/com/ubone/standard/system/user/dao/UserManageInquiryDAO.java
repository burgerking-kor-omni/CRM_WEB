package com.ubone.standard.system.user.dao;

import java.util.List;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.User;

/** 
 * <pre>
 *  파 일 명 : UserManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface UserManageInquiryDAO {
	
	/**
	 * 사용자 목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자 목록 조회 결과
	 */
	public DataList getUserList(Parameter parameter);
	
	public DataList getUserDetail(Parameter parameter);
	
	public DataList getUserPortalDetail(Parameter parameter);
		
	/**
	 * 비밀번호 확인 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList getUserPasswdInfo(Parameter parameter);
	
	/**
	 * 비밀번호 변경처리
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList updateUserPasswdInfo(Parameter parameter);
	
	/**
	 * 비밀번호 초기화
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList updateUserPasswdReset(Parameter parameter);
	
	/**
	 * ID_CORP로 영업사원정보 조회
	 * @param parameter
	 * @return
	 */	
	public List<User> findByUserSalesEmp(String idCorp);
	
	
	/**
	 * ID_CORP로 점주정보 조회
	 * @param parameter
	 * @return
	 */
	public List<User> findByUserStoreOwner(String idCorp);
	
	
	/**
	 * 사용자정보를 등록한다.
	 * @param parameter
	 * @return
	 */
	public String insertUser(Parameter parameter);

	/**
	 * 사용자정보 수정
	 * @param parameter
	 * @return
	 */
	public int update(Parameter parameter);
	
	/**
	 * 사용자정보 조회
	 * @param parameter
	 * @return
	 */
	public DataList getSysUserDetail(Parameter parameter);
	
	/**
	 * 사용자 상태 수정
	 * @param param 사용자 정보
	 * @return 성공 여부
	 */
	public int updateUserStatus(Parameter param);
	
	/**
	 * 로그인 여부 수정
	 * @param param
	 * @return
	 */
	public int updateLoginInfo(Parameter param);
}
