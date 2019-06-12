package com.ubone.example.hessian;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.BasicUserContainer;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.domain.UserContainer;
import com.ubone.framework.engine.service.support.ServiceContext;
import com.ubone.interfaces.hessian.BaseHessianService;
import com.ubone.interfaces.hessian.HessianUtils;
import com.ubone.interfaces.hessian.domain.HessianParam;
import com.ubone.interfaces.hessian.domain.HessianResult;
import com.ubone.interfaces.hessian.service.HessianService;

/** 
 * <pre>
 *  파 일 명 : HessianServerGateway.java
 *  설    명 : 헤시안 서버 인터페이스 Gateway
 *  작 성 자 : 강영운
 *  작 성 일 : 2012. 06. 08
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class HessianServerGatewaySO extends BaseHessianService implements HessianService {
	
	private static final Log logger = LogFactory.getLog(HessianServerGatewaySO.class);
	
	/**
	 * HessianAdapter 구현 메소드
	 * @param txId 호출유형
	 * @param paramMap 파라미터 맵
	 * @param headerMap 헤더 맵
	 * @return 결과 Map
	 */
	@Override
	public HessianResult invoke(HessianParam param) {
		
		HessianResult result = HessianUtils.makeHessianSuccessResult(param);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.putAll(param.getParamMap());
		
		
		Iterator<String> iterator = map.keySet().iterator();
		while (iterator.hasNext()) {
		    String key = (String) iterator.next();
		 	System.out.print("key="+key);
		 	System.out.println(" value="+map.get(key));
		}
		
		Parameter parameter = DataUtil.makeParameter((HashMap)map.get("PARAM_2"));
		
		//상담저장인터페이스 셋팅
		parameter.setParameter("INTERFACE_ID", param.getInterfaceId());

			
		// 홈페이지 이관처리 -----------------------------------------------------
		if(param.getInterfaceId().equals("VCTO005")) {


		} else {
			
			result = HessianUtils.makeHessianFailResult(param);
			result.setMessage("["+param.getInterfaceId()+"]은 정의되지 않은 트랜잭션ID 입니다.");
		}	
			

		logger.debug(">>>>>>>>>>>>  UserContaine Remove ");
		ServiceContext.removeUserContainer();
	
			return result; 
		}

	/**
	 * [조회처리] 인터페이스로 입력되는 경우, Anonymous User로 세션정보 셋팅
	 * @param void
	 * @return void
	 */
	private void setAnonymous(){
		UserContainer userContainer = ServiceContext.getUserContainer();
		if(userContainer == null) {
			userContainer = new BasicUserContainer(ConstantHolder.AUTH_ANONYMOUS_USER, UserBuilder.buildAnonymousUser(), false, "");
		}
		ServiceContext.setUserContainer(userContainer);
	}
	
	
	
	/**
	 * [등록처리] 인터페이스로 입력되는 경우, Anonymous User로 세션정보 셋팅
	 * @param void
	 * @return void
	 */
	private void setCallUserInfo(String userId, String deptId){
		UserContainer userContainer = null;
		userContainer = new BasicUserContainer(ConstantHolder.AUTH_ANONYMOUS_USER, this.buildCallUser(userId, deptId), false, "");
		ServiceContext.setUserContainer(userContainer);
	}
	
	
	public static User buildCallUser(String userId, String deptId) {
		return new UserBuilder()
		.setLanguageCode(Locale.KOREAN.getLanguage())
		.setId(userId)
		.setName("")
		.setPartCode(deptId)
		.setPartName("")
		.addRole("dummy_role")
		.build();	
	}
	
}

















