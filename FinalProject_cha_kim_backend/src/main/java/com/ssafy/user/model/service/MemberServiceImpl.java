package com.ssafy.user.model.service;

import java.sql.SQLException;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.ssafy.user.MemberInfo;
import com.ssafy.user.model.MemberDto;
import com.ssafy.user.model.dao.MemberDao;
import com.ssafy.user.util.MailService;
import com.ssafy.util.BCryptImpl;
import com.ssafy.util.EncryptHelper;

@Service
public class MemberServiceImpl implements MemberService {

	
	private MemberDao memberDao;
	private MailService mailService;
	private EncryptHelper encryptHelper;
	


	public MemberServiceImpl(MemberDao memberDao, MailService mailService,
			EncryptHelper encryptHelper) {
		super();
		this.memberDao = memberDao;
		this.mailService = mailService;
		this.encryptHelper = encryptHelper;
	}

	@Override
	public boolean signUp(MemberDto memberDto) throws Exception {
		memberDto.encryptPassword(encryptHelper);
		memberDao.signUp(memberDto);
		return true;
	}

	@Override
	public MemberInfo login(String id, String password) throws Exception {
		MemberDto memberDto = memberDao.findById(id);
		
		if(encryptHelper.isMatch(password, memberDto.getPassword())) {
			
			return new MemberInfo(
					memberDto.getUserId(), 
					memberDto.getNickname(),
					memberDto.getEmail(),
					memberDto.getDisabledType(),
					memberDto.getToken(),
					memberDto.getIsAdmin());
		}
		else {
			return null;
		}
	}

	@Override
	public boolean updatePassWord(String name, String email) throws Exception {
		String password = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
        String hashedPwd = encryptHelper.encrypt(password);
        
        boolean isPwdUpdated = memberDao.updatePassWord(name, email, hashedPwd);
        if(isPwdUpdated) {
			mailService.sendUpdatePassword(email, password);   	
        }
		
		return isPwdUpdated;
	}

//	@Override
//	public void updateUser(int userId, String newName, String newEmail) throws Exception {
//		userDao.updateUser(userId, newName, newEmail);
//	}
//
//	@Override
//	public void deleteUser(int userId) throws SQLException {
//		userDao.deleteUser(userId);
//	}

	@Override
	public String emailAuth(String email) {
		return mailService.sendEmailAuth(email);
	}

	@Override
	public boolean isIdExists(String id) throws SQLException {
		return memberDao.isIdExists(id) > 0 ? true : false;
	}

	@Override
	public boolean isNickNameExists(String nickName) throws SQLException {
		return memberDao.isNickNameExists(nickName) > 0 ? true : false;
	}

	@Override
	public boolean isEmailExists(String email) throws SQLException {
		return memberDao.isEmailExists(email) > 0 ? true : false;
	}
}
