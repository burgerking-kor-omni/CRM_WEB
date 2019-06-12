package com.ubone.framework.util.sequence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import com.ubone.framework.dao.JdbcDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.engine.service.ServiceException;


/** 
 * <pre>
 *  설    명 : Biz 시퀀스 저장소
 *  작 성 자 : 정현민
 *  작 성 일 : 2017.10.17
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2017 by ㈜ 유비원. All right reserved.
 */
public class BizSequenceRepository extends JdbcDaoSupport implements BizSeqRepository {
	
	/**
	 * 시퀀스의 NextValue를 리턴하는 함수
	 * @param sequenceId 시퀀스ID
	 * @return NextValue
	 */
	@Override
	public String nextVal(String tpBiz, String stnd) {
		String value = "0";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tpBiz", tpBiz);
		map.put("stnd", stnd);

		NamedParameterJdbcTemplate template = getNamedParameterJdbcTemplate();
		// 시퀀스 삭제
		template.update(super.getQuery("query.bizSequence.set.init"), map);
		// 시퀀스 Value 증가
		int result = template.update(super.getQuery("query.bizSequence.set.nextval"), map);
		if(result == 0){
			throw new ServiceException("Does not found tpBiz and stnd. tpBiz : ["+tpBiz+"], stnd : ["+stnd+"] : Please use the sequence after registration.", "");
		}

		// 시퀀스 현재값 조회
		List<Map<String, Object>> list = template.queryForList(super.getQuery("query.bizSequence.get.currval"), map);
		DataList dataList = DataUtil.makeDataList("dlSequence", list);
		if(dataList.getRowCount() > 0){
			value = dataList.getString(0, 0);
		}
		
		return value;
	}
}