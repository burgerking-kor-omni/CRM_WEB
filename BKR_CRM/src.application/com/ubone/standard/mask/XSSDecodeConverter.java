package com.ubone.standard.mask;

import java.util.Map;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataList.Replacer;
import com.ubone.framework.data.mask.BaseCustomConverter;
import com.ubone.framework.domain.Mask;
import com.ubone.framework.engine.domain.ServiceMask;

/** 
 * <pre>
 *  설    명 : XSS Decode 컨버터
 *  작 성 자 : 강영운
 *  작 성 일 : 2014.04.25
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2013 by ㈜ 유비원. All right reserved.
 */
public class XSSDecodeConverter extends BaseCustomConverter{

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
					data = data.replaceAll("&lt;", "<");
					data = data.replaceAll("&gt;", ">");
					row.put(key, data);
				}
			}
		});
	}
}
