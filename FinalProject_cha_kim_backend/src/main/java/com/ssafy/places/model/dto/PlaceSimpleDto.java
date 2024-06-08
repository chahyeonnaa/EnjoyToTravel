package com.ssafy.places.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 카드뷰에 출력하기 위한 dto
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class PlaceSimpleDto {
    private String contentId;
    private String contentTypeId;
    private String firstImage;
    private String title;
    private String areaCode;
    private String mapx;
    private String mapy;
    private int isAvailableToBlind;
    private int isAvailableToPhysicalDisablity;
    private int isAvailableToChildren;
    private int isAvailableToSenior;
    private int isAvailableToHardOfHearing;
}
