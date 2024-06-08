package com.ssafy.places.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.places.model.dto.PlaceDetailDto;
import com.ssafy.places.model.dto.PlaceOperationInfoDto;
import com.ssafy.places.model.dto.PlaceSimpleDto;

public interface PlaceService {
	public List<PlaceSimpleDto> listPlaces(String contentTypeId, String barrierType, String areaCode, String sigunguCode, String inputKeyword) throws SQLException;
	public List<PlaceSimpleDto> listPlacesOfPlaceCard(String contentTypeId, String areaCode, String sigunguCode, String inputKeyword) throws SQLException;
	public PlaceDetailDto getPlaceWithBarrierFreeInfo(String contentId) throws SQLException;
	public PlaceOperationInfoDto getPlaceOperationInfoById(String contentId) throws SQLException;
}
