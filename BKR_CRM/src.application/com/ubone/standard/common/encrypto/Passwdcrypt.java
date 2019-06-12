package com.ubone.standard.common.encrypto;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Passwdcrypt {
	public static String digestMD5(String str) {
		String MD5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16)
						.substring(1));
			}
			MD5 = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			MD5 = null;
		}
		return MD5;
	}

	public static String digestSHA256(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16)
						.substring(1));
			}
			SHA = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}
	
	public static String sha256md5(String str) {
		return Passwdcrypt.digestSHA256(Passwdcrypt.digestMD5(str));
	}
	
	// 암호화 테스트 매서드
	public static void main(String[] args) {
		String str = "admin";
		String passwd = "";
		try {
			passwd = digestSHA256(digestMD5(str));
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			System.out.println("패스워드 암호화 : " + passwd + " / length : " + passwd.length());
		}
	}
}
