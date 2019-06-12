package com.ubone.standard.crypto;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ubone.framework.data.crypto.BasicDataCrypto;

/** 
 * <pre>
 *  파 일 명 : NoneDataCrypto.java
 *  설    명 : 암호화 처리를 하지 않는 구현체
 *  작 성 자 : 강영운
 *  작 성 일 : 2012.07.27
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 : DB에 데이터를 저장시 또는 조회시 암복호화 하는 모듈
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class NoneDataCrypto extends BasicDataCrypto {
	private Log logger = LogFactory.getLog(NoneDataCrypto.class);
	
	@Override
	public String encode(String text) throws RuntimeException {
		String ret = text;
		try{
			ret = text;
		}catch(Exception e){
			logger.debug(e);
		}
		return ret;
	}
	
	@Override
	public String decode(String text) throws RuntimeException {
		String ret = text;
		try{
			ret = StringUtils.replace(text, "", "");
		}catch(Exception e){
			logger.debug(e);
		}
		return ret;
	}
}
