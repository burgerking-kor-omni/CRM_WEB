package com.ubone.standard.system.message;

import com.ubone.framework.engine.CodeEnum;
import com.ubone.framework.util.code.Code;

/** 
 * <pre>
 *  설    명 : 수신자 유형
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public enum RecipientType implements CodeEnum {
	Customer("01", "고객"),
	Employee("02", "직원"),
	Worker("03", "업무담당자"),
	Role("04", "업무권한"),
	RoleInDepartment("05", "처리부서 업무권한"),
	SalesEmployee("06", "영업담당(SV)"),
	StoreOwner("07", "발생점포 점주"),
	Partner("08", "협력사"),
	Undefined("Undefined", "Undefined", Code.SLEEP_STATUS_CODE);
	
	private String code;
	private String description;
	private String status;
	
	private RecipientType(String code, String description) {
		this(code, description, Code.ACTIVITY_STATUS_CODE);
	}
	
	private RecipientType(String code, String description, String status) {
		this.code = code;
		this.description = description;
		this.status = status;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getCode()
	 */
	public String getCode() {
		return code;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getDescription()
	 */
	public String getDescription() {
		return description;
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getParentCode()
	 */
	public String getParentCode() {
		return "";
	}
	
	/* (non-Javadoc)
	 * @see com.ubone.framework.engine.CodeEnum#getStatus()
	 */
	public String getStatus() {
		return status;
	}
	
	public static RecipientType valueOfCode(String code) {
		for(RecipientType element : RecipientType.values()) {
			if(element.getCode().equals(code)) {
				return element;
			}
		}
		return Undefined;
	}
}