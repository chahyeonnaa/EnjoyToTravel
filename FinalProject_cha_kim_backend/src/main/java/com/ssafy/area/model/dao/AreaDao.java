package com.ssafy.area.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.area.model.dto.GugunDto;
import com.ssafy.area.model.dto.SidoDto;

@Mapper
public interface AreaDao {
    List<SidoDto> getAllSido() throws SQLException;
    List<GugunDto> getGugunBySidoCode(String sidoCode) throws SQLException;
}
