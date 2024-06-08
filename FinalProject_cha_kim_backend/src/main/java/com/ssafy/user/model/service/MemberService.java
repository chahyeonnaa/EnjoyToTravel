package com.ssafy.user.model.service;

import java.sql.SQLException;

import com.ssafy.user.MemberInfo;
import com.ssafy.user.model.MemberDto;
import com.ssafy.util.EncryptHelper;

public interface MemberService {

	boolean updatePassWord(String name, String email) throws Exception;
	boolean signUp(MemberDto memberDto) throws Exception;
	MemberInfo login(String id, String password) throws Exception;
//	void updateUser(int userId, String newName, String newEmail) throws Exception;
//	void deleteUser(int userId) throws Exception;
	String emailAuth(String email);
	boolean isIdExists(String id) throws SQLException;
	boolean isNickNameExists(String nickName) throws SQLException;
	boolean isEmailExists(String email) throws SQLException;
}
