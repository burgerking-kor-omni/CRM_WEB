package com.ubone.standard.login.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.domain.UserContainer;
import com.ubone.framework.util.UserUtil;
import com.ubone.standard.login.dao.LoginDAO;

/** 
 * <pre>
 *  파 일 명 : LoginDAO.java
 *  설    명 : Login 처리 관련 업무 처리 클래스
 *  작 성 자 : Administrator
 *  작 성 일 : 2013.12.09
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Repository
public class LoginDAOImpl extends UbSqlSessionDaoSupport implements LoginDAO {

	private String queryPrefix = "LoginDAO.";
	Log logger = LogFactory.getLog(this.getClass());

	/**
	 * 사용자가 로그인 상태 정보를 수정한다
	 * 
	 * [리턴]
	 * 저장된 건수를 리턴한다.
	 * 
	 * @param parameter 로그인 가능여부, 로그인상태코드
	 */
	@Override
	public int updateLoginStatus(Parameter parameter) {
		parameter.setParameter("lastUpdUserId", UserUtil.getLoginUser().getId());
		parameter.setParameter("lastUpdUserIpAddr", UserUtil.getLoginIp());
		
		return update(queryPrefix+"updateLoginStatus", parameter);
	}

	/**
	 * 로그인 정보를 저장한 후 저장 결과를 리턴한다
	 * 
	 * [리턴]
	 * 저장건수를 리턴한다.
	 * 
	 * @param 사용자    사용자ID, 사용자명, 사용자이니셜, 사용자비밀번호, 이전비밀번호, 사원번호, 회사명, 부서명, 사무실전화번호,
	 * 휴대전화번호, 이메일주소, 담당업무설명, 사용자그룹ID, 항공사그룹ID, 등록IP주소, 등록IP주소확장여부, 비밀번호수정일시, 사용자설명,
	 * 사용자언어코드, 관리자여부, 계정상태코드, 계정상태변경사유코드, 로그인실패횟수, 상태변경시간, 최종접속IP주소, 알람에이전트IP
	 * 
	 */
	@Override
	public int updateLoginInfo(Parameter parameter) {
		parameter.setParameter("lastUpdUserId", UserUtil.getLoginUser().getId());
		parameter.setParameter("lastUpdUserIpAddr", UserUtil.getLoginIp());

		return update(queryPrefix+"updateLoginInfo", parameter);
	}
	
	/**
	 * 로그인시 사용할 로그인 정보를 조회하는 함수
	 * @param parameter loginId
	 */
	@Override
	public DataList getLoginInfo(String loginId) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("loginId", loginId);

		return queryForDataList(queryPrefix+"getLoginInfo", parameter);
	}

	/**
	 * Token Filter에서 유효토큰에 대한 사용자 정보를 조회하는 함수
	 *  - [주의]로그인ID로 조회되는 쿼리와 동일한 쿼리를 사용하기
	 * @param loginToken 로그인 토큰정보
	 * @param loginIp 로그인 IP
	 * @return 사용자 정보
	 */
	@Override
	public DataList getLoginInfoByLoginToken(String loginToken, String loginIp) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("loginIp", loginIp);
		parameter.setParameter("loginToken", loginToken);

		return queryForDataList(queryPrefix+"getLoginInfo", parameter);
	}

	/**
	 * 사용자의 정보를 조회한다.
	 * @param userId 사용자ID
	 * @return 저장 건수
	 */
	public int updatePersonInfo(Parameter parameter) {
		parameter.setParameter("lastUpdUserId", UserUtil.getLoginUser().getId());
		parameter.setParameter("lastUpdUserIpAddr", UserUtil.getLoginIp());

		return update(queryPrefix+"updatePersonInfo", parameter);
	}

	/**
	 * 사용자의 권한정보를 조회한다.
	 * @param userId 사용자ID
	 * @return 저장 건수
	 */
	@Override
	public DataList getListUserRole(UserBuilder builder) {
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("userId", builder.getId());
		parameter.setParameter("partCode", builder.getPartCode());

		return queryForDataList(queryPrefix+"getListUserRole", parameter);
	}

	@Override
	public String insertLoginInfo(Parameter parameter) {
		return queryForObject(queryPrefix + "insertLoginInfo", parameter);
	}

	@Override
	public int updaePwdFailCount(Parameter parameter) {
		return update(queryPrefix+"updaePwdFailCount", parameter);
	}

	@Override
	public int updateLoginInfoForSuccess(UserContainer userContainer) {
		
		Parameter parameter = DataUtil.makeParameter();
		parameter.setParameter("loginId", userContainer.getUser().getLoginId());
		parameter.setParameter("loginIp", userContainer.getLoginClientIp());
		parameter.setParameter("sessionId", userContainer.getLoginToken());
		
		return update(queryPrefix+"updateLoginInfoForSuccess", parameter);
	}

	@Override
	public String insertApRoleCompostion(Parameter parameter) {
		return queryForObject(queryPrefix + "insertApRoleCompostion", parameter);
	}

	@Override
	public int updateSysLogin(Parameter parameter) {
		return update(queryPrefix+"updateSysLogin", parameter);
	}

	@Override
	public int updateApRoleCompstion(Parameter parameter) {
		return update(queryPrefix+"updateApRoleCompstion", parameter);
	}

	@Override
	public int deleteApRoleCompstion(Parameter parameter) {
		return delete(queryPrefix+"deleteApRoleCompstion", parameter);
	}
	
}
