package com.ubone.standard.alimy.service;

import java.util.HashMap;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.security.util.SHA256DigestUtils;
import com.ubone.framework.web.util.HttpUtils;
import com.ubone.standard.alimy.dao.AlimyLoginDAO;
import com.ubone.standard.login.domain.LoginResultType;
import com.ubone.standard.login.domain.VocUser;
import com.ubone.standard.login.service.LoginSO;

/** 
 * <pre>
 *  파 일 명 : AlimyLoginSO.java
 *  설    명 : 알리미 사용자 로그인 처리 하는 서비스를 제공한다.
 *  
 *    1. 기본 로그인 정책은 LoginController에 적용된 정책을 기준으로 처리한다.
 *    2. 알리미 로그인의 내부세션을 생성할 필요가 없으므로, 사용자의 인증만 통과만 체크 하고 내부 세션은 생성하지 않는다.
 *       (생성시 WAS의 불필요한 세션 정보가 생성이 되므로, 자원낭비가 됨)
 *    3. 웹 로그인과 알리미의 로그인 실패시 오류 유형에 대한 전환 처리는 알리미에서는 별도의 구현이 필요하므로,
 *       일반적인 오류와 동일하게 처리한다.
 *    4. SSO를 통한 로그인은 별도로 연구소에 문의하시기 바랍니다.
 *  
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.04.21
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
*/
@Service
public class AlimyLoginSO{

	@Resource
	private AlimyLoginDAO alimyLoginDAO;
	
	@Resource
	private LoginSO loginSO;

	public Result login(HttpServletRequest request, HttpServletResponse response, Parameter parameter) {

		Result result = DataUtil.makeFailedResult("로그인 실패", "");

		// 1.로그인 관련 파라미터 추출
		String loginId  = parameter.getValue("id");
		String loginIp  = StringUtils.defaultIfEmpty(parameter.getValue("ip"), HttpUtils.getRemoteAddr(request)) ;
		String password = parameter.getValue("password");
		String port     = parameter.getValue("port");
		String token    = UUID.randomUUID().toString();
		
		boolean autoStart = parameter.getBoolean("autoStart");
		
		if(!"".equals(loginId)){
			
			// 2.로그인ID에 해당하는 사용자 정보 조회
			VocUser user = loginSO.getLoginUserInfo(loginId);
			
			// 3.사용자가 없는 경우의 오류 처리
			if(user != null){
				
				// 4.로그인이 가능한 사용자인 경우
				if(user.isLoginYn()){
					
					boolean isLoginSuccess = false;
					
					if(autoStart){
						isLoginSuccess = true;
					}else{
						// 5. 패스 워드 확인(암호화는 별도 처리필요)
						String encPassword = SHA256DigestUtils.digest(password);
						if(user.getPassword().equals(encPassword)){
							isLoginSuccess = true;
						}
					}
					
					if(isLoginSuccess){
						// DB조회시 파라미터의 값이 로깅에 남는데
						// 패스워드 정보도 같이 남으므로 새로운 파라미터를 생성한다. (보안사항)
						Parameter newParam = DataUtil.makeParameter();
						newParam.set("LOGIN_ID" , loginId);
						newParam.set("CLIENT_IP", loginIp);
						newParam.set("CLIENT_PORT", port);
						newParam.set("SESSION_ID", request.getSession().getId());
						newParam.set("LOGIN_TOKEN", token);
						
						alimyLoginDAO.saveAlimyLoginInfo(newParam);
						
						result = DataUtil.makeResult();
						result.getServiceMessage().setResultKey(token);
					}
				}
			}
		}
		
		return result;
	}
	
	
}