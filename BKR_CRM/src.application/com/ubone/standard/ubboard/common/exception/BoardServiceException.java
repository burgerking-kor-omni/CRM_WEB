package com.ubone.standard.ubboard.common.exception;

/** 
 * <pre>
 *  파 일 명 : BoardServiceException.java
 *  설    명 : UB-Board 서비스 오류
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.11.23
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class BoardServiceException extends RuntimeException {

	private static final long serialVersionUID = 2675805139659633425L;

	public BoardServiceException(String message){
		super(message);
	}
	
	public BoardServiceException(Throwable thr){
		super(thr);
	}
	
	public BoardServiceException(String message, Throwable thr){
		super(message, thr);
	}
}
