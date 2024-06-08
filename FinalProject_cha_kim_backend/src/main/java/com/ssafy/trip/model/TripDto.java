package com.ssafy.trip.model;

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
public class TripDto {
	
	int tripId;
	String title;
	String addr1;
	String addr2;
	double mapx;
	double mapy;
	String imageSrc;
	
	
	
}
