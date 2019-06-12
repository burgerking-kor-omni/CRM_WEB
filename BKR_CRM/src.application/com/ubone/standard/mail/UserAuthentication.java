package com.ubone.standard.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class UserAuthentication extends Authenticator {

	PasswordAuthentication pa;
	
	public UserAuthentication(String id, String password) {
		pa = new PasswordAuthentication(id, password);
	}
	
	
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}

}