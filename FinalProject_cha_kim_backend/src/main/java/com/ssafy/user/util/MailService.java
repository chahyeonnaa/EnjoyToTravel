package com.ssafy.user.util;


public interface MailService {

	void sendUpdatePassword(String email, String password);
	String sendEmailAuth(String email);
}
