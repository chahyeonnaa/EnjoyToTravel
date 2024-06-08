package com.ssafy.course.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.course.model.dto.CourseCardInputDto;
import com.ssafy.course.model.dto.CourseDto;
import com.ssafy.course.model.dto.CourseInputDto;

@Mapper
public interface CourseDao {
    List<CourseDto> getAllCourses() throws SQLException;
    CourseDto getCourseById(int courseId) throws SQLException;
    
    void insertCourse(CourseInputDto courseInputDto);

    void insertCourseCard(CourseCardInputDto courseCardInputDto);

}
