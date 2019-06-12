package com.ubone.standard.mask;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataList.Replacer;
import com.ubone.framework.data.mask.BaseCustomConverter;
import com.ubone.framework.domain.Mask;
import com.ubone.framework.engine.domain.ServiceMask;

/** 
 * <pre>
 *  설    명 : 통보 고객정보 마스킹
 *  작 성 자 : 김범수
 *  작 성 일 : 2014.05.27
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public class DispatchCustomerInfoConverter extends BaseCustomConverter{

	/**
	 * 컨버터 처리 함수
	 * @param dataList 대상 데이터 리스트 인스턴스
	 * @param serviceMask Service 마스크 정보
	 * @param mask 마스크 정보
	 */
	@Override
	public void convert(DataList dataList, final ServiceMask serviceMask, final Mask mask) {
		logger.debug("Processing "+this.getClass().getSimpleName() + "::"+serviceMask.getColumnName());

		dataList.replace(new Replacer() {
			@Override
			public void process(Map<String, Object> row) {
				String key  = serviceMask.getColumnName();
				String data = (String) row.get(key);
				if(data != null){
					if(data.length() > 0 && "C0".equals(row.get("CD_VOC_STATUS")) 
										 && ("NM_DISPATCH".equals(key) ||  ("NM_CUST".equals(key))) 
									     && "01".equals(row.get("TP_DISPATCH_TARGET"))){
						data = data.substring(0,1)+"**";
						row.put(key, data);
					}
					if(data.length() > 0  && "C0".equals(row.get("CD_VOC_STATUS")) && "DISPATCH_EMAIL_SMS".equals(key) && "01".equals(row.get("TP_DISPATCH_TARGET")) ){
						if(data.indexOf("-")> 0){
							if(data.indexOf("-")> 0){
								//Phone number have '-' characters.
								String[] idPhones = data.split("-");
								int sizePhones = idPhones.length;
								if( sizePhones == 2){
									//Phone number have 2 '-' characters. (Valid Phone number format)
									data = idPhones[0] + "-****-" + idPhones[2];
								}else if(sizePhones == 1){
									//Phone number have 1 '-' characters. (invalid Phone number format)
									data = idPhones[0] + "-****-";
								}else{
									//Phone number have more than 2 '-' characters. (invalid Phone number format)
									data = idPhones[0] + "-****-";
									for(int i=2;i<sizePhones;i++){
										data = data + idPhones[i];
									}
								}
								
							}else{
								//Phone number have not '-' characters.
								int sizePhones = data.length();
								if(sizePhones<4){
									//Do not anything because data is wrong data.
								}else if(sizePhones>4 && sizePhones < 8){
									data  = data.substring(0,3) + "-****-";
								}else{
									//sizePhonse >= 8
									data = data.substring(0,3) + "-****-" + data.substring(7,sizePhones);
								}
							}
						}
						if(data.indexOf("@")>0){
							String[] email = data.split("@");
							data = email[0].substring(0,3)+"****@"+email[1];
							row.put(key, data);
						}
						row.put(key, data);
					}
				}
			}
		});
	}
}
