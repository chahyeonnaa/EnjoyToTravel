package com.ssafy.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.board.model.BoardDto;
import com.ssafy.user.MemberInfo;
import com.ssafy.user.model.MemberDto;
import com.ssafy.user.model.service.MemberService;

@Controller
@RequestMapping("/user")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class RestMemberController {
	
	private MemberService memberService;
	
	public RestMemberController(MemberService memberService) {
		super();
		this.memberService = memberService;

	}

	
	@GetMapping("/login")
	public ResponseEntity<Map<String, Object>> login(@RequestParam("id") String id, @RequestParam("password") String password) throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			MemberInfo memberInfo = memberService.login(id, password);
			if (memberInfo != null) {
				res.put("res", "success");
				res.put("memberInfo", memberInfo);
			} else {
				res.put("res", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}
	
	@PostMapping("/sign")
	public ResponseEntity<Map<String, Object>> signUp(@RequestBody MemberDto memberDto) throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			boolean isSignedUp = memberService.signUp(memberDto);
			if (isSignedUp) {
				res.put("res", "success");
				res.put("signUpInfo", memberDto);
			} else {
				res.put("res", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

}
