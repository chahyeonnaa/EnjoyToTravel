package com.ssafy.places.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.places.model.dto.BarrierFreeDto;
import com.ssafy.places.model.dto.PlaceDto;
import com.ssafy.places.model.dto.PlaceOperationInfoDto;
import com.ssafy.places.model.dto.PlaceSimpleDto;

@Mapper
public interface PlaceDao {

	List<PlaceSimpleDto> listPlaces(String contentTypeId, String barrierType, String areaCode, String sigunguCode, String inputKeyword) throws SQLException;
	List<PlaceSimpleDto> listPlacesOfPlaceCard(String contentTypeId, String areaCode, String sigunguCode, String inputKeyword) throws SQLException;
	PlaceDto getPlaceById(String contentTypeId) throws SQLException;
	BarrierFreeDto getBarrierFreeInfoById(String contentTypeId) throws SQLException;
	PlaceOperationInfoDto getPlaceOperationInfoById(String contentId) throws SQLException;
}
