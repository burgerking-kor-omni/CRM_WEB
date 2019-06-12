package com.ubone.standard.cust.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.sequence.BizSeqRepository;
import com.ubone.standard.common.encrypto.IwtCrypt;
import com.ubone.standard.common.encrypto.Passwdcrypt;
import com.ubone.standard.cust.dao.CustManageDAO;
import com.ubone.standard.cust.dao.CustManageRimsDAO;
import com.ubone.standard.system.log.dao.LogManageDAO;


@Service
public class CustManageSO {
	@Resource
	private CustManageDAO custDAO;
	@Resource
	private CustManageRimsDAO custRimsDAO;
	
	@Resource
	private LogManageDAO logDAO;
	
	@Resource
	private BizSeqRepository bizSeqRepository;
	
	/**
	 * 고객 목록 조회
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getCustList(Parameter param){
		
		DataList result = DataUtil.makeDataList("");
		
		try {
			if(!param.get("NM_MEMBER_SEARCH").isEmpty()){
				param.set("NM_MEMBER", IwtCrypt.aesEncryptHex(param.get("NM_MEMBER_SEARCH")));
			}
			if(!param.get("NO_PHONE_SEARCH").isEmpty()){
				param.set("NO_PHONE", IwtCrypt.aesEncryptHex(param.get("NO_PHONE_SEARCH").replaceAll("-", "")));
			}
			result = custDAO.getCustList(param);
			
			for(int i=0; i < result.getRowCount(); i++){
				if(result.get(i, "NM_MEMBER").toString().length() >= 32){
					result.set(i, "NM_MEMBER", IwtCrypt.aesDecryptHex(result.get(i, "NM_MEMBER").toString()) );					
				}
				if(result.get(i, "NO_PHONE").toString().length() >= 32){
					result.set(i, "NO_PHONE", IwtCrypt.aesDecryptHex(result.get(i, "NO_PHONE").toString()) );					
				}
			}
			
			// 고객정보 조회로그 등록
			Parameter logParam = DataUtil.makeUserAddedParameter();
			logParam.set("SCREEN_ID", "CUS0001");
			logDAO.insertPrivacyLog(logParam);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 고객 상세 조회
	 * @param param 고객 ID_MEMBER
	 * @return 상세정보
	 */
	public DataList getCustDetail(Parameter param) throws Exception{
		DataList result = custDAO.getCustDetail(param);
		
		// 이름 연락처 복호화
		if(result.get(0, "NM_MEMBER").toString().length() >= 32){
			result.set(0, "NM_MEMBER", IwtCrypt.aesDecryptHex(result.get(0, "NM_MEMBER").toString()) );					
		}
		if(result.get(0, "NO_PHONE").toString().length() >= 32){
			result.set(0, "NO_PHONE", IwtCrypt.aesDecryptHex(result.get(0, "NO_PHONE").toString()) );					
		}
		
		// 고객정보 조회로그 등록
		Parameter logParam = DataUtil.makeUserAddedParameter();
		logParam.set("ID_ADDR", logParam.get("lastLoginIp"));
		logParam.set("SCREEN_ID", "CUS0002");
		logDAO.insertPrivacyLog(logParam);
		
		return result;
	}
	
	/**
	 * 고객 회원탈퇴 처리
	 * @param param 고객 ID_MEMBER
	 */
	public void deleteMember(Parameter param){
		DataList dtMember = custDAO.getCustDetail(param);
		
		if (0 < dtMember.getRowCount()) {
			Parameter delParam = DataUtil.makeParameter();
			delParam = DataUtil.makeUserAddedParameter(delParam);
			delParam.setParameter("ID_MEMBER", param.getParameter("ID_MEMBER"));
			delParam.setParameter("TP_DEL", "99");
			delParam.setParameter("DS_DEL", "관리자 탈퇴처리.");
			delParam.setParameter("CD_AGE", dtMember.getString(0, "CD_AGE_DEL"));
			delParam.setParameter("CD_GENDER", dtMember.getString(0, "CD_GENDER"));
			delParam.setParameter("CD_GRADE", dtMember.getString(0, "CD_GRADE"));
			custDAO.insertDelMember(delParam);

			// 2-2. 회원 탈퇴
			custDAO.deleteMember(delParam);
			
			// 2-3. 회원 주소 탈퇴
			custDAO.deletelMemberAddr(delParam);
		
			// 2-4. 회원 SNS 탈퇴
			custDAO.deletelSnsMember(delParam);
		}
	}
	
	/**
	 * 고객 비밀번호 초기화
	 * @param param
	 */
	public void resetPasswd(Parameter param){
		
		// 초기화 비밀번호
		String passwd = Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5("123456789"));

		param = DataUtil.makeUserAddedParameter(param);
		param.set("PASSWD", passwd);
		
		custDAO.resetPasswd(param);
	}
	
	/**
	 * 고객상세 진행중 주문 탭  조회
	 * @param param 멤버id 
	 * @return 목록
	 */
	public DataList getOrderList (Parameter param){
		return custDAO.getOrderList(param);
	}
	
	/**
	 * 주문상세 팝업 조회
	 * @param param
	 * @return
	 */
	public DataList getOrderDetail (Parameter param){
		return custDAO.getOrderDetail(param);
	}
	
	/**
	 * 주문상세 팝업 메뉴 목록 조회
	 * @param param
	 * @return
	 */
	public DataList getProdList (Parameter param){
		return custDAO.getProdList(param);
	}
	
	/**
	 * 주문상세 팝업 구성품 목록 조회
	 * @param param
	 * @return
	 */
	public DataList getOptionList (Parameter param){
		return custDAO.getOptionList(param);
	}
	
	/**
	 * 주문상세 팝업 사용쿠폰 목록 조회
	 * @param param
	 * @return
	 */
	public DataList getCouponListUse (Parameter param){
		return custDAO.getCouponListUse(param);
	}

	
	/**
	 * 고객상세 탭 rims 완료 주문 목록  조회
	 * @param param 멤버id
	 * @return 주문 목록
	 */
	public DataList getOrderListRims (Parameter param){
//		return custRimsDAO.getOrderListRims(param);
		return custDAO.getOrderList(param);
	}
	
	/**
	 * 고객상세 탭 rims 주문 상세  조회
	 * @param param ORDER_NO, STOR_CD, POS_NO, SALE_DT
	 * @return 상세정보
	 */
	public DataList getOrderDetailRims (Parameter param){
		return custRimsDAO.getOrderDetailRims(param);
	}
	
	/**
	 * 주문상세 팝업 메뉴 목록 조회
	 * @param param
	 * @return
	 */
	public DataList getProdListRims (Parameter param){
		return custRimsDAO.getProdListRims(param);
	}
	
	public DataList getCouponUseListRims(Parameter param){
		DataList result = DataUtil.makeDataList("result");
		DataList rimsCpnList = custRimsDAO.getCouponListUseRims(param);
		int cnt = rimsCpnList.getRowCount();
		for(int i = 0; i < cnt; i++){
			param.set("CPN_NO", rimsCpnList.getString(i, "CPN_NO"));
			result.addRow(custDAO.getCouponInfo(param).getRow(0));
		}
		
		return result;
	}
	
	/**
	 * 고객상세 변경이력탭 조회
	 * @param param 멤버id
	 * @return 각항목 및 횟수
	 * @throws Exception 
	 */
	public DataList getCustLog_Change (Parameter param) throws Exception{
		DataList result = custDAO.getCustLogChange(param);
		int cnt = result.getRowCount();
		for(int i = 0; i < cnt; i++){
			if(!result.get(i, "NM_REG_USER").toString().contains("관리자")){
				result.set(i, "NM_REG_USER", IwtCrypt.aesDecryptHex(result.getString(i, "NM_REG_USER").toString()) );
			};
		}
		return result;
	}

	/**
	 * 고객상세 스탬프탭 조회
	 * @param param 고객정보
	 * @return 목록정보
	 */
	public DataList getCustLog_Stamp(Parameter param){
		DataList result = custDAO.getCustLogStamp(param);
		int rowCnt = result.getRowCount();
		for(int i = 0; i < rowCnt; i++){
			if("05".equals(result.get(i, "TP_INCREMENT").toString())){
				result.set(i, "NM_INCREMENT", result.get(i,"NM_INCREMENT").toString() + 
						" ("+ result.get(i,"ID_REG_USER").toString() +
						" / "+ result.get(i,"NM_REG_USER").toString() + ")"
						);
			}
		}
		return result;
	}
	
	/**
	 * 고객상세 선물함 조회
	 * @param param 고객 ID_MEMBER
	 * @return 목록정보
	 */
	// 보낸 선물함
	public DataList getSendGift(Parameter param){
		return custDAO.getSendGift(param);
	}
	// 받은 선물함
	public DataList getRecvGift(Parameter param){
		return custDAO.getRecvGift(param);
	}
	
	/**
	 * 고객상세 연동SNS 조회
	 * @param param 고객 ID_MEMBER
	 * @return 목록 정보
	 */
	public DataList getSnsList(Parameter param){
		return custDAO.getSnsList(param);
	}
	
	/**
	 * 주문 상품 이력 조회
	 * @param param
	 * @return
	 */
	public DataList getOrderProd(Parameter param){
		return custDAO.getOrderProd(param);
//		return custRimsDAO.getOrderProdRims(param);
	}
	
	/**
	 * 주문매장이력 목록 조회
	 * @param param 회원코드
	 * @return 목록정보
	 */
	public DataList getOrderStore(Parameter param){
//		return custRimsDAO.getOrderStore(param);
		return custDAO.getOrderStore(param);
	}
	
	/**
	 * 구매방법 이력 목록 조회
	 * @param param 회원코드
	 * @return 목록정보
	 */
	public DataList getPaymentList(Parameter param){
//		return custRimsDAO.getPaymentList(param);
		return custDAO.getPaymentList(param);
	}
	
	/**
	 * 구매채널이력 조회
	 * @param param 회원코드
	 * @return 목록정보
	 */
	public DataList getPayChannel(Parameter param){
//		return custRimsDAO.getPayChannel(param);
		return custDAO.getPayChannel(param);
	}
	
	/**
	 * 주문 목록 팝업 조회
	 * @param param 회원pk, 검색조건
	 * @return 목록정보
	 */
	public DataList getOrderListPopup(Parameter param){
//		return custRimsDAO.getOrderListPopup(param);
		return custDAO.getOrderListPopup(param);
	}
	
	/**
	 * 쿠폰 사용이력 목록 조회
	 * @param param 회원Pk
	 * @return 목록 정보
	 */
	public DataList getUseCouponList (Parameter param){
		DataList result = custDAO.getUseCouponList(param);
		return result;
	}
	
	/**
	 * 보유쿠폰 목록 조회
	 * @param param 회원코드
	 * @return 목록정보
	 */
	public DataList getHaveCouponList(Parameter param){
		DataList result = custDAO.getHaveCouponList(param);
//		int rowCnt = result.getRowCount();
//		for(int i = 0; i < rowCnt; i++){
//			result.set(i, "VAL_SALE_POLICY", String.format("%,d", Integer.parseInt(result.get(i, "VAL_SALE_POLICY").toString())));
//			if(result.get(i, "CD_SALE_POLICY").toString() == "2"){
//				result.set(i, "CD_SALE_POLICY", "정율할인 "+result.get(i,"VAL_SALE_POLICY").toString() + " %");
//			}else{
//				result.set(i, "CD_SALE_POLICY", "정액할인 "+result.get(i,"VAL_SALE_POLICY").toString() + " 원");
//			}
//		}
		
		return result;
	}
	
	/**
	 * 킹머니이력 조회
	 * @param param 회원코드
	 * @return 목록정보
	 */
	public DataList getMoneyList(Parameter param){
		return custDAO.getMoneyList(param);
	}
	
	
	
	
	
	
	
	
	/**
	 * 고객 등급목록 조회
	 * @return 목록정보
	 */
	public DataList getGradeList(){
		return custDAO.getGradeList();
	}
	
	/**
	 * 고객 등급상세 조회
	 * @param param 등급코드
	 * @return 상세정보
	 */
	public DataList getGradeDetail(Parameter param){
		return custDAO.getGradeDetail(param);
	}
	
	/**
	 * 등급 신규등록
	 * @param param 등급정보
	 */
	public void insertGrade(Parameter param){
		param.set("CNT_MAX_STAMP", param.get("CNT_MAX_STAMP").replaceAll(",",""));
		param.set("CNT_MIN_STAMP", param.get("CNT_MIN_STAMP").replaceAll(",",""));
		manageDownStd(param);
		custDAO.insertGrade(DataUtil.makeUserAddedParameter(param));
	}
	
	/**
	 * 등급 상세 수정
	 * @param param 등급정보
	 * @return 수정여부
	 */
	public int updateGrade(Parameter param){
		param.set("CNT_MAX_STAMP", param.get("CNT_MAX_STAMP").replaceAll(",",""));
		param.set("CNT_MIN_STAMP", param.get("CNT_MIN_STAMP").replaceAll(",",""));
		manageDownStd(param);
		return custDAO.updateGradeDetail(param);
	}
	
	/**
	 * 등급 삭제 처리
	 * @param param 등급코드
	 */
	public void deleteGrade (Parameter param){
		custDAO.deleteGrade(DataUtil.makeUserAddedParameter(param));
	}
	
	
	/**
	 * 등급 하향기준 관리
	 * @param param 기준값
	 */
	public void manageDownStd(Parameter param){
		String currval = param.get("CD_DOWN_STAD");
		String downstd = custDAO.getDownStd().get("CD_DOWN_STAD");
		if(!currval.equals(downstd)){
			custDAO.deleteDownStd();
			custDAO.insertDownStd(DataUtil.makeUserAddedParameter(param));
		}
	}
	
	/**
	 * 등급하향 기준 조회
	 * @return 기간
	 */
	public DataList getDownStd (){
		return custDAO.getDownStd();
	}
	
	/**
	 * 쿠폰 전체 리스트
	 * @param param
	 * @return 쿠폰 전체리스트
	 */
	public DataList getCouponList(Parameter param){
		return custDAO.getCouponList(param);
	}
	
	/**
	 * 선불카드 목록 조회
	 * @param param id_member
	 * @return 목록 정보
	 */
	public DataList getCardList(Parameter param){
		return custDAO.getCardList(param);
	}
	
	/**
	 * 관리자 스탬프 추가 기능
	 * @param param 스탬프 개수, 멤버id
	 */
	public void addStampAdmin(Parameter param){
		param = DataUtil.makeUserAddedParameter(param);
		// 현 최종 누적 스탬프 개수 조회
		DataList lastStamp = custDAO.getStampCntLast(param);
		int lastCnt = 0;
		if(lastStamp.getRowCount() > 0){
			lastCnt = Integer.parseInt(lastStamp.get(0, "CNT_STAMP_STACK").toString())
					+ Integer.parseInt(param.get("CNT_STAMP"));
		}else{
			lastCnt = Integer.parseInt(param.get("CNT_STAMP"));
		}

		// 계산된 최종 누적 스탬프 개수 세팅
		param.set("CNT_STAMP_STACK", lastCnt);
		
		// 최종 스탬프 이력 등록
		custDAO.addStampRecord(param);
		// 멤버테이블에 최종 스탬프 누적개수 수정
		custDAO.updateStampMember(param);
		
		// 적립된 스탬프개수
		DataList cntMstamp = custDAO.getCountStamp(param);
		
		// 발급 받아야 할 리워드 쿠폰 개수
		int cnt5 = Integer.parseInt(cntMstamp.getString(0, "CNT_FIVE")) - Integer.parseInt(cntMstamp.getString(0, "CNT_TEN"));
		int cnt10 = Integer.parseInt(cntMstamp.getString(0, "CNT_TEN"));
		
		// 이전에 발행된 리워드 쿠폰 개수 조회
		DataList Rewardcnt = custDAO.getCountReward(param);
		String tpReward = "";
		
		// 리워드 쿠폰 발행 시 id_member 기본 세팅
		Parameter rewardParam = DataUtil.makeUserAddedParameter();
		rewardParam.setParameter("ID_MEMBER", param.get("ID_MEMBER"));
		
		for(int i = 0; i < Rewardcnt.getRowCount(); i++){
			tpReward = Rewardcnt.getString(i, "TP_REWARD");
			if(tpReward.equals("5")){
				cnt5 = cnt5 - Integer.parseInt(Rewardcnt.getString(i, "CNT"));
				for(int j = 0; j < cnt5; j++){
					rewardParam.setParameter("TP_REWARD", tpReward);
					// 리워드 쿠폰 발행
					custDAO.addStampReward(rewardParam);
				}
			}else{
				cnt10 = cnt10 - Integer.parseInt(Rewardcnt.getString(i, "CNT"));
				for(int j = 0; j < cnt10; j++){
					rewardParam.setParameter("TP_REWARD", tpReward);
					// 리워드 쿠폰 발행
					custDAO.addStampReward(rewardParam);
				}
			}
		}
	}
}
