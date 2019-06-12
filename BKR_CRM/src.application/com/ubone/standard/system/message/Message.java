package com.ubone.standard.system.message;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import com.ubone.framework.data.BaseDataObject;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.engine.domain.User;

/** 
 * <pre>
 *  설    명 : 메세지 Domain
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public class Message extends BaseDataObject {
	
	private WorkCategory workCategory;
	private String[] workKeys;
	private ChannelType channelType;
	private String title = "";
	private String message = "";
	private String url = "";
	private Date occuredDate;
	private Date planDate;
	private Parameter parameter;
	private Sender sender;
	private String cdDispatchBiz = "";
	private String dsDispatch = "";
	
	private List<Recipient> recipients = new LinkedList<Recipient>();
	
	public WorkCategory getWorkCategory() {
		return workCategory;
	}
	public Message setWorkCategory(WorkCategory workCategory) {
		this.workCategory = workCategory;
		return this;
	}
	
	public String[] getWorkkeys() {
		return workKeys;
	}
	public Message setWorkKeys(String[] workKeys) {
		this.workKeys = workKeys;
		return this;
	}
	
	public ChannelType getChannelType() {
		return channelType;
	}
	public Message setChannelType(ChannelType channelType) {
		this.channelType = channelType;
		return this;
	}
	
	public String getTitle() {
		return title == null ? "" : title;
	}
	public Message setTitle(String title) {
		this.title = title;
		return this;
	}
	
	public String getMessage() {
		return message == null ? "" : message;
	}
	public Message setMessage(String message) {
		this.message = message;
		return this;
	}
	
	public String getCdDispatchBiz() {
		return cdDispatchBiz == null ? "" : cdDispatchBiz;
	}
	public Message setCdDispatchBiz(String cdDispatchBiz) {
		this.cdDispatchBiz = cdDispatchBiz;
		return this;
	}
	
	public String getUrl() {
		return url == null ? "" : url;
	}
	public Message setUrl(String url) {
		this.url = url;
		return this;
	}
	
	public Date getOccuredDate() {
		return occuredDate;
	}
	public Message setOccuredDate(Date occuredDate) {
		this.occuredDate = occuredDate;
		return this;
	}
	
	public Date getPlanDate() {
		return planDate;
	}
	public Message setPlanDate(Date planDate) {
		this.planDate = planDate;
		return this;
	}
	
	public Parameter getParameter() {
		return parameter == null ? DataUtil.makeParameter() : parameter;
	}
	public Message setParameter(Parameter parameter) {
		this.parameter = parameter;
		return this;
	}
	
	public Sender getSender() {
		return sender;
	}
	public Message setSender(Sender sender) {
		this.sender = sender;
		return this;
	}
	public Message setSender(User sender) {
		this.sender = new Sender(sender);
		return this;
	}
	public Message setSenderWithEmail(String userId, String email) {
		this.sender = new Sender(userId).setEmail(email);
		return this;
	}
	public Message setSenderWithPhoneNumber(String userId, String phoneNumber) {
		this.sender = new Sender(userId).setPhoneNumber(phoneNumber);
		return this;
	}
	
	public List<Recipient> getRecipients() {
		return recipients;
	}
	public Message setRecipient(List<Recipient> recipients) {
		this.recipients = recipients;
		return this;
	}
	public Message addRecipient(Recipient recipient) {
		recipients.add(recipient);
		return this;
	}
	public String getDispatch() {
		return dsDispatch;
	}
	public Message setDispatch(String dsDispatch) {
		this.dsDispatch = dsDispatch;
		return this;
	}
	/**
	 * 메세지 정보를 파라미터 객체로 변환
	 * @return Parameter 메세지 정보를 담고 있는 파라미터 객체
	 * @throws MessageException
	 */
	public Parameter asParameter() {
		Parameter parameter = DataUtil.makeParameter();
		parameter.set("workCategory", workCategory.getCode());
		parameter.set("workKeys", DataUtil.joinedKey(workKeys));
		parameter.set("channelType", channelType.getCode());
		parameter.set("title", title);
		parameter.set("message", message);
		parameter.set("url", url);
		parameter.set("occuredDate", occuredDate);
		parameter.set("planDate", planDate);
		parameter.set("cdDispatchBiz", cdDispatchBiz);
		parameter.set("dsDispatch", dsDispatch);
		
		try {
			parameter.set("sender", BeanUtils.describe(this.sender));
		}
		catch (IllegalAccessException e1) {
			throw new MessageException("error occured when sender described to map; sender[" + this.sender + "]; ", e1);
		}
		catch (InvocationTargetException e1) {
			throw new MessageException("error occured when sender described to map; sender[" + this.sender + "]; ", e1);
		}
		catch (NoSuchMethodException e1) {
			throw new MessageException("error occured when sender described to map; sender[" + this.sender + "]; ", e1);
		}
		return parameter;
	}
	
	public static class Sender extends BaseDataObject {
		Sender(String userId) {
			employeeId = userId;
		}
		Sender(User user) {
			employeeId = user.getId();
			departmentId = user.getPartCode();
			email = user.getEmail();
			phoneNumber = user.getPhoneNumber();
		}
		
		boolean createdById = false;
		public boolean isCreatedById() {
			return createdById;
		}
		
		private String employeeId = "";
		public String getEmployeeId() {
			return employeeId;
		}
		public Sender setEmployeeId(String employeeId) {
			this.employeeId = employeeId;
			return this;
		}
		
		private String departmentId = "";
		public String getDepartmentId() {
			return departmentId;
		}
		public Sender setDepartmentId(String departmentId) {
			this.departmentId = departmentId;
			return this;
		}
		
		private String email = "";
		public String getEmail() {
			return email;
		}
		public Sender setEmail(String email) {
			this.email = email;
			return this;
		}
		
		private String phoneNumber = "";
		public String getPhoneNumber() {
			return phoneNumber;
		}
		public Sender setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
			return this;
		}
	}
	
	public static class Recipient extends BaseDataObject {
		private String messageId = "";
		private String recipientType = "";
		private String customerId = "";
		private String employeeId = "";
		private String departmentId = "";
		private String email = "";
		private String phoneNumber = "";
		private String nmPartner = "";
		
		Recipient(RecipientType recipientType) {
			this.recipientType = recipientType.getCode();
		}
		
		public String getMessageId() {
			return messageId;
		}
		public Recipient setMessageId(String messageId) {
			this.messageId = messageId;
			return this;
		}
		
		public String getRecipientType() {
			return recipientType;
		}
		public Recipient setRecipientType(RecipientType recipientType) {
			this.recipientType = recipientType.getCode();
			return this;
		}
		
		public String getCustomerId() {
			return customerId;
		}
		public Recipient setCustomerId(String customerId) {
			this.customerId = customerId;
			return this;
		}
		
		public String getEmployeeId() {
			return employeeId;
		}
		public Recipient setEmployeeId(String employeeId) {
			this.employeeId = employeeId;
			return this;
		}
		
		public String getDepartmentId() {
			return departmentId;
		}
		public Recipient setDepartmentId(String departmentId) {
			this.departmentId = departmentId;
			return this;
		}
		
		public String getEmail() {
			return email;
		}
		public Recipient setEmail(String email) {
			this.email = email;
			return this;
		}
		
		public String getPhoneNumber() {
			return phoneNumber;
		}
		public Recipient setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
			return this;
		}
		public Recipient setNmPartner(String nmPartner) {
			this.nmPartner = nmPartner;
			return this;
		}
		public String getNmPartner() {
			return nmPartner;
		}
		
		/**
		 * 수신인 정보를 파라미터 객체로 변환
		 * @return Parameter 수신자 속성을 지닌 파라미터 객체
		 * @throws MessageException
		 */
		@SuppressWarnings("unchecked")
		public Parameter asParameter() {
			Map<String, Object> map;
			try {
				map = BeanUtils.describe(this);
			}
			catch (IllegalAccessException e1) {
				throw new MessageException("error occured when recipient described to map; sender[" + this + "]; ", e1);
			}
			catch (InvocationTargetException e1) {
				throw new MessageException("error occured when recipient described to map; sender[" + this + "]; ", e1);
			}
			catch (NoSuchMethodException e1) {
				throw new MessageException("error occured when recipient described to map; sender[" + this + "]; ", e1);
			}
			return DataUtil.makeParameter(map);
		}
		
		/**
		 * 직원 수신자 생성
		 * @param userId
		 * @return 수신자 정보
		 */
		public static Recipient userRecipient(String userId) {
			return new Recipient(RecipientType.Employee)
			.setEmployeeId(userId);
		}
		
		/**
		 * 직원 수신자 생성
		 * @param user
		 * @return 수신자 정보
		 */
		public static Recipient userRecipient(User user) {
			return new Recipient(RecipientType.Employee)
			.setEmployeeId(user.getId())
			.setDepartmentId(user.getPartCode())
			.setEmail(user.getEmail())
			.setPhoneNumber(user.getMobilePhoneNumber());
		}
		
		/**
		 * 점포점주 수신자 생성
		 * @param user
		 * @return 수신자 정보
		 */
		public static Recipient userRecipientStoreEmp(User user) {
			return new Recipient(RecipientType.StoreOwner)
			.setEmployeeId(user.getId())
			.setDepartmentId(user.getPartCode())
			.setEmail(user.getEmail())
			.setPhoneNumber(user.getMobilePhoneNumber());
		}		
		
		/**
		 * 직원 수신자 생성 - 수신 email 주소를 직접 지정
		 * @param userId
		 * @param email
		 * @return 수신자 정보
		 */
		public static Recipient userRecipientWithEmail(String userId, String email) {
			return new Recipient(RecipientType.Employee)
			.setEmployeeId(userId)
			.setEmail(email);
		}
		
		/**
		 * 직원 수신자 생성  - 수신 전화번호를 직접 지정 
		 * @param userId
		 * @param phoneNumber
		 * @return 수신자 정보
		 */
		public static Recipient userRecipientWithPhoneNumber(String userId, String phoneNumber) {
			return new Recipient(RecipientType.Employee)
			.setEmployeeId(userId)
			.setPhoneNumber(phoneNumber);
		}
		
		/**
		 * 고객 수신자 생성
		 * @param customerId
		 * @return 수신자 정보
		 */
		public static Recipient customerRecipient(String customerId) {
			return new Recipient(RecipientType.Customer)
			.setCustomerId(customerId);
		}
		
		/**
		 * 고객 수신자 생성 - 수신 email 주소를 직접 지정
		 * @param customerId
		 * @param email
		 * @return 수신자 정보
		 */
		public static Recipient customerRecipientWithEmail(String customerId, String email) {
			return new Recipient(RecipientType.Customer)
			.setCustomerId(customerId)
			.setEmail(email);
		}
		
		/**
		 * 고객 수신자 생성 - 수신 전화번호를 직접 지정 
		 * @param customerId
		 * @param phoneNumber
		 * @return 수신자 정보
		 */
		public static Recipient customerRecipientWithPhoneNumber(String customerId, String phoneNumber) {
			return new Recipient(RecipientType.Customer)
			.setCustomerId(customerId)
			.setPhoneNumber(phoneNumber);
		}
		
		/**
		 * 협력사
		 * @param user
		 * @return 수신자 정보
		 */
		public static Recipient userRecipientPartner(String email, String nmPartner) {
			return new Recipient(RecipientType.Partner)
			.setEmail(email)
			.setNmPartner(nmPartner);		}
		
		/**
		 * Thank-u mail
		 * @param user
		 * @return 수신자 정보
		 */
		public static Recipient userRecipientThanku(String email) {
			return new Recipient(RecipientType.Customer)
			.setEmail(email);
		}
	}
}