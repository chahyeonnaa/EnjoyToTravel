package com.ssafy.course.model.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.course.model.dao.CourseDao;
import com.ssafy.course.model.dto.CourseCardInputDto;
import com.ssafy.course.model.dto.CourseDto;
import com.ssafy.course.model.dto.CourseInputDto;

@Service
public class CourseServiceImpl implements CourseService {
	private CourseDao courseDao;
	private static final Map<Integer, String> KEYWORD_MAP = new HashMap<>();
    private static final Map<String, String[]> CONTENT_TYPE_KEYWORD_MAP = new HashMap<>();

    static {
        // keyword01 ~ keyword09 mapping
        KEYWORD_MAP.put(1, "#휠체어편리");
        KEYWORD_MAP.put(2, "#장애인주차장");
        KEYWORD_MAP.put(3, "#점자안내");
        KEYWORD_MAP.put(4, "#보조견동반");
        KEYWORD_MAP.put(5, "#수유실");
        KEYWORD_MAP.put(6, "#유아차대여");
        KEYWORD_MAP.put(7, "#엘리베이터");
        KEYWORD_MAP.put(8, "#친절");
        KEYWORD_MAP.put(9, "#가성비");

        // keyword10 ~ keyword12 mapping by contentTypeId
        CONTENT_TYPE_KEYWORD_MAP.put("32", new String[]{"#좋은침구", "#방음좋음", "#멋진인테리어"});
        CONTENT_TYPE_KEYWORD_MAP.put("39", new String[]{"#맛있음", "#사진잘나옴", "#양많음"});
        CONTENT_TYPE_KEYWORD_MAP.put("default", new String[]{"#볼거리많음", "#사진잘나옴", "#깨끗한화장실"});
    }

    
	public CourseServiceImpl(CourseDao courseDao) {
		super();
		this.courseDao = courseDao;
	}

	@Override
	public List<CourseDto> getAllCourses() throws SQLException {
		return courseDao.getAllCourses();
	}

	@Override
	public CourseDto getCourseById(int courseId) throws SQLException {
		return courseDao.getCourseById(courseId);
	}

	@Override
	@Transactional
    public void addCourse(CourseInputDto courseInputDto) {
		updateCourseTag(courseInputDto);
        courseDao.insertCourse(courseInputDto);
        String courseId = courseInputDto.getCourseId(); // Insert 후에 생성된 ID를 가져옴
        for (CourseCardInputDto courseCard : courseInputDto.getCourseCards()) {
            courseCard.setCourseId(courseId); // 각 CourseCard에 courseId 설정
            System.out.println(courseCard);
            courseDao.insertCourseCard(courseCard);
        }
    }
	
	public static void updateCourseTag(CourseInputDto courseInput) {
	    List<String> tags = new ArrayList<>();

	    for (CourseCardInputDto card : courseInput.getCourseCards()) {
	        // Add tags based on keyword01 ~ keyword09
	        for (int i = 1; i <= 9; i++) {
	            try {
	                var field = card.getClass().getDeclaredField("keyword" + String.format("%02d", i));
	                field.setAccessible(true); // Private 필드 접근 허용
	                if (field.getBoolean(card)) {
	                    tags.add(KEYWORD_MAP.get(i));
	                }
	            } catch (NoSuchFieldException | IllegalAccessException e) {
	                e.printStackTrace();
	            }
	        }

	        // Add tags based on contentTypeId and keyword10 ~ keyword12
	        String[] keywordMap = CONTENT_TYPE_KEYWORD_MAP.getOrDefault(card.getContentTypeId(), CONTENT_TYPE_KEYWORD_MAP.get("default"));
	        for (int i = 10; i <= 12; i++) {
	            try {
	                var field = card.getClass().getDeclaredField("keyword" + i);
	                field.setAccessible(true); // Private 필드 접근 허용
	                if (field.getBoolean(card)) {
	                    tags.add(keywordMap[i - 10]);
	                }
	            } catch (NoSuchFieldException | IllegalAccessException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    StringBuilder tagBuilder = new StringBuilder();
	    for (String tag : tags) {
	        if (tagBuilder.length() + tag.length() + 1 > 65) break; // +1 for the space
	        if (tagBuilder.length() > 0) tagBuilder.append("  ");
	        tagBuilder.append(tag);
	    }

	    courseInput.setTag(tagBuilder.toString());
	}


}
