package com.ssafy.user.model.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.user.model.MemberDto;

@Mapper
public interface MemberDao {

	boolean updatePassWord(String nickname, String email, String password) throws SQLException;
	void signUp(MemberDto memberDto) throws SQLException;
	MemberDto findById(String id) throws SQLException;
//	void updateUser(int userId, String name, String email) throws SQLException;
//	void deleteUser(int userId) throws SQLException;
	int isIdExists(String id) throws SQLException;
	int isNickNameExists(String nickName) throws SQLException;
	int isEmailExists(String email) throws SQLException;
}
