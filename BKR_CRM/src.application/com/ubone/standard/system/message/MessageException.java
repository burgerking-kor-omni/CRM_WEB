package com.ubone.standard.system.message;

public class MessageException extends RuntimeException {

	private static final long serialVersionUID = -2711673157299237514L;

	public MessageException(String message) {
		super(message);
	}

	public MessageException(String message, Throwable cause) {
		super(message);
	}
}