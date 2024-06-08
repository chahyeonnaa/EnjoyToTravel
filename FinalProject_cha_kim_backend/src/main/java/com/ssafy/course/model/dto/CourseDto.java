package com.ssafy.course.model.dto;

import java.util.Date;
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
public class CourseDto {
    private int courseId;
    private String userId;
    private String title;
    private String tripDate;
    private String tag;
    private int sidoCode;
    private int gugunCode;
    private Date createdAt;
    private List<CourseCardDto> courseCards;

    // Getters and Setters
}
