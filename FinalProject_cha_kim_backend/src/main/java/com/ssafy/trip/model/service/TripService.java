package com.ssafy.trip.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.trip.model.TripDto;

public interface TripService {
	List<TripDto> listTrip(int sidoCode, int contentTypeId, String keyword) throws SQLException;
}
