package com.ssafy.area.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.area.model.dto.GugunDto;
import com.ssafy.area.model.dto.SidoDto;

public interface AreaService  {
    public List<SidoDto> getAllSido() throws SQLException;
    public List<GugunDto> getGugunBySidoCode(String sidoCode) throws SQLException;
}
