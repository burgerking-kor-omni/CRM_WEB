package com.ubone.framework.util.sequence;

/** 
 * <pre>
 *  파 일 명 : BizSeqRepository.java
 *  설    명 : 비즈니스 시퀀스 저장소
 *  작 성 자 : 정현민
 *  작 성 일 : 2017.10.30
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2017 by ㈜ 유비원. All right reserved.
 */
public interface BizSeqRepository {
	
	/**
	 * 시퀀스의 NextValue를 리턴하는 함수
	 * @param tpBiz 업무구분 코드
	 * @param stnd 기준
	 * @return NextValue
	 */
	public String nextVal(String tpBiz, String stnd) ;
}