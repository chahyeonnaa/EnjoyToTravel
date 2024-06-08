package com.ssafy.course.model.dto;

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
public class CourseCardInputDto {
    private String cardId;  // CourseCard의 ID 필드
    private String courseId;  // Course ID를 저장할 필드
    private String contentId;
    private String contentTypeId;
    private String text;
    private String placeTitle;
    private String firstImage;
    private boolean keyword01;
    private boolean keyword02;
    private boolean keyword03;
    private boolean keyword04;
    private boolean keyword05;
    private boolean keyword06;
    private boolean keyword07;
    private boolean keyword08;
    private boolean keyword09;
    private boolean keyword10;
    private boolean keyword11;
    private boolean keyword12;
}
