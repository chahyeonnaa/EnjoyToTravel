package com.ssafy.trip.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.trip.model.TripDto;

@Mapper
public interface TripDao {
	
	List<TripDto> listTrip(int sidoCode, int contentTypeId, String keyword) throws SQLException;
}
