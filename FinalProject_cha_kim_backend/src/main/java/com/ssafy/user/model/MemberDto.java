package com.ssafy.user.model;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.user.model.dao.RequestSignUp;
import com.ssafy.util.EncryptHelper;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MemberDto {
	private String userId;
	private String password;
	private String nickname;
	private String email;
	private String disabledType;
	private String token;
	private Integer isAdmin;
	
    // JSON 객체를 받아서 클래스로 변환하는 메서드
    public static RequestSignUp fromJson(String json) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(json, RequestSignUp.class);
    }

    // JSON 객체를 반환하는 메서드
    public String toJson() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(this);
    }
	
	public void encryptPassword(EncryptHelper encryptHelper) {
		this.password = encryptHelper.encrypt(this.password);
	}
}
