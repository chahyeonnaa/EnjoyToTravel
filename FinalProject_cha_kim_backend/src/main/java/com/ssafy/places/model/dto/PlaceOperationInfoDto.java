package com.ssafy.places.model.dto;

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
public class PlaceOperationInfoDto {
	private String contentId;
    private String contentTypeId;
    private String scale;
    private String useFee;
    private String discountInfo;
    private String spendTime;
    private String parkingFee;
    private String infoCenterCulture;
    private String accomCountCulture;
    private String useTimeCulture;
    private String restDateCulture;
    private String parkingCulture;
    private String chkBabyCarriageCulture;
    private String chkPetCulture;
    private String chkCreditCardCulture;
}
