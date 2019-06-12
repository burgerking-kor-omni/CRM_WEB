package com.ubone.framework.web.util;

import org.apache.commons.lang3.StringUtils;

import com.nhncorp.lucy.security.xss.XssSaxFilter;

/** 
 * <pre>
 *  파 일 명 : XssUtils.java
 *  설    명 : Xss Injection관련 유틸리티 클래스
 *   - LucyXss 라이브러리를 이용한 방식으로 html 에디터의 컨텐츠에 태크를 이용한 패턴 공격 방어
 *   - 개별 문자열의 스트링 변환 지원 
 *  작 성 자 : 강영운
 *  작 성 일 : 2017.08.25
 *  버    전 : 1.1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class XssUtils {

	private static XssSaxFilter filter = XssSaxFilter.getInstance("resource/config/lucyxss/lucy-xss-sax.xml", true);
	
	public static Object doFilter(Object source){
		if(source instanceof String){
			return doFilter((String)source);
		}else{
			return source;
		}
	}
	
	public static String doFilter(String source){
		return filter.doFilter(source);
	}

	public static String doFilterReconvertXss(String source){
		return filter.doFilter(reconvertXss(source));
	}
	
	public static String reconvertXss(String source){
		String result = StringUtils.defaultString(source);
		
		result = result.replaceAll("&#39;", "\'"); 
		result = result.replaceAll("&quot;", "\"");
		result = result.replaceAll("&#58;", ":");
		result = result.replaceAll("&#59;", ";"); 
		result = result.replaceAll("&#40;", "(");
		result = result.replaceAll("&#41;", ")");
		result = result.replaceAll("&lt;", "<");
		result = result.replaceAll("&gt;", ">");
		result = result.replaceAll("&#123;", "{"); 
		result = result.replaceAll("&#125;", "}"); 
		result = result.replaceAll("&#35;", "#"); 
		result = result.replaceAll("&#36;", "\\$"); 
		result = result.replaceAll("&#37;", "%"); 

		result = result.replaceAll("&amp;", "&"); 
		result = result.replaceAll("&#63;", "?"); 
		result = result.replaceAll("&#33;", "!"); 
		result = result.replaceAll("&#64;", "@"); 
		result = result.replaceAll("&#42;", "*"); 
		result = result.replaceAll("&#124;", "|"); 

		return result;
	}
	
	public static void main(String[] args) {
		String test = "<form><button formaction=\"javascript:alert('눌렀네?')\">눌러봐</button></form>";
		System.out.println(XssUtils.doFilter(test));
	}

}
