package com.ubone.standard.gateway;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

/** 
 * <pre>
 *  파 일 명 : HttpGatewayController.java
 *  설    명 : 모바일 --> 중계서버 --> WAS 서버의 터널링 컨트롤러 클래스
 *             해당 클래스틑 중계서버에 설정되며, 모바일 클라이언트는 중계서버와 통신후 결과를 리턴받는다.
 *  작 성 자 : 강영운
 *  작 성 일 : 2016. 06. 16.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 *  
 *		1. applicationContext-web.xml 에 아래의 내용을 추가하여 사용한다.
 *
 *  	<!-- Mobile GateWay Controller 설정 -->
 *		<bean id="httpGatewayController" class="com.ubone.standard.gateway.HttpGatewayController">
 *			<property name="targetUrl" 		value="http://localhost:8080" />
 *			<property name="encoding"		value="UTF-8"/>
 *			<property name="resetSession"	value="true" />
 *		</bean>
 *  
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
@Controller
public class HttpGatewayController {

    private static Log logger = LogFactory.getLog(HttpGatewayController.class);
    
    private String targetUrl = "http://localhost:8080";
    private String encoding = "UTF-8";
    private boolean resetSession = true;

    /**
     * 대상 URL정보를 리턴한다.
     * @return
     */
    public String getTargetUrl() {
		return targetUrl;
	}

    /**
     * 연결대상 URL의 정보를 설정하는 함수
     * @param targetUrl 연결할 서버 URL
     */
	public void setTargetUrl(String targetUrl) {
		this.targetUrl = targetUrl;
	}

	/**
	 * 서버 인코딩 정보를 리턴한다.
	 * @return 인코딩 정보
	 */
	public String getEncoding() {
		return encoding;
	}

	/**
	 * 서버의 인코딩 정보를 셋팅하는 함수
	 * @param encoding 인코딩 문자셋
	 */
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}
	
	/**
	 * 로그인 처리시 세션의 리셋여부를 리턴하는 함수
	 * @return the resetSession
	 */
	public boolean isResetSession() {
		return resetSession;
	}

	/**
	 * 로그인 처리시 세션의 리셋여부를 설정하는 함수
	 * @param resetSession the resetSession to set
	 */
	public void setResetSession(boolean resetSession) {
		this.resetSession = resetSession;
	}

	/**
     * 로그인 처리를 위한 Request 처리 함수
     *  - 로그인 이후에 cookieStore를 세션에서 관리하여, 동일세션의 요청시 동일한 대상서버에게도
     *    동일한 세션을 유지하기 위한 store를 관리한다.
     *    
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping({"/login.ub", "/mlogin.ub"})
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        BasicCookieStore cookieStore = new BasicCookieStore();
        
        // 세션을 초기화 한다.
        if(resetSession){
        	request.getSession().invalidate();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute(BasicCookieStore.class.getName(), cookieStore);

        /**
         * 대상서버로 Http 요청 결과를 받는다.
         */
    	HttpRequestResult result = sendHttpRequest(request);
    	
		//클라이언트로 넘길 Response 맵 세팅 (모피어스의 데이터 구조)
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
		responseBodyMap.put("status", "OK");
		
    	/**
    	 * 상태코드가 400이상이면 오류로 처리한다.
    	 */
    	if(result.getStatusCode() == 401){
    		responseHeadMap.put(Const.RESULT_CODE, 401);
    		responseHeadMap.put(Const.RESULT_MESSAGE, "대상서버의 세션이 만료되었습니다. 재접속해주세요.");
    	}else if(result.getStatusCode() > 401){
    		responseHeadMap.put(Const.RESULT_CODE, Const.FAIL);
    		responseHeadMap.put(Const.RESULT_MESSAGE, "대상서버의 서비스 요청시 오류가 발생하였습니다.");
    	}else{
    		responseHeadMap.put(Const.RESULT_CODE, Const.OK);
    		responseHeadMap.put(Const.RESULT_MESSAGE, Const.SUCCESS);
    	}
    	
		responseMap.put(Const.HEAD, responseHeadMap);
        responseMap.put(Const.BODY, responseBodyMap);
        
		ModelAndView mv = new ModelAndView("defaultJsonView"); //이곳에서 JSON으로 변환
		mv.addAllObjects(responseMap);
		return mv;
    }
    
    /**
     * 로그아웃 처리를 위한 Request 처리 함수
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping({"/logout.ub","/mlogout.ub"})
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	/**
         * 대상서버로 Http 요청 결과를 받는다.
         */
    	HttpRequestResult result = sendHttpRequest(request);

    	// 세션정보를 초기화 한다.
    	HttpSession session = request.getSession();
    	session.invalidate();
    	
    	
		//클라이언트로 넘길 Response 맵 세팅 (모피어스의 데이터 구조)
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
    	/**
    	 * 상태코드가 400이상이면 오류로 처리한다.
    	 */
    	if(result.getStatusCode() == 401){
    		responseHeadMap.put(Const.RESULT_CODE, 401);
    		responseHeadMap.put(Const.RESULT_MESSAGE, "대상서버의 세션이 만료되었습니다. 재접속해주세요.");
    	}else if(result.getStatusCode() > 401){
    		responseHeadMap.put(Const.RESULT_CODE, Const.FAIL);
    		responseHeadMap.put(Const.RESULT_MESSAGE, "대상서버의 서비스 요청시 오류가 발생하였습니다.");
    	}else{
    		responseHeadMap.put(Const.RESULT_CODE, Const.OK);
    		responseHeadMap.put(Const.RESULT_MESSAGE, Const.SUCCESS);
    	}

    	responseMap.put(Const.HEAD, responseHeadMap);
        responseMap.put(Const.BODY, responseBodyMap);
        
		ModelAndView mv = new ModelAndView("defaultJsonView"); //이곳에서 JSON으로 변환
		mv.addAllObjects(responseMap);
		return mv;
    }
    
    /**
     * 서비스 처리를 위한 Request 처리 함수
     * @param request
     * @param response
     * @param screenId
     * @param functionAlias
     * @return
     * @throws Exception
     */
    @RequestMapping("/function/{screenId}/{functionAlias}.ub")
    public ModelAndView functionService(HttpServletRequest request, HttpServletResponse response,
    		@PathVariable("screenId")String screenId, 
    		@PathVariable("functionAlias")String functionAlias) throws Exception {

    	HttpRequestResult result = sendHttpRequest(request);
    	
		//클라이언트로 넘길 Response 맵 세팅 (모피어스의 데이터 구조)
		Map<String, Object> responseMap = new HashMap<String, Object>();
		Map<String, Object> responseHeadMap = new HashMap<String, Object>();
		Map<String, Object> responseBodyMap = new HashMap<String, Object>();
		
		// HttpResult의 Json 결과를 가져와서 Map으로 전환후, 다시 body 데이터 추가한다.
		if(!"".equals(result.getData())){
			ObjectMapper mapper = new ObjectMapper();
			responseBodyMap = mapper.readValue(result.getData(), HashMap.class);
		}
		
    	/**
    	 * 상태코드가 400이상이면 오류로 처리한다.
    	 */
    	if(result.getStatusCode() == 401){
    		responseHeadMap.put(Const.RESULT_CODE, 401);
    		responseHeadMap.put(Const.RESULT_MESSAGE, "대상서버의 세션이 만료되었습니다. 재접속해주세요.");
    	}else if(result.getStatusCode() > 401){
    		responseHeadMap.put(Const.RESULT_CODE, Const.FAIL);
    		responseHeadMap.put(Const.RESULT_MESSAGE, "대상서버의 서비스 요청시 오류가 발생하였습니다.");
    	}else{
    		responseHeadMap.put(Const.RESULT_CODE, Const.OK);
    		responseHeadMap.put(Const.RESULT_MESSAGE, Const.SUCCESS);
    	}

    	responseMap.put(Const.HEAD, responseHeadMap);
        responseMap.put(Const.BODY, responseBodyMap);
        
		ModelAndView mv = new ModelAndView("defaultJsonView"); //이곳에서 JSON으로 변환
		mv.addAllObjects(responseMap);
		return mv;
    }    

    class Const{
    	static final String HEAD = "head";
    	static final String BODY = "body";
    	static final String RESULT_CODE = "result_code";
    	static final String RESULT_MESSAGE = "result_message";
    	static final String SUCCESS = "Success";
    	
    	static final int OK   = 200;
    	static final int FAIL = 999;
    }
    
    /**
     * HttpResult Domain Class
     */
    class HttpRequestResult{
    	int statusCode = HttpServletResponse.SC_OK;
    	String data = "";
    	
    	public HttpRequestResult(){
    		
    	}
    	public HttpRequestResult(int statusCode, String data){
    		this.statusCode = statusCode;
    		this.data = data;
    	}
		public int getStatusCode() {
			return statusCode;
		}
		public void setStatusCode(int statusCode) {
			this.statusCode = statusCode;
		}
		public String getData() {
			return data;
		}
		public void setData(String data) {
			this.data = data;
		}
    }
    
    /**
     * 특정 서버로 터널링 하기 위한 함수
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    private HttpRequestResult sendHttpRequest(HttpServletRequest request){

    	HttpRequestResult result = new HttpRequestResult();
    	try{
    		// Response 인코딩 설정
	    	request.setCharacterEncoding(encoding);
	        
			// 세션의 쿠키 정보 로드
	        HttpSession session = request.getSession();
	        BasicCookieStore cookieStore = (BasicCookieStore) session.getAttribute(BasicCookieStore.class.getName());
	        
	        if(cookieStore == null){
	        	result.setStatusCode(HttpServletResponse.SC_UNAUTHORIZED);
	        	return result;
	        }
	        
	        // Post 방식의 Client 생성
	        HttpPost httpPost = new HttpPost(targetUrl+request.getServletPath());
	        CloseableHttpClient httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).build();
	        
	        try{
		        logger.debug("connecting : " + httpPost.getURI());
		         
		        // Request Parameter 셋팅
		        List<NameValuePair> paramList = convertParam(request.getParameterMap());
		        httpPost.setEntity(new UrlEncodedFormEntity(paramList, encoding));

		        CloseableHttpResponse response1 = httpclient.execute(httpPost);
		        
		        try {
		            HttpEntity entity = response1.getEntity();
		            String responseData = EntityUtils.toString(entity, encoding);
		            EntityUtils.consume(entity);

		        	result.setStatusCode(response1.getStatusLine().getStatusCode());
		        	result.setData(responseData);
		        } finally {
		            response1.close();
		        }
	        }finally{
	        	httpclient.close();        	
	        }
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    		result = new HttpRequestResult(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error!!");
    	}
        
        return result;
    }
    
    /**
     * Http Parameter를 Form형식의 NameValue형태로 리턴하는 함수
     * @param map HttpServletRequest의 Parameter Map Instance
     * @return HttpClient에서 사용할 파라미터 리스트
     */
    private List<NameValuePair> convertParam(Map<String, String[]> map){
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        Iterator<String> keys = map.keySet().iterator();
        
        while(keys.hasNext()){
            String key = keys.next();
            Object value = map.get(key);

            if(value instanceof String){
            	paramList.add(new BasicNameValuePair(key, (String)value));
            }else if (value instanceof String[]){
            	String[] values = (String[])value;
            	for(int i=0; i<values.length; i++){
            		paramList.add(new BasicNameValuePair(key, (String)values[i]));
            	}
            }
        }
        return paramList;
    }    
}
