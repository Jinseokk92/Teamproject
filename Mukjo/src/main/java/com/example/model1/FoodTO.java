package com.example.model1;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FoodTO {
	private String id;
	private String name;
	private String category;
	private String longitude;
	private String latitude;
	private String thumurl;
	
	private String address;
	private String tel;
	private String etc;
	private String time;
	private String facilities;
	
	private String avgStar;
}
