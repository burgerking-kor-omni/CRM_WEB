package com.ubone.standard.crypto;

import org.apache.commons.codec.digest.DigestUtils;


public class CryptoUtil {
	
	public static String encrypt(String data){
		return DigestUtils.sha512Hex(data);
	}
}
 