package com.ubone.example.hessian;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.engine.domain.BasicUserContainer;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.domain.UserContainer;
import com.ubone.framework.engine.service.ServiceException;
import com.ubone.interfaces.hessian.HessianClient;
import com.ubone.interfaces.hessian.service.HessianFunctionService;
import com.ubone.interfaces.hessian.domain.HessianResult;

/** 
 * <pre>
 *  파 일 명 : HessianFunctionServiceClientTest.java
 *  설    명 : Hessian을 이용한 Function Service Call Test 클래스 
 *  작 성 자 : 강영운
 *  작 성 일 : 2015. 07. 18
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public class HessianFunctionServiceClientTest{                
    public static void main(String[] args){
        HessianFunctionServiceClientTest test = new HessianFunctionServiceClientTest();
        
        String screenId = "EXP8001";
        String functionAlias = "INQUIRY";
        
        System.out.println("Call FunctionService :: ["+screenId+"/"+functionAlias+"]");
        Result result = test.callFunctionService(screenId, functionAlias, DataUtil.makeParameter());
        
        System.out.println("Result : "+result);
    }

    public Result callFunctionService(String screenId, String functionAlias, Parameter parameter){
        String serviceUrl = "http://localhost:8080/hessianFunctionService.do";
        HessianClient client = new HessianClient(serviceUrl);
        HessianFunctionService adapter = client.create(HessianFunctionService.class); //원격 호출 Adapter 인터페이스 선언
        
        UserContainer userContainer = new BasicUserContainer("admin", UserBuilder.buildSystemUser());
        
        // 연결 접속 오류 시
        try{
            HessianResult hessianResult = adapter.invoke(screenId, functionAlias, parameter, userContainer);

            if("S".equals(hessianResult.getStatus())){
            	return hessianResult.getResult();
            }else{
                throw new ServiceException(hessianResult.getMessage(), "HessianFunctionService");
            }

        } catch (Exception e){
            throw new ServiceException(e.getMessage(), e, "HessianFunctionService");
        }
    }
}
