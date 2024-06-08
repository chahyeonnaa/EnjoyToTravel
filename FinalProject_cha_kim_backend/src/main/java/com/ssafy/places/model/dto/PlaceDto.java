package com.ssafy.places.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// places 테이블을 그대로 가져올 dto
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class PlaceDto {
	private String addr1;
    private String addr2;
    private String areaCode;
    private String bookTour;
    private String cat1;
    private String cat2;
    private String cat3;
    private String contentId;
    private String contentTypeId;
    private String createdTime;
    private String firstImage;
    private String firstImage2;
    private String cpyrhtDivCd;
    private String mapx;
    private String mapy;
    private String mlevel;
    private String modifiedTime;
    private String sigunguCode;
    private String tel;
    private String title;
    private String zipcode;
    private int isAvailableToBlind;
    private int isAvailableToPhysicalDisablity;
    private int isAvailableToChildren;
    private int isAvailableToSenior;
    private int isAvailableToHardOfHearing;
}
