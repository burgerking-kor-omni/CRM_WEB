package com.ubone.standard.coupon.service;

import java.net.URL;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ubone.framework.ConfigHolder;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.data.ServiceMessage;
import com.ubone.framework.type.ResultStatus;
import com.ubone.standard.common.encrypto.IwtCrypt;
import com.ubone.standard.coupon.dao.CouponManageDAO;
import com.ubone.framework.util.UUIDUtil;
import com.ubone.framework.util.file.FileSupport;
import com.ubone.framework.util.file.FileSupport.FileMethodType;

@Service
public class CouponManageSO {

	@Resource
	private CouponManageDAO cmDAO;
	
	private String COOPER_ID = "";
	private String COOPER_PW = "";
	private String SITE_ID = "";
	private String DOMAIN = "";
	
	/**
	 * 다우 핀 가져오기 설정 등록
	 * @param param 설정정보
	 */
	public void insertDauPinConfig(Parameter param){
		DataList pinList = cmDAO.getDauPinConfig();
		if(pinList.getRowCount() > 0){
			cmDAO.delDauPinConfig(DataUtil.makeUserAddedParameter(param));
		}
		cmDAO.insertDauPinConfig(param);
	}

	/**
	 * 다우 핀 가져오기 설정 조회
	 * @return 
	 */
	public DataList getDauPinConfig (){ 
		return cmDAO.getDauPinConfig();
	}
	
	/**
	 * 쿠폰 마스터 목록 조회
	 * @param param 검색조건
	 * @return 목록 정보
	 */
	public DataList getCouponList(Parameter param){
		return cmDAO.getCouponList(param);
	}
	
	/**
	 * 쿠폰 핀 현황 조회
	 * @param param 쿠폰 코드
	 * @return 현황정보
	 */
	public DataList getPinStatus (Parameter param){
		DataList result = cmDAO.getPinStatus(param);
		String flag = result.getString(0, "YN_FLAG");
		result.addColumns("TXT_STATUS");
		if(flag.equals("0")){
			result.set(0, "TXT_STATUS", "발행가능");
		}else{
			result.set(0, "TXT_STATUS", "발행 대기중");
		}
		return result;
	}
	
	/**
	 * 쿠폰 핀 발행 대상 조회
	 * @param param 검색조건
	 * @return 회원정보
	 */
	public DataList getMemberID(Parameter param) throws Exception{
		DataList result = cmDAO.getMemberID(param);
		
		if(result.getRowCount() > 0){
			String nm_member = IwtCrypt.aesDecryptHex(result.getString(0, "NM_MEMBER"));
			result.set(0, "NM_MEMBER", nm_member);
		}
		
		return result;
	}
	
	/**
	 * 쿠폰 핀 발행
	 * @param param 쿠폰,멤버정보
	 */
	public Result publishCoupon (Parameter param){
		Result result = DataUtil.makeResult();
		String[] members = param.getValues("ID_MEMBERS"); 
		int cnt = members.length;
		
		for(int i = 0; i < cnt; i++){
			// id_memeber 세팅
			param.set("ID_MEMBER", members[i]);
			// 쿠폰 발급
			cmDAO.publishCouponBkr(param);
		}
		return result;
	}
	
	/**
	 * 쿠폰 핀 발행 중복 체크
	 * @param param 쿠폰 id, 멤버id
	 * @return 중복여부
	 */
	public Result checkOverCoupon(Parameter param){
		
		Result result = DataUtil.makeResult();
		
		DataList cnt_check = cmDAO.checkOverCoupon(param);
		
		if(!cnt_check.get(0,"CNT").equals("0")){
			return result.setServiceMessage(new ServiceMessage("이미 발급 받은 회원입니다.").setResultStatus(ResultStatus.Fail));
		}
		
		return result.setServiceMessage(new ServiceMessage().setResultStatus(ResultStatus.Success));
	}
	
	/**
	 * 다우 쿠폰 상품 선택 리스트 조회
	 * @return 목록 정보
	 */
	public DataList getDauProdList() throws Exception{
		
		// 다우 접속정보 셋팅
		setDauString();
		
		// 다우 상품 다운로드 url
		String daouProductListApiUrl = "/B2CCoupon/B2CService.aspx?ACTION=CC01_DOWN_ALL_GOODSINFO";
		
		
		// url 세팅
		StringBuilder queryStringBuilder = new StringBuilder();
		queryStringBuilder.append("COOPER_ID=" + COOPER_ID);
		queryStringBuilder.append("&COOPER_PW=" + COOPER_PW);
		queryStringBuilder.append("&SITE_ID=" + SITE_ID);

		StringBuilder urlBuilder = new StringBuilder();
		urlBuilder.append(DOMAIN);
		urlBuilder.append(daouProductListApiUrl);
		urlBuilder.append("&" + queryStringBuilder.toString());
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(new URL(urlBuilder.toString()).openStream());
		
		NodeList nl = doc.getElementsByTagName("GOODS_INFO");
		List<Map<String, Object>> list = new LinkedList<Map<String,Object>>();
		NumberFormat format = NumberFormat.getNumberInstance();
		
		if (nl != null && nl.getLength() > 0) {
	        for (int i = 0; i < nl.getLength(); i++) {
	            if (nl.item(i).getNodeType() == Node.ELEMENT_NODE) {
	            	Map<String, Object> data = new HashMap<String, Object>();

	            	Element el = (Element) nl.item(i);
	            	data.put("NO_REQ",					el.getElementsByTagName("NO_REQ").item(0).getTextContent());
	                data.put("NM_REQ",					el.getElementsByTagName("NM_REQ").item(0).getTextContent());
	                data.put("VALID_START",				el.getElementsByTagName("VALID_START").item(0).getTextContent());
	                data.put("VALID_END",				el.getElementsByTagName("VALID_END").item(0).getTextContent());
	                data.put("DT_VALID",				el.getElementsByTagName("VALID_START").item(0).getTextContent().substring(0, 4)+ "-" + el.getElementsByTagName("VALID_START").item(0).getTextContent().substring(4, 6) + "-" + el.getElementsByTagName("VALID_START").item(0).getTextContent().substring(6, 8) 
	                									+ " ~ " 
	                									+ el.getElementsByTagName("VALID_END").item(0).getTextContent().substring(0, 4)+ "-" + el.getElementsByTagName("VALID_END").item(0).getTextContent().substring(4, 6) + "-" + el.getElementsByTagName("VALID_END").item(0).getTextContent().substring(6, 8));
	                data.put("NO_GOODS",				el.getElementsByTagName("NO_GOODS").item(0).getTextContent());
	                data.put("NM_GOODS",				el.getElementsByTagName("NM_GOODS").item(0).getTextContent());
	                data.put("SITE_ID",					el.getElementsByTagName("SITE_ID").item(0).getTextContent());
	                data.put("GOODS_COMPANY",			el.getElementsByTagName("GOODS_COMPANY").item(0).getTextContent());
	                data.put("NM_GOODS_COMPANY",		el.getElementsByTagName("NM_GOODS_COMPANY").item(0).getTextContent());
	                data.put("GOODS_COMPANY_CHARGE",	el.getElementsByTagName("GOODS_COMPANY_CHARGE").item(0).getTextContent());
	                data.put("GOODS_PRICE",				Long.valueOf(el.getElementsByTagName("GOODS_PRICE").item(0).getTextContent()).longValue());
	                data.put("GOODS_CNT",				Long.valueOf(el.getElementsByTagName("GOODS_CNT").item(0).getTextContent()).longValue());
	                data.put("CPN_PRICE",				format.format(Long.valueOf(el.getElementsByTagName("CPN_PRICE").item(0).getTextContent()).longValue()) + " 원" ) ;
	                data.put("DISCOUNT_PRICE",			Long.valueOf(el.getElementsByTagName("DISCOUNT_PRICE").item(0).getTextContent()).longValue());
	                data.put("GOODS_DISCOUNT",			Long.valueOf(el.getElementsByTagName("GOODS_DISCOUNT").item(0).getTextContent()).longValue());
	                data.put("YN_CHANGED",				el.getElementsByTagName("YN_CHANGED").item(0).getTextContent());
	                data.put("CHANGED_DATE",			el.getElementsByTagName("CHANGED_DATE").item(0).getTextContent());
	                data.put("REG_DATE",				el.getElementsByTagName("REG_DATE").item(0).getTextContent().substring(0, 4)+ "-" + el.getElementsByTagName("REG_DATE").item(0).getTextContent().substring(4, 6) + "-" + el.getElementsByTagName("REG_DATE").item(0).getTextContent().substring(6, 8));
	                data.put("GOODS_IMAGE",				el.getElementsByTagName("GOODS_IMAGE").item(0).getTextContent());
	                data.put("IMG_SRC",					el.getElementsByTagName("GOODS_IMAGE").item(0).getTextContent());

	                list.add(data);
	            }
	        }
	    }
		
		DataList returnDataList = DataUtil.makeDataList("result", list);
		
		return returnDataList;
	}
	
	/**
	 * 쿠폰 마스터 등록  
	 * @param param 쿠폰 정보
	 */
	public void insertCoupon (Parameter param){
		
		// 쿠폰 등록
		String cd_coupon = cmDAO.insertCoupon(DataUtil.makeUserAddedParameter(param));
		param.set("CD_COUPON", cd_coupon);
		
		// 제외매장 개수
		String [] CD_STORE = param.getValues("CD_STORE");
		String [] NM_STORE = param.getValues("NM_STORE");
		int cnt = CD_STORE.length;
		
		// 제외매장 등록
		for(int i = 0; i < cnt; i++){
			if(!NM_STORE[i].equals("0") && !CD_STORE[i].equals("0")){
				param.set("ID_STORE_EXCEPT", CD_STORE[i]);
				param.set("NM_STORE_EXCEPT", NM_STORE[i]);
				cmDAO.insertStoreEx(param);
			}
		}
		
	}
	
	/**
	 * 상품 찾기 팝업
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getMenuList (Parameter param){
		return cmDAO.getMenuList(param);
	}

	
	/**
	 * 쿠폰 순서 수정
	 * @param param 쿠폰pk, 순서
	 */
	public void updateCouponOrder(Parameter param){
		Parameter orderParam = DataUtil.makeParameter();
		
		String [] cd_coupons = param.getValues("CD_COUPON");
		String [] no_order = param.getValues("NO_COUPON_ORDER");
		
		int cnt = cd_coupons.length;
		for(int i = 0; i < cnt; i++){
			orderParam.set("CD_COUPON", cd_coupons[i]);
			orderParam.set("NO_COUPON_ORDER", no_order[i]);
			orderParam.set("DT_EXPIRY_START", param.getValue("DT_EXPIRY_START_ORDER"));
			orderParam.set("DT_EXPIRY_END", param.getValue("DT_EXPIRY_END_ORDER"));
			cmDAO.updateCouponOrder(orderParam);
		}
		
	}
	
	public Result checkDauPinStatus(Parameter param){
		Result result = DataUtil.makeResult();
		String flag = cmDAO.checkDauPinStatus(param);
		if(!"Y".equals(flag)){
			return result.setServiceMessage(new ServiceMessage("현재 발행 대기 중인 쿠폰입니다.").setResultStatus(ResultStatus.Fail));
		}else{
			insertDauPin(param);
		}
		return result.setServiceMessage(new ServiceMessage().setResultStatus(ResultStatus.Success));
	}
	
	/**
	 * 다우 쿠폰 핀 발행
	 * @param param
	 * @throws Exception
	 */
	public void insertDauPin(Parameter param){
		
		// 난수 설정
		param.set("COOPER_ORDER", UUID.randomUUID().toString());
		
		cmDAO.insertDauPin(DataUtil.makeUserAddedParameter(param));
	}
	
	/**
	 * 쿠폰 마스터 상세조회
	 * @param param 쿠폰pk
	 * @return 상세정보
	 */
	public DataList getCouponDetail(Parameter param){
		return cmDAO.getCouponDetail(param);
	}
	
	/**
	 * 쿠폰 마스터 수정
	 * @param param 쿠폰pk, 제외매장 목록
	 */
	@FileSupport(primaryKeyFieldNames="CD_COUPON", methodType=FileMethodType.UPDATE)
	public void updateCouponDetail(Parameter param){
		
		// 쿠폰 마스터 수정
		cmDAO.updateCouponDetail(DataUtil.makeUserAddedParameter(param));
		
		// 제외매장 삭제
		cmDAO.deleteStoreEx(param);
		
		// 제외매장 개수
		String [] CD_STORE = param.getValues("CD_STORE");
		String [] NM_STORE = param.getValues("NM_STORE");
		int cnt = CD_STORE.length;
		
		// 제외매장 등록
		for(int i = 0; i < cnt; i++){
			if(!NM_STORE[i].equals("0") && !CD_STORE[i].equals("0")){
				param.set("ID_STORE_EXCEPT", CD_STORE[i]);
				param.set("NM_STORE_EXCEPT", NM_STORE[i]);
				cmDAO.insertStoreEx(param);
			}
		}
	}
	
	/**
	 * 쿠폰 마스터 삭제
	 * @param param 쿠폰pk
	 */
	@FileSupport(primaryKeyFieldNames="CD_COUPON", methodType=FileMethodType.DELETE)
	public void deleteCouponDetail(Parameter param){
		// 제외매장 삭제
		cmDAO.deleteStoreEx(param);
		// 쿠폰삭제
		param = DataUtil.makeUserAddedParameter(param);
		cmDAO.deleteCouponDetail(param);
	}
	
	/*
	 * 다우 도메인 설정
	 */
	public void setDauString(){
		if("real".equals(ConfigHolder.APPLICATION_MODE)){
			DOMAIN		= ConfigHolder.get("dau.real.domain");
			SITE_ID		= ConfigHolder.get("dau.real.site.id");
			COOPER_ID	= ConfigHolder.get("dau.real.cooper.id");
			COOPER_PW	= ConfigHolder.get("dau.real.cooper.pw");
		}else {
			DOMAIN		= ConfigHolder.get("dau.dev.domain");
			SITE_ID		= ConfigHolder.get("dau.dev.site.id");
			COOPER_ID	= ConfigHolder.get("dau.dev.cooper.id");
			COOPER_PW	= ConfigHolder.get("dau.dev.cooper.pw");
		};
	}
	
	/**
	 * 리워드 쿠폰 현황 목록 조회
	 * @param param 발급일 조건
	 * @return 목록정보
	 */
	public DataList getRewardCouponList(Parameter param){
		return cmDAO.getRewardCouponList(param);
	}
	
	/**
	 * 스탬프 목록 조회
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getStampList(Parameter param){
		return cmDAO.getStampList(param);
	}
	
	/**
	 * 쿠폰마스터 재등록
	 * @param param 유효기간,쿠폰pk
	 */
	public void reInsertCoupon(Parameter param){
		// 쿠폰 마스터 재등록
		String CD_COUPON_NEW = cmDAO.reInsertCoupon(DataUtil.makeUserAddedParameter(param));
		param.set("CD_COUPON_NEW", CD_COUPON_NEW);
		
		// 제외매장 재등록
		cmDAO.reinsertStoreEx(param);

		// 기존 첨부파일 조회
		DataList attachData = cmDAO.getAttachCount(param);
		
		for(int i = 0;i < attachData.getRowCount(); i++){
			// attach 재등록
			param.set("ATTACH_ID", attachData.get(i, "ATTACH_ID"));
			param.set("ATTACH_ID_NEW", UUIDUtil.simpleId());
			cmDAO.insertAttach(param);
			
			// link 재등록
			param.set("ATTACH_LINK_ID", UUID.randomUUID().toString().replaceAll("-", ""));
			cmDAO.insertAttachLink(param);
		}
		
		
	}
}
