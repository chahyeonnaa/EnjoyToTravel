package com.ssafy.area.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.area.model.dao.AreaDao;
import com.ssafy.area.model.dto.GugunDto;
import com.ssafy.area.model.dto.SidoDto;

@Service
public class AreaServiceImpl implements AreaService {
	private AreaDao areaDao;

	public AreaServiceImpl(AreaDao areaDao) {
		super();
		this.areaDao = areaDao;
	}

	@Override
	public List<SidoDto> getAllSido() throws SQLException {
		return areaDao.getAllSido();
	}

	@Override
	public List<GugunDto> getGugunBySidoCode(String sidoCode) throws SQLException {
		return areaDao.getGugunBySidoCode(sidoCode);
	}
}
