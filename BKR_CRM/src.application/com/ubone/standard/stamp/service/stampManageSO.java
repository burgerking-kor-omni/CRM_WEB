package com.ubone.standard.stamp.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.framework.type.ResultStatus;
import com.ubone.standard.cust.dao.CustManageDAO;
import com.ubone.standard.stamp.dao.stampManageDAO;

@Service
public class stampManageSO {
	@Resource
	private stampManageDAO smDAO;
	@Resource
	private CustManageDAO custDAO;
	
	/**
	 * 상품 찾기 팝업 목록 조회
	 * @param param
	 * @return 목록 정보
	 */
	public DataList getProdList(Parameter param){
		return smDAO.getProdList(param);
	}
	
	/**
	 * 제품명 자동완성
	 * @param param 검색어
	 * @return 자동완성
	 */
	public DataList getMenuAutoComplete (Parameter param){
		return smDAO.getMenuAutoComplete(param);
	}
	
	/**
	 * 스탬프 기준관리 상품 유효성 확인
	 * @param param 상품id, 등급id, 적용일자
	 * @return 유효여부
	 */
	public Result checkStampMenu (Parameter param){

		Result result = DataUtil.makeResult();
		DataList rdl = DataUtil.makeDataList("");
		Parameter checkParam = DataUtil.makeParameter();
		
		String [] CD_GRADE = param.getValues("CD_GRADE"); 
		String [] CD_MENU = param.getValues("CD_MENU");
		String [] NM_MENU = param.getValues("NM_MENU");
		String strFlag = param.getValue("FLAG");
		String str = "";
		String flag = "Y";
		
		// 중복되는 메뉴 찾기
		checkParam.set("DT_APPLY_START", param.get("DT_APPLY_START"));
		checkParam.set("DT_APPLY_END", param.get("DT_APPLY_END"));
		for(int i = 0; i < CD_GRADE.length; i++){
			checkParam.set("CD_GRADE", CD_GRADE[i]);
			for(int j = 0; j < CD_MENU.length; j++ ){
				checkParam.set("CD_MENU",CD_MENU[j]);
				rdl = smDAO.checkStampMenu(checkParam);
				if( 0 < Integer.parseInt(rdl.get("CNT").toString()) 
				  && strFlag.equals("insert")){
					switch (CD_GRADE[i]) {
					case "01":
						str += "등급 : 주니어 / 메뉴 : " + NM_MENU[j] + "\n";
						break;
					case "02":
						str += "등급 : 와퍼 / 메뉴 : " + NM_MENU[j] + "\n";
						break;
					case "03":
						str += "등급 : 킹 / 메뉴 : " + NM_MENU[j] + "\n";
						break;
					}
					flag = "N";
				}
			}
		}
		if(flag.equals("Y")){
			result.setServiceMessage(new ServiceMessage().setResultStatus(ResultStatus.Success));
		}else{
			result.setServiceMessage(new ServiceMessage("적용기간이 겹치는 다른 이벤트에 등록된 상품이 존재합니다.\n"+str).setResultStatus(ResultStatus.Fail));
		}
		
		return result;
	}
	
	/**
	 * 스템프 기준관리 등록
	 * @param param 
	 */
	public void insertStamp(Parameter param){
		
		Parameter subParam = DataUtil.makeUserAddedParameter();

		// 스탬프 pk
		String noStamp = smDAO.insertTbsStamp(DataUtil.makeUserAddedParameter(param));
		subParam.set("NO_STAMP", noStamp);
		
		// 적립기준 메뉴 데이터
	    String [] strMenu    = param.getValues("STR_MENU");

		// 메뉴 수만큼 반복
		for(int i = 0; i < strMenu.length; i++){
			
			subParam.setParameter("CD_GRADE", strMenu[i].split("/")[0]);
			subParam.setParameter("CD_MENU", strMenu[i].split("/")[1]);
//			subParam.setParameter("NM_MENU", strMenu[i].split("/")[2].toString().split("\\)")[1].toString());
			subParam.setParameter("NM_MENU", strMenu[i].split("/")[2].toString());
			subParam.setParameter("CNT_ACCML", strMenu[i].split("/")[3]);
			subParam.setParameter("FG_USE", strMenu[i].split("/")[4]);
			
    		// 상품등록
    		smDAO.insertStampRole(subParam);
		};
	    // 등급 수 만큼 반복 end

	    
	    // 제외매장 데이터
	    String [] cdStore  = param.getValues("CD_STORE");
		String [] nmStore  = param.getValues("NM_STORE");
		 // 제외매장 개수
		int cnt = cdStore.length;
		// 제외매장 등록
		for(int i = 0; i < cnt; i++){
			subParam.set("ID_STORE", cdStore[i]);
			subParam.set("NM_STORE", nmStore[i]);
			smDAO.insertStampExStore(subParam);
		}
		
		
		// 적립체널 데이터
		String [] pos 		= param.getValues("POS");
		String [] kiosk 	= param.getValues("KIOSK");
		String [] app 		= param.getValues("APP");
		String [] web 		= param.getValues("WEB");
		String [] mobileWeb	= param.getValues("MOBILEWEB");

		cnt = pos.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", pos[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", pos[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		cnt = kiosk.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", kiosk[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", kiosk[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		
		cnt = app.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", app[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", app[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		
		cnt = web.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", web[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", web[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		
		cnt = mobileWeb.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", mobileWeb[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", mobileWeb[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
	}
	
	
	
	
	/**
	 * 스탬프 상세 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getTbsStamp(Parameter param){
		return smDAO.getTbsStamp(param);
	}
	
	/**
	 * 스탬프 구입방법/채널 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getStampStnd(Parameter param){
		return smDAO.getStampStnd(param);
	}
	
	/**
	 * 스탬프 적립기준 메뉴 조회
	 * @param param 스템프 pk
	 * @return 목록정보
	 */
	public DataList getStampRole(Parameter param){
		return smDAO.getStampRole(param);
	}
	
	/**
	 * 스탬프 변경이력 조회
	 * @param param 스템프 pk
	 * @return 목록정보
	 */
	public DataList getStampRecode(Parameter param){
		return smDAO.getStampRecode(param);
	}
	
	
	/**
	 * 스템프 기준관리 수정
	 * @param param 
	 */
	public void updateStamp(Parameter param){
		
		Parameter subParam = DataUtil.makeUserAddedParameter(param);

		// 스탬프 pk
		subParam.set("NO_STAMP", param.get("NO_STAMP"));
		
		// 스탬프 이력 pk
		String noStampRecode = smDAO.insertTbsStampRecode(subParam);
		subParam.set("NO_STAMP_RECODE",noStampRecode);
		
		// 스탬프 이력 등록
		smDAO.insertStampRecode(subParam);
		
		// 스탬프 관련 데이터 삭제
		smDAO.deleteStampStnd(subParam);
		smDAO.deleteStampRole(subParam);
		smDAO.deleteStampExStore(subParam);
		
		
		// 스탬프 마스터 수정
		smDAO.updateTbsStamp(subParam);

	    
		// 적립기준 메뉴 데이터
	    String [] strMenu    = param.getValues("STR_MENU");

		// 메뉴 수만큼 반복
		for(int i = 0; i < strMenu.length; i++){
			
			subParam.setParameter("CD_GRADE", strMenu[i].split("/")[0]);
			subParam.setParameter("CD_MENU", strMenu[i].split("/")[1]);
//			subParam.setParameter("NM_MENU", strMenu[i].split("/")[2].toString().split("\\)").length > 1 ? strMenu[i].split("/")[2].toString().split("\\)")[1].toString() : strMenu[i].split("/")[2].toString().split("\\)")[0].toString());
			subParam.setParameter("NM_MENU", strMenu[i].split("/")[2].toString());
			subParam.setParameter("CNT_ACCML", strMenu[i].split("/")[3]);
			subParam.setParameter("FG_USE", strMenu[i].split("/")[4]);
			
    		// 상품등록
    		smDAO.insertStampRole(subParam);
		};
	    // 등급 수 만큼 반복 end
	    
	    // 제외매장 데이터
	    String [] cdStore  = param.getValues("CD_STORE");
		String [] nmStore  = param.getValues("NM_STORE");
		 // 제외매장 개수
		int cnt = cdStore.length;
		// 제외매장 등록
		for(int i = 0; i < cnt; i++){
			subParam.set("ID_STORE", cdStore[i]);
			subParam.set("NM_STORE", nmStore[i]);
			smDAO.insertStampExStore(subParam);
		}
		
		
		// 적립체널 데이터
		String [] pos 		= param.getValues("POS");
		String [] kiosk 	= param.getValues("KIOSK");
		String [] app 		= param.getValues("APP");
		String [] web 		= param.getValues("WEB");
		String [] mobileWeb	= param.getValues("MOBILEWEB");

		cnt = pos.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", pos[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", pos[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		cnt = kiosk.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", kiosk[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", kiosk[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		
		cnt = app.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", app[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", app[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		
		cnt = web.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", web[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", web[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
		
		cnt = mobileWeb.length;
		for(int i = 0; i < cnt; i++){
			subParam.set("CD_MTH_PURCHS", mobileWeb[i].substring(0, 2));
			subParam.set("CD_ORDER_CHNN", mobileWeb[i].substring(2, 4));
			smDAO.insertStampStnd(subParam);
		}
	}
	
	/**
	 * 스탬프 상세 이력 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getTbsStampRecord(Parameter param){
		return smDAO.getTbsStampRecord(param);
	}
	
	/**
	 * 스탬프 구입방법/채널 이력 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getStampStndRecord(Parameter param){
		return smDAO.getStampStndRecord(param);
	}
	
	/**
	 *  
	 * @param param 스템프 pk
	 * @return 목록정보
	 */
	public DataList getStampRoleRecord(Parameter param){
		return smDAO.getStampRoleRecord(param);
	}
	
	/**
	 * 스탬프 기준관리 삭제
	 * @param param 스탬프pk
	 */
	public void deleteStamp(Parameter param){
		smDAO.deleteStamp(DataUtil.makeUserAddedParameter(param));
	}
	
	/**
	 * 적립혜택 쿠폰 등록
	 * @param param 쿠폰 정보
	 */
	public void insertStampReward(Parameter param){
		param = DataUtil.makeUserAddedParameter(param);
		
		// 기존 쿠폰 삭제 처리
		smDAO.deleteStampReward(param);
		
		String [] CNT5 = param.getValues("STR_COUPON5");
		String [] CNT10 = param.getValues("STR_COUPON10");
		
		for(int i = 0; i < CNT5.length; i++){
			if(CNT5[i].split("/").length > 1){
				param.set("CNT_STAMP_REWARD", "5");
				param.set("CD_COUPON",CNT5[i].split("/")[0].toString());
				param.set("NM_COUPON",CNT5[i].split("/")[1].toString());
				param.set("ORDER_NO", i+1);
				smDAO.insertStampReward(param);
			}
		}
		
		for(int i = 0; i < CNT10.length; i++){
			if(CNT10[i].split("/").length > 1){
				param.set("CNT_STAMP_REWARD", "10");
				param.set("CD_COUPON",CNT10[i].split("/")[0].toString());
				param.set("NM_COUPON",CNT10[i].split("/")[1].toString());
				param.set("ORDER_NO", i+1);
				smDAO.insertStampReward(param);
			};
			
		}
	}
	
	/**
	 * 스탬프 리워드 쿠폰 목록 조회
	 * @return 목록 정보
	 */
	public DataList getStampReward (){
		return smDAO.getStampReward();
	}
	
	
	
	/**
	 * 2019.05.23 강현준 추가
	 * @param param 3뎁스 메뉴코드
	 * @return 1,2단계 메뉴코드
	 */
	public DataList getUpMenuCode(Parameter param){
		return smDAO.getUpMenuCode(param);
	}
}
