package com.ubone.standard.common.encrypto;

import java.util.logging.Logger;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;


public class IwtCrypt {
	
	static Logger log;
	
	static String IV = "dfgjer5f9y7asdfj";

	public static String encryptionKey = "cvbmsdfg48gjsd3e" ;

	public static String aesEncryptHex(String plainText, String encryptionKey)
			throws Exception {
		return Hex.encodeHexString(aesEncrypt(plainText, encryptionKey));
	}

	public static String aesDecryptHex(String cipherText, String encryptionKey) throws Exception {
		try { 
			String decrypt = aesDecrypt(Hex.decodeHex(cipherText.toCharArray()), encryptionKey);
			return decrypt;
		} catch(DecoderException e) {
			return cipherText;
		}
	}

	public static String aesEncryptHex(String plainText)
			throws Exception {
		return Hex.encodeHexString(aesEncrypt(plainText, encryptionKey, IV));
	}

	public static String aesDecryptHex(String cipherText)
			throws Exception {
		return aesDecrypt(Hex.decodeHex(cipherText.toCharArray()),
				encryptionKey, IV);
	}
	
	public static byte[] aesEncrypt(String plainText, String encryptionKey)
			throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"),
				"AES");
		log.log(Constant.IWT_DEBUG_LOG_LEVEL, "aesE " + encryptionKey + " " + key);
		cipher.init(Cipher.ENCRYPT_MODE, key,
				new IvParameterSpec(IV.getBytes("UTF-8")));
		return cipher.doFinal(plainText.getBytes("UTF-8"));
	}

	public static String aesDecrypt(byte[] cipherText, String encryptionKey)
			throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"),
				"AES");
		log.log(Constant.IWT_DEBUG_LOG_LEVEL, "daesE " + encryptionKey + " " + key);
		cipher.init(Cipher.DECRYPT_MODE, key,
				new IvParameterSpec(IV.getBytes("UTF-8")));
		return new String(cipher.doFinal(cipherText), "UTF-8");
	}
	
	public static byte[] aesEncrypt(String plainText, String encryptionKey, String iv)
			throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"),"AES");
//		log.log(Constant.IWT_DEBUG_LOG_LEVEL, "aesE iv " + iv + " " + encryptionKey + " " + key);
		cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(iv.getBytes("UTF-8")));
		return cipher.doFinal(plainText.getBytes("UTF-8"));
	}

	public static String aesDecrypt(byte[] cipherText, String encryptionKey, String iv)
			throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");
//		log.log(Constant.IWT_DEBUG_LOG_LEVEL, "daesE iv " + iv + " " + encryptionKey + " " + key);
		cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(iv.getBytes("UTF-8")));
		return new String(cipher.doFinal(cipherText), "UTF-8");
	}
	
	// 암호화 테스트 메서드
	public static void main(String[] args) {
		String test = "01023022271";
		String test2 = "23be0e003538e8b48536a89bf5ae2836";
		String encrypt = "";
		String decrypt = "";
		try {
			encrypt = aesEncryptHex(test);
			decrypt = aesDecryptHex(test2);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("암호화 : " + encrypt + " / length : " + encrypt.length());
		System.out.println("복호화 : " + decrypt);
	}
}
