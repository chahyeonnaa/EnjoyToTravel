package com.ssafy.places.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.places.model.dao.PlaceDao;
import com.ssafy.places.model.dto.BarrierFreeDto;
import com.ssafy.places.model.dto.PlaceDetailDto;
import com.ssafy.places.model.dto.PlaceDto;
import com.ssafy.places.model.dto.PlaceOperationInfoDto;
import com.ssafy.places.model.dto.PlaceSimpleDto;

@Service
public class PlaceServiceImpl implements PlaceService {
	private PlaceDao placeDao;

	public PlaceServiceImpl(PlaceDao placeDao) {
		super();
		this.placeDao = placeDao;
	}

	@Override
	public List<PlaceSimpleDto> listPlaces(String contentTypeId, String barrierType, String areaCode,
			String sigunguCode, String inputKeyword) throws SQLException {
		return placeDao.listPlaces(contentTypeId, barrierType, areaCode, sigunguCode, inputKeyword);
	}

	@Override
	public List<PlaceSimpleDto> listPlacesOfPlaceCard(String contentTypeId, String areaCode,
			String sigunguCode, String inputKeyword) throws SQLException {
		return placeDao.listPlacesOfPlaceCard(contentTypeId, areaCode, sigunguCode, inputKeyword);
	}

	@Override
	public PlaceDetailDto getPlaceWithBarrierFreeInfo(String contentId) throws SQLException {
		PlaceDto place = placeDao.getPlaceById(contentId);
		BarrierFreeDto barrierFreeInfo = placeDao.getBarrierFreeInfoById(contentId);
		PlaceDetailDto placeWithBarrierFreeInfoDto = new PlaceDetailDto();
		placeWithBarrierFreeInfoDto.setPlace(place);
		placeWithBarrierFreeInfoDto.setBarrierFreeInfo(barrierFreeInfo);
		return placeWithBarrierFreeInfoDto;
	}
	
	@Override
	public 
	PlaceOperationInfoDto getPlaceOperationInfoById(String contentId) throws SQLException {
		return placeDao.getPlaceOperationInfoById(contentId);
	}
}
