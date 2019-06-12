package com.ubone.standard.cust.impl;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.cust.dao.CustManageRimsDAO;


@Repository
public class CustManageRimsDAOImpl extends UbSqlSessionDaoSupport implements CustManageRimsDAO {
	
	private String prefix = "CustManageRimsDAO.";
	
	// 추가한 SessionTemplate 명 기술
	@Resource(name="rimsSessionTemplate")
    private SqlSessionTemplate sqlSessionTemplate;
	
	// 클래스 생성시 생성자 실행후 @PostConstruct 지정된 함수 실행하여 지정한 SessionTemplate으로 변경
	@PostConstruct
    public void init(){
        super.setSqlSessionTemplate(sqlSessionTemplate);
    }

	@Override
	public DataList getOrderListRims(Parameter param) {
		return queryForDataList(this.prefix+"getOrderListRims", param);
	}

	@Override
	public DataList getOrderDetailRims(Parameter param) {

		return queryForDataList(this.prefix+"getOrderDetailRims", param);
	}

	@Override
	public DataList getProdListRims(Parameter param) {
		return queryForDataList(this.prefix+"getProdListRims", param);
	}

	@Override
	public DataList getCouponListUseRims(Parameter param) {
		return queryForDataList(this.prefix+"getCouponListUseRims", param);
	}

	@Override
	public DataList getOrderProdRims(Parameter param) {
		return queryForDataList(this.prefix+"getOrderProdRims", param);
	}

	@Override
	public DataList getOrderStore(Parameter param) {
		return queryForDataList(this.prefix+"getOrderStoreRims", param);
	}

	@Override
	public DataList getPaymentList(Parameter param) {
		return queryForDataList(this.prefix+"getPaymentListRims", param);
	}

	@Override
	public DataList getPayChannel(Parameter param) {
		return queryForDataList(this.prefix+"getPayChannelRims", param);
	}

	@Override
	public DataList getOrderListPopup(Parameter param) {
		return queryForDataList(this.prefix+"getOrderListRims", param);
	}
	
	@Override
	public DataList getPosSchedule(Parameter param) {
		return queryForDataList(this.prefix+"getPosSchedule", param);
	}
	
}
