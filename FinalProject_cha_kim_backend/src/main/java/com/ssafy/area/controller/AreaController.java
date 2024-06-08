package com.ssafy.area.controller;

import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.area.model.dto.GugunDto;
import com.ssafy.area.model.dto.SidoDto;
import com.ssafy.area.model.service.AreaService;
import com.ssafy.places.model.dto.PlaceDetailDto;
import com.ssafy.places.model.dto.PlaceDto;
import com.ssafy.places.model.dto.PlaceSimpleDto;
import com.ssafy.places.model.service.PlaceService;

@Controller
@RequestMapping("/area")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class AreaController {
	private AreaService areaService;

	public AreaController(AreaService areaService) {
		super();
		this.areaService = areaService;
	}

	@GetMapping("/sido")
	public ResponseEntity<Map<String, Object>> getAllSido() throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			List<SidoDto> sidoList = areaService.getAllSido();
			if (sidoList != null) {
				res.put("res", "success");
				res.put("data", sidoList);
			} else {
				res.put("res", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

	@GetMapping("/gugun")
	public ResponseEntity<Map<String, Object>> getGugunBySidoCode(@RequestParam("sidocode") String sidocode) throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			List<GugunDto> gugunList = areaService.getGugunBySidoCode(sidocode);
			if (gugunList != null) {
				res.put("res", "success");
				res.put("data", gugunList);
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
