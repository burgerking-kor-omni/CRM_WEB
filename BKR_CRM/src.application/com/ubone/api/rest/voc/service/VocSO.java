package com.ubone.api.rest.voc.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import com.ubone.api.rest.common.constant.ApiCommon;
import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.voc.dao.VocDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.framework.util.StringUtils;
import com.ubone.framework.util.sequence.BizSeqRepository;
import com.ubone.standard.common.constant.AuthConstantHolder;
import com.ubone.standard.common.dispatch.dao.DispatchDAO;

/**
 * <pre>
 *  파 일 명  : AddressSO.java
 *  설    명   : API 회원주소용 SO
 *  작 성 자  : 
 *  작 성 일  : 2018.10.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * 
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */

@Service
public class VocSO {

	@Resource
	private ApiCommon apiCommon;

	@Resource
	private VocDAO vocDAO;
	
	@Resource
	private DispatchDAO dispatchDAO;
	
	@Resource
	private BizSeqRepository bizSeqRepository;

	/**
	 * 문의/클레임 등록 - (Web & APP & CallCenter)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result insertVoc(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. VOC 저장
		SimpleDateFormat fm1 = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
		String date = fm1.format(new Date());		

		String key = bizSeqRepository.nextVal("VOC", date);
		
		key = "VOC" + date + String.format("%04d", Integer.parseInt(key));
		parameter.setParameter("ID_VOC", key);
		
		vocDAO.insertVoc(parameter);
		
		// 2. 첨부파일 저장 - APP, WEB, Mobile Web 일때만 저장
		if ("01".equals(parameter.getParameter("BIZ_CHNN"))
				|| "02".equals(parameter.getParameter("BIZ_CHNN"))
				|| "03".equals(parameter.getParameter("BIZ_CHNN"))) {
			if (!StringUtils.isEmpty(parameter.getParameter("FILE_LIST"))) {
				JSONArray productList = new JSONArray(parameter.getParameter("FILE_LIST").toString());
				if (0 < productList.length()) {
					for (int i=0; i<productList.length(); i++) {
						JSONObject product = productList.getJSONObject(i);
						Parameter fileParam = DataUtil.makeParameter();
						fileParam.setParameter("ID_VOC", key);
						fileParam.setParameter("FILE_NM", product.getString("file_nm"));	// 파일명
						fileParam.setParameter("FILE_KEY", product.getString("file_key"));	// 파일키
						
						vocDAO.insertVocFile(fileParam);
					}
				}
			}
		}
		
		// 3. 통보 메일 발송
		// 3-1. 콜센터 예외처리
		if ("04".equals(parameter.getParameter("BIZ_CHNN"))) {
			if (ApiConstantHolder.FLAG_N.equals(parameter.getParameter("FG_IMM_PROCESS"))) {
				this.sendDispath(parameter, key);
			}
		} else {
			this.sendDispath(parameter, key);
		}
		
//		// 3-1. 통보실행이력 저장
//		Parameter disParam = DataUtil.makeParameter();
//		disParam.setParameter("TP_BIZ", "VOC");							// 업무구분
//		disParam.setParameter("ID_BIZ_KEY", key);						// 업무별ID
//		disParam.setParameter("DS_TITLE_DISPATCH", "VOC가 접수되었습니다.");	// 통보제목
//		disParam.setParameter("DS_DISPATCH", this.setMailContent(parameter));		// 통보내용
//		String idDispatch = dispatchDAO.insertDispatchRun(disParam);
//		
//		// 3-2. 통보대상자 조회
//		Parameter disSearchParam = DataUtil.makeParameter();
//		
//		// 유형이 요청일때는 IT 담당자에게 메일을 발송한다.
//		if ("05".equals(parameter.getParameter("CD_VOC_CAUSE"))) {
//			disSearchParam.setParameter("ROLE_ID", AuthConstantHolder.ROLE_IT_ADMIN);
//		} else {
//			disSearchParam.setParameter("ROLE_ID", AuthConstantHolder.ROLE_VOC_ADMIN);
//		}
//		DataList dtDispatch = dispatchDAO.getDispatchEmpTarget(disSearchParam);
//		
//		// 3-3. 통보대상자  저장
//		if (0 < dtDispatch.getRowCount()) {
//			for (int i=0; i<dtDispatch.getRowCount(); i++) {
//				Parameter targetParam = DataUtil.makeParameter();
//				targetParam.setParameter("ID_DISPATCH_RUN", idDispatch);									// 통보실행ID
//				targetParam.setParameter("TP_DISPATCH_TARGET", "02");										// 통보대상자구분
//				targetParam.setParameter("ID_EMP_DISPATCH_TARGET", dtDispatch.getString(i, "USER_ID"));		// 통보대상직원
//				targetParam.setParameter("ID_DEPT_DISPATCH_TARGET", dtDispatch.getString(i, "DEPT_ID"));	// 통보대상부서
//				targetParam.setParameter("DS_EMAIL_RECV", dtDispatch.getString(i, "EMAIL_DS"));				// 받는메일
//				
//				dispatchDAO.insertDispatchRunTarget(targetParam);
//			}
//		}
		
		// 4. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 등록되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 5. VOC key 셋팅
		resultData.put("id_voc", key);                     // VOC key
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	private void sendDispath(Parameter parameter, String key) {
		Parameter disParam = DataUtil.makeParameter();
		
		DataList dt = vocDAO.getMailSendCause(parameter);
		String nmVocCause = "";
		if (0 < dt.getRowCount()) {
			nmVocCause = dt.getString(0, "NM_VOC_CAUSE");
		}
		
		disParam.setParameter("TP_BIZ", "VOC");							// 업무구분
		disParam.setParameter("ID_BIZ_KEY", key);						// 업무별ID
		disParam.setParameter("DS_TITLE_DISPATCH", "[" + nmVocCause + "] " + parameter.getParameter("DS_TITLE"));	// 통보제목
		disParam.setParameter("DS_DISPATCH", this.setMailContent(parameter, key, nmVocCause));		// 통보내용
		String idDispatch = dispatchDAO.insertDispatchRun(disParam);
		
		// 1. 통보대상자 조회
		Parameter disSearchParam = DataUtil.makeParameter();
		
		// 유형이 요청일때는 IT 담당자에게 메일을 발송한다.
		if ("05001".equals(parameter.getParameter("CD_VOC_CAUSE"))) {
			disSearchParam.setParameter("ROLE_ID", AuthConstantHolder.ROLE_IT_ADMIN);
		} else {
			disSearchParam.setParameter("ROLE_ID", AuthConstantHolder.ROLE_VOC_ADMIN);
		}
		DataList dtDispatch = dispatchDAO.getDispatchEmpTarget(disSearchParam);
		
		// 1-1. 통보대상자  저장 - VOC 관리자 및 IT담당자
		if (0 < dtDispatch.getRowCount()) {
			for (int i=0; i<dtDispatch.getRowCount(); i++) {
				Parameter targetParam = DataUtil.makeParameter();
				targetParam.setParameter("ID_DISPATCH_RUN", idDispatch);									// 통보실행ID
				targetParam.setParameter("TP_DISPATCH_TARGET", "02");										// 통보대상자구분
				targetParam.setParameter("ID_EMP_DISPATCH_TARGET", dtDispatch.getString(i, "USER_ID"));		// 통보대상직원
				targetParam.setParameter("ID_DEPT_DISPATCH_TARGET", dtDispatch.getString(i, "DEPT_ID"));	// 통보대상부서
				targetParam.setParameter("DS_EMAIL_RECV", dtDispatch.getString(i, "EMAIL_DS"));				// 받는메일
				targetParam.setParameter("FG_REFERENCES", ApiConstantHolder.FLAG_N);						// 참조여부
				
				dispatchDAO.insertDispatchRunTarget(targetParam);
			}
		}
		
		if ("01".equals(parameter.getParameter("BIZ_CHNN"))
				|| "02".equals(parameter.getParameter("BIZ_CHNN"))
				|| "03".equals(parameter.getParameter("BIZ_CHNN"))) {	// APP, WEB, Mobile WEB 일때만 발송하는 대상
			// 2. 유형에 따른 메일 대상자 조회
			Parameter vocDispatchParam = DataUtil.makeParameter();
			vocDispatchParam.setParameter("CD_TARGET", parameter.getParameter("CD_VOC_CAUSE"));
			
			DataList dtVocDispatch = dispatchDAO.getVocDispatch(vocDispatchParam);
			
			// 2-1. 통보대상자  저장 - 유형별 메일 대상자
			if (0 < dtVocDispatch.getRowCount()) {
				for (int i=0; i<dtVocDispatch.getRowCount(); i++) {
					Parameter targetParam = DataUtil.makeParameter();
					targetParam.setParameter("ID_DISPATCH_RUN", idDispatch);									// 통보실행ID
					targetParam.setParameter("TP_DISPATCH_TARGET", "02");										// 통보대상자구분
					targetParam.setParameter("DS_EMAIL_RECV", dtVocDispatch.getString(i, "DS_EMAIL"));			// 받는메일
					targetParam.setParameter("FG_REFERENCES", dtVocDispatch.getString(i, "FG_CC"));				// 참조여부
					
					dispatchDAO.insertDispatchRunTarget(targetParam);
				}
			}
		}
	}
	
	/**
	 * 문의/클레임 수정 - (Web & APP & CallCenter)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result updateVoc(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. VOC 저장
		vocDAO.updateVoc(parameter);
		
		// 2. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 수정되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 3. VOC key 셋팅
		resultData.put("id_voc", parameter.getParameter("ID_VOC"));                     // VOC key
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	/**
	 * 문의/클레임 삭제 - (Web & APP & CallCenter)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result deleteVoc(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 저장을 위한 데이터 값 생성
		// 1-1. 주문여부
		if (StringUtils.isEmpty(parameter.getParameter("ORDER_NO"))) {
			parameter.setParameter("FG_ORDER", ApiConstantHolder.FLAG_N);
		} else {
			parameter.setParameter("FG_ORDER", ApiConstantHolder.FLAG_Y);
		}
		// 1-2. 회원여부
		if (StringUtils.isEmpty(parameter.getParameter("ID_MEMBER"))) {
			parameter.setParameter("FG_MEMBER", ApiConstantHolder.FLAG_N);
		} else {
			parameter.setParameter("FG_MEMBER", ApiConstantHolder.FLAG_Y);
		}
		
		// 2. VOC 삭제
		vocDAO.deleteVoc(parameter);
		
		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 삭제되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. VOC key 셋팅
		resultData.put("id_voc", parameter.getParameter("ID_VOC"));                     // VOC key
		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	public String setMailContent(Parameter parameter, String vocKey, String nmVocCause) {
		Parameter vocParam = DataUtil.makeParameter();
		vocParam.setParameter("ID_VOC", vocKey);
		DataList dtVoc = vocDAO.getMailData(vocParam);

		String html = "";
		
		html +="<table style=\"width:738px; margin:0 auto; font-size:15px; font-family:'Malgun Gothic', '맑은 고딕', dotum, '돋움',sans-serif; line-height:167%; border:1px solid #c5c5c5; border-collapse:collapse;\">";
		html +="	<tbody>";
		html +="	<tr>";
		html +="		<td style=\"padding:0; border:none;\"><img src=\"http://13.209.180.127/mail/mail_top02.gif\" alt=\"BURGER KING\" /></td>";
		html +="	</tr>";
		html +="	<tr>";
		html +="		<td style=\"padding:0; border:none;\">";
		html +="			<div style=\"padding:10px 32px;\">";
		html += "<table style=\"width:100%; margin:20px 0; font-size:14px; border-top:1px solid #999; border-collapse:collapse;\">";
		html += "<tbody>";
		html += "<tr>";
		html += "<th scope=\"row\" width=\"15%\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">문의구분</th>";
		html += "<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + nmVocCause + "</td>";
		html += "<th scope=\"row\" width=\"15%\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">문의시간</th>";
		html += "<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + dtVoc.getString(0, "DT_REG") + "</td>";
		html += "</tr>";
		html += "<tr>";
		html += "<th scope=\"row\" width=\"15%\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">매장명</th>";
		html += "<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + dtVoc.getString(0, "NM_STORE") + "</td>";
		html += "<th scope=\"row\" width=\"15%\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">작성자</th>";
		html += "<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + parameter.getParameter("NM_CUST_REAL") + "</td>";
		html += "</tr>";
		html += "<tr>";
		html += "<th scope=\"row\" width=\"15%\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">이메일</th>";
		html += "<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + dtVoc.getString(0, "DS_EMAIL") + "</td>";
		html += "<th scope=\"row\" width=\"15%\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">전화번호</th>";
		html += "<td style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + parameter.getParameter("NO_PHONE_REAL") + "</td>";
		html += "</tr>";
		html += "<tr>";
		html += "<th scope=\"row\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">제목</th>";
		html += "<td colspan=\"3\" style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + dtVoc.getString(0, "DS_TITLE") + "</td>";
		html += "</tr>";
		html += "<tr>";
		html += "<th scope=\"row\" style=\"height:30px; padding:10px 18px; font-weight:bold; text-align:left; background:#f4f4f4; border:1px solid #dcdcdc; border-left:none;\">내용</th>";
		html += "<td colspan=\"3\" style=\"height:30px; padding:10px 16px; text-align:left; border:1px solid #dcdcdc; border-right:none;\">" + dtVoc.getString(0, "DS_CONT").replaceAll("\n", "<br />");
		html += "<br /><br />개인정보동의여부<br /><br />일반 개인정보 수집 및 활용에 관한 동의(" + dtVoc.getString(0, "YN_PRIVACY_AGREE") + ")";
		html += "<br />민감정보 수집 및 활용에 관한 동의(" + dtVoc.getString(0, "YN_SENSITIVE_AGREE") + ")";
		html += "<br />일반 개인정보의 제 3자제공에 관한 동의(" + dtVoc.getString(0, "YN_PRIVACY_ORDER_AGREE") + ")";
		html += "<br />민감 개인정보의 제 3자제공에 관한 동의(" + dtVoc.getString(0, "YN_SENSITIVE_ORDER_AGREE") + ")</td>";
		html += "</tr>";
		html += "</tbody>";
		html += "</table>";
		html +="				<br />";
		html +="				<br />";
		html +="			</div>";
		html +="		</td>";
		html +="	</tr>";
		html +="	<tr>";
		html +="		<td style=\"padding:0; border:none;\">";
		html +="			<div style=\"padding:20px 32px; font-size:13px; line-height:170%; background:#eee;\">";
		html +="				<p style=\"margin:0;\">본 메일은 버거킹에서 발송한 메일이며 발신전용 메일입니다.</p>";
		html +="			</div>";
		html +="		</td>";
		html +="	</tr>";
		html +="	<tr>";
		html +="		<td style=\"padding:0; border:none;\">";
		html +="			<div style=\"padding:31px 32px 20px; font-size:12px; color:#818181; line-height:167%; background:#292929;\">";
		html +="				<div style=\"margin-bottom:5px;\"><img src=\"http://13.209.180.127/mail/logo.gif\" alt=\"버거킹 logo\" /></div>";
		html +="				<p style=\"margin:0;\">서울 종로구 삼봉로 71 G 타워 2층  주식회사 비케이알 │ TEL 02-6331-8282  FAX 02-3775-4325</p>";
		html +="				<p style=\"margin:0;\">사업자 등록번호 101-86-76277 │ (주)BKR 대표이사 문영주</p>";
		html +="				<p style=\"margin:0;\">Copyright 2018 BKR Co., Ltd. All right Reserved</p>";
		html +="			</div>";
		html +="		</td>";
		html +="	</tr>";
		html +="	</tbody>";
		html +="</table>";
		
		return html;
	}
	
}
