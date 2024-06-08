package com.ssafy.trip.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.trip.model.TripDto;
import com.ssafy.trip.model.dao.TripDao;

@Service
public class TripServiceImpl implements TripService{
	
	private TripDao tripDao;
	
	public TripServiceImpl(TripDao tripDao) {
		super();
		this.tripDao = tripDao;
	}



	@Override
	public List<TripDto> listTrip(int sidoCode, int contentTypeId, String keyword) throws SQLException {
		return tripDao.listTrip(sidoCode, contentTypeId, keyword);
	}
}