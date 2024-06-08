package com.ssafy.util;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BCryptImpl implements EncryptHelper {
	
	@Autowired
	private static EncryptHelper encryptHelper;
	
//	private BCryptImpl() {}
	
	public static EncryptHelper getEncryptHelper() {
		if(encryptHelper == null) {
			encryptHelper = new BCryptImpl();
		}
		return encryptHelper;
	}

	@Override
	public String encrypt(String password) {
		return BCrypt.hashpw(password, BCrypt.gensalt());
	}

	@Override
	public boolean isMatch(String password, String hashed) {
		return BCrypt.checkpw(password, hashed);
	}

}
