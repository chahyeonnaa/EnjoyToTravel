package com.ssafy.course.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.course.model.dto.CourseDto;
import com.ssafy.course.model.dto.CourseInputDto;

public interface CourseService {
    public List<CourseDto> getAllCourses() throws SQLException;
    public CourseDto getCourseById(int courseId) throws SQLException;
    public void addCourse(CourseInputDto courseInputDto);
    
}
