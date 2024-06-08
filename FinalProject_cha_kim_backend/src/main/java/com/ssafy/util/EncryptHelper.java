package com.ssafy.util;

public interface EncryptHelper {
	String encrypt(String password);
	boolean isMatch(String password, String hashed);
}
