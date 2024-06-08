package com.ssafy.course.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CourseInputDto {
    private String courseId;  // Course의 ID 필드
    private String userId;
    private String title;
    private String tripDate;
    private String tag;
    private int sidoCode;
    private int gugunCode;
    private List<CourseCardInputDto> courseCards;
}
