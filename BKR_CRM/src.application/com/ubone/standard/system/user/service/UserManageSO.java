package com.ubone.standard.system.user.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.security.jcryption.utils.JCryptionUtil;
import com.ubone.standard.common.encrypto.Passwdcrypt;
import com.ubone.standard.login.dao.LoginDAO;
import com.ubone.standard.login.domain.LoginStatusCd;
import com.ubone.standard.system.user.dao.UserManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : UserManageSO.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class UserManageSO {
	private static final String MOBILE_NO = "MOBILE_NO";

	private static final String CHANGE_PASSWD = "CHANGE_PASSWD";

	private static final String PASSWD = "PASSWD";

	private static final String FG_PASS = "FG_PASS";

	@Resource
	UserManageInquiryDAO userManageInquiryDAO;
	
	@Resource
	LoginDAO loginDAO;

	/**
	 * 사용자관리 목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList getReferenceList(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		// 암호화 처리 함수
		JCryptionUtil.decrypt(parameter, new String[]{"EMP_NO", "USER_NM"});

		return userManageInquiryDAO.getUserList(parameter);
	} 
	
	public DataList getUserDetail(Parameter parameter){
		return userManageInquiryDAO.getUserDetail(parameter);
	} 
	
	/**
	 * 비밀번호 변경처리
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList updateUserPasswdInfo(Parameter parameter){

		DataList dt = null;
		// passwd 암호
		if(!"N".equals(parameter.getParameter(FG_PASS))){
			parameter.setParameter(PASSWD, (String)parameter.getParameter(PASSWD));
			// 인증조회
			dt = userManageInquiryDAO.getUserPasswdInfo(parameter);
			
			if(dt.getRowCount() > 0){
				// 인증성공후 비밀번호  update
				parameter.setParameter(CHANGE_PASSWD, (String)parameter.getParameter(CHANGE_PASSWD));
				userManageInquiryDAO.updateUserPasswdInfo(parameter);
			}
			
			return dt;
		}else{
			parameter.setParameter(CHANGE_PASSWD, (String)parameter.getParameter(CHANGE_PASSWD));
			dt = userManageInquiryDAO.updateUserPasswdInfo(parameter);
			return dt;
		}
	}
	
	/**
	 * 비밀번호 초기화
	 * @param parameter HTTP 요청 파라미터  
	 * @return 사용자관리 목록 조회 결과
	 */
	public DataList updateUserPasswdReset(Parameter parameter){
		parameter.setParameter("RESET_PASSWD", (String)parameter.getParameter("newPass"));
		return userManageInquiryDAO.updateUserPasswdReset(parameter);
	}
	
	
	
	public String insertUser(Parameter parameter) {
		
		Parameter makeUserAddedParameter = DataUtil.makeUserAddedParameter(parameter);
		
		String [] arrRole = makeUserAddedParameter.getValues("CD_ROLE_LIST");
		String mobileNo = makeUserAddedParameter.get(MOBILE_NO).replace("-", "");
		makeUserAddedParameter.set(MOBILE_NO, mobileNo);
		
		
		
		//사용자등록
		String userId = userManageInquiryDAO.insertUser(makeUserAddedParameter);
		String passwd = Passwdcrypt.digestSHA256(parameter.get("PASSWD"));
		
		//로그인정보 등록
		makeUserAddedParameter.setParameter("USER_ID", userId);
		makeUserAddedParameter.setParameter("PASSWD", passwd );
		//makeUserAddedParameter.setParameter("LOGIN_YN", "N");
		makeUserAddedParameter.setParameter("STATUS", LoginStatusCd.NORMAL.getCode());
		loginDAO.insertLoginInfo(makeUserAddedParameter);
		if(arrRole.length > 0){
			for(int i = 0;i < arrRole.length; i++){
				makeUserAddedParameter.set("CD_ROLE", arrRole[i]);
				loginDAO.insertApRoleCompostion(makeUserAddedParameter);
			}
		}
		
		
		return userId;
	}
	
	
	/**
	 * 사용자정보 수정
	 * @param parameter
	 * @return the count of updated example rows
	 */
	public int update(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		String incumbent_cd = parameter.get("INCUMBENT_CD");
		String passwd = parameter.get("PASSWD");
		int result = 0;
		
		// 퇴사처리
		if(incumbent_cd.equals("D")){

			// 로그인 삭제처리
			parameter.set("LOGIN_YN", "N");
			parameter.set("STATUS", "01");
			userManageInquiryDAO.updateLoginInfo(parameter);
			
			// 사용자 정보 삭제 처리
			result = userManageInquiryDAO.updateUserStatus(parameter);
			
		}else{
			// 사용자정보 수정
			if(!passwd.isEmpty() && passwd != ""){
				passwd = Passwdcrypt.digestSHA256(passwd);
				parameter.set("CHANGE_PASSWD", passwd);
				userManageInquiryDAO.updateUserPasswdInfo(parameter);
			}
			
			
			result = userManageInquiryDAO.update(parameter);
//			loginDAO.updateSysLogin(parameter);
//			loginDAO.updateApRoleCompstion(parameter);
			
			loginDAO.deleteApRoleCompstion(parameter);
			
			String [] arrRole = parameter.getValues("CD_ROLE_LIST");
			if(arrRole.length > 0){
				for(int i = 0;i < arrRole.length; i++){
					parameter.set("CD_ROLE", arrRole[i]);
					loginDAO.insertApRoleCompostion(parameter);
				}
			}
		}
		return result;
	}
}



