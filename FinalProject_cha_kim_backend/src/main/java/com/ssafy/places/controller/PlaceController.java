package com.ssafy.places.controller;

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

import com.ssafy.places.model.dto.PlaceDetailDto;
import com.ssafy.places.model.dto.PlaceDto;
import com.ssafy.places.model.dto.PlaceOperationInfoDto;
import com.ssafy.places.model.dto.PlaceSimpleDto;
import com.ssafy.places.model.service.PlaceService;

@Controller
@RequestMapping("/places")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class PlaceController {
	private PlaceService placeService;

	public PlaceController(PlaceService placeService) {
		super();
		this.placeService = placeService;
	}

	@GetMapping("/list")
	public ResponseEntity<Map<String, Object>> getPlaces(@RequestParam("contentTypeId") String contentTypeId,
			@RequestParam("barrierType") String barrierType, @RequestParam("areaCode") String areaCode, 
			@RequestParam("sigunguCode") String sigunguCode, @RequestParam("inputKeyword") String inputKeyword) throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			List<PlaceSimpleDto> placeList = placeService.listPlaces(contentTypeId, barrierType, areaCode, sigunguCode, inputKeyword);
			if (placeList != null) {
				res.put("res", "success");
				res.put("data", placeList);
			}else {
				res.put("res", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

	@GetMapping("/list/card")
	public ResponseEntity<Map<String, Object>> getPlacesInPlaceCard(@RequestParam("contentTypeId") String contentTypeId,
			@RequestParam("areaCode") String areaCode, 
			@RequestParam("sigunguCode") String sigunguCode, @RequestParam("inputKeyword") String inputKeyword) throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			List<PlaceSimpleDto> placeList = placeService.listPlacesOfPlaceCard(contentTypeId, areaCode, sigunguCode, inputKeyword);
			if (placeList != null) {
				res.put("res", "success");
				res.put("data", placeList);
			}else {
				res.put("res", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}
	
    @GetMapping("/{contentId}")
    public ResponseEntity<Map<String, Object>> getPlaceWithBarrierFreeInfo(@PathVariable("contentId") String contentId) throws Exception {
        Map<String, Object> res = new HashMap<>();
        try {
            PlaceDetailDto placeDetailDto = placeService.getPlaceWithBarrierFreeInfo(contentId);
            if (placeDetailDto != null) {
                res.put("res", "success");
                res.put("data", placeDetailDto);
            } else {
                res.put("res", "fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>(res, HttpStatus.OK);
    }
	
    @GetMapping("/{contentId}/operation")
    public ResponseEntity<Map<String, Object>> getPlaceOperationInfoById(@PathVariable("contentId") String contentId) throws Exception {
        Map<String, Object> res = new HashMap<>();
        try {
            PlaceOperationInfoDto placeOperationInfoDto = placeService.getPlaceOperationInfoById(contentId);
            System.out.println(placeOperationInfoDto);
            if (placeOperationInfoDto != null) {
                res.put("res", "success");
                res.put("data", placeOperationInfoDto);
            } else {
                res.put("res", "fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>(res, HttpStatus.OK);
    }
}
