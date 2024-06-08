package com.ssafy.places.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// places와 barrierfreeinfo(무장애정보)를 담아 관광정보를 반환할 테이블
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class PlaceDetailDto {
    private PlaceDto place;
    private BarrierFreeDto barrierFreeInfo;
}
