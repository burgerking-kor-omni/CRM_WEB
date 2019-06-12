package com.ubone.standard.system.user.impl;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.standard.system.user.dao.UserManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : UserManageInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 5. 9.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class UserManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements UserManageInquiryDAO{
	
	private String queryPrefix = "UserManageInquiry.";
	
	public DataList getUserList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getUserList", parameter);
	}

	public DataList getUserDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getUserDetail", parameter);
	}
	
	public DataList getUserPortalDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getUserPortalDetail", parameter);
	}
	
	/**
	 * 비밀번호 확인 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList getUserPasswdInfo(Parameter parameter){
		return queryForDataList(this.queryPrefix + "getUserPasswdInfo", parameter);
	}
	
	/**
	 * 비밀번호 변경처리
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList updateUserPasswdInfo(Parameter parameter){
		return queryForDataList(this.queryPrefix + "updateUserPasswdInfo", parameter);
	}
	
	/**
	 * 비밀번호 초기화
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList updateUserPasswdReset(Parameter parameter){
		return queryForDataList(this.queryPrefix + "updateUserPasswdReset", parameter);
	}
	
	public List<User> findByUserSalesEmp(String idCorp) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("idCorp", idCorp);

		DataList list = queryForDataList(this.queryPrefix+"findByUserSalesEmp", map);
		
		List<User> users = new LinkedList<User>();
		for (int i = 0; i < list.size(); i++) {
			String id = (String) list.getString(i, "id");
			String name = (String) list.getString(i, "name");
			String password = (String) list.getString(i, "password");
			String partName = (String) list.getString(i, "partName");
			String headPartCode = (String) list.getString(i, "headquartersCode");
			String classCode = (String) list.getString(i, "classCode");
			String positionCode = (String) list.getString(i, "positionCode");
			String email = (String) list.getString(i, "email");
			String phoneNumber = (String) list.getString(i, "phoneNumber");
			String mobilePhoneNumber = (String) list.getString(i, "mobilePhoneNumber");
			String languageCode = (String) list.getString(i, "languageCode");
			
			UserBuilder builder = new UserBuilder();
			builder.setId(id);
			builder.setName(name);
			builder.setPassword(password);
			builder.setPartCode("");
			builder.setPartName("");
			builder.setHeadPartCode(headPartCode);
			builder.setClassCode(classCode);
			builder.setPositionCode(positionCode);
			builder.setEmail(email);
			builder.setPhoneNumber(phoneNumber);
			builder.setMobilePhoneNumber(mobilePhoneNumber);
			builder.setLanguageCode(languageCode);
			
			users.add(builder.build());			
		}

		return users;
	}
	
	public List<User> findByUserStoreOwner(String idCorp) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("idCorp", idCorp);

		DataList list = queryForDataList(this.queryPrefix+"findByUserStoreOwner", map);
		
		List<User> users = new LinkedList<User>();
		for (int i = 0; i < list.size(); i++) {
			String id = (String) list.getString(i, "id");
			String name = (String) list.getString(i, "name");
			String password = (String) list.getString(i, "password");
			String partName = (String) list.getString(i, "partName");
			String headPartCode = (String) list.getString(i, "headquartersCode");
			String classCode = (String) list.getString(i, "classCode");
			String positionCode = (String) list.getString(i, "positionCode");
			String email = (String) list.getString(i, "email");
			String phoneNumber = (String) list.getString(i, "phoneNumber");
			String mobilePhoneNumber = (String) list.getString(i, "mobilePhoneNumber");
			String languageCode = (String) list.getString(i, "languageCode");
			
			UserBuilder builder = new UserBuilder();
			builder.setId(id);
			builder.setName(name);
			builder.setPassword(password);
			builder.setPartCode("");
			builder.setPartName("");
			builder.setHeadPartCode(headPartCode);
			builder.setClassCode(classCode);
			builder.setPositionCode(positionCode);
			builder.setEmail(email);
			builder.setPhoneNumber(phoneNumber);
			builder.setMobilePhoneNumber(mobilePhoneNumber);
			builder.setLanguageCode(languageCode);
			
			users.add(builder.build());			
		}

		return users;
	}

	@Override
	public String insertUser(Parameter parameter) {
		return insert(this.queryPrefix  + "insertUser", parameter);
	}

	@Override
	public int update(Parameter parameter) {
		return update(this.queryPrefix  + "updateUser", parameter);
	}
	
	@Override
	public DataList getSysUserDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getSysUserDetail", parameter);
	}
	
	@Override
	public int updateUserStatus(Parameter param) {
		return update(this.queryPrefix+"updateUserStatus", param);
	}
	
	@Override
	public int updateLoginInfo(Parameter param) {
		return update(this.queryPrefix+"updateLoginInfo", param);
	}
}
