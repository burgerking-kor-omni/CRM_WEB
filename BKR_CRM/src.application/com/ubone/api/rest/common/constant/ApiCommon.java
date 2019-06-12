package com.ubone.api.rest.common.constant;

import java.util.UUID;

import org.springframework.stereotype.Service;

/** 
 * <pre>
 *  파 일 명  : ApiCommon.java
 *  설    명   : API 공통
 *  작 성 자  : 
 *  작 성 일  : 2018.10.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */

@Service
public class ApiCommon {
	
	public String tempPassword() {
		// 임시비밀번호 생성 - 10자리, '-' 제거
		String uuid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
		return uuid;
	}

}
