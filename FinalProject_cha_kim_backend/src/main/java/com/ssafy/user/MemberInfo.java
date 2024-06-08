package com.ssafy.user;

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
public class MemberInfo {
	private String userId;
	private String nickName;
	private String email;
	private String disabledType;
	private String token;
	private Integer isadmin;

	
	
}
