package com.ubone.example.hessian;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import com.ubone.interfaces.hessian.HessianClient;
import com.ubone.interfaces.hessian.domain.HessianParam;
import com.ubone.interfaces.hessian.domain.HessianResult;
import com.ubone.interfaces.hessian.service.HessianService;

/** 
 * <pre>
 *  파 일 명 : HessianTest.java
 *  설    명 : Hessian Test 클래스 
 *  작 성 자 : 강영운
 *  작 성 일 : 2013. 05. 23
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public class HessianClientTest{                
    public static void main(String[] args){
        HessianClientTest test = new HessianClientTest();
        test.test();
    }

    /**
    * 고객조회 인터페이스
    * @param 검색조건
    * @return 검색결과
    */
    public void test(){ 
        System.out.println("============================================");
        System.out.println("                헤시안 테스트 ");
        System.out.println("============================================");

        String serviceUrl = "http://localhost:8080/hessianAdapter.do";
        HessianClient client = new HessianClient(serviceUrl);  //서비스 Url(기간계 WAS 원격호출 Url : http://ip:port/remoting/adapter)
        HessianService adapter = client.create(HessianService.class); //원격 호출 Adapter 인터페이스 선언 

        String interfaceId = "VCTO001";

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("CALL_GUBUN","Y");
        
        String[] tmp = new String[2];
        tmp[0] = "1|2|3|4|5";
        tmp[1] = "21|2|3|4|5";
        
        map.put("ADDR_CUS", tmp);
        
        HessianParam param = new HessianParam(interfaceId);
        param.putParam("PARAM_1", "TEST_1");
        param.putParam("PARAM_2", map);
        param.putParam("PARAM_3", new ArrayList<String>());
        param.putParam("TP_CHNN_SYSTEM", "01");
        

        // 연결 접속 오류 시
        try{
            HessianResult result = adapter.invoke(param); //1: TxID, 2: 메서드 호출을 위한 파라미터 Map, 3: Header Map

            if("S".equals(result.getStatus())){
                // 정상 처리
                System.out.println("============================================");
                System.out.println("Result : " + result.getMessage());

                for(Iterator<String> e = result.getResultMap().keySet().iterator(); e.hasNext();){
                    String key = e.next();
                    System.out.println("key = "+key + " ==> "+result.getResultMap().get(key));
                }
                System.out.println("============================================");
            }else{
                // 오류 처리
                String errorMsg = result.getMessage();
                System.out.println("============================================");
                System.out.println("errorMsg : " + errorMsg);
                System.out.println("============================================");
            }

        } catch (Exception e){

            //오류처리
            System.out.println("***********************************************************");
            System.out.println("*********************연결 접속 오류***********************");
            System.out.println(e.getMessage());
            e.printStackTrace();
            System.out.println("***********************************************************");
        }
    } 
}
