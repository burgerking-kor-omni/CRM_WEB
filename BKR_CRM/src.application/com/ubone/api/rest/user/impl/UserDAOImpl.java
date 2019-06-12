package com.ubone.api.rest.user.impl;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.user.dao.UserDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

@Repository
public class UserDAOImpl extends UbSqlSessionDaoSupport implements UserDAO  {
	
	private String queryPrefix = "ApiUser.";
	
	@Override
	public DataList getMember(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMember", parameter);
	}
	
	@Override
	public DataList getMemberSns(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMemberSns", parameter);
	}
	
	@Override
	public DataList getMemberAuto(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMemberAuto", parameter);
	}
	
	@Override
	public DataList getMemberTokenFirst(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMemberTokenFirst", parameter);
	}
	
	@Override
	public DataList checkJoin(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "checkJoin", parameter);
	}
	
	@Override
	public DataList findMemberId(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "findMemberId", parameter);
	}
	
	@Override
	public DataList getResetMember(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getResetMember", parameter);
	}
	
	@Override
	public DataList checkPasswd(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "checkPasswd", parameter);
	}
	
	@Override
	public DataList getSns(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getSns", parameter);
	}
	
	@Override
	public DataList getSnsMember(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getSnsMember", parameter);
	}
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	@Override
	public String insertMember(Parameter parameter) {
		return insert(this.queryPrefix + "insertMember", parameter);
	}
	
	@Override
	public int updateLoginFailCnt(Parameter parameter) {
		return update(this.queryPrefix + "updateLoginFailCnt", parameter);
	}
	
	@Override
	public int updateTempPassword(Parameter parameter) {
		return update(this.queryPrefix + "updateTempPassword", parameter);
	}
	
	@Override
	public int updateMember(Parameter parameter) {
		return update(this.queryPrefix + "updateMember", parameter);
	}
	
	@Override
	public int updateMemberPw(Parameter parameter) {
		return update(this.queryPrefix + "updateMemberPw", parameter);
	}
	
	@Override
	public int updateDormancy(Parameter parameter) {
		return update(this.queryPrefix + "updateDormancy", parameter);
	}
	
	@Override
	public int updateChangeLater(Parameter parameter) {
		return update(this.queryPrefix + "updateChangeLater", parameter);
	}
	
	@Override
	public int updateAddTermsAgree(Parameter parameter) {
		return update(this.queryPrefix + "updateAddTermsAgree", parameter);
	}
	
	@Override
	public String insertDelMember(Parameter parameter) {
		return insert(this.queryPrefix + "insertDelMember", parameter);
	}
	
	@Override
	public int deletelMember(Parameter parameter) {
		return update(this.queryPrefix + "deletelMember", parameter);
	}
	
	@Override
	public int deletelMemberAddr(Parameter parameter) {
		return update(this.queryPrefix + "deletelMemberAddr", parameter);
	}
	
	@Override
	public int deletelSnsMember(Parameter parameter) {
		return update(this.queryPrefix + "deletelSnsMember", parameter);
	}
	
	@Override
	public String insertMemberSns(Parameter parameter) {
		return insert(this.queryPrefix + "insertMemberSns", parameter);
	}
	
	@Override
	public int updateMemberInfo(Parameter parameter) {
		return update(this.queryPrefix + "updateMemberInfo", parameter);
	}
	
	@Override
	public int updateLoginMember(Parameter parameter) {
		return update(this.queryPrefix + "updateLoginMember", parameter);
	}
	
	@Override
	public String insertMemberRecord(Parameter parameter) {
		return insert(this.queryPrefix + "insertMemberRecord", parameter);
	}
	
}
