package com.ubone.standard.mail;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

public class MailSender
{
	private Logger logger = Logger.getLogger(MailSender.class);
	
	private static String HOST = "";
	private static String PORT = "";
	private static String USER_ID = "" ;
	private static String USER_PW = "" ;
	//private static String ENCODING = ConfigUtil.getString("com.ubone.batch.mail.default.encoding");
	private static String ENCODING = "UTF-8";

	public MailSender(){
		
//		HOST    = ConfigUtil.getString("com.ubone.batch.mail.host");
//		PORT    = ConfigUtil.getString("com.ubone.batch.mail.port");
//		USER_ID = ConfigUtil.getString("com.ubone.batch.mail.user.name");
//		USER_PW = ConfigUtil.getString("com.ubone.batch.mail.password");
		
		HOST    = "smtp.gmail.com";
		PORT    = "465";
		USER_ID = "tantluskim";
		USER_PW = "fighting1350";
		
	}
	
	public MailSender(String serverUrl, String port){
		HOST = serverUrl;
		PORT = port;
	}

	public MailSender(String serverUrl, String port, String id, String pw){
		HOST = serverUrl;
		PORT = port;
		USER_ID = id;
		USER_PW = pw;
	}

	/**
	 * SMTP메일 서버의 환경설정
	 * @param serverUrl		서버 URL
	 * @param id			ID
	 * @param pw			Password
	 */
	public void  setServerInfo(String serverUrl, String id, String pw){
		HOST = serverUrl;
		USER_ID = id;
		USER_PW = pw;
	}

	/**
	 * SMTP 발송
	 * @param fromEmail			보내는사람
	 * @param toEmail			받는사람
	 * @param subject			제목
	 * @param contents			내용
	 * @return
	 */
	public String sendMail(String fromEmail, String toEmail, String subject, String contents){
		
		String[] toEmailList = StringUtils.split(toEmail, ";");
		
		return sendMail(fromEmail, toEmailList, subject, contents);
	}

	/**
	 * SMTP 발송
	 * @param fromEmail		보내는사람
	 * @param toEmailList	{array}	받는사람
	 * @param subject		제목
	 * @param contents		내용
	 * @return
	 */
	public String sendMail(String fromEmail, String[] toEmailList, String subject, String contents){
		return sendMail(fromEmail, toEmailList, subject, contents, null, null);
	}

	/**
	 * SMTP 발송
	 * @param fromEmail		보내는사람
	 * @param toEmailList	{array}	받는사람
	 * @param subject		제목
	 * @param contents		내용
	 * @param ccEmailList	{array} 참조할사람
	 * @return
	 */
	public String sendMail(String fromEmail, String[] toEmailList, String subject, String contents, String [] ccEmailList){
		return sendMail(fromEmail, toEmailList, subject, contents, ccEmailList,  null);
	}

	/**
	 * SMTP 발송
	 * @param fromEmail		보내는사람
	 * @param toEmailList	{array}	받는사람
	 * @param subject		제목
	 * @param contents		내용
	 * @param ccEmailList	{array} 참조할사람
	 * @param fileList		{array} 첨부파일(경로+이름)
	 * @return
	 */
	public String sendMail(
			  String fromEmail
			, String[] toEmailList
			, String subject
			, String contents
			, String[] ccEmailList
			, String[] fileList)
	{
		String strReturn = "" ;
		boolean devMode = false;
		String receivers = "";
		
		try
		{
			// 메일 서버 세션 생성
			Session session = getSession() ;

			// 메세지 정의
			Message message = new MimeMessage(session);
			
			String[] splitFromEmail = fromEmail.split(" ");
			String senderName = splitFromEmail[0];
			String sender = splitFromEmail[1].substring(splitFromEmail[1].indexOf("<")+1, splitFromEmail[1].indexOf(">"));
			setFrom(message, sender, senderName) ;
			
			Map<String, String[]> splitrRcipient = splitrRcipient(toEmailList);
			setTo(message, splitrRcipient.get("sender"), splitrRcipient.get("senderName")) ;
			setCC(message, ccEmailList, ccEmailList) ;
			setSubject(message, subject) ;
			setBodyPart(message, contents, fileList) ;
			setSendDate(message) ;

			// 생성된 메세지 전송
			Transport.send(message);
//			sendThreadMessage(message) ;
		}
		catch(Exception ex)
		{
			strReturn = ex.toString() ;
			logger.error(">> Sending emails failed.", ex);
		}

		return strReturn ;
	}
	
	/**
	 * SMTP 발송
	 * @param fromEmail		보내는사람
	 * @param toEmailList	{array}	받는사람
	 * @param ccEmailList	{array} 참조할사람
	 * @param bccEmailList	{array} 숨은참조할사람
	 * @param subject		제목
	 * @param contents		내용
	 * @param fileList		{array} 첨부파일(경로+이름)
	 * @return
	 * @throws Exception 
	 */
	public String sendMail(
			  String fromEmail
			, String[] toEmailList
			, String[] ccEmailList
			, String[] bccEmailList
			, String subject
			, String contents
			, String[] fileList) throws Exception
	{
		String strReturn = "" ;
		boolean devMode = false;
		String receivers = "";
		
		try
		{
			// 메일 서버 세션 생성
			Session session = getSession() ;

			// 메세지 정의
			Message message = new MimeMessage(session);
			
			String[] splitFromEmail = fromEmail.split(" ");
			String senderName = splitFromEmail[0];
			String sender = splitFromEmail[1].substring(splitFromEmail[1].indexOf("<"), splitFromEmail[1].indexOf(">"));
			setFrom(message, sender, senderName) ;
			
			Map<String, String[]> splitrRcipient = splitrRcipient(toEmailList);
			setTo(message, splitrRcipient.get("sender"), splitrRcipient.get("senderName")) ;
			setCC(message, ccEmailList, ccEmailList) ;
			setBCC(message, bccEmailList, bccEmailList) ;
			setSubject(message, subject) ;
			setBodyPart(message, contents, fileList) ;
			setSendDate(message) ;

			// 생성된 메세지 전송
			Transport.send(message);
//			sendThreadMessage(message) ;
		}
		catch(Exception ex)
		{
			strReturn = ex.toString() ;
			logger.debug(ex.getMessage());
			throw ex;
		}

		return strReturn ;
	}
	
	private Map<String,String[]> splitrRcipient(String[] recipients){
		Map<String,String[]> map = new HashMap<String,String[]>(); 
		String[] senderNames = new String[recipients.length];
		String[] senders = new String[recipients.length];
		
		for (int i = 0; i < recipients.length; i++) {
			String recipient = recipients[i];
			String[] splitFromEmail = recipient.split(" ");
			senderNames[i] = splitFromEmail[0];
			senders[i] = splitFromEmail[1].substring(splitFromEmail[1].indexOf("<")+1, splitFromEmail[1].indexOf(">"));
		}
		map.put("senderName", senderNames);
		map.put("sender", senders);
		 
		return map; 
	}


	/**
	 * SMTP메일 서버의 Session객체 생성
	 * @return
	 */
	private static Session getSession()
	{
		if(HOST == null || USER_ID == null || USER_PW == null){
			return null;
		}

		try
		{
			/*
			 * mail.smtp.host=mail.superbiz.org
			 * mail.smtp.port=25
			 * mail.transport.protocol=smtp
			 * mail.smtp.auth=true
			 * mail.smtp.user=someuser
			 * password=mypassword
			 */
			
			
			Properties props = new Properties() ;
			
			props.setProperty("mail.transport.protocol", "smtp");
			props.setProperty("mail.smtp.host", HOST);
			props.put("mail.smtp.port", PORT);
			props.put("mail.smtp.socketFactory.port", HOST);
			props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");
			props.setProperty("mail.smtp.quitwait", "false");

			String auth = "true";
			if(USER_ID == null || "".equals(USER_ID)) auth = "false";
			// 인증이 있는서버
			props.put("mail.smtp.auth", auth) ;
			
			UserAuthentication uauth = new UserAuthentication(USER_ID, USER_PW) ;

			Session session = Session.getInstance(props, uauth) ;

			return session;
		}
		catch (Exception ex)
		{
			System.out.println("MailSender.getSession()::Exception::"+USER_ID+":"+USER_PW);
			return null;
		}
	}

	/**
	 * 보내는 사람 설정
	 * @param message
	 * @param sender
	 * @param sendername
	 * @throws Exception
	 */
	private void setFrom(Message message, String sender, String sendername) throws Exception
	{
		try {
			message.setFrom(new InternetAddress(sender, sendername, ENCODING));
		} catch (java.io.UnsupportedEncodingException e) {
			message.setFrom(new InternetAddress(sendername + "<" + sender + ">"));
		}
	}

	/**
	 * 받는 사람 설정
	 * @param message
	 * @param recipient
	 * @param recipientname
	 * @throws Exception
	 */
	private void setTo(Message message, String recipient, String recipientname) throws Exception
	{
		try {
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient, recipientname, ENCODING));
		} catch (java.io.UnsupportedEncodingException e) {
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientname + "<" + recipient + ">"));
		}
	}

	/**
	 * 받는 사람 설정(여러명)
	 * @param message
	 * @param recipient
	 * @param recipientname
	 * @throws Exception
	 */
	private void setTo(Message message, String[] recipient, String[] recipientname) throws Exception
	{
		if(recipient != null){
			for (int i = 0; i < recipient.length; i++) {
				try {
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient[i], recipientname[i], ENCODING));
				} catch (java.io.UnsupportedEncodingException e) {
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientname[i] + "<" + recipient[i] + ">"));
				}
			}
		}
	}

	/**
	 * 참소할 사람 설정
	 * @param message
	 * @param cc
	 * @throws Exception
	 */
	private void setCC(Message message, String[] cc, String[] ccname) throws Exception
	{
		if(cc != null){
			for (int i = 0; i < cc.length; i++) {
				try {
					message.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i], ccname[i], ENCODING));
				} catch (java.io.UnsupportedEncodingException e) {
					message.addRecipient(Message.RecipientType.CC, new InternetAddress(ccname[i] + "<" + cc[i] + ">"));
				}
			}
		}
	}

	/**
	 * 숨은 참조할 사람 설정
	 * @param message
	 * @param bcc
	 * @throws Exception
	 */
	private void setBCC(Message message, String[] bcc, String[] bccname) throws Exception
	{
		if(bcc != null){
			for (int i = 0; i < bcc.length; i++) {
				try {
					message.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i], bccname[i], ENCODING));
				} catch (java.io.UnsupportedEncodingException e) {
					message.addRecipient(Message.RecipientType.BCC, new InternetAddress(bccname[i] + "<" + bcc[i] + ">"));
				}
			}
		}
	}

	/**
	 * 제목 설정
	 * @param message
	 * @param subject
	 * @throws Exception
	 */
	private void setSubject(Message message, String subject) throws Exception
	{
		message.setSubject(subject) ;
	}

	/**
	 * 보낸 날짜 설정
	 * @param message
	 * @throws Exception
	 */
	private void setSendDate(Message message) throws Exception
	{
		message.setSentDate(new Date());
	}


	/**
	 * body 부분 설정
	 * @param message
	 * @param contents
	 * @param filename
	 * @throws Exception
	 */
	private void setBodyPart(Message message, String contents, String[] filename) throws Exception
	{
		// 다양한 종류의 데이터 추가를 위한 객체 생성
		//MimeMultipart multipart = new MimeMultipart("related");
		Multipart multipart = new MimeMultipart();
		message.addHeader("IMT", "multi");



		// 메세지 몸체 생성
		//BodyPart messageBodyPart = new MimeBodyPart();
		MimeBodyPart messageBodyPart = new MimeBodyPart();
		// 메세지 데이터 MIME 형식 설정
		messageBodyPart.setContent(contents, "text/html; charset="+ENCODING);
		messageBodyPart.setDisposition(Part.INLINE);
		// 메세지 몸체를 Multipart 객체에 추가
		multipart.addBodyPart(messageBodyPart);

		// 첨부파일
		addMultiPartContent(multipart, filename);

		// Multipart 객체를  Message 객체에 추가
		message.setContent(multipart);
	}

	/**
	 * 파일 첨부
	 * @param multipart
	 * @param filename
	 * @throws MessagingException
	 * @throws Exception
	 */
	private void addMultiPartContent(Multipart multipart, String[] filename) throws Exception {

		if(filename == null || filename.length <= 0) return;

		for(int i = 0 ; i < filename.length ;i++){
			if(!filename[i].equals("")){
				
				MimeBodyPart messageBodyPart = new MimeBodyPart();

				logger.debug(">> Add AttachFile :: ["+filename[i]+"]");
				
				DataSource fds = new FileDataSource(filename[i]);
				
				// 메세지 몸체에 파일 객체 첨부
				messageBodyPart.setDataHandler(new DataHandler(fds));
				// 파일 이름 설정(한글처리)
				messageBodyPart.setFileName(MimeUtility.encodeText(fds.getName(), ENCODING, "Q"));

				messageBodyPart.setDisposition(Part.ATTACHMENT);
				// 두번째 메세지 몸체 추가
				multipart.addBodyPart(messageBodyPart);
			} //if ends
		}// for ends

	}

	public static void main(String [] args){
		MailSender sender = new MailSender();
		String rst = "";
		String title = "ㅇㅇㄹㄹㄷㄹㄷ";
		String content =  "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=euc-kr\"><title>무제 문서</title><style type=\"text/css\"><!--.body {	font-family: \"MS Sans Serif\", \"돋움\";	font-size: 12px;	color: #253137;	padding-top: 5px;	padding-right: 25px;	padding-bottom: 60px;	padding-left: 30px;	line-height: 18px;}.my_info {	font-family: \"MS Sans Serif\", \"돋움\";	font-size: 12px;	color: #AEB9C7;	line-height: 16px;}body {	margin-left: 0px;	margin-top: 0px;	margin-right: 0px;	margin-bottom: 0px;}--></style></head><body><table width=\"610\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">  <tr>    <td><img src=\"http://www.ubqone.com/images/mail/mail_01.gif\" width=\"610\" height=\"85\"></td>  </tr>  <tr>    <td background=\"http://www.ubqone.com/images/mail/mail_02.gif\" class=\"body\">	<p>SMTP 테스트 메일입니다."
						+" "
						+" "
						+"============내용====================</p>	<p></p>	<p>&nbsp;</p>    <p>&nbsp;</p>    <p>&nbsp;</p></td>  </tr>  <tr>    <td width=\"610\" height=\"183\" valign=\"bottom\" background=\"http://www.ubqone.com/images/mail/mail_04.gif\" style=\"padding:0px 0px 13px 17px; background-repeat:no-repeat; \"><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">      <tr>        <td class=\"my_info\">성명/직책 : 임근대 주임 </td>        </tr>      <tr>        <td class=\"my_info\">소속 : (주)유비원 </td>        </tr>      <tr>        <td class=\"my_info\">Office : 02.422.1240 </td>        </tr>      <tr>        <td class=\"my_info\">Mobile : 011.9268.5575 </td>        </tr>      <tr>        <td class=\"my_info\">e-Mail : milkglow@ubqone.com </td>        </tr>    </table>  </tr>  <tr>    <td valign=\"bottom\" bgcolor=\"#15324C\" style=\"padding-bottom:4px; padding-top:2px; \"><img src=\"http://www.ubqone.com/images/mail/mail_05.gif\" width=\"610\" height=\"65\"></td>  </tr></table></body></html>";
		rst = sender.sendMail(
				  "kang0252@ubqone.com"
				, "petery.lee@partner.samsung.com;youngun.kang@partner.samsung.com"
				, title
				, content );

		System.out.println(rst);

	}

}
