package com.ssafy.course.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.course.model.dto.CourseDto;
import com.ssafy.course.model.dto.CourseInputDto;
import com.ssafy.course.model.service.CourseService;

@Controller
@RequestMapping("/course")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class CourseController {
	private CourseService courseService;

	public CourseController(CourseService courseService) {
		super();
		this.courseService = courseService;
	}

	@GetMapping("/list")
	public ResponseEntity<Map<String, Object>> getCourses() throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			List<CourseDto> courseList = courseService.getAllCourses();
			if (courseList != null) {
				res.put("res", "success");
				res.put("data", courseList);
			} else {
				res.put("res", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		ResponseEntity<Map<String, Object>> resp = new ResponseEntity<Map<String, Object>>(res, HttpStatus.OK);
		return resp;
	}

	@GetMapping("/{courseId}")
	public ResponseEntity<Map<String, Object>> getCourseCard(@PathVariable("courseId") int courseId) throws Exception {
		Map<String, Object> res = new HashMap<>();
		try {
			CourseDto course = courseService.getCourseById(courseId);
			if (course != null) {
				res.put("res", "success");
				res.put("data", course);
			} else {
				res.put("res", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<>(res, HttpStatus.OK);
	}

	@PostMapping("/write")
	public ResponseEntity<Map<String, Object>> addCourse(@RequestBody CourseInputDto courseInputDto) throws SQLException {
		System.out.println(courseInputDto);
		Map<String, Object> res = new HashMap<>();
		try {
			courseService.addCourse(courseInputDto);
			res.put("res", "success");
		} catch (Exception e) {
			res.put("res", "fail");
			e.printStackTrace();
		}

		return new ResponseEntity<>(res, HttpStatus.OK);
	}

}
