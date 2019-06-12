package com.ubone.api.rest.user.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

public interface UserDAO {
	
	/**
	 * 회원 정보 조회  조회
	 * @param param 고객id
	 * @return 회원 정보 조회 
	 */
	public DataList getMember(Parameter parameter);
	
	/**
	 * 회원SNS 정보 조회  조회
	 * @param param 고객id
	 * @return 회원 정보 조회 
	 */
	public DataList getMemberSns(Parameter parameter);
	
	/**
	 * 회원 정보 조회  조회 - AUTO
	 * @param param 고객id
	 * @return 회원 정보 조회 
	 */
	public DataList getMemberAuto(Parameter parameter);
	
	/**
	 * 회원 로그인 처리 - 신규앱 최초 로그인
	 * @param param 고객id
	 * @return 회원 정보 조회 
	 */
	public DataList getMemberTokenFirst(Parameter parameter);
	
	/**
	 * 회원 정보 중복 체크 
	 * @param param 고객id
	 * @return 회원 정보 조회 
	 */
	public DataList checkJoin(Parameter parameter);
	
	/**
	 * 회원 ID 찾기
	 * @param param 고객id
	 * @return 회원 정보 조회 
	 */
	public DataList findMemberId(Parameter parameter);
	
	/**
	 * 비밀번호 초기화 대상 조회
	 * @param param 고객id
	 * @return 비밀번호 초기화 대상 조회
	 */
	public DataList getResetMember(Parameter parameter);
	
	/**
	 * 비밀번호 체크
	 * @param param
	 * @return 
	 */
	public DataList checkPasswd(Parameter parameter);
	
	/**
	 * SNS 유저 조회
	 * @param param
	 * @return 
	 */
	public DataList getSns(Parameter parameter);
	
	/**
	 * SNS 유저 중 버거킹회원 조회
	 * @param param
	 * @return 
	 */
	public DataList getSnsMember(Parameter parameter);
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	/**
	 * 회원가입
	 * @param param
	 * @return count 
	 */
	public String insertMember(Parameter parameter);
	
	/**
	 * login 실패건수 증가
	 * @param param 고객id
	 * @return count 
	 */
	public int updateLoginFailCnt(Parameter parameter);
	
	/**
	 * 임시비밀번호 발급시 수정
	 * @param param
	 * @return count 
	 */
	public int updateTempPassword(Parameter parameter);
	
	/**
	 * 회원정보수정 - 전화번호, SMS/EMAIL수신동의여부
	 * @param param
	 * @return count 
	 */
	public int updateMember(Parameter parameter);
	
	/**
	 * 회원정보수정 - 비밀번호
	 * @param param
	 * @return count 
	 */
	public int updateMemberPw(Parameter parameter);
	
	/**
	 * 휴먼정보해제
	 * @param param
	 * @return count 
	 */
	public int updateDormancy(Parameter parameter);
	
	/**
	 * 비밀번호 나중변경일 수정
	 * @param param
	 * @return count 
	 */
	public int updateChangeLater(Parameter parameter);
	
	/**
	 * 추가 약관 동의
	 * @param param
	 * @return count 
	 */
	public int updateAddTermsAgree(Parameter parameter);
	
	/**
	 * 회원 탈퇴 테이블 정보 저장
	 * @param param
	 * @return count 
	 */
	public String insertDelMember(Parameter parameter);
	
	/**
	 * 회원 탈퇴
	 * @param param
	 * @return count 
	 */
	public int deletelMember(Parameter parameter);
	
	/**
	 * 회원 주소 탈퇴
	 * @param param
	 * @return count 
	 */
	public int deletelMemberAddr(Parameter parameter);
	
	/**
	 * 회원 SNS 탈퇴
	 * @param param
	 * @return count 
	 */
	public int deletelSnsMember(Parameter parameter);
	
	/**
	 * 회원 SNS 정보 저장
	 * @param param
	 * @return count 
	 */
	public String insertMemberSns(Parameter parameter);
	
	/**
	 * SNS 로그인시 회원 성별, 생일정보 수정
	 * @param param
	 * @return count 
	 */
	public int updateMemberInfo(Parameter parameter);
	
	/**
	 * 최종 로그인 일시 수정
	 * @param param
	 * @return count 
	 */
	public int updateLoginMember(Parameter parameter);
	
	/**
	 * 회원 정보 변경 이력 저장
	 * @param param
	 * @return count 
	 */
	public String insertMemberRecord(Parameter parameter);
	
}
