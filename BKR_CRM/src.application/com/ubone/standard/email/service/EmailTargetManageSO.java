package com.ubone.standard.email.service;

import java.util.Iterator;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.email.dao.EmailTargetManageDAO;

@Service
public class EmailTargetManageSO {

	@Resource
	private EmailTargetManageDAO emailTargetDAO;

	/**
	 * VOC유형 별 이메일 발송 대상  목록 조회
	 * @param param 검색조건
	 * @return
	 */
	public DataList getEmailTargetList(Parameter param){
		return emailTargetDAO.getEmailTargetList(param);
	}
	/**
	 * VOC유형 별 이메일 발송 대상 상세 목록 조회
	 * @param param ID_TARGET
	 * @return
	 */
	public Result getEmailTargetDetailList (Parameter param){
		Result rs = DataUtil.makeResult();
		rs.addDataList(emailTargetDAO.getEmailTargetList(param));
		rs.addDataList(emailTargetDAO.getEmailTargetDetailList(param));
		return rs;
	}
	/**
	 * VOC유형 별 이메일 발송 대상  등록
	 * @param param ID_TARGET
	 * @return
	 */
	public String insertVocDispatch (Parameter param){
		param = DataUtil.makeUserAddedParameter(param);
		String returnVal = emailTargetDAO.insertVocDispatch(param);
		return returnVal;
	}
	/**
	 * VOC유형 별 이메일 발송 대상  수정
	 * @param param ID_VOC
	 */
	public int updateVocDispatch (Parameter param){
		param = DataUtil.makeUserAddedParameter(param);
		//수정 전 유형 별 상세 목록 초기화(전체 삭제)
		emailTargetDAO.deleteVocDispatchCategory(param);
		//상세 기본정보 수정
		int returnVal = emailTargetDAO.updateVocDispatch(param);
		//유형 별 상세정보 목록 정보 문자열
		String arrayData = param.getParameter("ARRAY_DATA").toString().replaceAll("&quot;", "'");
		try {
			JSONArray jsonArray = new JSONArray(arrayData);
			for(int i=0; i<jsonArray.length(); i++){
				JSONObject json = new JSONObject(jsonArray.get(i).toString());
				Iterator<String> keys = json.keys();
				while(keys.hasNext()){
					String key = keys.next();
					String value = json.getString(key);
					param.setParameter(key, value);
				}
				if("Y".equals(param.getValue("YN_ADD"))){
					emailTargetDAO.insertVocDispatchCategory(param);
				}
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return returnVal;
	}
	/**
	 * VOC유형 별 이메일 발송 대상 삭제
	 * @param param ID_VOC
	 */
	public int deleteVocDispatch (Parameter param){
		int returnVal = emailTargetDAO.deleteVocDispatch(param);
		int returnVal2 = emailTargetDAO.deleteVocDispatchCategory(param);
		return returnVal+returnVal2;
	}

}
